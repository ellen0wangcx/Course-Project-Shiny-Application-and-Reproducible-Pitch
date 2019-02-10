library(shiny)
library(ggplot2)

sampleData <- NULL
distData <- NULL
theory_mean <<- NULL
theory_std <<- NULL
para <<- "(lamda = 0.5)"

# Define server logic required to demo the
# Central Limit Theorem Simulation
shinyServer(function(input, output) {
  
  # description of the sample ditribution plot
  output$samples <- renderPrint({
    cat("Distribution of simulated",input$n_sample, "random", 
        input$distribution, para, "samples:")
  })
  
  # plot of the sample ditribution based on selection
  set.seed(1000)
  output$distPlot <- renderPlot({
    if (input$distribution == "Binomial"){
      sampleData = rbinom(input$n_sample, 1, 0.5)
      para <<- "(lamda = 0.5)"
    }
    if (input$distribution == "Chi-squared"){
      sampleData = rchisq(input$n_sample, df = 5)
      para <<- "(df = 5)"
    }
    if (input$distribution == "Exponential"){
      sampleData = rexp(input$n_sample, 0.2)
      para <<- "(lamda = 0.5)" 
    }
    if (input$distribution == "Normal"){
      sampleData = rnorm(input$n_sample)
      para <<- "(mean=0, std=1)" 
    }
    
    ggplot(data.frame(sampleData), aes(x = sampleData)) +
      xlab("Sample Value") + ylab("Frequency") +
      geom_histogram(aes(y=..density..), color="black", 
                     fill = "red", bins = 30)  
    
    
  })
  
  # plot of the ditribution of sample means
  set.seed(2000)
  output$simuPlot <- renderPlot({
    if (input$distribution == "Binomial") {
      theory_mean <<- 0.5
      theory_std <<- sqrt(0.25/as.numeric(input$n_sample))
      for(i in 1 : input$n_simu) distData = c(distData, mean(rbinom(input$n_sample, 1, 0.5)))
    }
    if (input$distribution == "Chi-squared") {
      theory_mean <<- 5
      theory_std <<- sqrt(10/as.numeric(input$n_sample))
      for(i in 1 : input$n_simu) distData = c(distData, mean(rchisq(input$n_sample, df = 5)))
    }
    if (input$distribution == "Exponential") {
      theory_mean <<- 5
      theory_std <<- sqrt(25/as.numeric(input$n_sample))
      for(i in 1 : input$n_simu) distData = c(distData, mean(rexp(input$n_sample, 0.2)))
    }
    if (input$distribution == "Normal") {
      theory_mean <<- 0
      theory_std <<- sqrt(1/as.numeric(input$n_sample))
      for(i in 1 : input$n_simu) distData = c(distData, mean(rnorm(input$n_sample)))
    }
    
    ggplot(data.frame(distData), aes(x = distData)) +  
      geom_histogram(aes(y=..density..), color="black", 
                     fill = "red", bins = 30) +
      xlab("Sample Mean") + ylab("Density") +
      stat_function(fun = dnorm, args = list(mean = theory_mean, sd = theory_std),
                    color = "green", size = 1.0) +
      geom_vline(xintercept = theory_mean, color = "green", size = 1.0)
    
    
  })
  
  #output the theoretical mean and std of the simulation
  output$simu <- renderPrint({
    cat("Distribution of", input$n_simu, "means of",input$n_sample, 
        input$distribution, "samples:\n(theoretical mean=", theory_mean, "std=", round(theory_std, 3),
        ")")
  })
  
})