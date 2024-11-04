library(shiny)
library(ggplot2)
library(viridis)  # Ensure this package is installed

# Define UI
ui <- fluidPage(
  titlePanel("MPG Prediction App"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("hp", "Horsepower:", min = 50, max = 300, value = 150),
      sliderInput("wt", "Weight (1000 lbs):", min = 1, max = 6, value = 3),
      actionButton("submit", "Predict MPG")  # Button to trigger prediction
    ),
    
    mainPanel(
      h3("Predicted Miles Per Gallon (MPG)"),
      textOutput("prediction"),
      plotOutput("mpgPlot")  # Add a plot output
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  output$prediction <- renderText({
    req(input$submit)  # Ensure the button has been pressed
    hp <- input$hp
    wt <- input$wt
    
    mpg <- 37 - (0.05 * hp) - (3 * wt)  # Calculate MPG
    paste("Predicted MPG:", round(mpg, 2))  # Display predicted MPG
  })
  
  output$mpgPlot <- renderPlot({
    req(input$submit)  # Ensure the button has been pressed
    
    # Create a grid of horsepower and weight
    hp_values <- seq(50, 300, by = 10)
    wt_values <- seq(1, 6, by = 0.5)
    
    # Create a data frame to store MPG calculations for all combinations
    data <- expand.grid(Horsepower = hp_values, Weight = wt_values)
    data$MPG <- 37 - (0.05 * data$Horsepower) - (3 * data$Weight)  # Calculate MPG for all combinations
    
    # Plotting the MPG against Horsepower
    ggplot(data, aes(x = Horsepower, y = MPG, color = as.factor(Weight))) +
      geom_line() +  # Draw lines for different weights
      geom_point(aes(x = input$hp, y = 37 - (0.05 * input$hp) - (3 * input$wt)),
                 color = "red", size = 3) +  # Highlight the predicted point
      labs(title = "MPG vs Horsepower",
           x = "Horsepower",
           y = "Predicted MPG") +
      theme_minimal() +
      scale_color_viridis_d()  # Use discrete color scale for different weights
  })
}

# Run the application
shinyApp(ui = ui, server = server)
