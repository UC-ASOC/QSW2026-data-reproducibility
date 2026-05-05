##--##--##--##--#
## CHAPTER 2 ####
##--##--##--##--#

# Now, let's check our location in the system:
getwd()

# [PRO TIP]: Everytime this project is loaded in RStudio, we will be located
# in this same path. However, it is a good practice to run "getwd()"
# in the beginning of the script to confirm our location.

# R comes with some pre-installed datasets. Let's explore one of them:
head(CO2)

# Help pages can be accessed for further clarification
?CO2

# Let's load our first package:
library(stats)

# Now, calculate the mean miles per gallon (mpg) per car:
mean(CO2$conc)

# Plot two columns from the "mtcars" data:
plot(
  x = CO2$conc,
  xlab = "Concentration",
  y = CO2$uptake,
  ylab = "Uptake"
)

##--##--##--##--#

# Let's install our first package: renv
install.packages("renv")
# R might ask if we want to install renv dependencies.
# Type "Y" and hit "Enter"

# Creating our first environment
renv::init()

# Let's check our library location again:
.libPaths()

# Restart R using one of the options below:
# Menu bar > "Session" > "Restart R"
# Ctrl + Shift + 0 (Windows)
# Command + Shift + 0 (Mac)

# Welcome to your new R environment!
# Has our library changed location?
.libPaths()

# Have you noticed any other changes?
# Tip: bottom right window might have the answer.

# Now, let's install a "renv-managed" package
renv::install("ggplot2")
# R might ask if we want to install ggplot2 dependencies.
# Once again, type "Y" and hit "Enter"

# Load the ggplot2 library:
library(ggplot2)

# Let's say what ggplot can do:
ggplot(CO2, aes(x = conc, y = uptake, color = Treatment)) +
  geom_point(size = 3) +
  facet_wrap(~ Type) +
  geom_label(
    data = CO2[CO2$uptake == max(CO2$uptake), ],
    aes(label = Plant),
    color = "black",
    size = 2.5,
    hjust = 1.4
  ) +
  labs(
    title = "CO2 Uptake vs Concentration by Type",
    x = "Concentration (mL/L)",
    y = expression("Uptake (" * mu * mol / m^2 * " sec)")
  ) +
  theme_bw()

# Checking the status of our project
renv::status()

# Snapshoting (i.e., saving) the list of used packages
renv::snapshot()

## The End
