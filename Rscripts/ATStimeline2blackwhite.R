# Load the library
library(ggplot2)

# Create data frame
data <- data.frame(
  Days = factor(c('Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6', 'Day 7'), levels = c('Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6', 'Day 7')),
  Expression = c(4.592505804, 19.99672085, 510.8878734, 2167.140897, 3805.561862, 8193.649312, 11780.52507),
  StandardError = c(4.07, 4.40, 47.40, 220.45, 345.44, 594.88, 922.94)
)

# Define custom tick mark positions
tick_positions <- seq(1, 7, by = 1)

# Create ggplot line graph
p <- ggplot(data, aes(x = Days, y = Expression, group = 1)) +
  geom_line(color = "black", size = 1.25) +
  geom_point() +
  geom_errorbar(aes(ymin = Expression - StandardError, ymax = Expression + StandardError), width = 0.2, color = "gray", size = 0.75) +
  geom_hline(yintercept = 0, color = "gray") +
  geom_segment(data = data.frame(x = tick_positions), aes(x = tick_positions, xend = tick_positions, y = -100, yend = 0), color = 'gray') +
  labs(
    title = expression(paste("Expression of ", italic("UBE3A-ATS"), " Over Time")),
    x = "Days in Differentiation Media",
    y = expression(paste(italic("UBE3A-ATS"), " Expression (2^-ΔΔCt)"))
  ) +
  theme_minimal(base_size = 24) +  # Increased base font size
  theme(
    plot.title = element_text(hjust = 0.5),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.ticks.x = element_blank(),
    axis.ticks.y = element_line(color = "gray"),
    axis.line.y = element_line(color = "gray"),
    axis.text.x = element_text(margin = margin(t = -20, r = 0, b = 0, l = 0)),  # Adjust margin and vjust
    axis.title.x = element_text(margin = margin(t = 20))  # Increase space between labels and axis label
  ) +
  scale_y_continuous(breaks = seq(0, 12000, 1500)) +
  scale_x_discrete(expand = expansion(mult = c(0.1, 0.1)))  # Add 10% space before the first day and after the last day

# Show the plot
print(p)

