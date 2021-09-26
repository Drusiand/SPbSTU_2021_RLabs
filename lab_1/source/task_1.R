fix_data <- function(data) {

  fix_column <- function(column) {
    res <- gsub(" ", "", column)
    res <- as.numeric(res)
    if (is.na(res))
      return(column)
    return(res)
  }

  fixed_data <- apply(data, 1:2, fix_column)
  return(data.frame(fixed_data))
}