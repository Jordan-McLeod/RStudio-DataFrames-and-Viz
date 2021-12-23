========================================================================================================}

$$$ Advanced Visualization with GGPlot2 $$$   }

### Skip to Line 403 for Results!

library(ggplot2)
install.packages("ggplot2")


========================================================================================================}

$$$ Section 6 - 59
$ Project Brief: Movie Ratings My Attempt (Practice)

### Layers to a great visualization:

# Data
# Aesthetics
# Statistics
# Geometries
# Coordinates
# Factors
# Themes

========================================================================================================}

$$$ Section 6 - 61
$ What is a Factor?    } 


## Importing and Exploring the Dataset. 

# Setting the working directory.
getwd()
setwd("C:\\Users\\kirby\\OneDrive\\Desktop\\Code\\R Code\\R for Data Science\\Section 6 - Visualization w GGPlot 2\\Dataset")

# Importing the Movie ratings csv into the movies variable. 
movies <- read.csv("P2-Movie-Ratings.csv")
head(movies)

# Re-assigning the column names & exploring the datatypes.
colnames(movies) <- c("Film","Genre","CriticRating","AudienceRating","BudgetMM","Year")
head(movies)
str(movies)
summary(movies)     # Notice that "Year" is being treated as a continuous variable. We must change it to a nominal variable.


# Converting numbers into factors.
factor(movies$Year)                      # Declare movies as a factor.
movies$Year <- factor(movies$Year)       # Re-assign the movies column as a factor.
str(movies)                              # Success!





========================================================================================================}

$$$ Section 6 - 62
$ Aesthetics    } 


## Introduction to ggplot2
# Creating the aesthetics of the plot using ggplot2.


# Loading the ggplot2 library.
library("ggplot2")
head(movies)


## Plot Version 1
# Levels: Data, Aesthetics (X & Y), Geometry

ggplot(
  data = movies,                                      # Declare dataset.
  aes(x = CriticRating, y = AudienceRating)) +        # Establish x and y axis.                 
  geom_point()                                        # Add geometry. Other options include (geom_bar, geom_jitter, etc.)




## Plot Version 2
# Levels: Data, Aesthetics (X, Y & Color), Geometry

ggplot(
  data = movies,                                                     # Declare dataset.
  aes(x = CriticRating, y = AudienceRating, color = Genre)) +        # Establish x and y axis.                 
  geom_point()                                                       # Add geometry. Other options include (geom_bar, geom_jitter, etc.)



## Plot Version 3
# Levels: Data, Aesthetics (X, Y, Color & Size), Geometry

RatingComparison <- ggplot(
  data = movies,                                                     # Declare dataset.
  aes(x = CriticRating, y = AudienceRating, 
      color = Genre, size = BudgetMM, alpha(.1)), 
      xlab = "Critic Rating", ylab = "Audience Rating") +            # Establish x and y axis. Add colors & sizing.                
  geom_point()                                                       # Add geometry. Other options include (geom_bar, geom_jitter, etc.)
    

RatingComparison


========================================================================================================}

$$$ Section 6 - 63
$ Plotting w/ Layers    } 


## Plot Version 4 / Creating an Object

ObjA <- ggplot(
  data = movies,                                                     # Declare dataset.
  aes(x = CriticRating, y = AudienceRating, 
      color = Genre, size = BudgetMM, alpha(.1))) +                  # Establish x and y axis. Add colors & sizing. 
  xlab("Critic Rating") +
  ylab("Audience Rating")

ObjA                 # Notice: Will not show any datapoints because we have not declared any geometry using geom_<geomname>
str(ObjA)            # Confimed creation of an object.


# By creating an object, we can reuse our chart format and data. The geom_x functions allow us to add custom geometry.

# Point Plot
ObjA + geom_point()

# Line Plot
ObjA + geom_line()

# Hybrid
ObjA + geom_line() + geom_point()          # Notice: The order of the script changes the layering of the graph.



========================================================================================================}

$$$ Section 6 - 64
$ Overriding Aesthetics    } 


ObjB <- ggplot( data = movies, aes(x = CriticRating, y = AudienceRating, color = Genre, Size = BudgetMM))
ObjB

# Note: When overriding an aesthetic, we will not actually change the properties of our object! 
# Add geometry Layer

ObjB + geom_point()


# Overriding aes() - EXAMPLE 1

ObjB + geom_point(aes(size = CriticRating))


# Overriding aes() - EXAMPLE 2

ObjB + geom_point(aes(color = BudgetMM))


# Overriding x and y values

ObjB + geom_point(aes(x = BudgetMM, y = AudienceRating, size = BudgetMM)) + 
  xlab("Budget in Millions") +                       # xlab and ylab are additional functions OUTSIDE of aes().
  ylab("Audience Rating")                            


# Reduce Line Size 

ObjB + geom_point(size = 3)                           # Setting a size.
ObjB + geom_point(aes(size = CriticRating))           # Mapping a size.



## Mapping vs Setting Variables to Aesthetics
# Mapping: More complex. Used when attaching a color according to a variable. USES aes().
# Setting: Less complex. Used when declaring a color for the visualization. 


## Section Synopsis
# When creating visualizations, it's helpful to create objects that contain the data and the data coordinates.
# Once the object is created with the ggplot() function, we then add geometries (the datapoint visuals).
# This allows us to easily manipulate data visuals while preserving the integrity of the original graph.



========================================================================================================}

$$$ Section 6 - 65
$ Mapping vs Setting    }

str(ObjB)

ObjB + geom_point(aes(x = BudgetMM, y = AudienceRating, size = BudgetMM)) + 
  xlab("Budget in Millions") +                       # xlab and ylab are additional functions OUTSIDE of aes().
  ylab("Audience Rating") 

# Insight: Audience rating is poorly correlated to Budget. Therefore, it is possible to get a high audience
# rating without needing a high budget. 

#----

# Create a new object with only data and coordinates.
ObjC <- ggplot(data = movies, 
               aes(x = CriticRating, y = AudienceRating))
ObjC


## Add geometries.
# Mapping
ObjC + geom_point(aes(size = BudgetMM, color = Genre))


# Setting
ObjC + geom_point(color = "dark green")

# ERROR 
# ObjC + geom_point(aes(color = "Dark Green")          # 



## Examples of Mapping vs Setting
# 1. Mapping
ObjC + geom_point(aes(size = BudgetMM, color = Genre))


# 2. Setting
ObjC + geom_point(size = I(3), color = "Navy")


# ERROR
ObjC + geom_point(aes(size = 10))




========================================================================================================}

$$$ Section 6 - 66
$ Histograms & Density Charts    }

# Create new object for histogram with Budget in the x - axis.
ObjD <- ggplot(data = movies, aes(x = BudgetMM))
ObjD

# Creation of the BudgetMM histocgram. The number of instances by budget.
?geom_histogram
BudgetHistogram <- ObjD + 
  geom_histogram(binwidth = 10, aes(fill = Genre),
                 color = "Black", alpha = I(.8)) + 
  ylab("Count") + 
  xlab("Budget in Millions")

BudgetHistogram

## Density Charts 
# Density Charts visualize the distribution of data over a continuous interval or time period.
# A variation of a histogram.

?geom_density()
ObjD + geom_density(aes(fill = Genre), position = "stack") # + xlab, ylab, etc.



========================================================================================================}

$$$ Section 6 - 67
$ Starting Layer Tips    }

ObjE <- ggplot(data = movies)
ObjE

# Histogram of Critics Ratings. A uniform distribution.
CriticalHistogram <- ObjE + geom_histogram(aes(x = CriticRating), binwidth = 5, color = "blue", fill = "white")
CriticalHistogram

# Histogram of Audience Ratings. A normal distribution.
AudienceHistogram <- ObjE + geom_histogram(aes(x = AudienceRating), binwidth = 5, color = "blue", fill = "white")
AudienceHistogram

# Interestingly the audience ratings are normally distributed while the critics ratings are uniformly distributed. 
# This suggests that audiences rate movie quality subjectively with a preference for an average movie score. Conversely,
# critics equally rate movies as either > 90 and  < 10. This indicates a smaller degree of subjectivity in film assessments.



========================================================================================================}

$$$ Section 6 - 68
$ Statistical Transformations    }

# Leveraging Statistical Transformation overlays in our ggplot graph.

?geom_smooth()                 # "Aids the eye in seeing patterns in the presence of overplotting."

# Create a new object with predefined x, y, and color values.
ObjF <- ggplot(data = movies, 
               aes(x = CriticRating,
                   y = AudienceRating,
                   color = Genre )
               )

ObjF + geom_point() + geom_smooth(se = F, level = .90)      # "se" is a binary  for confidence intervals. "level" is the confidence level (Default = .95)  

## Insights
# From this graph, we can see that low critic ratings for romance movies (between 10 and 35) tend to have 
# higher Audience ratings than any other genre. Likewise, Horror movies that receive high ratings (between 80 and 90)
# tend to have lower audience ratings than other genres. From this, we can conclude that the relationship between
# audience and critic ratings can vary based on movie genre. Overall, we can determine that there is a reasonable 
# correlation between critic and audience ratings. 


# Creating boxplots
# Create the ggplot object
ObjG <- ggplot(data = movies, aes(x = CriticRating, y = AudienceRating))

# Assign boxplot geometry with Genre as x value and color. 
BoxPlot <- ObjG + geom_boxplot(aes(x = Genre, color = Genre))


# Assign a boxplot with points included (using "jitter" to ease reading).
JitterPlot <- ObjG + 
  geom_jitter(aes(y = AudienceRating, x = Genre, color = Genre)) +    # Jitter allows us to additionally see volume of data per Genre.
  geom_boxplot(aes(x = Genre, color = Genre, alpha = I(.4)))      


### Results ### 

BoxPlot
JitterPlot
AudienceHistogram
CriticalHistogram
BudgetHistogram
BudgetHistogram2
RatingComparison
FullFacet


### Layers to a great visualization:

# Data
# Aesthetics
# Statistics
# Geometries
# Coordinates
# Factors
# Themes



========================================================================================================}

$$$ Section 6 - 69
$ Using Facets    }

### Creating multiple versions of a chart. Breaking down charts and graphs.

# Creating a histogram that will be faceted by year.
ObjH <- ggplot(data = movies, aes(x = BudgetMM))

ObjH + geom_histogram(binwidth = 10, aes(fill = Genre), color = "black")


## Facet by Genre

GenreFacet <- ObjH + 
  geom_histogram(binwidth = 10, aes(fill = Genre), color = "black") +
  facet_grid(Genre~., scales = "free") + ylab("Count")             # facet_grid() creates a facet. Breaks down Genre "~" ("by") everything.

?facet_grid()

# Facet by Year
YearFacet <- ObjH + 
  geom_histogram(binwidth = 10, aes(fill = Genre), color = "black") + 
  facet_grid(Year~., scales = "free") + ylab("Count")

GenreFacet
YearFacet

# Facets with Scatterplots

ObjI <- ggplot(data = movies, aes(x = CriticRating , y = AudienceRating, color = Genre)) # Object Creation


ObjI + geom_point(size = 3) + facet_grid(Genre~.)       # Faceting by Genre

ObjI + geom_point(size = 3) + facet_grid(.~Year)        # Faceting by Year

ObjI + geom_point(size = 3) + facet_grid(Year~Genre)    # Faceting by Genre and Year


# Adding Statistical Transformations
?geom_smooth
FullFacet <- ObjI + geom_point(aes(size = BudgetMM)) + facet_grid(Year~Genre) + geom_smooth() + coord_cartesian(ylim = c(0,100)) # Budget, year, and ratings are all depicted visually.
FullFacet    # Includes statistical transformations w/ confidence bounds. Coord_cartsian limits x and y value to 100 max.
?ylim


========================================================================================================}

$$$ Section 6 - 70
$ Coordinates    }


### Altering limits, zooming in & out of chart.

# Axis Limits

ObjJ <- ggplot( data = movies, aes(x = CriticRating, y = AudienceRating, color = Genre, size = BudgetMM))

ObjJ + geom_point() + 
  xlim(50,100) +             # xlim sets a limit to the rows depicted on the x plane. 1st arg is min, 2nd arg is max.
  ylim(50,100)               # ylim sets a limit to the rows depicted on the y plane. 




# Axis Zoom

ObjH <- ggplot( data = movies, aes(x = BudgetMM, color = Genre, size = BudgetMM))

ObjH + geom_histogram(binwidth = 10, aes(fill = Genre), color = "black") + coord_cartesian(ylim = c(0,50))



### New Functions!
 
xlim                # Sets x axis limits. Does not work well with histograms (stacked bar). Changes underlying data.
ylim                # Sets y axis limits. Does not work well with histograms (stacked bar). Changes underlying data.
facet_grid          # Uses facet_grid(Variable~. OR [AnotherVariable]) to get versions of graphics based on another variable.
?coord_cartesian    # Zooms the plot (like you're looking at it with a magnifying glass). Does not change data like x or ylim



========================================================================================================}

$$$ Section 6 - 70
$ Theming Visualizations    }

### Creating unique themes for each graph.

# Create base histogram.

ObjK <- ggplot(data = movies, aes(x = BudgetMM))


# Label Formatting
ObjK + 
  geom_histogram(binwidth = 10, aes(fill = Genre), color = "black") + 
  xlab("Budget in Millions") + 
  ylab("# of Movies") + 
  theme(axis.title.x = element_text(color = "Dark Green", size = 15), 
        axis.title.y = element_text(color = "Dark Red", size = 15),
        axis.text.x = element_text(size = 15),
        axis.text.y = element_text(size = 15))

# How to use theme() function. Be sure to look through the theme function help!
?theme() # Allows adjustments for titles, labels, fonts, background, gridlines, and legends.


# Legend formatting
BudgetHistogram2 <- ObjK + 
  geom_histogram(binwidth = 10, aes(fill = Genre), color = "black") + 
  xlab("Budget in Millions") + 
  ylab("# of Movies") + 
  ggtitle("Movie Budget Distribution") +
  
  theme(axis.title.x = element_text(color = "Dark Green", size = 15), 
        axis.title.y = element_text(color = "Dark Red", size = 15),
        axis.text.x = element_text(size = 15),
        axis.text.y = element_text(size = 15),
        
        legend.title = element_text(size = 15),                      # Adjusting legend title text size
        legend.text = element_text(size = 10),                       # Adjusting legend text size
        legend.position = c(.868,.593),                              # Adjusting legend position
        legend.key.size = unit(1,"cm"),                              # Adjusting legend size. unit() function is new.
        legend.key.width = unit(1.84,"cm"),                          # Adjusting legend width. 
        
        plot.title = element_text(color = "Dark Blue", size = 20)
        )
  
BudgetHistogram2

========================================================================================================}

$$$ BONUS SECTION
$ FizzBuzz    }

## Surprise Round of FizzBuzz!
# Goal:
# If item in list from 1 to 100 is divisible by 2, print "Fizz"
# If item in list from 1 to 100 is divisible by 5, print "Buzz"
# If item in list from 1 to 100 is divisible by 2 and 5, print "FizzBuzz"

list = c(1:100)     # Original List
output <- c()       # Output Container

for (i in list){                   
  if (i%%2 == 0 && i%%5 == 0) {    # Because FizzBuzz could be triggered by 5 or 2, it will have priority in our "for" loop. 
    output[i] <- "FizzBuzz"        # output element will contain "FizzBuzz" where the if conditional is TRUE.
  } 
  else if (i%%5 == 0) {              
    output[i] <- "Buzz"            # output element will contain "FizzBuzz" where the if conditional is TRUE.
  } 
  else if (i%%2 == 0){
    output[i] <- "Fizz"            # output element will contain "FizzBuzz" where the if conditional is TRUE.
  } 
  else {
    output[i] <- i                 # When none of the conditionals are satisfied, return the original item in the list.
  }
}

as.data.frame(print(output))

## Or, like a real DS:
# install.packages("fizzbuzzR")
library(fizzbuzzR)
fizzbuzz(start = 1, end = 100, step = 1, mod1 = 2, mod2 = 5)

