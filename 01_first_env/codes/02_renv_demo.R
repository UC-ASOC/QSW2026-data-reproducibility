##--##--##--##--#
## CHAPTER 2 ####
##--##--##--##--#

# Let's install our first package: renv
install.packages("renv")
# R may ask if we want to install renv dependencies.
# Type "Y" and hit "Enter"

# NOTE:
# We used the function "install.packages()" to install the
# package "renv". This is the standard way to add new
# packages to your R library.
#
# Normally, packages installed this way are added to your
# default library, meaning all your R projects share the
# same set of packages.
#
# As discussed in the lecture, this can create problems:
# different projects may require different versions of
# the same package.
#
# The "renv" package helps solve this by giving each project
# its own isolated library, so packages used in one project
# won’t interfere with packages used in another.

# Can we start a renv-managed environment after simply installing renv?
# Let's try!
init()

# It failed because we need to bring renv (our toolbox) to our "bench":
library(renv)

# [PRO TIP]:
# We usually only attach a package to our workspace when we
# plan to use many of its functions. In other words, we only
# keep a toolbox in our bench if we plan to use many of its tools.
#
# If we only need a single function, we can call it directly
# using the "::" operator, for example: "renv::init()".
# We will use this approach in our next script.

# Now, using renv, let's create our first environment:
init(bare = TRUE)

# [PRO TIP]:
# Notice the use of "bare = TRUE". When renv initializes,
# it normally scans the project for packages already in use
# and installs them automatically.
#
# This is usually very helpful, but for this demo we want
# to start with the bare minimum setup, so we use
# "bare = TRUE".

# We might need to restart for our environment to start working.
# If R does not restart automatically, use one of the options below:
# Menu bar > "Session" > "Restart R"
# Ctrl + Shift + 0 (Windows)
# Command + Shift + 0 (Mac)

# Welcome to your new R environment!
# Has our library changed location?
.libPaths()

# Have you noticed any other changes?
# Tip: bottom right window might have the answer.

# Now, let's install two "renv-managed" package
install("ggplot2")
install("tinytest")
# R might ask if we want to install ggplot2 dependencies.
# Once again, type "Y" and hit "Enter"

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
status()

# Snapshoting (i.e., saving) the list of used packages
snapshot()

# [PRO TIP]:
# We installed "tinytest" by running install("tinytest"), but never used it.
# Do you think renv tracked this packaged and added it to our project?
# Open the "renv.lock" file and check if "tinytest" is present.

## The End
