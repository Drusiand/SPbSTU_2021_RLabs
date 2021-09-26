get_id <- function(data) {
  complete_dataframe <- Reduce(function(a, b) merge(a, b, by = "id"), data)

  get_mean_per_patient <- function(row) {
    id <- row[[1]]
    mean_temp <- mean(row[2:length(row)])
    return(data.frame(id = id, mean_temp = mean_temp))
  }

  processed_data <- apply(complete_dataframe, 1, get_mean_per_patient)
  return(Reduce(function(a, b) merge(a, b, all = TRUE), processed_data))
}