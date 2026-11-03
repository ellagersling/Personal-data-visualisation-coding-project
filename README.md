# Personal data visualisation coding project
Personal sleep data gathered and recorded to visualise emotional fluctuations through code in Processing.


# Table of contents

* [General information](#general-information)
* [Features](#features)
* [Screenshot](#screenshot)
* [Setup](#setup)
* [Usage](#usage)
* [Known limitations](#known-limitations)
* [Room for improvement](#room-for-improvement)
* [Acknowledgements](#acknowledgements)

# General information:

* Every night, following the connection of my Apple Watch to my sleep settings, my iPhone gathers heart rate data, time in bed data and sleep stages. These are all valuable and interesting aspects, yet are presented merely as a set of numbers/statistics. These numbers don't show the story or a visualisation behind the data set
* The data visualisation has collected data from week 6 - week 10 (including stuvac, to be more time efficient). These are the following dates of data collection: week 6: (31/8 - 6/9), week 7: (7/9 - 13/9), week 8: (14/9 - 20/9), week 9: (21/9 - 27/9), week 10: (28/9 - 4/10)
* This coding project will take that raw data (tabulated in my project journal word document), and turn it into a personalised data self-portrait, visualising the effects of a good week versus a rough week
* It's a visual art/data humanism concept, rather than a data analysis tool, the goal is emotional legibility and not data optimisation

# Features:

* Bar chart with labelled axis and colour key to showcase sleep quality across 5 weeks
* The prototype is data-driven, read from a csv using loadTable(). Changing a value in the csv and rerunning the sketch will change the chart
* Settings are located in one place, variables located at the top
* Code is commented throughout
* A null check and console messages report if the csv is missing or how many rows loaded

# Screenshot:

* Screenshot of final prototype:
* <img width="771" height="583" alt="Screenshot 2026-10-30 at 12 56 55 pm" src="https://github.com/user-attachments/assets/349887b8-2b73-4806-8a6f-2892f8bc5587" />

# Setup:

* Requirements: Processing, built in version 4.5.6, Java mode, no extra libraries necessary
* Folder structure: keep the data file in a 'data' folder next to the sketch
* To run: Download this repository, open 'personal_data_visualisation.pde' in Processing, press the run button
* If it doesn't run: check that 'sleep_data.csv' is inside the 'data' folder

# Usage:

**Reading the chart:**

* Bar height: average hours of sleep for the week (the y axis shows hours)
* Bar colour: average sleep score, from red (low) to green (high), the key on the right explains the colours
* Labels: the week is under each bar and the score is above it

**Trying your own data:**

* Open 'data/sleep_data.csv' and change a value, for example a weeks 'avg_sleep_score'
* Save the file and press run again
* The bars height or colour will update to match

# Known limitations:

* The y axis starts at 4 hours rather than 0, so differences look larger than they are
* The red to green colours may be hard for some viewers to tell apart
* Heart rate variability (`avg_hrv`) is in the CSV but not shown in the chart
* The colour key has a fixed position, so a much larger dataset could overlap it

# Room for improvement:

* Show heart rate variability as a second chart or an extra visual
* Use a colour-blind-friendly palette
* Add hover labels or a switch between hours and score
* Fit more weeks by scaling the bar width automatically

# Acknowledgements: 

* Marina: (classmate), for the early peer review, her feedback led me to add clearer labelling, axes and a colour key
* Andrew: (teaching staff), for assisting me in tutorials, supplying important information, delivering weekly lectures, and for the Canvas video that showed how to create this Git repository and all the other resources that assisted me in this project
* Git cheat sheets: by ritaly and peter kubichi, which I used to learn Git commands and format this repository https://github.com/ritaly/README-cheatsheet#usage
* Creative Coding subject, UTS, for the lectures, readings and project brief this prototype was built for
* Processing (processing.org), the programming environment the sketch is written in


