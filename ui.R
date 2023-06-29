
library(shiny)
library(shinythemes)

# cat("Começo do FRONTEND\n")

shinyUI(
    fluidPage(
        theme = shinytheme("journal"),
        includeHTML("www/Cabecalho.Rhtml"),
        sidebarLayout(
            sidebarPanel(
                # Upload de arquivo. -----------------------------------
                fileInput(
                    inputId = "THEFILE",
                    label = "Selecione o arquivo",
                    accept = c(
                        "jpg", "png", "jpeg")
                ),
                actionButton(
                    inputId = "RUN",
                    width = , 
                    label = "Importar",
                    icon("file-import"), 
                    style="color: #121201; background-color: #11fa3c; border-color: #121201;padding:10px; font-size:80%"),
                hr(),
                # Seleção das variáveis e grau do modelo ---------------
                checkboxInput(
                    inputId = "FORMATACAO",
                    label = "Formatar imagem",
                    value = FALSE),
                conditionalPanel(
                    condition = "input.FORMATACAO",
                    div(id='my_div',style='margin-left: 20px;',
                        fluidRow(column(width=9, checkboxInput(
                        inputId = "REDIM",
                        label = "Redimensionar imagem",
                        value = FALSE)))),
                    conditionalPanel(
                        condition = "input.REDIM",
                        sliderInput(inputId ="PERC", 
                                    label = "Percentagem de redimensionamento da imagem", 
                                    min = 0.0, 
                                    max = 100,
                                    step = 1,
                                    value = 100)),
                    div(id='my_div', style='margin-left: 20px;',
                        fluidRow(column(width=9, checkboxInput(
                        inputId = "CORTAR",
                        label = "Cortar imagem",
                        value = FALSE)))),
                    conditionalPanel(
                        condition = "input.CORTAR",
                        numericInput(inputId ="ALTURA_MIN", 
                                     label = "Altura: margem superior", 
                                     value = 1),
                        numericInput(inputId ="ALTURA_MAX", 
                                     label = "Altura: margem inferior", 
                                     value = 2000),
                        numericInput(inputId ="LARGURA_MIN", 
                                     label = "Largura: margem esquerda", 
                                     value = 1),
                        numericInput(inputId ="LARGURA_MAX", 
                                     label = "Largura: margem direita", 
                                     value = 2000)),
                    actionButton(
                        inputId = "IMAGEM_FINAL",
                        label = "Definir imagem",
                        icon("image"), 
                        style="color: #121201; background-color: #11a5fa; border-color: #121201")

                    ),
                
                checkboxInput(
                    inputId = "SEGMENTATION",
                    label = "Segmentação",
                    value = FALSE),
                conditionalPanel(
                    condition = "input.SEGMENTATION",
                    div(id='my_div',style='margin-left: 20px;',
                        fluidRow(column(width=9, 
                                        checkboxInput(
                                            inputId = "INDEX",
                                            label = "Índice",
                                            value = FALSE)))),
                    conditionalPanel(
                        condition = "input.INDEX",
                        selectInput(inputId ="INDICE",
                                    label = "Escolha o índice", 
                                    choices = list("R"="r","G" ="g","B" ="b",
                                                   "RG"="rg","RB" ="rb","GB"="gb",
                                                   "RGB"="rgb","R/RGB" ="r/rgb",
                                                   "G/RGB"="g/rgb","B/RGB"="b/rgb",
                                                   "BI"="BI","BIM"="BIM", "SCI"="SCI",
                                                   "GLI"="GLI","HI"="HI",
                                                   "NGRDI"="NGRDI","SI"="SI",
                                                   "VARI"="VARI","HUE"="HUE",
                                                   "MGVRI"="MGVRI","GLI"="GLI",
                                                   "MPRI"="MPRI", "RGVBI"="RGVBI","ExG"="ExG",
                                                   "VEG"="VEG"),
                                    selected = "R")),
                    div(id='my_div', style='margin-left: 20px;',
                        fluidRow(column(width=9, 
                                        checkboxInput(
                                            inputId = "SEGMENT",
                                            label = "Segmentação",
                                            value = FALSE)))),
                    conditionalPanel(
                        condition = "input.SEGMENT",
                        sliderInput(inputId ="THRESH", 
                                    label = "Escolha o threshold:", 
                                    min = 0, 
                                    max = 1,
                                    step = 0.01,
                                    value = 0.5),
                        checkboxInput(inputId ="SELECTHIGHER", 
                                      label = "Selecionar pixels de valores maiores que o limiar", 
                                      value = F),
                        checkboxInput(inputId ="FILLBACK", 
                                      label = "Desconsiderar valores vazios dentro do fundo.", 
                                      value = F),
                        checkboxInput(inputId ="FILLHULL", 
                                      label = "Desconsiderar valores vazios dentro do foreground.", 
                                      value = F)),
                    
                    div(id='my_div', style='margin-left: 20px;',
                        fluidRow(column(width=9, 
                                        checkboxInput(
                                            inputId = "LIMITE",
                                            label = "Tamanho mínimo de objeto",
                                            value = FALSE)))),
                    conditionalPanel(
                        condition = "input.LIMITE",
                        numericInput(inputId ="TAMANHO_MIN", 
                                     label = "Tamanho mínimo", 
                                     value = 1)
                    )
                    
                ),
                
                
                actionButton(
                    inputId = "MEDIR",
                    label = "Contar e medir",
                    icon("gears"), 
                    style="color: #121201; background-color: #e8e407; border-color: #121201"),

                hr(),
            ),
            mainPanel(
                p(code("OBS: Este dashboard utiliza as funções do pacote ExpImage.")),
                tags$div(
                    p(code(a(href="https://www.youtube.com/playlist?list=PLvth1ZcREyK4wSzwg-IxvrzaNzSLLrXEB", "Link to ExpImage package")))),
                # Gráficos e saídas. -----------------------------------
                tabsetPanel(
                    id = "GUIAS",
                    tabPanel(
                        title = "Imagem original",
                        plotOutput("PLOT_IMAGE",
                                   width = 600,
                                  height = 450),
                        verbatimTextOutput("INFO_IMAGE")),
                    tabPanel(
                        title = "Imagem formatada",
                        fluidRow(column(6, wellPanel(plotOutput('REDIMENS'))),
                                 column(6, wellPanel(plotOutput('CORTAR_IM')))),
                        fluidRow(column(6, wellPanel(verbatimTextOutput('INFO_IMAGE_REDM'))),
                                 column(6, wellPanel(verbatimTextOutput('INFO_IMAGE_CORT'))))
                    ),
                    tabPanel(
                        p(code("OBS: Aguarde até todos os índices serem calculados.")),
                        title = "Índices",
                        plotOutput("PLOT_INDEX",
                                   width = 900,
                                   height = 900)),
                    tabPanel(
                        title = "Segmentação",
                        fluidRow(column(6, plotOutput('MASCARA')),
                                 column(6, plotOutput('SEGMENT')))
                        ),
                    tabPanel(
                        title = "Contagem e biometria",
                        dataTableOutput("MED_IMAGE"),
                        downloadButton(outputId = "DOWN_CONT",
                                       label= "Download da tabela",
                                       icon = shiny::icon("download"),
                                       style="color: #fcf7f8; background-color: #fc1934; border-color: #fcf7f8"),
                        fluidRow(column(6, wellPanel(plotOutput('PLOT_MED_IMAGE1'))),
                                 column(6, wellPanel(plotOutput('PLOT_MED_IMAGE2')))),
                        
                        fluidRow(column(6,downloadButton(outputId = "DOWN_IMG_COL",
                                                         label= "Baixar imagem",
                                                         icon = shiny::icon("download"),
                                                         style="color: #fcf7f8; background-color: #fc1934; border-color: #fcf7f8"))
                                 )
                        )
                ) # tabsetPanel
            ) # mainPanel
        ), # sidebarLayout
        includeHTML("www/Rodape.Rhtml"),
    ) # fluidPage
) # shinyUI

# cat("Final do FRONTEND\n")
