# Shiny 2.2
library(shiny)
library(plotly)
library(shinythemes)
# library(networkD3)
library(markdown)
library(leaflet)
library(DT)

shinyUI(fluidPage(
  theme = shinytheme("journal"),
  # "theme_sexwell.css", #shinytheme("sandstone"),

  titlePanel("You Are NOT Alone, #MeToo!"),
  navbarPage("",
             # theme = "theme_sexwell.css",
             tabPanel(icon = icon("home"),"Home",
                      includeMarkdown("intro.md")
                      ),
             navbarMenu("Data Story of Sexual Assaults", icon = icon("stethoscope"),
                        tabPanel("General information", icon=icon("stethoscope"),
                                 includeMarkdown("general_edu.md")),
                        tabPanel("Sexual Assaults in Academia", icon = icon("address-book-o"),
                                 includeMarkdown("credit_aca.md"),
                                 plotOutput("plot_aca_gen", width=100),
                                 sliderInput("n", "Minimal amount of response submitted", min = 1, max=130, value =20, step=10),
                                 plotOutput("plot_aca_major", width=100))
                        ),
            navbarMenu("#MeToo Movement in 2017", icon = icon("twitter"),
                       tabPanel("Twitter Data Story",
                                includeMarkdown("twitter.md")),
                       tabPanel("Key Word Search in #MeToo tweets",
                                includeMarkdown("tweet-keyword.md"),
                                textInput("keyword", label = h4("Please enter a word or a string of words that you would like to learn about in our Tweet Database"),
                                          value = "You can try: survivor, consent, believe, courage"),
                                h3(textOutput("keywordsum")))),
             navbarMenu("Report a Sexual Assasult", icon = icon("edit"),
                        tabPanel("Report via a form", icon = icon("wpforms"),
                                 tags$iframe(id = "googleform",
                                             src = "https://docs.google.com/forms/d/e/1FAIpQLSdqw5NXblD48ZvJGCCTXhj16aRNKAg9CO1SrnLyyvhrrFoh_A/viewform?embedded=true",
                                             width = 760,
                                             height = 500,
                                             frameborder = 0,
                                             marginheight = 0)),
                        
                        tabPanel("ChatBot", htmlOutput("chatbot"))
                        ),
             
            tabPanel("Resources", icon = icon("info"),
                  includeMarkdown("resources.md")),
            tabPanel("Contact and Future Direction", 
                     includeMarkdown("contact.md"))
             
  )
))