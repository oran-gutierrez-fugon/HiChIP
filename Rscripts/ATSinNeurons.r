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

# Plotting the bar graph with original settings
ggplot(data, aes(x = Treatment_Groups, y = Expression, fill = Treatment_Groups)) +
    geom_bar(stat = "identity", color = "black", width = 0.8, position = position_dodge(width = 0.9)) +
    geom_errorbar(aes(ymin = Expression - Standard_Error, ymax = Expression + Standard_Error), width = 0.2, color = "black", position = position_dodge(width = 0.9)) +
    scale_fill_manual(values = colors, guide = "none") +
    labs(x = NULL, y = expression(italic("UBE3A-ATS") ~ "Expression (2^-ΔΔCt)"), 
         title = expression(italic("UBE3A-ATS") ~ "is Only Present in Neuronal Cells")) +
    theme_minimal() +
    theme(
        axis.text = element_text(family = "Arial", size = 12),
        axis.title = element_text(family = "Arial", size = 16),
        plot.title = element_text(family = "Arial", size = 20, face = "bold", hjust = -3),
        axis.text.y = element_text(family = "Arial", size = 11, face = ifelse(data$Treatment_Groups == "UBE3A-ATS", "italic", "plain")),
        axis.text.x = element_text(family = "Arial", size = 11, angle = 0, hjust = 0.5, vjust = 1),
        axis.ticks.x = element_blank(),
        legend.position = "none",
        panel.spacing = unit(0.2, "lines"),
        plot.margin = margin(0, 0, 0, 0),
        axis.title.y = element_text(margin = margin(l = 30)),
        axis.ticks.y = element_line(),
        axis.text.y.right = element_text(margin = margin(r = 15)),
        panel.grid.major.y = element_line(color = "gray90"),
        panel.grid.minor.y = element_blank(),
        axis.ticks.length = unit(0.2, "cm"),
        axis.ticks.margin = unit(0.1, "cm")
    ) +
    scale_x_discrete(labels = function(x) {
        ifelse(x == "Undifferentiated LUHMES", "Undifferentiated\nLUHMES",
               ifelse(x == "7 Day Differentiated LUHMES", "7 Day Differentiated\nLUHMES", x))
    }) +
    scale_y_continuous(breaks = seq(0, 16000, by = 2000))







    For dif timeline


    # Data for the Y-axis
days_differentiated <- c('D1', 'D2', 'D3', 'D4', 'D5', 'D6', 'D7')
expression_values <- c(4.592505804, 19.99672085, 510.8878734, 2167.140897, 3805.561862, 8193.649312, 11780.52507)
standard_errors <- c(4.073157207, 4.395319753, 47.40443181, 220.4549096, 345.43709, 594.8829192, 922.9445048)

# Create a data frame
data <- data.frame(Days_Differentiated = days_differentiated, Expression = expression_values, Standard_Error = standard_errors)

# Set all bars to orange
colors <- rep("orange", length(days_differentiated))

# Plotting the bar graph
ggplot(data, aes(x = Days_Differentiated, y = Expression, fill = Days_Differentiated)) +
  geom_bar(stat = "identity", color = "black", width = 0.6) +
  geom_errorbar(aes(ymin = Expression - Standard_Error, ymax = Expression + Standard_Error), width = 0.2, color = "black") +
  scale_fill_manual(values = colors, guide = "none") +
  labs(x = "Days Differentiated", y = expression(italic("UBE3A-ATS") ~ "Expression (2^-ΔΔCt)"), 
       title = "Expression Levels during Differentiation") +
  theme_minimal() +
  theme(
    axis.text = element_text(family = "Arial", size = 12),
    axis.title = element_text(family = "Arial", size = 16),
    plot.title = element_text(family = "Arial", size = 20, face = "bold", hjust = 0.5),
    axis.text.y = element_text(family = "Arial", size = 12),
    axis.text.x = element_text(family = "Arial", size = 12, angle = 0, hjust = 0.5, vjust = 0.5),
    axis.ticks.x = element_blank(),
    legend.position = "none",
    panel.spacing = unit(0.2, "lines"),
    plot.margin = margin(0, 0, 0, 0),
    axis.title.y = element_text(margin = margin(l = 30)),
    axis.ticks.y = element_line(),
    panel.grid.major.y = element_line(color = "gray90"),
    panel.grid.minor.y = element_blank(),
    axis.ticks.length = unit(0.2, "cm"),
    axis.ticks.margin = unit(0.1, "cm")
  )


