library(ggplot2)
library(data.table)
library(ggthemes) # For theme_economist_white

# Load the data
df <- fread("C:\\Users\\New\\Desktop\\R-Course-HTML-Notes\\R-Course-HTML-Notes\\R-for-Data-Science-and-Machine-Learning\\Training Exercises\\Capstone and Data Viz Projects\\Data Visualization Project\\Economist_Assignment_Data.csv",
            drop = 1)

# Initial scatter plot with points colored by Region
pl <- ggplot(df, aes(x = CPI, y = HDI)) +
  geom_point(aes(color = Region), size = 4, shape = 1, alpha = 0.7) # Add transparency

# Add a trend line with log transformation for x
pl2 <- pl +
  geom_smooth(aes(group = 1), color = 'red', method = 'lm', formula = y ~ log(x), se = FALSE)

# Add country labels for specific points
pointsToLabel <- c(
  "Germany", "Norway", "Japan", "New Zealand", "Britain", "US", "Spain", "France", "Italy",
  "Venezuela", "Argentina", "Brazil",
  "Singapore", "Bhutan", "India", "China",
  "Greece", "Russia",
  "Iraq", "Sudan", "Afghanistan",
  "Congo", "Botswana", "Cape Verde", "Rwanda", "South Africa"
)

pl3 <- pl2 +
  geom_text(aes(label = Country),
            color = 'grey20',
            data = subset(df, Country %in% pointsToLabel),
            check_overlap = TRUE)

# Adjust x-axis and y-axis scales with proper labels, limits, and breaks
pl4 <- pl3 +
  scale_x_continuous(
    name = 'Corruption Perceptions Index, 2011 (10=least corrupt)',
    limits = c(0.9, 10.5),
    breaks = 1:10
  ) +
  scale_y_continuous(
    name = 'Human Development Index, 2011 (1=best)',
    limits = c(0.2, 1)
  )

# Add R² annotation near the top-right
pl5 <- pl4 +
  annotate(
    "text",
    x = 9.5, y = 0.25, # Position of the annotation
    label = "R² = 56%",
    color = "red",
    size = 4,
    hjust = 0
  )

# Add a title and apply economist white theme
final_plot <- pl5 +
  theme_economist_white() +
  ggtitle('Corruption and Human Development') +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    axis.title.x = element_text(size = 10, face = "italic"),
    axis.title.y = element_text(size = 10, face = "italic"),
    legend.title = element_text(size = 10),
    legend.position = "top"
  )

# Print the final plot
print(final_plot)

