# You Are Not Alone #MeToo
An online dashboard to educate the masses about the #MeToo movement.


We want to:
  - Provide resources to survivors of sexual assualt
  - Contextualize the movement with a sexual assault reporting database
  - Analyze #MeToo tweets in aggregate 
  - Show our users that **they are not alone**

We are:
  - Two coworkers
  - Proud women who code in Python and R
  - Sexual assault survivor advocates
  - #SheHackers

Our vision is to comfort sexual assault survivors by emphasizing the ubiquity of sexual assault through detailed analysis available in an online dashboard called [You Are Not Alone](https://phoebe.shinyapps.io/you-are-not-alone/). 

## The Website

#### The Front Page
The front page of the website welcomes the user with critical information and statistics about sexual assault and outlines the vision behind the dashboard.
#### Data Story
There are two primary data sources integrated into _You're Not Alone_. The first is an open source database about sexual assault in academia called [Sexual Harassment In the Academy: A Crowdsource Survey](https://docs.google.com/spreadsheets/d/1S9KShDLvU7C-KkgEevYTHXr3F6InTenrBsS9yk-8C5M/edit#gid=1530077352), which is curated by [Dr. Karen Kelsky](https://theprofessorisin.com/about-the-professor-2/). We visualize the gender breakdown of the survivors in the database as well as their academic backgrounds with interactive bar graphs. 

The second data source is Twitter, where #MeToo hashtags run rampant.  The data is ingested from Twitter using an API wrapper called [Tweepy](http://tweepy.readthedocs.io/en/v3.5.0/), which has built-in functionality for querying the API for keywords.  In this case, we queried tweets with #MeToo in the text body.  Additional variables were inferred from the raw data including retweets, gender, and ethnicity.  To infer the users’ gender, we used a Python package called [SexMachine](https://pypi.python.org/pypi/SexMachine) that employs a gender classification model trained on over 40,000 first names. The model classifies first names as either unknown, male, female, mostly male, and mostly female.  The ethnicity inference was computed using the [ethnicolr](https://github.com/appeler/ethnicolr) package, which draws its predictions from a combination of the US Census database, Florida Voter Registration data, and Wikipedia data. The model classifiers and diagnostics for these packages were unfortunately not listed on the packages’ websites. 



