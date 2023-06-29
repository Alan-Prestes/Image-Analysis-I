
#Plotando a imagem----------------------------------------------------------------------------
plot_imagem <- function(dataset) {
  plot(dataset)

}

#informação da imagem original----------------------------------------------------------------------------
image_info<-function(dataset){
  cat("------------------------------------------------------------------------\n")
  cat("Informações sobre a imagem\n")
  info<-info_image(dataset)
  imagem<-data.frame(Classe=info$Class,
                     Largura=info$Length[1],
                     Altura=info$Length[2],
                     Canais=info$Length[3],
                     Tamanho=info$MegaPixels,
                     Tamanho_memória_MB=info$SizeMemory)
  row.names(imagem)<-"Informações"
  return(imagem)
}


#REDIMENSIONANDO----------------------------------------------------------------------------
redimensionar<-function(dataset, perc){
    percentagem<-perc
    resize_image(im=dataset, percentage = percentagem, plot = F)

}

plot_redm<-function(dataset, resposta){
  if (resposta==F) {
    return(NULL)
    
  }
  else{
plot(dataset)
  }
}

image_info_red<-function(dataset, resposta){
  if (resposta==F) {
    return(NULL)
  }
  else{
  cat("------------------------------------------------------------------------\n")
  cat("Informações sobre a imagem redimensionada\n")
  info<-info_image(dataset)
  imagem<-data.frame(Classe=info$Class,
                     Largura=info$Length[1],
                     Altura=info$Length[2],
                     Canais=info$Length[3],
                     Tamanho=info$MegaPixels,
                     Tamanho_memória_MB=info$SizeMemory)
  row.names(imagem)<-"Informações"
  return(imagem)
  }
}

#CORTANDO----------------------------------------------------------------------------
corte_image<-function(dataset, h_min, h_max, w_min, w_max, resposta){
  if (resposta==F) {
    return(NULL)
    
  }
  else{
    crop_image(dataset, w=w_min:w_max, h=h_min:h_max, plot=T)

  }
}

corte<-function(dataset, h_min, h_max, w_min, w_max, resposta){
  if (resposta==F) {
    return(NULL)
    
  }
  else{
    crop_image(dataset, w=w_min:w_max, h=h_min:h_max, plot=T)
    
  }
}


plot_cort<-function(dataset, resposta){
  if (resposta==F) {
    return(NULL)
    
  }
  else{
    plot(dataset)
  }
}

image_info_cort<-function(dataset, resposta){
  if (resposta==F) {
    return(NULL)
  }
  else{
    cat("------------------------------------------------------------------------\n")
    cat("Informações sobre a imagem cortada\n")
    info<-info_image(dataset)
    imagem<-data.frame(Classe=info$Class,
                       Largura=info$Length[1],
                       Altura=info$Length[2],
                       Canais=info$Length[3],
                       Tamanho=info$MegaPixels,
                       Tamanho_memória_MB=info$SizeMemory)
    row.names(imagem)<-"Informações"
    return(imagem)
  }
}


#ÍNDICES----------------------------------------------------------------------------
#plot_index <- function(dataset) {
# if (resposta==F) {
#    return(NULL)
#  }
#  else{
#    plot_indexes(dataset)
#  }
#}

plot_index <- function(dataset_corte_redm, dataset_redim,
                       dataset_cortado,dataset_sem_edit,
                       resposta_redm, resposta_cortar) {

  if (resposta_redm==F & resposta_cortar==F) {
    plot_indexes(dataset_sem_edit)
  }
  
  else if (resposta_redm==T & resposta_cortar==F) {
    plot_indexes(dataset_redim)
  }
  
  else if (resposta_cortar==T & resposta_redm==F) {
    plot_indexes(dataset_cortado)
  }
  
  else{
  plot_indexes(dataset_corte_redm)
  }
}

#MASCARA----------------------------------------------------------------------------
plot_mask <- function(dataset_corte_redm, dataset_redim,
                      dataset_cortado,dataset_sem_edit,
                      resposta_redm, resposta_cortar, 
                      indice, resposta_indice) {
  if (resposta_indice==T) {
    
    if (resposta_redm==F & resposta_cortar==F) {
      plot_image(gray_scale(dataset_sem_edit, method = indice, plot = T), col=3)
    }
    
    else if (resposta_redm==T & resposta_cortar==F) {
      plot_image(gray_scale(dataset_redim, method = indice, plot = T), col=3)
    }
    
    else if (resposta_cortar==T & resposta_redm==F) {
      plot_image(gray_scale(dataset_cortado, method = indice, plot = T), col=3)
    }
    
    else{
      plot_image(gray_scale(dataset_corte_redm, method = indice, plot = T), col=3)
    }
    
  }

  else{
    return(NULL)
  }
}

#plot_mask <- function(dataset, indice, resposta) {
#  if (resposta==F) {
#    return(NULL)
#  }
#  else{
#    plot_image(gray_scale(dataset, method = indice, plot = T), col=3)
#  }
#}

#PLOTANDO SEGMENTAÇÃO----------------------------------------------------------------------------
plot_segment <- function(dataset_corte_redm, dataset_redim,
                         dataset_cortado,dataset_sem_edit,
                         resposta_redm, resposta_cortar, 
                         indice, resposta_segment,
                         
                         thr, fillback, fillhull, selec_val) {
  if (resposta_segment==T) {

    if (resposta_redm==F & resposta_cortar==F) {
      segmentation(gray_scale(dataset_sem_edit, method = indice), 
                   threshold = thr, 
                   selectHigher = selec_val,
                   fillHull = fillhull,
                   fillBack = fillback,
                   plot=F)
    }
    
    else if (resposta_redm==T & resposta_cortar==F) {
      segmentation(gray_scale(dataset_redim, method = indice), 
                   threshold = thr, 
                   selectHigher = selec_val,
                   fillHull = fillhull,
                   fillBack = fillback,
                   plot=F)
    }
    
    else if (resposta_cortar==T & resposta_redm==F) {
      segmentation(gray_scale(dataset_cortado, method = indice), 
                   threshold = thr, 
                   selectHigher = selec_val,
                   fillHull = fillhull,
                   fillBack = fillback,
                   plot=F)
    }
    
    else{
      segmentation(gray_scale(dataset_corte_redm, method = indice), 
                   threshold = thr, 
                   selectHigher = selec_val,
                   fillHull = fillhull,
                   fillBack = fillback,
                   plot=F)
    }
    
  }
  else{
    return(NULL)
  }

}

plot_segment2<- function(dataset, resposta_segment){
  if(resposta_segment==F){
    return(NULL)
  }
  
  else{
    plot_image(dataset)
  }
}


#CONTANDO E MEDINDO----------------------------------------------------------------------------
med_image <- function(segmentacao, tam_min) {
    dados<-measure_image(segmentacao, plot= F,splitConnected = T, noise =tam_min)
    dados2<-as.data.frame(dados$measures)
    dados2$Objeto<-1:nrow(dados2)
    dados2<-as.data.frame(dados2)
    
    return(dados2)
}

plot_med_image1<- function(dataset_corte_redm, dataset_redim,
                           dataset_cortado,dataset_sem_edit,
                           resposta_redm, resposta_cortar, 
                           resposta_segment,
                           segmentacao) {
  if (resposta_segment==T) {
    
    if (resposta_redm==F & resposta_cortar==F) {
      plot<-mask_pixels(dataset_sem_edit,TargetPixels=segmentacao==1,
                  Contour =F,col.TargetPixels = "red",plot=T)
      return(plot)
    }
    
    else if (resposta_redm==T & resposta_cortar==F) {
      plot<-mask_pixels(dataset_redim,TargetPixels=segmentacao==1,
                  Contour =F,col.TargetPixels = "red",plot=T)
      return(plot)
    }
    
    else if (resposta_cortar==T & resposta_redm==F) {
      plot<-mask_pixels(dataset_cortado,TargetPixels=segmentacao==1,
                  Contour =F,col.TargetPixels = "red",plot=T)
      return(plot)
    }
    
    else{
      plot<-mask_pixels(dataset_corte_redm,TargetPixels=segmentacao==1,
                  Contour =F,col.TargetPixels = "red",plot=T)
      return(plot)
    }
    
  }
  else{
    return(NULL)
  }
} 


plot_med_image2<-  function(dataset_corte_redm, dataset_redim,
                           dataset_cortado,dataset_sem_edit,
                           resposta_redm, resposta_cortar, 
                           resposta_segment,
                           segmentacao, tam_min) {
  if (resposta_segment==T) {
    
    if (resposta_redm==F & resposta_cortar==F) {
      dados<-measure_image(segmentacao, plot= F,splitConnected = T, noise = tam_min)
      dados2<-as.data.frame(dados$measures)
      dados2$Objeto<-1:nrow(dados2)
      
      plot_meansures(dataset_sem_edit,coordx=dados2$x,coordy=dados2$y,
                     text=dados2$Objeto,cex = 0.9,
                     col="red" ,plot=TRUE)

      
    }
    
    else if (resposta_redm==T & resposta_cortar==F) {
      dados<-measure_image(segmentacao, plot= F,splitConnected = T, noise = tam_min)
      dados2<-as.data.frame(dados$measures)
      dados2$Objeto<-1:nrow(dados2)
      
      plot_meansures(dataset_redim,coordx=dados2$x,coordy=dados2$y,
                     text=dados2$Objeto,cex = 0.9,
                     col="red" ,plot=TRUE)

    }
    
    else if (resposta_cortar==T & resposta_redm==F) {
      dados<-measure_image(segmentacao, plot= F,splitConnected = T, noise = tam_min)
      dados2<-as.data.frame(dados$measures)
      dados2$Objeto<-1:nrow(dados2)
      
      plot_meansures(dataset_cortado,coordx=dados2$x,coordy=dados2$y,
                     text=dados2$Objeto,cex = 0.9,
                     col="red" ,plot=TRUE)
    }
    
    else{
      dados<-measure_image(segmentacao, plot= F,splitConnected = T, noise = tam_min)
      dados2<-as.data.frame(dados$measures)
      dados2$Objeto<-1:nrow(dados2)
      
      plot_meansures(dataset_corte_redm,coordx=dados2$x,coordy=dados2$y,
                     text=dados2$Objeto,cex = 0.9,
                     col="red" ,plot=TRUE)

    }
    
  }
  else{
    return(NULL)
  }
} 



plot_med_image3<-  function(dataset_corte_redm, dataset_redim,
                            dataset_cortado,dataset_sem_edit,
                            resposta_redm, resposta_cortar, 
                            resposta_segment,
                            segmentacao) {
  if (resposta_segment==T) {
    
    if (resposta_redm==F & resposta_cortar==F) {
      dados<-measure_image(segmentacao, plot= F,splitConnected = T)
      dados2<-as.data.frame(dados$measures)
      dados2$Objeto<-1:nrow(dados2)
      
      plot_meansures(dataset_sem_edit,coordx=dados2$x,coordy=dados2$y,
                     text=dados2$Objeto,cex = 0.9,
                     col="red" ,plot=T)
      
      dev.print(png, width = 1000, height = 1000)
    }
    
    else if (resposta_redm==T & resposta_cortar==F) {
      dados<-measure_image(segmentacao, plot= F,splitConnected = T)
      dados2<-as.data.frame(dados$measures)
      dados2$Objeto<-1:nrow(dados2)
      
      plot_meansures(dataset_redim,coordx=dados2$x,coordy=dados2$y,
                     text=dados2$Objeto,cex = 0.9,
                     col="red" ,plot=T)
      dev.print(png, width = 1000, height = 1000)


    }
    
    else if (resposta_cortar==T & resposta_redm==F) {
      dados<-measure_image(segmentacao, plot= F,splitConnected = T)
      dados2<-as.data.frame(dados$measures)
      dados2$Objeto<-1:nrow(dados2)

      plot_meansures(dataset_cortado,coordx=dados2$x,coordy=dados2$y,
                     text=dados2$Objeto,cex = 0.9,
                     col="red",plot=T)
      dev.print(png, width = 1000, height = 1000)

    }
    
    else{
      dados<-measure_image(segmentacao, plot= F,splitConnected = T)
      dados2<-as.data.frame(dados$measures)
      dados2$Objeto<-1:nrow(dados2)
      
      plot_meansures(dataset_corte_redm,coordx=dados2$x,coordy=dados2$y,
                     text=dados2$Objeto,cex = 0.9,
                     col="red",plot=T)
      dev.print(png, width = 1000, height = 1000)

    }
    
  }
  else{
    return(NULL)
  }
} 









