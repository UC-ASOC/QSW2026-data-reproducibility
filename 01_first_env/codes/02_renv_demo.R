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

# Let's grab a tool from our toobox.
# In other words, let's load our first package:
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
# R will ask if we want to install renv dependencies.
# Type "Y" and hit "Enter"

# NOTE:
# We used the function "install.packages()" to install the
# package "renv". This is the standard way of adding new
# tools to your toolbox in R.
#
# Normally, when you install a package this way, it gets added
# to your main toolbox, and all your projects will use the same tools.
#
# As discussed in the lecture, this can cause problems:
# different projects might need different versions of the same tool.
#
# The "renv" package helps us solve this by giving each project
# its own separate toolbox, so the tools used in one project
# don’t interfere with another.

# Let's bring renv (our tool) to our "bench":
library(renv)

# Now, using renv, let's create our first environment:
init()

# We need to restart for our environment to start working.
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

# NOTE:
# Did you noticed we used "renv::install()" instead of install.packages()?
# The original function would still work, but it is better practice to use
# renv when adding/removing new packages.

# Now, load the ggplot2 package:
library(ggplot2)

# Let's see what ggplot can do:
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
