
library(shiny)
library(writexl)
library(ExpImage)
library(raster)
library(sp)

shinyServer(
    function(input, output) {
        FILEURL <-
            reactive({
                fileUploaded <- input$THEFILE
                if (is.null(fileUploaded)) {
                    return(NULL)
                } else {
                    return(fileUploaded$datapath)
                }
            })

        DATASET <-
            reactive({
                fileurl <- isolate(FILEURL())
                input$RUN
                if (is.null(fileurl)) {
                    return(NULL)
                } else {
                    imagem <-
                        read_image(
                            fileurl
                        )
                    return(imagem)
                }
            })
        

        output$INFO_IMAGE <-
            renderPrint({
                if (is.null(DATASET())) {
                    cat("------------------------------------------------\n")
                    cat("Informações sobre a imagem\n")
                } else {
                    image_info(dataset = DATASET())
                }
            })

        output$PLOT_IMAGE <-
            renderPlot({
                if (is.null(DATASET())) {
                    NULL
                } else {
                    plot_imagem(dataset = DATASET())
                }
            })
        
        
        REDIMENSIONAR <-
            reactive({
                if (is.null(DATASET())) {
                    NULL
                } else {
                    rdm<-redimensionar(dataset = DATASET(), perc=input$PERC)
                    return(rdm)
    
                }
            })
        
        

        output$REDIMENS <-
            renderPlot({
                if (is.null(REDIMENSIONAR())) {
                    NULL
                } else {
                    plot_redm(dataset = REDIMENSIONAR(), resposta=input$REDIM)
                    
                    
                }
            })
        
        output$INFO_IMAGE_REDM <-
            renderPrint({
                if (is.null(REDIMENSIONAR())) {
                    cat("----------------------------------------------\n")
                    cat("Informações sobre a imagem redimensionada\n")
                } else {
                    image_info_red(dataset = REDIMENSIONAR(), resposta=input$REDIM)
                }
            })
        
        
        CORTAR<-
            reactive({
                if (is.null(DATASET())) {
                    NULL
                } 
                else {
                    corte<-corte_image(dataset= DATASET(),
                                h_min=input$ALTURA_MIN, h_max=input$ALTURA_MAX,
                                w_min=input$LARGURA_MIN, w_max=input$LARGURA_MAX, resposta=input$CORTAR)
                    return(corte)
                }
            })
       
        
        output$CORTAR_IM<-
            renderPlot({
                if (is.null(CORTAR())) {
                    NULL
                } else {
                    corte_image(dataset= REDIMENSIONAR(),
                                h_min=input$ALTURA_MIN, h_max=input$ALTURA_MAX,
                                w_min=input$LARGURA_MIN, w_max=input$LARGURA_MAX, resposta=input$CORTAR)
                }
            })


        output$INFO_IMAGE_CORT <-
            renderPrint({
                if (is.null(CORTAR())) {
                    cat("----------------------------------------------\n")
                    cat("Informações sobre a imagem cortada\n")
                } else {
                    image_info_cort(dataset = corte_image(dataset= REDIMENSIONAR(),
                                                          h_min=input$ALTURA_MIN, h_max=input$ALTURA_MAX,
                                                          w_min=input$LARGURA_MIN, w_max=input$LARGURA_MAX, 
                                                          resposta=input$CORTAR), resposta=input$CORTAR)
                }
            })


        output$PLOT_INDEX <-
            renderPlot({
                input$IMAGEM_FINAL
                isolate({
                if (is.null(DATASET())) {
                    NULL
                } else {
                    plot_index(dataset_corte_redm = corte_image(dataset= REDIMENSIONAR(),
                                                     h_min=input$ALTURA_MIN, h_max=input$ALTURA_MAX,
                                                     w_min=input$LARGURA_MIN, w_max=input$LARGURA_MAX, 
                                                     resposta=input$CORTAR), 
                               dataset_redim = REDIMENSIONAR(),
                               dataset_cortado = CORTAR(),
                               dataset_sem_edit= DATASET(),
                               
                               resposta_redm=input$REDIM, 
                               resposta_cortar=input$CORTAR)
                }
            })
        })

        output$MASCARA <-
            renderPlot({
                if (is.null(DATASET())) {
                    NULL
                } else {
                    plot_mask(dataset_corte_redm = corte_image(dataset= REDIMENSIONAR(),
                                                               h_min=input$ALTURA_MIN, h_max=input$ALTURA_MAX,
                                                               w_min=input$LARGURA_MIN, w_max=input$LARGURA_MAX, 
                                                               resposta=input$CORTAR), 
                              dataset_redim = REDIMENSIONAR(),
                              dataset_cortado = CORTAR(),
                              dataset_sem_edit= DATASET(),
                              
                              resposta_redm=input$REDIM, 
                              resposta_cortar=input$CORTAR,
                              
                              indice=input$INDICE, 
                              resposta_indice=input$INDEX)
                }
            })
        

        SEGMENTACAO <-
            reactive({
                if (is.null(DATASET())) {
                    NULL
                } else {
                    segm<-plot_segment(dataset_corte_redm = corte_image(dataset= REDIMENSIONAR(),
                                                                         h_min=input$ALTURA_MIN, h_max=input$ALTURA_MAX,
                                                                         w_min=input$LARGURA_MIN, w_max=input$LARGURA_MAX, 
                                                                         resposta=input$CORTAR), 
                                        dataset_redim = REDIMENSIONAR(),
                                        dataset_cortado = CORTAR(),
                                        dataset_sem_edit= DATASET(),
                                        
                                        resposta_redm=input$REDIM, 
                                        resposta_cortar=input$CORTAR,
                                        
                                        indice=input$INDICE, 
                                        
                                       thr=input$THRESH, resposta_segment=input$SEGMENT,
                                        fillback=input$FILLBACK, fillhull=input$FILLHULL,
                                        selec_val=input$SELECTHIGHER)
                    
                    return(segm)
                }
            })
        
        output$SEGMENT <-
            renderPlot({
                if (is.null(DATASET())) {
                    NULL
                } else {
                    plot_segment2(dataset = SEGMENTACAO(), resposta_segment=input$SEGMENT)
                }
            })
        
        MEDINDO_IMAGEM <-
            reactive({
                    if (is.null(SEGMENTACAO())) {
                        NULL
                    } else {
                        med_img<-med_image(segmentacao=SEGMENTACAO(), tam_min=input$TAMANHO_MIN)
                        return(med_img)
                    }
                })
        
        
        output$MED_IMAGE <-
            renderDataTable({
               input$MEDIR
                isolate({
                    if (is.null(SEGMENTACAO())) {
                       NULL
                   } else {
                       MEDINDO_IMAGEM()
                   }
               })
                })
        
        PLOT_IMAGEM_CONT <-
            reactive({
                if (is.null(SEGMENTACAO())) {
                    NULL
                } else {
                    plot_im_contorn<-plot_med_image1(dataset_corte_redm = corte_image(dataset= REDIMENSIONAR(),
                                                                     h_min=input$ALTURA_MIN, h_max=input$ALTURA_MAX,
                                                                     w_min=input$LARGURA_MIN, w_max=input$LARGURA_MAX, 
                                                                     resposta=input$CORTAR), 
                                    dataset_redim = REDIMENSIONAR(),
                                    dataset_cortado = CORTAR(),
                                    dataset_sem_edit= DATASET(),
                                    
                                    resposta_segment=input$SEGMENT,
                                    
                                    resposta_redm=input$REDIM, 
                                    resposta_cortar=input$CORTAR,
                                    segmentacao=SEGMENTACAO())
                    return(plot_im_contorn)
                }
            })
        
        
        output$PLOT_MED_IMAGE1 <-
            renderPlot({
                input$MEDIR
                isolate({
                    if (is.null(SEGMENTACAO())) {
                        NULL
                    } else {
                        PLOT_IMAGEM_CONT()
                    }
                })
            })
        
        


        output$PLOT_MED_IMAGE2 <-
                renderPlot({
                    input$MEDIR
                    isolate({
                    if (is.null(SEGMENTACAO())) {
                        NULL
                    } else {
                        plot_med_image2(dataset_corte_redm = corte_image(dataset= REDIMENSIONAR(),
                                                                        h_min=input$ALTURA_MIN, h_max=input$ALTURA_MAX,
                                                                        w_min=input$LARGURA_MIN, w_max=input$LARGURA_MAX, 
                                                                        resposta=input$CORTAR), 
                                       dataset_redim = REDIMENSIONAR(),
                                       dataset_cortado = CORTAR(),
                                       dataset_sem_edit= DATASET(),
                                       
                                       resposta_segment=input$SEGMENT,
                                       
                                       resposta_redm=input$REDIM, 
                                       resposta_cortar=input$CORTAR,
                                       segmentacao=SEGMENTACAO(),
                                       tam_min=input$TAMANHO_MIN)
                    }
                })
                })
        
        

        output$DOWN_CONT<-downloadHandler(
            filename = function(data) {
                paste("Biometria","-", data=Sys.Date(), ".xlsx", sep="")
            },
            content = function(file) {write_xlsx(MEDINDO_IMAGEM(),
                                                 path = file)}
            )
        
        output$DOWN_IMG_COL<-downloadHandler(
            filename = function(data) {
                paste("Objetos destacados ",data=Sys.Date(), "-", ".png", sep="")
            },
            content = function(file) {write_image(x=PLOT_IMAGEM_CONT(),
                                                  files=file)}
        )
        
        })

