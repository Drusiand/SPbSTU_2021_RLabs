data_1 <- read.table("data/data1.txt", header = TRUE, sep = " ")
data_1 <- data.frame(t(data_1))

data_2 <- read.csv("data/data2.csv")
tmp_names <- data_2$X
data_2[[1]] <- NULL
rownames(data_2) <- tmp_names

total_data <- t(rbind(data_1, data_2))
total_data <- data.frame(total_data[complete.cases(total_data), ])

data <- read.csv("data/test_data_01.csv")
fix_column <- function(column) {
    res <- as.numeric(column)
    return(res)
  }
data <- data.frame(apply(data, 1:2, fix_column))
na_df <- apply(data, 2, function(x) length(which(is.na(x))))
data_len <- dim(data)[1]

for (name in names(na_df))
  if (na_df[[name]] / data_len  > 0.8)
    data[[name]] <- NULL

tidy_data<- data %>% pivot_longer(names(data), names_to = "Type", values_to = "Value")
tidy_data <- tidy_data[complete.cases(tidy_data), ]
print(tidy_data)

hist <- ggplot(tidy_data, aes(Value)) +
    geom_histogram(binwidth=1) +
    facet_wrap(~Type) +
    xlab("Вид наблюдения") +
    ylab("Частота")

my_colors <- colorRampPalette(c("cyan", "deeppink3"))
cor_matrix <- cor(total_data)
heatmap(cor_matrix)

