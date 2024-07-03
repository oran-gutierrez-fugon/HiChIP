library(ggplot2)

# Data for the Y-axis
treatment_groups <- c('HEK293T', 'Undifferentiated LUHMES', 'LUHMES Neurons-1', 'LUHMES Neurons-2', 'LUHMES Neurons-3', 'Brain-1406', 'Brain-1136', 'IPSCs-1', 'IPSCs-2', 'IPSCs-3')
expression_values <- c(0, 0, 13307.94326, 12590.08149, 10369.07802, 13216.01858, 21920.60506, 31000.41697, 30152.70894, 20882.40132)
standard_errors <- c(NA, NA, 2169.21653, 2033.879676, 2010.167119, 1844.629149, 839.3440519, 3895.006013, 808.6433003, 499.3778348)

# Create a data frame
data <- data.frame(Treatment_Groups = treatment_groups, Expression = expression_values, Standard_Error = standard_errors)

# Reorder the treatment groups
data$Treatment_Groups <- factor(data$Treatment_Groups, levels = treatment_groups)

# Set custom colors
colors <- c('HEK293T' = 'gray', 'Undifferentiated LUHMES' = 'gray', 'LUHMES Neurons-1' = 'yellow', 'LUHMES Neurons-2' = 'yellow', 'LUHMES Neurons-3' = 'yellow', 'Brain-1406' = 'orange', 'Brain-1136' = 'orange', 'IPSCs-1' = 'orange', 'IPSCs-2' = 'orange', 'IPSCs-3' = 'orange')

# Plotting the bar graph
ggplot(data, aes(x = Treatment_Groups, y = Expression, fill = Treatment_Groups)) +
  geom_bar(stat = "identity", color = "black", width = 0.8, position = position_dodge(width = 0.9)) +
  geom_errorbar(aes(ymin = Expression - Standard_Error, ymax = Expression + Standard_Error), width = 0.2, color = "black", position = position_dodge(width = 0.9)) +
  geom_hline(yintercept = 0, color = "gray") +
  scale_fill_manual(values = colors, guide = "none") +
  labs(x = NULL, y = expression(italic("UBE3A-ATS") ~ "Expression (2^-ΔΔCt)"),
       title = expression(italic("UBE3A-ATS") ~ "is Only Present in Neuronal Cells")) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.ticks.y = element_line(color = "gray"),
    axis.line.y = element_line(color = "gray")
  ) +
  scale_x_discrete(labels = function(x) {
    ifelse(x == "Undifferentiated LUHMES", "Undifferentiated\nLUHMES",
           ifelse(x %in% c("LUHMES Neurons-1", "LUHMES Neurons-2", "LUHMES Neurons-3"), paste0("LUHMES\nNeurons-", sub(".*-(\\d+)", "\\1", x)), x))
  }) +
  scale_y_continuous(breaks = seq(0, 33000, by = 2500))
