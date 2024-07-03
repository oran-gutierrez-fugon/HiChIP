library(ggplot2)

data <- data.frame(
  Days = factor(c('Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6', 'Day 7'), levels = c('Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6', 'Day 7')),
  Expression = c(4.592505804, 19.99672085, 510.8878734, 2167.140897, 3805.561862, 8193.649312, 11780.52507),
  StandardError = c(4.07, 4.40, 47.40, 220.45, 345.44, 594.88, 922.94)
)

p <- ggplot(data, aes(x = Days, y = Expression, group = 1)) +
  geom_line(color = "black", size = 1.25) +
  geom_point() +
  geom_errorbar(aes(ymin = Expression - StandardError, ymax = Expression + StandardError), width = 0.2, color = "black", size = 0.75) +
  labs(
    x = "Days in Differentiation Media",
    y = expression(paste(italic("UBE3A-ATS"), " Expression (2^-ΔΔCt)"))
  ) +
  theme_minimal(base_size = 24) +
  theme(
    plot.title = element_text(hjust = 0.5),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.ticks.x = element_line(color = "gray", size = 0.75),
    axis.ticks.y = element_line(color = "gray", size = 0.75),
    axis.text.y = element_text(family = "Arial", size = 12),
    axis.text.x = element_text(margin = margin(t = 5, r = 0, b = 0, l = 0)),
    axis.title.x = element_text(margin = margin(t = 20)),
    axis.line.y = element_line(color = "gray", size = 0.75),
    axis.line.x = element_line(color = "gray", size = 0.75)
  ) +
  scale_y_continuous(breaks = c(seq(0, 12000, 1500), 13500), limits = c(0, 13500), expand = expansion(mult = c(0, 0))) +
  scale_x_discrete(position = "bottom", expand = expansion(mult = c(0.05, 0.05))) +
  coord_cartesian(clip = 'off')

print(p)


