# A Importância da Análise Exploratória de Dados

# Configurando o diretório de trabalho
setwd("C:/Users/Julia/Desktop/CienciaDeDados/1.Big-Data-Analytics-com-R-e-Microsoft-Azure-Machine-Learning/11.Machine-Learning-em-Linguagem-R")
getwd()




###############  Análise Exploratória de Dados ###############



# - Antes de construirmos um modelo de regressão e um modelo de classificação precisamos antes falar sobre a análise exploratória de dados.

# - Independemente do tipo de modelo de Machine Learning que iremos construir, a análise explorátoria é uma etapa fundamental.
#   E o que seria isso? É simplesmente conhecer/compreender os dados.
#   Não podemos começar um processo de limpeza, transformação, pré processamento dos dados se não conhecemos os daods.
#   Precisamos antes conhecer os dados, saber as médias, medianas, como os dados estão distribuidos, se as variáveis são numéricas ou categórias ou
#   se vamos precisar fazer algum tipo de transformação nessas variáveis.

# - Ou seja, as etapas seguintes de pré processamento dependem de uma Análise Exploratória.

# - Normalmente depois que carregamos os dados, a análise exploratória é a 1ª etapa a ser realizada independentemente do tipo de modelo de
#   Machine Learning que iremos criar.


# - Iremos ver abaixo uma Visão Geral para uma Análise Exploratória de Dados (tanto quanto para variáveis numéricas e variáveis categórias)
#   (utilizaremos o dataset carros-usados)



# Carregando pacotes
library(dplyr)
library('ggplot2')
library(readr)


# Carregando o dataset
carros <- read_csv("carros-usados.csv")
View(carros)
head(carros)



####### RESUMO GERAL #######


# Resumo dos dados (interpretando os dados podemos ver que a variável "ano" não precisa ser numérica.)
str(carros) 

# Exibindo Medidas de Tendência Central (valor min, 1Qu, mediana, média, 3Qu, max) (valor mediana e média iguais INDICA distribuição normal)
summary(carros$ano)               

# Exibindo Medidas de Tendência Central para duas variáveis de uma vez
summary(carros[c('preco', 'kilometragem')])



