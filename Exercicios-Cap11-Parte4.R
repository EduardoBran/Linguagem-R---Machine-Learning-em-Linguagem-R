# Lista de Exercícios Parte 4 - Capítulo 11 (Machine Learning)

# Configurando o diretório de trabalho
setwd("C:/Users/Julia/Desktop/CienciaDeDados/1.Big-Data-Analytics-com-R-e-Microsoft-Azure-Machine-Learning/11.Machine-Learning-em-Linguagem-R")
getwd()


# Carregando pacotes

library(tidyverse) # manipulação de dados
library(dplyr)     # manipulação de dados
library(corrplot)  # criar gráfico de mapa de correlação
library(ggplot2)   # criar outros gráficos (especificamente de dispersão)
library(caret)     # usado em tarefas de classificação e regressão para simplificar o processo de treinamento de modelos

# install.packages("kernlab")
library(kernlab)




# -> Contexto           : Definindo o Problema: OCR - Optical Character Recognition

# -> Problema de negócio: Seu modelo deve prever o caracter a partir do dataset fornecido. Use um modelo SVM



## Carregando os dados
letters <- read.csv("letterdata.csv")
head(letters)
#View(letters)


## Analise Exploratória

# Verificando dados ausentes
any(is.na(letters))
colSums(is.na(letters))

# Tipos dos dados
str(letters)
summary(letters)
dim(letters)


## Factor
letters$letter <- as.factor(letters$letter)
str(letters)


## Criando dados de treino e dados de teste (o ideal é sempre fazer de maneira aleatória)
letters_treino <- letters[1:16000, ]
letters_teste  <- letters[16001:20000, ]

# -> Lembrando sempre que: Treinamos o modelo com dados de TREINO e fazemos predições com dados de TESTE


## Treinando o Modelo (utilizando o kernel vanilladot)

# Criando o modelo com o kernel vanilladot
letter_classifier_van <- ksvm(letter ~ ., data = letters_treino, kernel = "vanilladot")

letter_classifier_van # Training error : 0.130062 



## Visualizando perfomance do modelo
letter_predictions_van <- predict(letter_classifier_van, letters_teste)
head(letter_predictions_van)


table(letter_predictions_van, letters_teste$letter) # matriz de confusão


resultados_van <- cbind.data.frame(letter_real = letters_teste$letter, predictions = letter_predictions_van)
head(resultados_van)
View(resultados_van)


## Criando um vetor de TRUE/FALSE indicando previsões CORRETAS/INCORRETAS
vetor_van <- letter_predictions_van == letters_teste$letter

table(vetor_van)                    # FALSE 643        TRUE 3357
prop.table(table(vetor_van))        # FALSE 0.16075    TRUE 0.83925 



## Treinando o Modelo (utilizando o kernel rbfdot)

# Criando o modelo com o kernel rbfdot
letter_classifier_rbf <- ksvm(letter ~ ., data = letters_treino, kernel = "rbfdot")

letter_classifier_rbf # Training error : 0.051562


## Visualizando perfomance do modelo
letter_predictions_rbf <- predict(letter_classifier_rbf, letters_teste)
head(letter_predictions_rbf)


resultados_rbf <- cbind.data.frame(letter_real = letters_teste$letter, predictions = letter_predictions_rbf)
head(resultados_rbf)
View(resultados_rbf)


## Criando um vetor de TRUE/FALSE indicando previsões CORRETAS/INCORRETAS
vetor_rbf <- letter_predictions_rbf == letters_teste$letter

table(vetor_rbf)                    # FALSE 277        TRUE 3723
prop.table(table(vetor_rbf))        # FALSE 0.06925    TRUE 0.93075 



# - E assim concluimos que o modelo letter_classifier_rbf que utiliza o kernel "rbfdot" se mostra mais eficiente, porém 
#   é mais pesado e demora mais a concluir.









# Os dados em "letters" parecem representar características de letras do alfabeto (caracteres) em um formato de dados tabular. 
# Cada linha representa uma observação de uma letra, e cada coluna representa uma característica específica da letra.
# Aqui está a interpretação das variáveis:
#   
# letter: Esta é uma variável categórica que representa a letra em si. Cada linha corresponde a uma letra do alfabeto,
# representada como um caractere.
# 
# xbox: Representa a largura da caixa que envolve a letra.
# 
# ybox: Representa a altura da caixa que envolve a letra.
# 
# width: Representa a largura média da letra.
# 
# height: Representa a altura média da letra.
# 
# onpix: Representa o número médio de pixels ligados na letra.
# 
# xbar: Representa a posição média do centro da letra ao longo do eixo x.
# 
# ybar: Representa a posição média do centro da letra ao longo do eixo y.
# 
# x2bar: Representa a média do segundo momento na direção x.
# 
# y2bar: Representa a média do segundo momento na direção y.
# 
# xybar: Representa a média do momento cruzado entre x e y.
# 
# x2ybar: Representa a média do segundo momento cruzado entre x e y.
# 
# xy2bar: Representa a média do segundo momento cruzado entre x e y (outro cálculo).
# 
# xedge: Representa o número médio de bordas (transições de branco para preto) na direção x.
# 
# xedgey: Representa o número médio de bordas (transições de branco para preto) na direção x e y.
# 
# yedge: Representa o número médio de bordas (transições de branco para preto) na direção y.
# 
# yedgex: Representa o número médio de bordas (transições de branco para preto) na direção y e x.
# 
# Essas variáveis parecem representar características numéricas extraídas de imagens de letras. Cada observação (linha) é uma
# letra, e as características descrevem diferentes aspectos da forma e orientação da letra. Esses tipos de dados podem ser
# usados em tarefas de classificação de caracteres ou análise de reconhecimento de letras.




