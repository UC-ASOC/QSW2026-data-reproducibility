##--##--##--##--#
##   RECAP   ####
##--##--##--##--#

# First, let's confirm that renv is available:
ifelse(
  requireNamespace("renv", quietly = TRUE),   # is renv available?
  "Success! The package is available",        # If true, this is the output
  "!!WARNING!! THE PACKAGE IS NOT AVAILABLE"  # If false, this is the ouput
)

# The function above is known as an "if statement". If a condition is met, then R performs
# a certain action, but if the condition is not met, then it performs another action.

# After confirming that renv is available, let's load it:
library(renv)

# Now, let's initiate a new environment. However, this time we won't start fresh.
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
init()

# Restart R using one of the options below:
# Menu bar > "Session" > "Restart R"
# Ctrl + Shift + 0 (Windows)
# Command + Shift + 0 (Mac)

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
  size = as.numeric(cell_sizes)
)

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
status()

# Snapshot the project's state:
snapshot()
