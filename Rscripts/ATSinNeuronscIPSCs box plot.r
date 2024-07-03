library(ggplot2)

# Original data
treatment_groups <- c('HEK293T', 'Undifferentiated LUHMES', '7 Day Differentiated\nLUHMES', '7 Day Differentiated\nLUHMES', '7 Day Differentiated\nLUHMES', 'Brain Tissue', 'Brain Tissue', 'IPSC Neurons', 'IPSC Neurons', 'IPSC Neurons')
expression_values <- c(0, 0, 13307.94326, 12590.08149, 10369.07802, 13216.01858, 21920.60506, 31000.41697, 30152.70894, 20882.40132)

# Create a data frame
data <- data.frame(Treatment_Groups = treatment_groups, Expression = expression_values)

# Set custom colors
colors <- c('HEK293T' = 'gray', 'Undifferentiated LUHMES' = 'gray', '7 Day Differentiated\nLUHMES' = 'yellow', 'Brain Tissue' = 'orange', 'IPSC Neurons' = 'orange')

# Reorder the treatment groups
ordered_groups <- c('HEK293T', 'Undifferentiated LUHMES', '7 Day Differentiated\nLUHMES', 'Brain Tissue', 'IPSC Neurons')
data$Treatment_Groups <- factor(data$Treatment_Groups, levels = ordered_groups)

# Plotting the boxplot
ggplot(data, aes(x = Treatment_Groups, y = Expression, fill = Treatment_Groups)) +
    geom_boxplot() +
    geom_hline(yintercept = 0, color = "gray") +
    scale_fill_manual(values = colors) +
    labs(x = NULL, y = expression(italic("UBE3A-ATS") ~ " Expression (2^-ΔΔCt)"),
                title = expression(italic("UBE3A-ATS") ~ "is Only Present in Neuronal Cells")) +
    theme_minimal() +
    theme(
        plot.title = element_text(hjust = 0.5),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.ticks.y = element_line(color = "gray"),
        axis.line.y = element_line(color = "gray"),
        legend.position = "none",
        axis.text.x = element_text(margin = margin(t = -20, r = 0, b = 0, l = 0))  # Adjust top margin
    ) +
    scale_y_continuous(breaks = seq(0, 35000, by = 2500)) # Set y-axis tick marks to intervals of 2500
