shinyUI(pageWithSidebar(  
  headerPanel("Example plot"),  
  sidebarPanel(    
    sliderInput('mu', 'Guess at the mu',value = 70, min = 60, max = 80, step = 0.05,)  ), 
  mainPanel(    
    plotOutput('newHist')  
  )
))





library(shiny)
shinyUI(pageWithSidebar(  
  headerPanel("Data science FTW!"),  
  sidebarPanel(    
    h2('Big text'),    
    h3('Sidebar')  
  ),  
  mainPanel(      
    h3('Main Panel text')  
  )
))



















library(shiny)
library(miniUI)

pickTrees <- function() {
  ui <- miniPage(
    gadgetTitleBar("Select Points by Dragging your Mouse"),
    miniContentPanel(
      plotOutput("plot", height = "100%", brush = "brush")
    )
  )
  server <- function(input, output, session) {
    output$plot <- renderPlot({
      plot(trees$Girth, trees$Volume, main = "Trees!",
           xlab = "Girth", ylab = "Volume")
    })
    observeEvent(input$done, {
      stopApp(brushedPoints(trees, input$brush,
                            xvar = "Girth", yvar = "Volume"))
    })
  }
}

shinyUI(fluidPage(
  titlePanel("Plot Random Numbers"),
  sidebarLayout(
    sidebarPanel(
      numericInput("numeric", "How Many Random Numbers Should be Plotted?",
                   value = 10000, min = 1, max = 10000, step = 1),
      sliderInput("sliderX", "Pick Minimum and Maximum X Values",
                  -100, 100, value = c(-50, 50)),
      sliderInput("sliderY", "Pick Minimum and Maximum Y Values",
                  -100, 100, value = c(-50, 50)),
      checkboxInput("show_xlab", "Show/Hide X Axis Label", value = TRUE),
      checkboxInput("show_ylab", "Show/Hide Y Axis Label", value = TRUE),
      checkboxInput("show_title", "Show/Hide Title"),
      submitButton("Submit")
      
    ),
    mainPanel(
      h3("Main Panel Text"),
      code("Some Code!"),
      textOutput("text1"),
      plotOutput("plot1")
    )
  )
))

myFirstGadget <- function() {
  ui <- miniPage(
    gadgetTitleBar("My First Gadget")
  )
  server <- function(input, output, session) {
    observeEvent(input$done, {
      stopApp()
    })
  }
  runGadget(ui,server)
}

multiplyNumbers <- function(numbers1, numbers2) {
  ui <- miniPage(
    gadgeTitleBar("Multiply Two Numbers"),
    miniContentPanel(
      selectInput("num1", "First Number", choices = numbers1),
      selectInput("num2", "Second Number", choices = numbers2)
    )
  )
  server <- function(input, output, session) {
    observeEvent(input$done, {
      num1 <- as.numeric(input$num1)
      num2 <- as.numeric(input$num2)
      stopApp(num1*num2)
    })
  }
  runGadget(ui, server)
}