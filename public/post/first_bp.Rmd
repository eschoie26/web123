---
title: "Food Inspection Result Prediction"
author: "Dana Choi"
date: "18 July 2016"
output: html_document
runtime: shiny
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

##My first ever project in R 

###Introduction and Background (plus a little bit about me)
I am a food enthusiast.
I find joy in eating and cooking. If I were to choose one eccentric job for life, I  would choose to be a content creator on Youtube and just film myself eating and cooking. 
So, as you can see, I love food. 
When I travel, my way of exploring the area is visiting local restaurant gems.
If you check my instagram @eunseodanachoi, you will get to see loads of food photos from around the world - Seoul Korea, Vancouver Canada, New York City to name a few. 

While I love travelling to places (and I do that often), my current home ground is Chicago. 
Like any big cities, Chicago has an explosive restaurant scene. As a food enthusiast, I am always thankful and excited that I have so many options to choose from whenever I go out to the city.
Sometimes, however, when I enter a restaurant, I wonder how clean that restaurant is. 

So, I looked up on Google (my best friend) to see how Chicago handles its food inspection: 
In 2015, more than half of restaurants, school and hospital kitchens, day care centres and other Chicago’s high-risk food establishments were not inspected twice, as required by the state. 

According to the reports, in 2015, 
only 44% (3,566) of Chicago’s high risk food establishment like restaurants were inspected two times (the minimum required by the state) 

80% (2,478) of Chicago’s medium risk food establishment like grocery stores were inspected once (the minimum required by the state). 

24.8% (1,078) of Chicago’s low risk food establishment like bars were inspected one time (the minimum required by the state). 
[source](http://digitaledition.chicagotribune.com/tribune/article_popover.aspx?guid=fffb81a2-3a38-4481-975c-d163e7ee9ba8) 


What I found more concerning was that as of 2016, Chicago only had 38 sanitarians. 38 sanitarians to inspect about 15,000 food businesses and additionally respond to food complaints and violations. So this problem will likely continue even in the future unless the city hires another 56 inspectors to do the job. This puts everyone at risk of food poisoning.  

The Department of Public Health responded by saying that they are doing what they can. 
Having insufficient resources to meet the requirements for food inspections, they are currently prioritizing highest-risk businesses using predictive analytics as an alternative solution. 
The city’s 311 hotline for complaints have also helped inspectors to respond more easily and more quickly. However, the department still needs more money and more helping hands to do its job properly.                                                                                                                                           
This will take a while. 

So at least for now, I figured that I need to look out for myself on what and where I eat — same for everyone else who wants to dine out in Chicago. 

Now, we can’t perform food inspection ourselves for every restaurants we visit. 
As an average civilian, the most we can do is checking the restaurant’s history of inspection results to decide whether we can trust the restaurant or not. 

###The Data Set 

```{table, include = FALSE}
head(foodinspect)
```

This information is derived from inspections done by Chicago Department of Public Health’s Food Protection Program using a standardized procedure. The [data set](https://data.cityofchicago.org/Health-Human-Services/Food-Inspections/4ijn-s7e5/data) is comprised of inspection results from January 1, 2010 to the present (most recent: July 14th 2017). 

Let's take a quick look at the variables being analyzed. 
```{data variables, include = FALSE}
## [1] "DBA" "AKA" "License #" "Facility Type" "Risk"
## [6] "Address" "City" "Zip" "Inspection Date" "Inspection Type"
## [11] "Results" "Violations" "Latitude" "Longitude" "Location"
```

• DBA: ‘Doing business as.’ This is legal name of the establishment.
  AKA: ‘Also known as.’ This is the name the public would know the establishment as.
• License number: This is a unique number assigned to the establishment for the
purposes of licensing by the Department of Business Affairs and Consumer Protection.
• Type of facility: Each establishment is described by one of the following: bakery, banquet
hall, candy store, caterer, coffee shop, day care center (for ages less than 2), day care
center (for ages 2 – 6), day care center (combo, for ages less than 2 and 2 – 6
combined), gas station, Golden Diner, grocery store, hospital, long term care
center(nursing home), liquor store, mobile food dispenser, restaurant, paleteria, school,
shelter, tavern, social club, wholesaler, or Wrigley Field Rooftop.
• Risk category of facility: Each establishment is categorized as to its risk of adversely
affecting the public’s health, with 1 being the highest and 3 the lowest. The frequency of
inspection is tied to this risk, with risk 1 establishments inspected most frequently and
risk 3 least frequently.
• Street address, city, state and zip code of facility: This is the complete address where
the facility is located.
• Inspection date: This is the date the inspection occurred. A particular establishment is
likely to have multiple inspections which are denoted by different inspection dates.
• Inspection type: An inspection can be one of the following types: canvass, the most
common type of inspection performed at a frequency relative to the risk of the
establishment; consultation, when the inspection is done at the request of the owner
prior to the opening of the establishment; complaint, when the inspection is done in
response to a complaint against the establishment; license, when the inspection is done
as a requirement for the establishment to receive its license to operate; suspect food
poisoning, when the inspection is done in response to one or more persons claiming to
have gotten ill as a result of eating at the establishment (a specific type of complaint-
based inspection); task-force inspection, when an inspection of a bar or tavern is done.
Re-inspections can occur for most types of these inspections and are indicated as such.
• Results: An inspection can pass, pass with conditions or fail. Establishments receiving a
‘pass’ were found to have no critical or serious violations (violation number 1-14 and 15-
29, respectively). Establishments receiving a ‘pass with conditions’ were found to have
critical or serious violations, but these were corrected during the inspection.
Establishments receiving a ‘fail’ were found to have critical or serious violations that
were not correctable during the inspection. An establishment receiving a ‘fail’ does not
necessarily mean the establishment’s licensed is suspended. Establishments found to
be out of business or not located are indicated as such.
• Violations: An establishment can receive one or more of 45 distinct violations (violation
numbers 1-44 and 70). For each violation number listed for a given establishment, the
requirement the establishment must meet in order for it to NOT receive a violation is
noted, followed by a specific description of the findings that caused the violation to be
issued. 


Unsurprisingly, this data set was HUGE (151209 rows).  While Chicago Data Portal tried its best to help users make use of its data, I personally found it difficult to search up specific restaurant in mind and visualize the history of its inspection results. 

So, as my final project for I_Xperience Data Science class, I’ve set an ambitious goal of making this process easier for local residents and visitors in Chicago. 

###Preliminary analysis 
But before we do that, we should first check whether this information (history of restaurant's inspection results) is significant or not and if so, how. 
So, what can this history of inspection results tell us? Should we give second chance for restaurants with a history of one or more failure in passing inspection? 

Well, Canada’s biggest analysis of public health inspection reports from national chain restaurants done by [CBC Marketplace](link:http://www.cbc.ca/news/health/restaurant-inspections-at-national-chains-uncover-repeated-major-violations-1.2605475) found that major violations tended to continue even after restaurants were notified by inspectors. 

I wanted to see whether this is also the case for restaurants in Chicago. 

####Back to initial analysis
If the number of of result=fail & number of of result=pass w. conditions together is greater than the number of result=pass, we can assume that food inspections have not much effect in improving environment of the food establishments. Then, restaurants with the history of failure in passing food inspection will likely be doing it again. 

![Number of Food Inspections by Results](/Users/danachoi/Dropbox/foodinspect/results_bar_graph.png)
*NA includes inspecton results marked as "business not located", "out of business", "no entry", or "not ready".

In this histogram, however, we see that the number of passes(and passes with conditions) are far greater than the number of fails. 

####Hypothesis 
So, I hypothesize that food inspections have significant effect on improving the quality of food establishments' environment. 
I hope to not see the same problem occuring in Chicago as in Canada. 

###Models, Analysis, and Predictions 

####Geom Point
```{plot}

```

####Linear Model
```{linear model}


```

####Decision Tree
```{decision tree}
```

####Cross Validation 


###Conclusion


###Sources
http://digitaledition.chicagotribune.com/tribune/article_popover.aspx?guid=fffb81a2-3a38-4481-975c-d163e7ee9ba8
https://data.cityofchicago.org/Health-Human-Services/Food-Inspections/4ijn-s7e5/data
http://www.cbc.ca/news/health/restaurant-inspections-at-national-chains-uncover-repeated-major-violations-1.2605475