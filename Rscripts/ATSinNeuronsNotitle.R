library(ggplot2)

# Data for the Y-axis
treatment_groups <- c('HEK293T', 'Undifferentiated LUHMES', '7 Day Differentiated LUHMES', 'Brain Tissue')
expression_values <- c(0, 0, 13307.94326, 13216.01858)
standard_errors <- c(0, 0, 2169.21653, 1844.629149)

# Create a data frame
data <- data.frame(Treatment_Groups = treatment_groups, Expression = expression_values, Standard_Error = standard_errors)

# Reorder the treatment groups
data$Treatment_Groups <- factor(data$Treatment_Groups, levels = c('HEK293T', 'Undifferentiated LUHMES', '7 Day Differentiated LUHMES', 'Brain Tissue'))

# Set custom colors
colors <- c('HEK293T' = 'gray', 'Undifferentiated LUHMES' = 'gray', '7 Day Differentiated LUHMES' = 'yellow', 'Brain Tissue' = 'orange')

# Plotting
ggplot(data, aes(x = Treatment_Groups, y = Expression, fill = Treatment_Groups)) +
  geom_bar(stat = "identity", color = "black", width = 0.8, position = position_dodge(width = 0.9)) +
  geom_errorbar(aes(ymin = Expression - Standard_Error, ymax = Expression + Standard_Error), width = 0.2, color = "black", position = position_dodge(width = 0.9)) +
  geom_segment(aes(x = -Inf, xend = -Inf, y = -30, yend = 16540), color = "gray", size = 2) +  # <-- Adjusted this line to make the y-axis line extend further.
  scale_fill_manual(values = colors, guide = "none") +
  labs(x = NULL, y = expression(italic("UBE3A-ATS") ~ "Expression (2^-ΔΔCt)")) +
  theme_minimal(base_size = 24) +
  theme(
    plot.title = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.ticks.x = element_blank(),
    axis.ticks.y = element_line(color = "gray"),
    axis.line.y = element_blank(),
    axis.text.y = element_text(family = "Arial", size = 12),
    axis.text.x = element_text(family = "Arial", size = 11, angle = 0, hjust = 0.5, vjust = 1),
    axis.title.y = element_text(margin = margin(l = 30)),
    legend.position = "none",
    plot.margin = margin(0, 0, 0, 0),
    axis.ticks.length = unit(0.2, "cm"),
    axis.ticks.margin = unit(0.1, "cm")
  ) +
  scale_x_discrete(labels = function(x) {
    ifelse(x == "Undifferentiated LUHMES", "Undifferentiated\nLUHMES",
           ifelse(x == "7 Day Differentiated LUHMES", "7 Day Differentiated\nLUHMES", x))
  }) +
  scale_y_continuous(breaks = seq(0, 165000, 1500), limits = c(-30, 16540))
