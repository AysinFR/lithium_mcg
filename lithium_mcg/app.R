#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  column(offset = 4, width = 5,

    # Application title
    titlePanel("Перевод концентрации лития из мкг/л в ммоль/л."),
    wellPanel(numericInput("lithium_mcg_l", 
                 label = "Введите концентрацию в мкг/л", 
                 value = NA),
    actionButton("calculate", label = "Рассчитать"),
    h2(textOutput("lithium_value_output")),
    h3(HTML("Норма для пациентов, получающих лития карбонат в мкг/л - от 3500 до 8400.  <br>  <br> Норма в ммоль/л для детей от 0.5 до 1. <br>  <br>  Токсической концентрацией считаются значения выше 1.2 ммоль/л. "))),
    h4("Как проводится расчет: молярная масса лития = 6, 941 гр/моль.
       Поделив это равенство на 6, 941, получаем 1 гр = 1/6,941 моль.
       Далее, 1 мкг = 10^−6 гр = 10^−6/6,941 моль = 10^−3/6,941 Ммоль = 1/6941 Ммоль.
       Так, для растворов лития можно делать перерасчет по правилу 1 мкг/л = 1/6941 Ммоль/л.")
  )
    )

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  v <- reactiveValues()
  
  observeEvent(input$calculate,
               v$lithium_mmol_value <- round(input$lithium_mcg_l/6941, digits = 2)) 
  
  # lithium_value <- reactive({
  #   if (is.na(lithium_value)) {
  #     paste("Требуется ввод массы тела для определения дозы.")
  #   } else if (lithium_value <= 0.5) {
  #     paste("Концентрация -", lithium_value, "ммоль/л")
  #   } else {
  #     paste("Начальная доза составляет 12,5 мг. В течение первых 2 недель дозу постепенно повышают, с учетом переносимости, до достижения суточной дозы", lithium_value, "мг в сутки.",
  #           "В течение последующих нескольких недель дозу продолжают постепенно повышать до достижения", lithium_value, "мг в сутки.")
  #   }
  # })
  
  output$lithium_value_output <- renderText(v$lithium_mmol_value)
  
}

# Run the application 
shinyApp(ui = ui, server = server)
