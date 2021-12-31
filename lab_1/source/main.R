# source("lab_1/source/task_1.R")
# source("lab_1/source/task_2.R")

data <- read.csv("lab_1/data/test_data_01.csv")
print("fix_data output example")
print("Before:")
print(data)
print("After:")
print(fix_data(data))

print("-------------------------------------")

data <- local(get(load("lab_1/data/data.RData")))
print("get_id output example:")
print(get_id(data))