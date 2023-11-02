# Lista de Exercícios Parte 2 - Capítulo 11 (Machine Learning)

# Configurando o diretório de trabalho
setwd("C:/Users/Julia/Desktop/CienciaDeDados/1.Big-Data-Analytics-com-R-e-Microsoft-Azure-Machine-Learning/11.Machine-Learning-em-Linguagem-R")
getwd()


# Carregando pacotes

library(tidyverse) # manipulação de dados
library(dplyr)     # manipulação de dados
library(corrplot)  # criar gráfico de mapa de correlação
library(ggplot2)   # criar outros gráficos (especificamente de dispersão)
library(caret)     # usado em tarefas de classificação e regressão para simplificar o processo de treinamento de modelos
library(ggthemes)

# Dataset com dados de estudantes
# https://archive.ics.uci.edu/ml/datasets/Student+Performance


#####  Regressão Linear #####

# -> Definição do Problema: Prever as notas dos alunos com base em diversas métricas
#                           Vamos prever a nota final (grade) dos alunos

# Carregando massa de dados
dados_matematica <- as.data.frame(read.table("student-mat.csv",sep=";",header=TRUE))
head(dados_matematica)

dados_portugues <- as.data.frame(read.table("student-por.csv",sep=";",header=TRUE))
head(dados_portugues)

# Unindo os dataframes
dados <- merge(dados_matematica, dados_portugues,
               by=c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet"))
head(dados)
View(dados)


# Arquivo original do professor (será usado este)
dados <- as.data.frame(read.csv2('estudantes.csv'))
head(dados)
View(dados)


## Analise Exploratória

# Verificando dados ausentes
any(is.na(dados))
colSums(is.na(dados))

# Tipos dos dados
str(dados)
summary(dados)


## Pré-Processamento e Encoding de Variáveis Categóricas

# Aplicando Enconding

# Selecionar todas as variáveis do tipo character
variaveis_character <- names(dados)[sapply(dados, is.character)]
variaveis_character

# Converter as variáveis character em factor
dados[variaveis_character] <- lapply(dados[variaveis_character], as.factor)

str(dados)
summary(dados)

# Dividindo os dados em treino e teste
indices <- createDataPartition(dados$G3, p = 0.80, list = FALSE)  

treino <- dados[indices, ]
teste <- dados[-indices, ]


## Modelagem


# Versão 1 do Modelo - Regressão Linear Múltipla

# Selecionar apenas as variáveis numéricas para o modelo
variaveis_numericas <- treino[, sapply(treino, is.numeric)]

# Remover as colunas G1, G2 e G3 das variáveis independentes
variaveis_independentes <- variaveis_numericas[, !(colnames(variaveis_numericas) %in% c("G1", "G2"))]

# Criar o modelo de regressão linear múltipla
modelo_v1 <- lm(data = variaveis_independentes, G3 ~ .)

summary(modelo_v1)


# Versão 2 do Modelo - Regressão Linear Múltipla

modelo_v2 <- lm(data = treino, G3 ~ Medu + failures + goout)

summary(modelo_v2)


# Versão 3 do Modelo - Regressão Linear Múltipla

modelo_v3 <- lm(data = treino, G3 ~ failures + Medu)

summary(modelo_v3)


# Versão 4 do Modelo - Regressão Linear Múltipla

modelo_v4 <- lm(data = treino, G3 ~ failures + goout)

summary(modelo_v3)


# Versão 4 do Modelo - Regressão Linear Simples

modelo_v5 <- lm(data = treino, G3 ~ failures)

summary(modelo_v5)


# Interpretando

# - A escolha do modelo depende de seus objetivos específicos. Se seu principal objetivo é a previsão precisa das
#   notas dos alunos, então você pode considerar um modelo de machine learning mais avançado, como uma regressão
#   linear regularizada (Ridge ou Lasso) ou modelos de árvore de decisão.

# - Se, por outro lado, você precisa de um modelo simples para entender quais variáveis estão mais relacionadas às
#   notas dos alunos, o Modelo_v3 (G3 ~ failures + Medu) pode ser adequado. Mesmo que o R² seja baixo, ele fornece
#   informações sobre a importância das variáveis independentes incluídas.


## Previsões

previsoes <- predict(modelo_v3, newdata = teste, type = 'response')
previsoes









#####  Modelo Ridge #####
library(glmnet)

str(dados)

# Converta as variáveis independentes em uma matriz
X <- as.matrix(variaveis_independentes[, !(colnames(variaveis_independentes) %in% c("G3"))])
X
typeof(X)

# Converta a variável dependente em um vetor
Y <- variaveis_independentes$G3
Y
typeof(Y)

# Ajuste o modelo Ridge
modelo_ridge <- glmnet(X, Y, alpha = 0)  # Use alpha = 0 para Ridge
modelo_ridge

# Escolha o valor de lambda (parâmetro de regularização) por validação cruzada
cv_ridge <- cv.glmnet(X, Y, alpha = 0)
cv_ridge

# O valor de lambda ótimo
best_lambda <- cv_ridge$lambda.min
best_lambda

# Ajuste o modelo Ridge com o lambda ótimo
modelo_ridge_final <- glmnet(X, Y, alpha = 0, lambda = best_lambda)
modelo_ridge_final

# Resumo do modelo Ridge
summary(modelo_ridge_final)

## Previsões

# Amostra aleatória de 20 linhas dos dados originais
amostra <- variaveis_independentes[sample(nrow(variaveis_independentes), 318), ]
amostra$G3 <- NULL

previsoes <- predict(modelo_ridge_final, newx = as.matrix(amostra))
previsoes <- as.vector(previsoes)


# adicionando as previsões a um novo dataframe editado
dados_com_previsoes <- variaveis_independentes
dados_com_previsoes$Previsoes_Ridge_G3 <- previsoes
dados_com_previsoes$Previsoes_Ridge_G3 <- round(dados_com_previsoes$Previsoes_Ridge_G3, 2)

head(dados_com_previsoes)


## Comparação com o modelo_v3

# -> "modelo_v3": R-quadrado (R-squared) ≈ 0.1759, o que significa que cerca de 17.59% da variabilidade em G3 é
#    explicada pelas variáveis independentes (failures e Medu) incluídas no modelo de Regressão Linear Múltipla.

# -> "modelo_ridge_final": %Dev (Desvio Deviance Percentual) ≈ 20.08, o que indica que aproximadamente 20.08% da
#    deviance (variabilidade) na variável G3 é explicada pelo modelo Ridge com a seleção de variáveis independentes.




















## Aqui está uma explicação de cada variável no conjunto de dados "dados":

# school: O tipo de escola frequentado pelo aluno ("GP" - Gabriel Pereira ou "MS" - Mousinho da Silveira).
# 
# sex: O sexo do aluno ("F" - Feminino ou "M" - Masculino).
# 
# age: A idade do aluno.
# 
# address: O tipo de endereço onde o aluno mora ("U" - Urbano ou "R" - Rural).
# 
# famsize: O tamanho da família do aluno ("GT3" - Maior que 3 pessoas ou "LE3" - Menor ou igual a 3 pessoas).
# 
# Pstatus: O status de coabitação dos pais do aluno ("A" - Pais vivem separados ou "T" - Pais vivem juntos).
# 
# Medu: A educação da mãe do aluno em uma escala de 0 a 4 
#       (0 - Nenhum, 1 - Educação primária, 2 - Educação de 5ª a 9ª série, 3 - Ensino médio ou 4 - Educação superior).
# 
# Fedu: A educação do pai do aluno em uma escala de 0 a 4 (mesma escala que o Medu).
# 
# Mjob: A ocupação da mãe do aluno.
# 
# Fjob: A ocupação do pai do aluno.
# 
# reason: A razão para escolher esta escola
#        ("home" - Proximidade da casa, "reputation" - Reputação da escola, "course" - Preferência de curso ou "other" - Outros motivos)
# 
# guardian: O responsável pelo aluno ("mother" - Mãe, "father" - Pai ou "other" - Outro responsável).
# 
# traveltime: Tempo de viagem de casa para a escola em minutos (de 1 a 4, onde 1 é menos tempo e 4 é mais tempo).
# 
# studytime: Tempo semanal de estudo em horas (de 1 a 4, onde 1 é menos tempo e 4 é mais tempo).
# 
# failures: Número de falhas de classe anteriores (numérica).
# 
# schoolsup: Suporte educacional extra da escola ("yes" - Sim ou "no" - Não).
# 
# famsup: Suporte educacional extra da família ("yes" - Sim ou "no" - Não).
# 
# paid: Aulas extras pagas no curso da disciplina ("yes" - Sim ou "no" - Não).
# 
# activities: Participação em atividades extracurriculares ("yes" - Sim ou "no" - Não).
# 
# nursery: Frequência à creche ("yes" - Sim ou "no" - Não).
# 
# higher: Deseja seguir educação superior ("yes" - Sim ou "no" - Não).
# 
# internet: Acesso à Internet em casa ("yes" - Sim ou "no" - Não).
# 
# romantic: Relacionamento romântico ("yes" - Sim ou "no" - Não).
# 
# famrel: Qualidade das relações familiares (de 1 a 5, onde 1 é pior e 5 é melhor).
# 
# freetime: Tempo livre após a escola (de 1 a 5, onde 1 é menos tempo e 5 é mais tempo).
# 
# goout: Tempo gasto com amigos (de 1 a 5, onde 1 é menos tempo e 5 é mais tempo).
# 
# Dalc: Consumo de álcool durante a semana (de 1 a 5, onde 1 é menos consumo e 5 é mais consumo).
# 
# Walc: Consumo de álcool nos fins de semana (de 1 a 5, onde 1 é menos consumo e 5 é mais consumo).
# 
# health: Estado de saúde atual (de 1 a 5, onde 1 é pior saúde e 5 é melhor saúde).
# 
# absences: Número de faltas na escola (numérica).
# 
# G1: Nota no primeiro período letivo (numérica).
# 
# G2: Nota no segundo período letivo (numérica).
# 
# G3: Nota final (numérica).



