##--##--##--##--#
##   Goals   ####
##--##--##--##--#

# The goal of this script is to demonstrate reproducibility
# in an renv-managed project. We use a script that calculates
# metrics from a TIFF image, as well as imports and exports data.
#
# The script is beginner-friendly, but introduces a substantial
# level of complexity. As a result, the focus is on the outcome
# of the script rather than understanding every single line.

##--##--##--##--#
##   Start   ####
##--##--##--##--#

# Let's initiate a new environment; however, this time we won't start fresh.
# We will restore an environment created by someone else. The goal is to simulate
# an occasion where you are trying to replicate an environment.
#
# When initiating the project with init(), renv will ask the following:
# 1: Restore the project from the lockfile.
# 2: Discard the lockfile and re-initialize the project.
# 3: Activate the project without snapshotting or installing any packages.
# 4: Abort project initialization.
#
# We want to restore the project library; thus, type "1" and hit enter.
renv::init()

# If needed, restart R using one of the options below:
# Menu bar > "Session" > "Restart R"
# Ctrl + Shift + 0 (Windows)
# Command + Shift + 0 (Mac)

# Note:
# The project was initialized using the "::" approach,
# for example: "renv::init()".
#
# This is because we only need a few functions from the
# renv package. As mentioned in our renv introduction,
# this is often considered a cleaner and more professional
# approach, since we avoid cluttering the workspace with
# functions we may not use.
#
# Whenever we need a renv function, we can simply call it
# with the "renv::" prefix.

# Load the packages
library(EBImage)
library(ggplot2)

# Load sample image
nuclei_image <- readImage("raw_data/nuclei.tif")

# Display the image
display(nuclei_image)

# Convert to grayscale
image_gray <- channel(nuclei_image, "gray")

# Smooth image (reduces noise)
image_blur <- gblur(image_gray, sigma = 2)

# Threshold to segment objects
binary_image <- image_blur > 0.5

# Display the result
display(binary_image)

# Label connected objects (cells)
labeled_image <- bwlabel(binary_image)

# Display labeled objects in color
coloured_image <- colorLabels(labeled_image)
display(coloured_image)

# Save the colored image
writeImage(coloured_image, "processed_data/coloured_image.tif")

# Count number of objects
cell_numbers <- max(labeled_image)

# Measure size of each object (area)
cell_sizes <- table(labeled_image)[-1]  # remove background (label 0)

# Print results
print(cell_numbers)
print(summary(as.numeric(cell_sizes)))

# Convert to data frame (necessary for ggplot)
cell_dataframe <- data.frame(
  cell_id = paste0("cell_", seq_along(cell_sizes)),
  size = as.numeric(cell_sizes)
)

# Display the first few lines of the dataframe
head(cell_dataframe)

# Plot with ggplot
ggplot(cell_dataframe, aes(x = size)) +
  # Histogram plot
  geom_histogram(
    bins = 30,
    fill = "lightblue",
    color = "black"
  ) +
  # Titles
  ggtitle("Cell Size Distribution") +
  xlab("Pixel Area") +
  ylab("Number of Cells") +
  # Aesthetics
  theme_minimal() +
  theme(
    axis.title = element_text(size = 18),
    axis.text = element_text(size = 16),
    plot.title = element_text(size = 20)
  )

# Save the histogram to the folder "figures"
ggsave(
  filename = "figures/cell_size_distribution.png",
  dpi = 150,
  height = 5,
  width = 8
)

# FINAL STEPS:

# Verify the project's state:
renv::status()

# Snapshot the project's state:
renv::snapshot()
