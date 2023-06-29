<p align="center"> <img src="https://user-images.githubusercontent.com/87569077/236585012-9f31c629-35f3-40c3-99de-541efcb9db63.jpg" width="200">
<h1 align="center"> Dashboard para análise de imagem:Contando e biometria </h1>

## Descrição do Projeto
Dashboard criado para a segmentação de imagens com o objetivo de contar e medir objetos.

## O que a aplicação é capaz de fazer :checkered_flag:
1. Importar arquivos em PNG ou JPEG;
2. Formatar arquivo importado;
3. Escolher o melhor canal ou índice de segmentação;
4. Definir o melhor threshold;
5. Fazer o download dos resultados em png e excel;

### Como executar:
Para executar abra o _`R Studio`_ e execute o seguinte comando:
```ruby
library(shiny)
runGitHub(repo="image-analysis", username = "Alan-Prestes", ref="main")
```


### Pacotes utilizados
* ExpImage: [CRAN](https://cran.r-project.org/web/packages/ExpImage/ExpImage.pdf)
* shiny: [CRAN](https://cran.r-project.org/package=shiny)
* shinythemes: [CRAN](https://cran.r-project.org/package=shinythemes)
* writexl: [CRAN](https://cran.r-project.org/package=writexl)
* raster: [CRAN](https://cran.r-project.org/package=raster)
* sp: [CRAN](https://cran.r-project.org/package=sp)
