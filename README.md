# sabermetricsFinal
Final project for Sabermetrics CSCI 4831 Spring 2018

Meredith Burgess

## Viewing the demo

Download repo and run Jupyter notebook to view interactive notebooks. There should be a link at top of page to toggle display of code cells for readability. 

Necessary CSVs include allStats.csv, 2gramofevents.csv, 3gramofevents.csv, and 4gramofevents.csv

See SQL query files and finalProject1.py for more details on how the scores were calculated 

### For most interactive version, lookg at ROC-widgetInteract.ipynb

Requires Python 3, Jupyter Notebook, numpy, pandas, matplotlib, ipywidgets, and Ipython.display 

### For partially interactive version, look at ROC-inputTextInteract.ipynb

Requires  Python 3, Jupyter Notebook, numpy, pandas, and matplotlib

### If you do not want to run Jupyter Notebook at all

see static (non-interactive) notebook page online here: 

https://nbviewer.jupyter.org/github/meriburgess/sabermetricsFinal/blob/master/ROC-totallyStatic.ipynb

or here 

https://nbviewer.jupyter.org/github/meriburgess/sabermetricsFinal/blob/master/ROC-widgetInteract.ipynb

## Video Link


## Write up 

There are many baseball statistics that attempt to measure the number of runs a player contributes toward their team. Gaining runs, after all, is the objective of the game and how the winner is determined. Understanding a players contribution to their score is equivalent of their worth to the team. Stats like Runs Created try to measure this exactly, while other stats try to measure players abilities to do things that will later turn into runs, such as getting on base, or things that will prevent runs from happening, such as strikeouts for pitchers.  

Run opportunities created is a statistic that, like many of the pre-existing offensive statistics, aims to look at indirect contribution toward overall runs. Rather than looking whether or not a player directly helps create a run in their offensive play (namely, being up to bat on the plate), ROC looks into the ability of a batter to set up a situation which will later create a run. This works under the assumption that there is a "long game" strategy to baseball. Most stats only account a player in isolation, sometimes involving situational statistics such as inning in the game, or the current score. Defensive stats for fielders and pitchers consider how those players indirectly control the number of runs, but there seem to be few offensive stats that take into consideration a teamwork element. 

ROC looks at sliding windows of events, in this case the data is sourced from retrosheet ranging from 2010 to 2013. Windows consist of sizes of 2, 3, and 4 events at a time. Order matters in these windows. For example, a single in the first event of the window is not the same as a single in the second, etc. In these windows, or N-grams of baseball events, we are looking for windows that end in a run scored. For example, if we look at two events, say, a single and a double, if it ends in a run scored for the team up to bat, it is added to list of Ngrams. If the same sequence of events occurs later but does not result in a run scored, it is not added to the list. After these windows are collected, we keep count of all events that happened and the subsequent probabilities of transitioning between them based on these counts. We also look at the players involved in the event and attribute a score to them based on the probability of that event leading to the next one. These scores are accumulated and then divided by total plate appearances (regardless of whether or not that PA occured in a run scoring window or not). 

A high ROC score for a player indicates that they are more often involved in sequences of events that give runs to teams, even though they may not be the ones directly creating the opportunity for the run. 

ROC gives an opportunity to assess players who are not necessarily stars or bigtime score makers, but perhaps are more subtle in their contribution toward a team. Perhaps the make-up of teams is more important than any one particular players performance, and this is what ROC is trying to look at. 

ROC is most closely related to RC, or runs created. Both look at how players create runs. However RC looks are direct creation while ROC looks at indirect creation. Both RC and ROC have an exponential distribution among players. Pearson correlation metrics however, indicate no particularly strong correlation. This may be a demonstration that there are players doing more contribution toward runs without getting credited as those who have high RC scores do. In other words, the types of players do not strongly overlap. ROC may actually be useful in uncovering this other group of players. 

There were several things that could have been added or considered in the creation of ROC that were not. ROC could see possible improvement or change if these things were. This includes a weight based on placement of the event in the sequence. For example, an event closer to the end of the sequence might have more significance toward the run scored than one earlier on, especially in a longer sequence. In this particular scoring system, players receive a higher score for being involved in an event that is more frequent with the idea that they are contributing in a more reliable manner. However, another approach would be to attribute higher scores toward less frequent events with the idea that the players are helping to overcome the odds. Sequences of events that resulted in a run were the only thing considered. Sequences resulting in runs frequency was not compared to the same sequences not resulting in runs to see how reliable such sequences were at producing runs. Considering such a metric could give better insight to how meaningful participation in the sequence is. Finally, because we consider that order of events matters, players were double counted in sequence scores. For example, if a player performs an event at the end of a 4-gram, he gets a certain score for that. However that same event may appear earlier in another 4-gram sequence down the line. He would also receive points for that. Figuring out how to properly adjust this could help balance resulting overall scores.  

It is difficult to say just how meaningful this new statistic is, due to the constrained window of observation (2010-2013). For a more clear idea, more data could be added and more adjacent statistics compared. However, it does give some interesting insights to the commonality of sequences of events, which is certainly useful in assessing the state of games. This is ROCs biggest contribution. 


