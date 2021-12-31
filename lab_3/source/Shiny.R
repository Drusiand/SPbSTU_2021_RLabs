library(shiny)
library(ggplot2)  # for the diamonds dataset

ui <- fluidPage(
  titlePanel("Merged data visualization"),
  sidebarLayout(
    sidebarPanel(
        checkboxGroupInput("show_vars", "Columns in \"total_data\" table to show:",
                           names(total_data), selected = names(total_data))
    ),
    mainPanel(
      tabsetPanel(
        id = 'dataset',
        tabPanel("Data from task 14", DT::dataTableOutput("mytable1")),
      )
    )
  )
)

server <- function(input, output) {
  data_1 <- read.table("data/data1.txt", header = TRUE, sep = " ")
  data_1 <- data.frame(t(data_1))

  data_2 <- read.csv("data/data2.csv")
  tmp_names <- data_2$X
  data_2[[1]] <- NULL
  rownames(data_2) <- tmp_names

  merged_data <- data.frame(t(rbind(data_1, data_2)))

  output$mytable1 <- DT::renderDataTable({
    DT::datatable(merged_data[, input$show_vars, drop = FALSE])
  })
}

shinyApp(ui, server)