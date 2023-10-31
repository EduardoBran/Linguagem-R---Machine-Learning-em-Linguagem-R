# Lista de Exercícios Parte 3 - Capítulo 11 (Machine Learning)

# Configurando o diretório de trabalho
setwd("C:/Users/Julia/Desktop/CienciaDeDados/1.Big-Data-Analytics-com-R-e-Microsoft-Azure-Machine-Learning/11.Machine-Learning-em-Linguagem-R")
getwd()


# Carregando pacotes

library(tidyverse) # manipulação de dados
library(dplyr)     # manipulação de dados
library(corrplot)  # criar gráfico de mapa de correlação
library(ggplot2)   # criar outros gráficos (especificamente de dispersão)
library(caret)     # usado em tarefas de classificação e regressão para simplificar o processo de treinamento de modelos

# Carregando o pacote MASS
library(MASS)


# Definindo o Problema: Analisando dados das casas de Boston, nos EUA e fazendo previsoes.

# The Boston Housing Dataset
# http://www.cs.toronto.edu/~delve/data/boston/bostonDetail.html

# Seu modelo deve prever a MEDV (Valor da Mediana de ocupação das casas). Utilize um modelo de rede neural!


# Importando os dados do dataset Boston
set.seed(101)
dados <- Boston
head(dados)

# Resumo dos dados
str(dados)
summary(dados)
any(is.na(dados))

# Carregando o pacote para Redes Neurais
install.packages("neuralnet")
library(neuralnet)


