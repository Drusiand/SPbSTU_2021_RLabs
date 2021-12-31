REGION_OF_INTEREST <- "Центральный федеральный округ"
REGION_TOKEN <- "округ"

library("readxl")
data <- read_excel("data/reforest.xlsx")
for (i in 2:length(names(data))) {
  data[[i]] <- as.numeric(data[[i]])
}
data_complete_cases <- data[complete.cases(data),]

library("tidyr")
library("dplyr")
new_data <- data_complete_cases %>%
  pivot_longer(cols = !Region, names_to = "Year", values_to = "Reforest_value") %>%
  slice(161:208)

library(ggplot2)
new_df <- data.frame(Year = c(1999, 2000), Value = c(14123, 34143))
print(new_df)
ggplot(new_data, aes(Year, Reforest_value, color = Region)) +
  geom_line(aes(group = Region), size=2) +
  geom_point(aes(group = Region), size=3) +
  geom_text(aes(label = Reforest_value, vjust = -1.25, size = 2)) +
  theme(legend.position=c(0.1, 0.85)) +
  xlab("Год") +
  ylab("Восстановленный лес, га")
