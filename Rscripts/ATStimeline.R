# Load ggplot2
library(ggplot2)

# Create data frame
data <- data.frame(
    Days = factor(c('D1', 'D2', 'D3', 'D4', 'D5', 'D6', 'D7'), levels=c('D1', 'D2', 'D3', 'D4', 'D5', 'D6', 'D7')),
    Expression = c(4.592505804, 19.99672085, 510.8878734, 2167.140897, 3805.561862, 8193.649312, 11780.52507),
    StandardError = c(4.07, 4.40, 47.40, 220.45, 345.44, 594.88, 922.94)
)

# Define custom tick mark positions
tick_positions <- seq(1, 7, by=1)

# Create ggplot line graph
p <- ggplot(data, aes(x = Days, y = Expression, group = 1)) +
    geom_line() +
    geom_point() +
    geom_errorbar(aes(ymin = Expression - StandardError, ymax = Expression + StandardError), width = 0.2) +
    geom_hline(yintercept = 0, color = "gray") +
    # Custom tick marks
    geom_segment(data=data.frame(x=tick_positions), aes(x=tick_positions, xend=tick_positions, y=-100, yend=0), color='gray') +
    labs(
        title = expression(paste("Expression of ", italic("UBE3A-ATS"), " Over Time")),
        x = "Days in Differentiation Media",
        y = expression(paste(italic("UBE3A-ATS"), " Expression (2^-ΔΔCt)"))
    ) +
    theme_minimal() +
    theme(
        plot.title = element_text(hjust = 0.5),  # Center the title
        panel.grid.major = element_blank(),  # Remove major grid lines
        panel.grid.minor = element_blank(),   # Remove minor grid lines
        axis.ticks.x = element_blank(),  # Hide default x-axis tick marks
        axis.ticks.y = element_line(color = "gray"),  # Show y-axis tick marks
        axis.line.y = element_line(color = "gray") # Add y-axis line (gray color)
    ) +
    scale_y_continuous(breaks = seq(0, 12000, 1500))  # Custom y-axis ticks

# Show the plot
print(p)
