# Librerias ---------------------------------------------------------------

library(tidyverse)
library(DT)
library(shiny)
library(shinydashboard)
library(plotly)


# ui ----------------------------------------------------------------------

ui <- dashboardPage(skin = "black",
  
  # Header
  dashboardHeader(title = "Medipedia",
                  dropdownMenu(type = "messages",
                               messageItem(from = "Cambia de formato",
                                           message = "Da clic aqui para ir al sitio",
                                           icon = icon("globe"),
                                           href = "https://cloudconvert.com/csv-converter",
                               ),
                               messageItem(from = "Correlaciones",
                                           message = "Da clic aqui para conocer mas",
                                           icon = icon("youtube"),
                                           href = "https://shorturl.at/dilIW",
                               )
                               
                  )
  ),
  
  # Sidebar
  dashboardSidebar(sidebarMenu(
    menuItem("Inicio", tabName = "Seccion_01", icon = icon("home")),
    menuItem("Datos", tabName = "Seccion_02", icon = icon("database")),
    menuItem("Analisis", tabName = "Seccion_03", icon = icon("chart-simple"), startExpanded = FALSE,
             menuSubItem("Analisis Esencial", tabName = "S3_submenu_01"))
             
  )),
  
  # Body
  dashboardBody(
    
    # Items - Contenidos
    tabItems(
      
      # Primer item
      tabItem(tabName = "Seccion_01",
              fluidRow(
                
                box(width = 4, solidHeader = FALSE,
                    img(src = "https://res.cloudinary.com/crunchbase-production/image/upload/c_lpad,f_auto,q_auto:eco,dpr_1/zfwgihpnc9fcnjsjohsu", height = 290, width = 340),
                    h2("Nosotros", align = "Left"),
                    p("Bienvenidos a la aplicación Medipedia, su solución integral para el análisis de datos
                      en el entorno hospitalario. En un mundo cada vez más digitalizado, entendemos la importancia
                      de utilizar información precisa y útil para mejorar la toma de decisiones en el ámbito de la salud.
                      Medipedia se ha diseñado específicamente para satisfacer las necesidades de los hospitales y centros 
                      médicos en la gestión eficiente de sus datos.")),
                
                box(width = 8, solidHeader = FALSE,
                    h2("Utilidad", align = "Left"),
                    p("Con Medipedia, los hospitales pueden acceder a potentes herramientas de análisis que
                      les permiten visualizar y comprender rápidamente los datos relevantes. Nuestra interfaz 
                      intuitiva y fácil de usar le brinda la capacidad de identificar tendencias, patrones y 
                      correlaciones, lo que le permite tomar decisiones informadas y basadas en evidencia.")),
                
                
                box(width = 8, solidHeader = FALSE,
                    p("En resumen, Hospipedia es la solución perfecta para hospitales y 
                      centros médicos que desean aprovechar al máximo sus datos. Nuestra 
                      aplicación está diseñada para ayudarlo a tomar decisiones informadas, 
                      mejorar la eficiencia operativa y proporcionar una atención de calidad superior
                      a sus pacientes. Únase a nosotros en la revolución del análisis de datos en 
                      el sector de la salud y experimente el poder transformador de Hospipedia."))
              )
              
      ),
      
      # Segundo item
      tabItem("Seccion_02",
              fluidRow(
                column(width = 12,
                       
                       box(title = "Archivo de base de datos",
                           width = 4, status = "primary", solidHeader = TRUE,
                           fileInput("archivo", "Selecciona tu archivo:", accept = ".csv")
                       ),
                       
                       box(title = "Informacion importante sobre la carga de archivos",
                           width = 8, status = "primary", solidHeader = TRUE,
                           p("Por favor, sube archivos solo de tipo CSV. Si tienes un archivo de otro tipo,
                             y deseas convertirlo en CSV, haz clic en el botón de la esquina superior derecha")
                           
                       ),
                       
                       box(title = "Previsualizacion de base de datos",
                           width = 12, status = "primary", solidHeader = TRUE,
                           fluidPage(dataTableOutput("tabla"))
                       )
                )
              )
      ),
      # Tercer Item
      tabItem("S3_submenu_01",
              fluidRow(
                
                box(title = "Grafica",
                    width = 9, status = "primary", solidHeader = TRUE,
                    plotlyOutput("grafica", height = 600)
                ),
                
                box(title = "Selector de variables",
                    width = 3, status = "primary", solidHeader = TRUE,
                    selectInput("variable_x", "Selecciona la variable x", 
                                c("Peso" = "Peso",
                                  "Altura" = "Altura",
                                  "Minutos" = "Minutos",
                                  "Examen 1" = "Examen 1",
                                  "Examen 2" = "Examen 2",
                                  "Examen 3" = "Examen 3")),
                    selectInput("variable_y", "Selecciona la variable y", 
                                c("Peso" = "Peso",
                                  "Altura" = "Altura",
                                  "Minutos" = "Minutos",
                                  "Examen 1" = "Examen 1",
                                  "Examen 2" = "Examen 2",
                                  "Examen 3" = "Examen 3"))
                ),
                
                
                infoBoxOutput(width = 3,
                              "promedio_x"),
                
                infoBoxOutput(width = 3,
                              "sd_x"),
                
                infoBoxOutput(width = 3,
                              "promedio_y"),
                
                infoBoxOutput(width = 3,
                              "sd_y"),
                
                
                column(width = 12,
                       
                       valueBoxOutput("Hombres"),
                       
                       valueBoxOutput("Mujeres"),
                       
                       valueBoxOutput("Otros")
                )
              
                
              )
      ),
      
      # Cuarto Item
      tabItem("S3_submenu_02",
              fluidRow(
                
                box(title = "Grafica",
                    width = 9, status = "primary", solidHeader = TRUE,
                    plotlyOutput("correlacion", height = 600)
                ),
                
                box(title = "Selector de variables",
                    width = 3, status = "primary", solidHeader = TRUE,
                    selectInput("variable_xx", "Selecciona la variable x", 
                                c("Peso" = "Peso",
                                  "Altura" = "Altura",
                                  "Minutos" = "Minutos",
                                  "Examen 1" = "Examen 1",
                                  "Examen 2" = "Examen 2",
                                  "Examen 3" = "Examen 3")),
                    selectInput("variable_yy", "Selecciona la variable y", 
                                c("Peso" = "Peso",
                                  "Altura" = "Altura",
                                  "Minutos" = "Minutos",
                                  "Examen 1" = "Examen 1",
                                  "Examen 2" = "Examen 2",
                                  "Examen 3" = "Examen 3"))
                ),
                
             
                
              ))
      
    )
  )
  
  
  # Fin ---------------------------------------------------------------------
)
