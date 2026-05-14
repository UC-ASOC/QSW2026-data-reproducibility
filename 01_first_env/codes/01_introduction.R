##--##--##--##--#
## CHAPTER 1 ####
##--##--##--##--#

# Let's run our first code!
print("Hello World!")

# Now, check our location in the system:
getwd()

# [PRO TIP]: Everytime you load a project in RStudio, you will start
# in the same path. However, it is a good practice to run "getwd()"
# in the beginning of the script to confirm your location.

# Now, let's explore our session information:
sessionInfo()
# What do you see under "Platform"? Does it match your personal computer?


# New packages are added to our library. Where is that library located?
# Write ".libPaths()" below


# [PRO TIP]: avoid adding, editing, or moving the folders/files located
# inside the ".libPaths()", as it can break your package installation
# and lead to unreproducible working spaces. Always use R itself
# to manage your library (i.e., install/uninstall packages).

# R comes with some pre-installed datasets. Let's explore one of them:
head(CO2)

# Let's grab a tool from our toobox.
# In other words, let's load our first package:
library(stats)

# Now, calculate the mean carbon dioxide concentrations:
mean(CO2$conc)

# Help pages can be accessed for further clarification.
# Just add "?" before the command, as such:
?mean()
?CO2

# Plot two columns from the "CO2" data:
plot(
  x = CO2$conc,
  xlab = "Concentration",
  y = CO2$uptake,
  ylab = "Uptake"
)
