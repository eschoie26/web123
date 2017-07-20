---
title: "Food Inspection Result Prediction"
author: "Dana Choi"
date: 2017-07-17T13:09:13-06:00
---

**Introduction and Background (plus a little bit about me)**

  To first talk a little bit about my interests, I find joy in eating and cooking. If I were to choose one eccentric job for life, I  would choose to be a content creator on Youtube and just film myself eating and cooking. 
So, as you can see, I love food. When I travel, my way of exploring the area is visiting local restaurant gems.
If you check my instagram @eunseodanachoi, you will get to see loads of food photos from around the world - Seoul Korea, Vancouver Canada, New York City to name a few. 

  While I love travelling to places (and I do that often), my current home ground is Chicago. Like any big cities, Chicago has an explosive restaurant scene. As a food enthusiast, I always try to take time off of school work and explore different restaurants in Chicagoland area on the weekends. While I care most about what's on my palte, sometimes I wonder what goes behind the scene -- how my food is made, whether my food is cooked in a clean environment, and so on. 

  So, I first looked up on Google (my best friend) to see how Chicago handles its food inspection.
The results were concerning: 

According to [CBC](http://digitaledition.chicagotribune.com/tribune/article_popover.aspx?guid=fffb81a2-3a38-4481-975c-d163e7ee9ba8) , in 2015,
*more than half of restaurants, school and hospital kitchens, day care centres and other Chicago’s high-risk food establishments were not inspected twice, as required by the state. 
*only 44% (3,566) of Chicago’s high risk food establishment like restaurants were inspected two times (the minimum required by the state) 
*80% (2,478) of Chicago’s medium risk food establishment like grocery stores were inspected once (the minimum required by the state). 
*24.8% (1,078) of Chicago’s low risk food establishment like bars were inspected one time (the minimum required by the state). 

  What I found more horrifying was that as of 2016, Chicago only had 38 sanitarians. 38 sanitarians to inspect about 15,000 food businesses and additionally respond to food complaints and violations. So this problem will likely continue even in the future unless the city hires another 56 inspectors to do the job. This puts everyone at risk of food poisoning.  

  The Department of Public Health responded by saying that they are doing what they can. 
Having insufficient resources to meet the requirements for food inspections, they are currently prioritizing highest-risk businesses using predictive analytics as an alternative solution. 
The city’s 311 hotline for complaints have also helped inspectors to respond more easily and more quickly. However, the department still needs more money and more helping hands to do its job properly.                                                                                  
  This will take them a while. 

  So at least for now, I figured that I need to look out for myself on what and where I eat — same for everyone else who wants to dine out in Chicago. Now, we can’t perform food inspection ourselves for every restaurants we visit. 
As an average civilian, the most we can do (when deciding whether or not we can trust a restaurant) is checking its history of food inspection results.

**The Data Set**

  The data set I used was derived from inspections done by Chicago Department of Public Health’s Food Protection Program using a standardized procedure. 
  The   [dataset](https://data.cityofchicago.org/Health-Human-Services/Food-Inspections/4ijn-s7e5/data) is comprised of inspection results from January 1, 2010 to the present (most recent: July 14th 2017). 

  Unsurprisingly, this data set was HUGE. It had 17 variables with 151,209 entries.
``` {variables}
##  `Inspection ID` `DBA Name`  `AKA Name` `License #` `Facility Type` `Risk`
##  `Address` `City` `State` `Zip` `Inspection Date``Inspection Type`
##  `Results` `Violations`  `Latitude`  `Longitude` `Location`
```
  While Chicago Data Portal tried its best to help users make use of its data, I personally found it difficult to search up specific restaurant in mind and visualize the history of its inspection results. I could imagine other people facing similar problems as well. For that reason, the ultimate end goal for my first ever project in R is to make this process easier and more efficient for local residents and visitors in Chicago. I am currently thinking of building an interactive map that will allow users to see the list of inspection results when they search up restaurants they wish to visit. 
In addition, I wish to potentially create a twitterbot to inform followers the list of food inspection results for different restaurants in Chicago. Every day, the bot would scrape off the data from Chicago Data Portal(which is updated daily) and tweet the updated results.   

**The Real Question of the Day**

  Before I go off doing those listed above, however, I thought I should first check whether this information (history of restaurant's inspection results) is a valuable information in the first place. What can this history of inspection results tell us? Should we give a second chance for restaurants with a history of one or more failure in passing inspection? Can we trust restaurants in Chicago? 
  If we don't see improvement in food inspection results over time, we can assume that restaurants with the history of failure in passing food inspection will likely be doing it again. 

**Hypothesis**

  Canada’s biggest analysis of public health inspection reports from national chain restaurants done by [CBCMarketplace](link:http://www.cbc.ca/news/health/restaurant-inspections-at-national-chains-uncover-repeated-major-violations-1.2605475) found that major violations tended to continue even after restaurants were notified by inspectors.

  Based on this report, I started off with the hypothesis that food inspections have insignificant effects on improvin the quality of food establishment's performance in foodhandling within Chicagoland area.

**Preliminary analysis**

![Number of Food Inspections by Results](/results_bar_graph.png)

*NA includes inspecton results marked as "business not located", "out of business", "no entry", or "not ready".
*We are going to consider restaurants who passed with conditions as still problematic even though their problems were fixe on-site during the inspection. 

  In this histogram, we see that the number of passes is far greater than the number of fails and passes with conditions together. That's good, but what I really wanted to see was whether certain restaurant's food inspection results improve over time (Dates). So I looked into scatterplot instead:
  
``` 
#Food_Inspections$`License #`=as.factor(Food_Inspections$`License #`)
#ggplot(data = Food_Inspections, aes(x = `Inspection Date`, y = `License #`, color = result)) + 
#  geom_point() 
```

![Scatterplot of Results](/scatterresultall.png)
  
  
![Scatterplot of Results](/resultallscatter.png)

  Unfortunately, the data set was so large (size 200 MB) that it was hard to visualize and get something out in ggplot just from its raw data frame. 


**Data Cleaning and Wrangling**
Took me most of the time doing this. 
(copy and paste code)
*each restaurant has unique license id 
*using dplyr and tidyr

**Experiment and analysis**
Created a subset of a data frame 
Just looked at 20 restaurants with most inspection results history (just so that we keep the number of our levels low while maximizing data)

![Scatterplot of Top 20 Restaurants with most inspection results history](/top20_plotovertime.png)

From our sample, restaurants pass 

**Further experiments and analysis**

data wrangling to just have a data frame of res

data frame still too large. 

created subset of that data frame (again, top 20 restaurants with most failure records)
Now I took closer look at variable called violations. Among restaurants with failure records, do they repeatedly make same violations? 


**Sources**

http://digitaledition.chicagotribune.com/tribune/article_popover.aspx?guid=fffb81a2-3a38-4481-975c-d163e7ee9ba8

https://data.cityofchicago.org/Health-Human-Services/Food-Inspections/4ijn-s7e5/data

http://www.cbc.ca/news/health/restaurant-inspections-at-national-chains-uncover-repeated-major-violations-1.2605475