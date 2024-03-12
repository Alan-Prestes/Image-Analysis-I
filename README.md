<p align="center"> <img src="https://user-images.githubusercontent.com/87569077/236585012-9f31c629-35f3-40c3-99de-541efcb9db63.jpg" width="200">
<h1 align="center"> Dashboard para análise de imagem: Contagem e biometria </h3>

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
runGitHub(repo="image-analysis-I", username = "Alan-Prestes", ref="main")
```

## Como proceder :punch:
**1.** Importe a imagem desejada (em formato PNG ou JPEG);
**2.** Após escolher o arquivo, clique em “Importar”;

![Passo 1](https://github.com/Alan-Prestes/Image-Analysis-I/assets/87569077/28870b87-535f-473c-9af7-b452507edf53)

**3.** Caso deseje editar a imagem importada, clique em “Formatar imagem”.
![Passo 2](https://github.com/Alan-Prestes/Image-Analysis-I/assets/87569077/c417ddcb-f470-40f6-9dba-cf4e2792fa42)

**3.1** Caso deseje redimensionar a imagem, basta escolher a percentagem desejada (sugere-se esta edição para imagens de alta resolução); <br />
**3.2** É possível também cortar a imagem caso deseje remover algo que prejudique a análise. <br />
**3.3** Importante estar atento à largura e altura da imagem uma vez que seja necessário escolher um intervalo mínimo e máximo de acordo com o tamanho da mesma. <br />
**4.** Após formatada a imagem, clique em “Definir imagem”. <br />
**OBS: Caso não seja necessária a edição, desconsidere a etapa 3.1, 3.2 e 3.3.** <br />
![Passo 3](https://github.com/Alan-Prestes/Image-Analysis-I/assets/87569077/50b29c7e-f2a0-4c19-ad30-261a54c06a9b)

**5.** Escolha o melhor índice de segmentação (há disponível 25 índices diferentes);<br />
![Passo 4](https://github.com/Alan-Prestes/Image-Analysis-I/assets/87569077/7917d627-0012-4ecd-9926-61d1646ca29b)

**6.** Após definido o melhor índice, é hora de realizar a segmentação dos objetos-alvos.<br />


### Pacotes utilizados
* ExpImage: [CRAN](https://cran.r-project.org/web/packages/ExpImage/ExpImage.pdf)
* shiny: [CRAN](https://cran.r-project.org/package=shiny)
* shinythemes: [CRAN](https://cran.r-project.org/package=shinythemes)
* writexl: [CRAN](https://cran.r-project.org/package=writexl)
* raster: [CRAN](https://cran.r-project.org/package=raster)
* sp: [CRAN](https://cran.r-project.org/package=sp)
