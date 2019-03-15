library(shiny)

shinyUI(fluidPage(
    titlePanel("Height Prediction Algorithm!"),
    sidebarLayout(
        sidebarPanel(
            helpText("Enter your fathers and mothers height and gender"),
            sliderInput(inputId = "heightF",
                        label = "Father's height (cm):",
                        value = 160,min = 140,max = 230,step = 1),
            sliderInput(inputId = "heightM",
                        label = "Mother's height (cm):",
                        value = 145,min = 120, max = 210, step = 1),
            radioButtons(inputId = "GenVal",
                         label = "Gender: ",
                         choices = c("Female"="female", "Male"="male")  )
        ),
        
        mainPanel(
            htmlOutput("text"),htmlOutput("predict"),plotOutput("plot", width = "70%")
        )
    )
))