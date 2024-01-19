# server ------------------------------------------------------------------

server <- function(input, output) { 
  
  # Carga de datos ----------------------------------------------------------
  
  datos <- reactive({
    file <- input$archivo
    if(is.null(file)){return()} 
    read_csv(file$datapath, show_col_types = FALSE) %>% 
      select(Nombre = v2,
             Apellido = v3,
             Genero = v4,
             Peso = v5,
             Altura = v6,
             Minutos = v7,
             `Examen 1` = v8,
             `Examen 2` = v9,
             `Examen 3` = v10) %>% 
      mutate(Altura = Altura * 100) %>% 
      mutate(Peso = Peso + 0.5) %>% 
      mutate(Genero = case_when(Genero == 1 ~ "Hombre",
                                Genero == 2 ~ "Mujer",
                                Genero == 3 ~ "otro")) %>% 
      mutate(`Nombre Completo` = paste(Nombre, Apellido)) %>% 
      select(`Nombre Completo`, 3:9)
    
    
  })
  
  
  # Tabla de datos ----------------------------------------------------------
  
  output$tabla <- renderDataTable({
    datatable(datos(),
              rownames = FALSE)
  })
  
  # Grafica -----------------------------------------------------------------
  
  output$grafica <- renderPlotly({
    ggplotly(
      ggplot(datos(), aes(x = datos()[[input$variable_x]], 
                          y = datos()[[input$variable_y]])) + 
        geom_point() +
        geom_smooth(method ='lm', se = FALSE, color ='dodgerblue1') +
        labs(title = paste("Grafica de", input$variable_x, "vs", input$variable_y),
             x = input$variable_x,
             y = input$variable_y) +
        theme_minimal() +
        theme(plot.title = element_text(hjust = 0.5, size = 20, face = 'bold'))
    )
  })
  
  
  
  
  
  
  
  # Textos ------------------------------------------------------------------
  
  output$conteo_filas <- renderText({
    paste("La cantidad de registros en esta base de datos es: ", 
          nrow(datos() %>% filter(paciente == "Hombre")))
    
  })
  
  
  # Cajas de información ----------------------------------------------------
  
  output$promedio_y <- renderInfoBox({
    
    infoBox(title = paste("Promedio de ", input$variable_y), 
            value = round(mean(datos()[[input$variable_y]]), 2),
            color = "light-blue"
    )
    
  })
  
  output$sd_y <- renderInfoBox({
    
    infoBox(title = paste("Desviación estándar de ", input$variable_y), 
            value = round(sd(datos()[[input$variable_y]]), 2),
            color = "light-blue"
    )
    
  })
  
  output$promedio_x <- renderInfoBox({
    
    infoBox(title = paste("Promedio de ", input$variable_x), 
            value = round(mean(datos()[[input$variable_x]]), 2),
            color = "light-blue"
    )
    
  })
  
  output$sd_x <- renderInfoBox({
    
    infoBox(title = paste("Desviación Estándar de ", input$variable_x), 
            value = round(sd(datos()[[input$variable_x]]), 2),
            color = "light-blue"
    )
    
  })
  
  output$Hombres <- renderValueBox({
    
    valueBox(
      paste(nrow(datos() %>% filter(Genero == "Hombre"))), "Hombres", icon = icon("mars"),
      color = "light-blue"
    )
    
  })
  
  output$Mujeres <- renderValueBox({
    
    valueBox(
      paste(nrow(datos() %>% filter(Genero == "Mujer"))), "Mujeres", icon = icon("venus"),
      color = "light-blue"
    )
    
  })
  
  output$Otros <- renderValueBox({
    
    valueBox(
      paste(nrow(datos() %>% filter(Genero == "Otro"))), "Otros",
      color = "light-blue"
    )
    
  })
  
  
  
  
  # Fin ---------------------------------------------------------------------
  
}