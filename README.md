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
Para executar, abra o _`R Studio`_ e execute o seguinte comando:
```ruby
library(shiny)
runGitHub(repo="image-analysis-I", username = "Alan-Prestes", ref="main")
```

## Como proceder :punch:
**1.** Importe a imagem desejada (em formato PNG ou JPEG); <br />
**2.** Após escolher o arquivo, clique em **_Importar_**; <br />

![Passo 1](https://github.com/Alan-Prestes/Image-Analysis-I/assets/87569077/28870b87-535f-473c-9af7-b452507edf53)

**3.** Caso deseje editar a imagem importada, clique em **_“Formatar imagem”_**. <br />
![Passo 2](https://github.com/Alan-Prestes/Image-Analysis-I/assets/87569077/c417ddcb-f470-40f6-9dba-cf4e2792fa42)

**3.1** Caso deseje redimensionar a imagem, basta escolher a percentagem desejada (sugere-se esta edição para imagens de alta resolução); <br />
**3.2** É possível também cortar a imagem caso deseje remover algo que prejudique a análise. <br />
**3.3** Importante estar atento à largura e altura da imagem uma vez que seja necessário escolher um intervalo mínimo e máximo de acordo com o tamanho da mesma. <br />
**4.** Após formatada a imagem, clique em **_“Definir imagem”_**. <br />
**OBS: Caso não seja necessária a edição, desconsidere a etapa 3.1, 3.2 e 3.3.** <br />
![Passo 3](https://github.com/Alan-Prestes/Image-Analysis-I/assets/87569077/50b29c7e-f2a0-4c19-ad30-261a54c06a9b)

**5.** Escolha o melhor índice de segmentação (há disponível 25 índices diferentes);<br />
![Passo 4](https://github.com/Alan-Prestes/Image-Analysis-I/assets/87569077/7917d627-0012-4ecd-9926-61d1646ca29b)

**6.** Após definido o melhor índice, é hora de realizar a segmentação dos objetos-alvos.<br />
![Passo 5](https://github.com/Alan-Prestes/Image-Analysis-I/assets/87569077/77a69561-e70a-42b0-82e1-a422c7aefc0f)

**6.1** Clique em **_“Segmentação”_** e aparecerá as opções: O Objetivo nesta seção é deixar o objeto-alvo (foreground) da cor branca (presença de pixel) e o fundo (background); <br />
**6.1.1** Definição do limiar (threshold). OBS: utilize a imagem à esquerda para definir o melhor valor; <br />
**6.1.2** Caso deseja selecionar pixels maior que o limiar, marque a caixa; <br />
**6.1.3** Caso deseje desconsiderar valores nulos no background, assinale a caixa; <br />
**6.1.4** Caso haja ruídos no interior do objeto-alvo (pixels escuros), assinale esta caixa; <br />
**6.1.5** É possível delimitar um tamanho mínimo de objeto. Caso a segmentação não seja suficiente para eliminar objetos indesejáveis, esta opção é válida. <br />
**7.** Definidos todos os parâmetros para a segmentação, clique em **_“Contar e medir”_**. <br />
![Passo 6](https://github.com/Alan-Prestes/Image-Analysis-I/assets/87569077/7e5bcd83-bb90-47e1-9fe2-f4f0369e836f)

**Como resultado, serão geradas três saídas, sendo elas:** <br />
**7.1** Tabela com a medida de todos os objetos contabilizados na imagem; <br />
**7.2** Imagem com os objetos contabilizados em destaque; <br />
**7.3** Identificação de cada objeto. <br />
**8.** É possível realizar o download da tabela em formato Excel e da imagem no formato PNG. <br />
![Passo 7](https://github.com/Alan-Prestes/Image-Analysis-I/assets/87569077/970ebfb0-70a3-4d10-aa4d-03eb4f532946)

### Pacotes utilizados
* ExpImage: [CRAN](https://cran.r-project.org/web/packages/ExpImage/ExpImage.pdf)
* shiny: [CRAN](https://cran.r-project.org/package=shiny)
* shinythemes: [CRAN](https://cran.r-project.org/package=shinythemes)
* writexl: [CRAN](https://cran.r-project.org/package=writexl)
* raster: [CRAN](https://cran.r-project.org/package=raster)
* sp: [CRAN](https://cran.r-project.org/package=sp)
