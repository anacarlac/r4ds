#############################################################################
################### R-LADIES SÃO PAULO BOOKCLUB #############################
################### CHAPER 1- DATA VISUALIZATION ############################
#############################################################################

# Load libraries
library(tidyverse)
library(palmerpenguins)
library(ggthemes)

# Load data
penguins <- palmerpenguins::penguins

# View data writing the name of the object or using glimpse() or View()
glimpse(penguins)

# Aim: build a visualization to display the relationhip between flipper lengths and body masses by groups of species

# Starting to build the plot
ggplot(data = penguins)

# We need to add layers to tell ggplot how to visualize the data
# The mapping argument (aes) is used to set the visual properties
# Arguments x and y specify which variables go to x-axis and y-axis

# First step: add arguments in x- and y-axis
# Result: plot structure with scales of x and y, but no observations
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
)

# Second step: determine geom_ to represent the data
# Chosen geom: geom_point() to visualize a scatterplot
# Adding a geom adds another layer to the plot
# Result: a positive and linear relationship (r = 0.87)
cor(penguins$flipper_length_mm, penguins$body_mass_g, use="pairwise.complete.obs") # r = 0.87

# Structure of the plot
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +

# Add geom layer
  geom_point()

# Third step: do all penguins' species present the same relationship?
# Modify mapping arguments to incorporate groups of species
# When categorical variables are added to the mapping argument, ggplot2 will assign an unique value to each level (scaling process)
# Result: Species are separated by colors

# Structure of the plot
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)
) +

# Add geom layer
  geom_point()

# Fourth step: Add a linear regression line (lm argument)
# Add another layer for observation using geom_smooth
# Result = Three regression lines because the mapping argument of the geom_smooth was added from the inherited arguments from the global level (aes from ggplot function)

# Structure of the plot
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)
) +

# Add geom layer
  geom_point() +
  geom_smooth(method="lm")

# Fifth step: Transform the three lines in one regression line
# Fix the global argument of colors to become a local argument by including it in geom_point() layer
# Result = One regression line plotted in the graph

# Structure of the plot
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +

# Add geom layer
  geom_point(mapping = aes(color = species)) +
  geom_smooth(method="lm")

# Sixth step: Add different symbols to different groups
# Include shape argument in the  geom_point()
# Result = One regression line plotted in the graph

# Structure of the plot
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +

# Add geom layer
  geom_point(mapping = aes(color = species, shape = species)) +
  geom_smooth(method="lm")

# Seventh step: Add title and labels to the plot and change color scheme
# Include title and labels to axis using labs() argument

# Structure of the plot
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +

  # Add geom layer
  geom_point(mapping = aes(color = species, shape = species)) +
  geom_smooth(method="lm") +

  # Add labs
  labs(
    title = "Body mass and flipper length",
    subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
    x = "Flipper length (mm)", y = "Body mass (g)",
    color = "Species", shape = "Species" # defines color and shape for legend
  ) +
  # Change color scheme
  scale_color_colorblind()

# DONE!

################################ EXERCISE ####################################
# 1. How many rows and columns in penguins? 344 rows and 8 colums

# 2. What does the bill_depth_mm variable means?
?penguins
## A number denoting bill depth (millimeters)

# 3. Scatter plot of bill_depth_mm (y axis) and bill_length_mm (x axis) and describe their relationship
cor(penguins$bill_length_mm, penguins$bill_depth_mm, use="pairwise.complete.obs") # r = -0.23

ggplot(
  data = penguins,
  mapping = aes(x = bill_length_mm, y = bill_depth_mm)
) +

  # Add geom layer
  geom_point(mapping = aes(color = species, shape = species)) +
  geom_smooth(method="lm")

## There is a weak and negative relationship. Data is very scatter and follows some kind of inverted U-shape

# 4. What happens if you make a scatterplot of species vs. bill_depth_mm? What might be a better choice of geom?
ggplot(
  data = penguins,
  mapping = aes(x = species, y = bill_depth_mm)
) +

  # Add geom layer
  geom_point()

## Given that species is categorical, it does not make sense to use it as a scatterplot because scatterplot assumes two numerical variables.
## A better option is geom_bar or boxplots
ggplot(
  data = penguins,
  mapping = aes(x = species, y = bill_depth_mm)
) +

  # Add geom layer
  geom_bar(stat= "identity")

# 5. Why does the following give an error and how would you fix it?
ggplot(data = penguins) +
  geom_point()

## It does not give the attributes of axis inside the mapping function

# What does the na.rm argument do in geom_point()? What is the default value of the argument? Create a scatterplot where you successfully use this argument set to TRUE.
