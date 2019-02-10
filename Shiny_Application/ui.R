library(shiny)

# Define UI  to demo the
# Central Limit Theorem Simulation
shinyUI(pageWithSidebar(
  
  # Application title.
  headerPanel("Central Limit Theorem Simulation"),
  
  #side panel to get the input parameters for the simulation
  sidebarPanel(
    
    selectInput("distribution", "1. Choose a sample distribution to start:", 
                choices = c("Binomial", "Chi-squared", "Exponential", "Normal")),
    
    selectInput("n_sample", "2. Number of samples to draw:", 
                choices = c(10, 50, 100, 1000, 5000)),
    
    selectInput("n_simu", "3. Number of simulations:", choices = c(10, 50, 100, 1000, 5000)),
    
    helpText("Note: This is a demo for Central Limit Theorem. Please select 
             the distribution you want to use for the simulation, how many 
             samples to draw each time and how many times to draw/simulate 
             the samples."),
    
    submitButton("Run Simulation")
    
    ),
  
  # Show the simulated plots
  mainPanel(
    
    # plot of the sample ditribution based on selection
    h5("Sample Distribution"),
    verbatimTextOutput("samples"),
    plotOutput("distPlot", width = "80%", height = "200px"),
    
    # plot of the ditribution of the sample means    
    h5("Distribution of Sample Means"),
    verbatimTextOutput("simu"),
    plotOutput("simuPlot", width = "80%", height = "200px")
    
  )
  ))
