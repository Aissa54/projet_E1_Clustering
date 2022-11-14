library(shiny)
library(shinydashboard)

#model <- readRDS("clustering_model.rds")

# Define UI for application that draws a histogram
ui <- dashboardPage(
    
    dashboardHeader(title = "Projet Paradise"),
    
    dashboardSidebar(),
    
    dashboardBody(
        tabName= "features",
        fluidRow(box(valueBox(0,"score_prediction", color = "black", width = NULL)),
                 box(numericInput("var1",label = "Age du patient",value = 40, min = 15, width = NULL))),
        fluidRow(box(numericInput("var2",label = "Creat en µmol/l",value = 65, min = 0, width = NULL)),
                 box(numericInput("var3",label = "Uree en g/l",value = 0.2, min = 0, width = NULL))),
        fluidRow(box(numericInput("var4",label = "LACT en µg/l",value = 10, min = 0, width = NULL)),
                 box(numericInput("var5",label = "PCO2_Corrigee en mm Hg",value = 30, min = 0, width = NULL))),
        fluidRow(box(numericInput("var6",label = "Globules_blancs 10⁹/l",value = 5, min = 0, width = NULL)),
                 box(numericInput("val7",label = "HCO3 reel en mmol/l", value = 25, min = 0, width = NULL))),
        fluidRow(box(numericInput("val8",label = "Polynucléaire Neutrophile en 10⁹/l", value = 20, min = 0, width = NULL)),
                 box(numericInput("val9",label = "PH corrige", value = 7, min = 0, width = NULL))),
        fluidRow(box(selectInput("val10",label = "ICC", choices = c('Présence','Absence'))),
                 box(numericInput("val11",label = "Glucose en mmol/l", value = 4.5, min = 0, width = NULL))),
        fluidRow(box(selectInput("val12",label = "Traitement Furosemide", choices = c('Oui','Non'))),
                 box(numericInput("val13",label = "CVGR en g/dl", value = 4, min = 0, width = NULL))),
        fluidRow(box(numericInput("var14",label = "PO2_Corrigee en mm Hg",value = 27, min = 0, width = NULL)))
        
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    prediction <- reactive({
        predit(
            model,
            data_frame(
                "age"= input$var1,
                "Creat_SI"= input$var2,
                "Uree"= input$var3,
                "LACT"= input$var4,
                "PCO2_corrigee"= input$var5, 
                "Globules_blancs"= input$var6,
                "HCO3_reels"= input$var7,
                "P_neutrophiles"= input$var8,
                "PH_corrige"= input$var9,
                "ICC"= input$var10,
                "Glucose"= input$var11,
                "Trt_Furosemide"= input$var12,
                "CVGR"=input$var13,
                "PO2_corrigee"= input$var14
            ),
            type ="prob"
        )
    })
    prediction_label <- reactive({
        
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
