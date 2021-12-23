
========================================================================================================}

$$$ Section 5 - 46 
$ Demographic Analysis

### Goal: 
# Import and manipulate demographic data from the World Bank to determine the relationship between
# income level, internet usage, and birth rates by country. 

### Please skip to "Section 5 - 50" to view final visualization.

###  In this section we will be using:
# ggplot2 library --> qplot() function.
# World Bank's Demographic-Data CSV file.

========================================================================================================}

$$$ Section 5 - 46
$ Importing Data Into R


## 2 Methods
# Manual Entry
# Using File Path

?read.csv()      # Reads a file in table format and creates a data frame from it, 


## Method #1 - Manual Entry

stats <-  read.csv(file.choose())          # Boots file explorer and prompts you to pick a file.
stats


## Method #2 - Set Working Directory (WD) and Read Data
# A working directory is the default folder that R looks for files. 

getwd()                            # Default WD is "C:/Users/kirby/OneDrive/Documents"
setwd("C:\\Users\\kirby\\OneDrive\\Desktop\\Code\\R Code\\R for Data Science\\Section 5 - Data Frames\\Datasets")                  
                                   # Note: Double backslashed needed when setting WD.

file <- ("P2-Demographic-Data.csv")
stats <- read.csv(file)
stats


========================================================================================================}

$$$ Section 5 - 47
$ Exploring Your dataset


stats                        # Our Demographics Dataset from above.


### Several Functions that Improve Workflow

str(stats)                   # str == structure. Returns type of data. # Variables, # observations.
                             # Give characteristic of each field.

summary(stats)               # Like str(), but with additional detail for each variable.


nrow(stats)                  # Returns the number of rows
# Imported 195 rows


ncol(stats)                  # Returns the number of columns
# Imported 5 columns.        # Commenting results ensures accuracy in the long term.

 
head(stats, n = 8)           # Returns the top 6 Rows of the data. SHOWS COLUMN NAMES. 
                             # Useful for getting data overview. A Fox has a HEAD() and a TAIL()
                             # n = "x" alters the number of rows shown.

tail(stats)                  # Returns bottom 6 Rows of the data. SHOWS COLUMN NAMES.
                             # Useful for getting data overview. 
                             


========================================================================================================}

$$$ Section 5 - 48
$ Using the $ Sign 

### Use the $ to access rows within a variable more quickly.


stats
head(stats)

### Goal: Extract the country names of the top 10 countries. 

## Method 1 - Counting rows and columns.

stats[1:10,1, drop = F]


## Method 2 - Using the names of the rows and columns.

stats[1:10,"Country.Name", drop = F]


## Method 3 - Use the $ Sign to return all rows in a field.

stats$Country.Name[1:10, drop = F]                        # Note the similarities. $ Sign does not preserve dataframe integrity it seems.




stats[1:10,"Country.Name"]



# Using levels()to state all levels.
str(stats)

levels(stats$Income.Group)           # This will produce a NULL value because R did not detect levels.(& we didn't set any.)



========================================================================================================}

$$$ Section 5 - 49
$  Basic Operations with a Data Frame   }

stats                               # Our dataset from the World Bank. (Countries & Internet)

# Return columns for rows 1 and 10.
stats[c(1,10),]


## Ensure Dataframe Integrity.
stats[1,]

is.data.frame(stats[1,])            # No need for "drop = F" to keep dataframe as a matrix.
# TRUE


## Extract first column of stats.
stats[ ,"Country.Name", drop = F]

is.data.frame(stats[ , 1])            # "drop = F" is necessary when extracting a single column! 
# FALSE


## Multiple Columns (Even if it doesn't make sense)

stats$Country.Name * stats$Birth.rate   # Fails 

stats$Birth.rate * stats$Internet.users # Nonsense, but works.


## Add a column named "myCalc".

head(stats)
stats$myCalc <- stats$Birth.rate * stats$Internet.users
stats$myCalc

head(stats)                              # New column called "myCalc" added to "stats".


## Test of Knowledge
# Goal: Add a column stats$xyz <- 1:5
stats$xyz <- 1:5                         # If a vector is of insufficient length, it will be recycled.
stats$xyz                                # Shows 1 through 5 until all elements of stats are filled.

head(stats, n=10)


## Removing a column. 
# Assign the column as NULL.

stats$myCalc <- NULL
stats$xyz <- NULL

head(stats)                               # Variables and columns are gone!



========================================================================================================}

$$$ Section 5 - 50
$  Filtering Data Frames   }

# Goal:
## Use a filter to determine which countries have less than 2 internet users.
head(stats)

stats$Internet.users < 2                    # Binary result T/F if the Internet.users column is less than 2.

filter <- stats$Internet.users < 2          # filter stores our query.

stats[filter, ])                            # Here we the rows of "stats" according to our binary query "filter".



# Return rows where birth rate is greater than 40.

stats$Birth.rate > 40                       # Returns binary result for elements with birth rate > 40.

stats[stats$Birth.rate > 40, ]              # Returns all rows and columns in stats where birthrate is > 40. Very nice!



# Return rows where birth rate is greater than 40 AND internet users under "2".

stats[stats$Birth.rate > 40 & stats$Internet.users < 2, ]     # Make sure to use the & operator to filter on multiple factors.
stats[stats$Income.Group == "High income", ]


## Goal: Return all variables related to "Malta" the country.
head(stats)
stats[stats$Country.Name == "Malta", ]

### HOW FILTERING WORKS IN R: 
## We pass a vector of TRUE / FALSE  values against the given dataset. 
## Values are returned where "TRUE".

# Ex: filter <- stats$Country.Name == "Argentina"
# stats[stats$Country.Name == "Argentina" & stats$Internet.users > 3]      # This will return a dataframe consisting of Argentina's variables.

## Steps: 
# 1. Looks at referenced dataframe                      # stats
# 2. Looks at the variable referenced                   # stats$Country.Name
# 3. Looks at the filter request                        # == "Argentina" & stats$Internet.users > 3




========================================================================================================}

$$$ Section 5 - 51
$  Introduction to qplot   }


### Create basic visualizations with qplot().

head(stats)


install.packages("ggplot2")
library(ggplot2)

?qplot()
qplot(data = stats, x = Internet.users) # Assign values in keyword arguments.
                                        # Histogram of internet users.


## Graph showing birth rates by income level.
qplot(data = stats,                     
      x = Income.Group,                  
      y = Birth.rate,                   
      size = I(1),                      # Use "I" in the "size = I()" argument. Purpose of "I" is not explained.
      colour = I("blue"))                     

## Graph showing a jittered boxplot of birth rates by income level.(More Visual!)                                                               
qplot(data = stats,
      x = Income.Group,                 
      y = Birth.rate,                   
      size = I(1),                      
      colour = I("red"),
      geom = c("boxplot","jitter"))                  # "geom" is the type of plot.

### Goal: How does internet usage relate to birth rate? Also shows income group (via colors).

head(stats)

?qplot()
qplot(data = stats, x = Internet.users, y = Birth.rate, color = I("Navy"))


# BR == Birth Rate
# IU == Internet Users
BRbyIU <- qplot(data = stats, x = Internet.users, y = Birth.rate, color = I("Navy"))
BRbyIU






========================================================================================================}

$$$ Section 5 - 52
$  Visualizing w/ qplot part 1  }

## Using qplot Steps:
# 1. library() or install.packages() ggplot2
# 2. Understand arguments with "?qplot()". 
# 3. Execute plot.

head(stats)

# Base Plot - Birth Rate by Internet Users
qplot(data = stats, 
      x = Internet.users, 
      y = Birth.rate
      )


# Categorize scatter-plot by income group of each country (Using color!). 
qplot(data = stats, 
      x = Internet.users,
      y = Birth.rate, 
      size = I(2), 
      color = Income.Group
      )

### Visualization Analysis:
# From this plot, we can make some conclusions. As income group and internet users increase 
# there is a decrease in birth rates. We can also tell that there is a strong correlation between
# internet usage and income group.




========================================================================================================}

$$$ Section 5 - 53
$  Creating Data Frames  }

### Goal: 
# Produce a second scatterplot illustrating Birth Rate and Internet Usage by Country. 
# However, this time, the scatterplot neets to be categorised by Country Region. 
# Additional data has been suppllied in the form  of R vectors. 


head(stats)

qplot(data = stats,
      x = Internet.users, 
      y = Birth.rate, 
      color = ,
      )

### ADDITIONAL DATA
# Country Names
Countries_2012_Dataset <- c("Aruba","Afghanistan","Angola","Albania","United Arab Emirates","Argentina","Armenia","Antigua and Barbuda","Australia","Austria","Azerbaijan","Burundi","Belgium","Benin","Burkina Faso","Bangladesh","Bulgaria","Bahrain","Bahamas, The","Bosnia and Herzegovina","Belarus","Belize","Bermuda","Bolivia","Brazil","Barbados","Brunei Darussalam","Bhutan","Botswana","Central African Republic","Canada","Switzerland","Chile","China","Cote d'Ivoire","Cameroon","Congo, Rep.","Colombia","Comoros","Cabo Verde","Costa Rica","Cuba","Cayman Islands","Cyprus","Czech Republic","Germany","Djibouti","Denmark","Dominican Republic","Algeria","Ecuador","Egypt, Arab Rep.","Eritrea","Spain","Estonia","Ethiopia","Finland","Fiji","France","Micronesia, Fed. Sts.","Gabon","United Kingdom","Georgia","Ghana","Guinea","Gambia, The","Guinea-Bissau","Equatorial Guinea","Greece","Grenada","Greenland","Guatemala","Guam","Guyana","Hong Kong SAR, China","Honduras","Croatia","Haiti","Hungary","Indonesia","India","Ireland","Iran, Islamic Rep.","Iraq","Iceland","Israel","Italy","Jamaica","Jordan","Japan","Kazakhstan","Kenya","Kyrgyz Republic","Cambodia","Kiribati","Korea, Rep.","Kuwait","Lao PDR","Lebanon","Liberia","Libya","St. Lucia","Liechtenstein","Sri Lanka","Lesotho","Lithuania","Luxembourg","Latvia","Macao SAR, China","Morocco","Moldova","Madagascar","Maldives","Mexico","Macedonia, FYR","Mali","Malta","Myanmar","Montenegro","Mongolia","Mozambique","Mauritania","Mauritius","Malawi","Malaysia","Namibia","New Caledonia","Niger","Nigeria","Nicaragua","Netherlands","Norway","Nepal","New Zealand","Oman","Pakistan","Panama","Peru","Philippines","Papua New Guinea","Poland","Puerto Rico","Portugal","Paraguay","French Polynesia","Qatar","Romania","Russian Federation","Rwanda","Saudi Arabia","Sudan","Senegal","Singapore","Solomon Islands","Sierra Leone","El Salvador","Somalia","Serbia","South Sudan","Sao Tome and Principe","Suriname","Slovak Republic","Slovenia","Sweden","Swaziland","Seychelles","Syrian Arab Republic","Chad","Togo","Thailand","Tajikistan","Turkmenistan","Timor-Leste","Tonga","Trinidad and Tobago","Tunisia","Turkey","Tanzania","Uganda","Ukraine","Uruguay","United States","Uzbekistan","St. Vincent and the Grenadines","Venezuela, RB","Virgin Islands (U.S.)","Vietnam","Vanuatu","West Bank and Gaza","Samoa","Yemen, Rep.","South Africa","Congo, Dem. Rep.","Zambia","Zimbabwe")

# Country Codes
Codes_2012_Dataset <- c("ABW","AFG","AGO","ALB","ARE","ARG","ARM","ATG","AUS","AUT","AZE","BDI","BEL","BEN","BFA","BGD","BGR","BHR","BHS","BIH","BLR","BLZ","BMU","BOL","BRA","BRB","BRN","BTN","BWA","CAF","CAN","CHE","CHL","CHN","CIV","CMR","COG","COL","COM","CPV","CRI","CUB","CYM","CYP","CZE","DEU","DJI","DNK","DOM","DZA","ECU","EGY","ERI","ESP","EST","ETH","FIN","FJI","FRA","FSM","GAB","GBR","GEO","GHA","GIN","GMB","GNB","GNQ","GRC","GRD","GRL","GTM","GUM","GUY","HKG","HND","HRV","HTI","HUN","IDN","IND","IRL","IRN","IRQ","ISL","ISR","ITA","JAM","JOR","JPN","KAZ","KEN","KGZ","KHM","KIR","KOR","KWT","LAO","LBN","LBR","LBY","LCA","LIE","LKA","LSO","LTU","LUX","LVA","MAC","MAR","MDA","MDG","MDV","MEX","MKD","MLI","MLT","MMR","MNE","MNG","MOZ","MRT","MUS","MWI","MYS","NAM","NCL","NER","NGA","NIC","NLD","NOR","NPL","NZL","OMN","PAK","PAN","PER","PHL","PNG","POL","PRI","PRT","PRY","PYF","QAT","ROU","RUS","RWA","SAU","SDN","SEN","SGP","SLB","SLE","SLV","SOM","SRB","SSD","STP","SUR","SVK","SVN","SWE","SWZ","SYC","SYR","TCD","TGO","THA","TJK","TKM","TLS","TON","TTO","TUN","TUR","TZA","UGA","UKR","URY","USA","UZB","VCT","VEN","VIR","VNM","VUT","PSE","WSM","YEM","ZAF","COD","ZMB","ZWE")

# Region Names
Regions_2012_Dataset <- c("The Americas","Asia","Africa","Europe","Middle East","The Americas","Asia","The Americas","Oceania","Europe","Asia","Africa","Europe","Africa","Africa","Asia","Europe","Middle East","The Americas","Europe","Europe","The Americas","The Americas","The Americas","The Americas","The Americas","Asia","Asia","Africa","Africa","The Americas","Europe","The Americas","Asia","Africa","Africa","Africa","The Americas","Africa","Africa","The Americas","The Americas","The Americas","Europe","Europe","Europe","Africa","Europe","The Americas","Africa","The Americas","Africa","Africa","Europe","Europe","Africa","Europe","Oceania","Europe","Oceania","Africa","Europe","Asia","Africa","Africa","Africa","Africa","Africa","Europe","The Americas","The Americas","The Americas","Oceania","The Americas","Asia","The Americas","Europe","The Americas","Europe","Asia","Asia","Europe","Middle East","Middle East","Europe","Middle East","Europe","The Americas","Middle East","Asia","Asia","Africa","Asia","Asia","Oceania","Asia","Middle East","Asia","Middle East","Africa","Africa","The Americas","Europe","Asia","Africa","Europe","Europe","Europe","Asia","Africa","Europe","Africa","Asia","The Americas","Europe","Africa","Europe","Asia","Europe","Asia","Africa","Africa","Africa","Africa","Asia","Africa","Oceania","Africa","Africa","The Americas","Europe","Europe","Asia","Oceania","Middle East","Asia","The Americas","The Americas","Asia","Oceania","Europe","The Americas","Europe","The Americas","Oceania","Middle East","Europe","Europe","Africa","Middle East","Africa","Africa","Asia","Oceania","Africa","The Americas","Africa","Europe","Africa","Africa","The Americas","Europe","Europe","Europe","Africa","Africa","Middle East","Africa","Africa","Asia","Asia","Asia","Asia","Oceania","The Americas","Africa","Europe","Africa","Africa","Europe","The Americas","The Americas","Asia","The Americas","The Americas","The Americas","Asia","Oceania","Middle East","Oceania","Middle East","Africa","Africa","Africa","Africa")



# Creating a dataframe from the imported variables.

mydf <- data.frame(Countries_2012_Dataset,
                   Codes_2012_Dataset,
                   Regions_2012_Dataset                     # Use data.frame instead of cbind.
                   )           
head(mydf)


# (OBSOLETE) Giving new names to the created dataframe "mydf".
?colnames
colnames(mydf) <- c("Country","Code","Region")



# Renaming variables IMMEDIATELY when creating a dataframe.

mydf <- data.frame(Country = Countries_2012_Dataset,         # SYNTAX: Desired.Name = Original.Name,
                   Code = Codes_2012_Dataset,                # NOTE: No quotation marks needed. (Because name is being assigned as  the var.)
                   Region = Regions_2012_Dataset             # Saves significant time and creates cleaner code.
                   )                                         
head(mydf)


# But how to combine our two dataframes?!?

tail(mydf)
summary(mydf)
str(mydf)




========================================================================================================}

$$$ Section 5 - 54
$  Merging Data Frames  }

# Goal: Merge the stats and mydf dataframes so that we can assign a region to each country on our plot.
head(stats)
head(mydf)

# Some SQL for fun.
SELECT mydf.<colnames>, stats.<colnames> FROM stats s
INNER JOIN mydf m ON stats s
WHERE m.Code=s.Country.Code


# Create a new dataframe using the merge() function. 

?merge()                                   # Merges two data frames by common columns or row names.

# 
merged <- merge(x = stats,                 # Important to designate x and y so that "by.x" & "by.y" arguments make more sense.
                y = mydf,
                by.x = "Country.Code",     # by.<The duplicate variable>
                by.y = "Code")             # by.<The duplicate variable>

head(merged)   # Returns snippet of data. Check success.
str(merged)    # Check structure.


merged[ ,"Country"] <- NULL    # Remove the duplicate column of data from our mydf dataframe.
merged$Country <- NULL         # Alternative method.
head(merged)

colnames(merged) <- c("Code",             # Re-assigning column names for clarity.
                      "Country",
                      "Birth.Rate",
                      "Internet.Users",
                      "Income.Group",
                      "Region")
head(merged, n = 10)  # Check success of top 10.






========================================================================================================}

$$$ Section 5 - 55
$  Visualizing with Qplot 2 }


# Create an Improved Visualization with Regions included. 

head(merged)

?qplot

# Shapes

qplot(data = merged, 
      x = Internet.Users, 
      y = Birth.Rate, 
      color = Region,
      size = I(3),
      geom = "jitter",
      shape = I(15))          # Changes the shape of each point based on "R Shapes" (Google for all shapes).

# Transparency 

qplot(data = merged, 
      x = Internet.Users, 
      y = Birth.Rate, 
      color = Region,
      size = I(3),
      geom = "jitter", 
      shape = I(19),          # Changes the shape of each point based on "R Shapes" (Google for all shapes).
      alpha = I(.2))          # "alpha" determines the level of transparency btwn 0 and 1.


# Title 

qplot(data = merged, 
      x = Internet.Users, 
      y = Birth.Rate, 
      color = Region,
      size = I(3),
      geom = "jitter", 
      shape = I(19),                          # Changes the shape of each point based on "R Shapes" (Google for all shapes).
      alpha = I(.6),                          # "alpha" determines the level of transparency btwn 0 and 1.
      main = "Birthrate vs Internet Users")   # Sets the title for the graph.    




========================================================================================================}

END of Section 5
Good job!}







### Filtering Refresher
# motodf = motorcycle values only
# df = dataset
# 

motodf <- df[df$Vehicle.Type == "Motorbike"]



