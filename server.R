# Shiny 2.2
library(DT)
library(dplyr)
library(ggplot2)
library("ggthemes")
library(scales)
library(shiny)
library(data.table)
library(plotly)
library(stringr)
# library(igraph)
# library(networkD3)
library(markdown)
library(leaflet)
library(googlesheets)

shinyServer(function(input, output, session) {
  # output$logo <- renderUI({
  #   graphic <- tags$iframe(src = "https://create.piktochart.com/embed/27453761-pt4phackathonlogo",
  #                          height = 72,
  #                          width = 150,
  #                          scrolling = "no")
  #   print(graphic)
  # })
  
  # Columns to show (reactive)
  # observe({ 
  #   x <- colnames(hospital.df)
  #   # Can use character(0) to remove all choices
  #   if (is.null(x)) x <- character(0)
  #   col_show <- c("Hospital.Name", "Address.1", "City", "State", "ZIP.Code", "County", "Phone.Number", "Hospital.Type", "Hospital.Ownership", "Emergency.Services")
  #   updateSelectizeInput(session, inputId = "show_cols",
  #                        label = "Columns to show:",
  #                        choices = x,
  #                        selected = x[x %in% col_show]
  #   )
  # })
  # Rows to show (reactive)
  # observe({ 
  #   x <- unique(hospital.df$City)
  #   # Can use character(0) to remove all choices
  #   if (is.null(x)) x <- character(0)
  #   row_show <- c("BOSTON")
  #   updateSelectizeInput(session, inputId = "show_rows",
  #                        label = "City to show:",
  #                        choices = x,
  #                        selected = x[x %in% row_show]
  #   )
  # })
  
  # ChatBot
  output$chatbot <- renderUI({
    graphic <- tags$iframe(src = "https://console.dialogflow.com/api-client/demo/embedded/0243fd9a-701c-4e4c-9541-a46d05b0591b",
                           height = 430,
                           width = 350,
                           scrolling = "no")
    print(graphic)
  })
  
  # table(survey.df$`Your Field/Discipline`)[table(survey.df$`Your Field/Discipline`) > 20]
  # Plot
  plot_aca_gen <- reactive({
    survey.df <- subset(survey.df, gen_har == "Female" | gen_har == "Male")
    ggplot(data = survey.df, aes(x=gen_har, fill = factor(gen_har))) +
      geom_bar(aes(y=(..count..)/sum(..count..)))+
      scale_y_continuous(labels=scales::percent) +
      geom_text(aes(label=scales::percent((..count..)/sum(..count..)),y=(..count..)/sum(..count..)), stat = "count", vjust=-0.5)+
      labs(title = paste("Gender of the Harasser (Based on", nrow(survey.df) ,"survey response)"), x = "", y="") +
      scale_fill_tableau() +
      theme_minimal() +
      theme(legend.position = "none",
            plot.title = element_text(face="bold", size = 15))
  })
  
  output$plot_aca_gen <- renderPlot({
    return(plot_aca_gen())
  }, height = 350, width = 600)
  
  plot_aca_major <- reactive({
    n <- input$n #default as 20
    totaln <- nrow(survey.df[!is.na(survey.df$Field),])
    
    major.df <- table(survey.df$Field)[table(survey.df$Field) >= n] %>% 
      data.frame()
    major.df$Prop <- major.df$Freq/totaln
    # sort bars
    major.df$Var1 <- factor(major.df$Var1) %>%
      reorder(-major.df$Prop)
    
    ggplot(data = major.df, aes(x=Var1, y=Prop)) +
      geom_bar(stat="identity", fill = "#006BA4")+
      scale_y_continuous(labels=scales::percent) +
      geom_text(aes(label=round(Prop*100), stat = "count", vjust=-0.5))+
      labs(title = paste("Field/Discipline of the Victim (Based on", nrow(survey.df) ,"survey response)"), x = "", y="") +
      # scale_fill_tableau() +
      theme_minimal() +
      theme(legend.position = "none", 
            axis.text.x = element_text(angle=45, hjust = 1),
            plot.title = element_text(face="bold", size = 15))
  })
  
  output$plot_aca_major <- renderPlot({
    return(plot_aca_major())
  }, height = 350, width = 600)
  
  output$keywordsum <- renderText({
    keyword <- paste0("^", input$keyword, "$") #for exact match
    n_tweet_og <- map_int(orig_tweet_list, function(x) length(grep(keyword, x))) %>% sum()
    n_tweet_rt <- map_int(rt_tweet_list, function(x) length(grep(keyword, x))) %>% sum()
    print(paste("From our tweet database of", as.numeric(table(tweet.df$retweet=="False")[2]), "original tweets and", 
          as.numeric(table(tweet.df$retweet=="True")[2]), "retweets, there are", n_tweet_og, "original tweets and",
          n_tweet_rt, "retweets contain the word or phrase", input$keyword))
  })
})