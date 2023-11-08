# Lista de Exercícios Parte 2 - Capítulo 11 (Machine Learning) CORREÇÃO PROFESSOR

# Configurando o diretório de trabalho
setwd("C:/Users/Julia/Desktop/CienciaDeDados/1.Big-Data-Analytics-com-R-e-Microsoft-Azure-Machine-Learning/11.Machine-Learning-em-Linguagem-R")
getwd()


# Carregando pacotes



library(tidyverse) # manipulação de dados
library(dplyr)     # manipulação de dados
library(corrplot)  # criar gráfico de mapa de correlação
library(corrgram)  # criar gráfico de mapa de correlação
library(ggplot2)   # criar outros gráficos (especificamente de dispersão)
library(caret)     # usado em tarefas de classificação e regressão para simplificar o processo de treinamento de modelos
library(ggthemes)

library(caTools)   # contém a função sample.split() que cria uma amostra que irá fazer a divisão entre dados de treinos e testes
                   # de maneira aleatória

# Dataset com dados de estudantes
# https://archive.ics.uci.edu/ml/datasets/Student+Performance


#####  Regressão Linear #####

# -> Definição do Problema: Prever as notas dos alunos com base em diversas métricas
#                           Vamos prever a nota final (grade) dos alunos

# - Este é um problema de REGRESSÃO pois a definição de problema é buscar um valor numérico (notas), caso o problema
#   buscar um valor categórico (ex: aluno aprovado 'SIM' ou 'NAO') usaríamos CLASSIFICAÇÃO



# Carregando massa de dados
dados <- read.csv2('estudantes.csv')
head(dados)
View(dados)


## Analise Exploratória


# Verificando dados ausentes
any(is.na(dados))
colSums(is.na(dados))

# Tipos dos dados
str(dados)
summary(dados)


# Obtendo apenas as colunas numéricas para correlação
colunas_numericas <- sapply(dados, is.numeric)
colunas_numericas

# Filtrando as colunas numéricas para correlação
data_cor <- cor(dados[, colunas_numericas])
data_cor


# Calculando correlação entre variáveis numéricas (corrplot)
corrplot(data_cor,
         method = "color",
         type = "upper",
         addCoef.col = 'springgreen2',
         tl.col = "black",
         tl.srt = 45)

# Calculando correlação entre variáveis numéricas (corrgram) - mesma coisa do corrplot
corrgram(dados)

corrgram(dados, order = TRUE, lower.panel = panel.shade,
         upper.panel = panel.pie, text.panel = panel.txt)


# Criando um histograma de G3
ggplot(dados, aes(x = G3)) +
  geom_histogram(bins = 20,
                 alpha = 0.5, fill = 'blue') +
  theme_minimal()
  


## Encoding de Variáveis Categóricas

# Selecionar todas as variáveis do tipo character
variaveis_character <- names(dados)[sapply(dados, is.character)]
variaveis_character

# Aplicando Enconding nas variáveis character para factor
dados[variaveis_character] <- lapply(dados[variaveis_character], as.factor)

str(dados)
summary(dados)



##### Modelagem #####


# Criando amostras de forma randômica
set.seed(101)

amostra <- sample.split(dados$age, SplitRatio = 0.70)

# -> Lembrando sempre que: Treinamos o modelo com dados de TREINO e fazemos predições com dados de TESTE

# Criando dataset de treino (70% dos dados)
treino <- subset(dados, amostra == TRUE)

# Criando dataset de teste (30% dos dados)
teste <- subset(dados, amostra == FALSE)


## Gerando Modelos

# Versão 1 (utilizando todas as variáveis)                # 0.8616
modelo_v1 <- lm(data = treino, G3 ~ .)
summary(modelo_v1)

# Versão 2 (utilizando G2 e G1)                           # 0.8211
modelo_v2 <- lm(data = treino, G3 ~ G2 + G1)
summary(modelo_v2)

# Versão 3 (utilizando absences e famrel)                 # 0.003505
modelo_v3 <- lm(data = treino, G3 ~ absences + famrel)
summary(modelo_v3)

# Versão 4 Simples (utilizando famrel)                    # 0.003182
modelo_v4 <- lm(data = treino, G3 ~ famrel)
summary(modelo_v4)

# Versão 5 Simples (utilizando absences)                  # 0.0002675
modelo_v5 <- lm(data = treino, G3 ~ absences)
summary(modelo_v5)

# Versão 6 Simples (utilizando Medu)                      # 0.06442
modelo_v6 <- lm(data = treino, G3 ~ Medu)
summary(modelo_v6)

# Versão 7 Simples (utilizando school)                    # 0.004634
modelo_v7 <- lm(data = treino, G3 ~ school)
summary(modelo_v7)


# - Com base nas interpretações do valor de R-squares, iremos escolher o modelo_v1



## Obtendo os resíduos do modelo escolhido (taxas de erros)

res <- residuals(modelo_v1)

# Convertendo para um dataframe
res <- as.data.frame(res)
head(res)

# Histograma dos resíduos
ggplot(res, aes(res)) +
  geom_histogram(fill = 'blue',
                 alpha = 0.5,
                 binwidth = 1)



## Plot do modelo
plot(modelo_v1)



## Previsões

previsoes <- predict(modelo_v1, teste)
head(previsoes)


# Agora vamos comparar as previsões do modelo com os valores reais.

resultados <- cbind(previsoes, teste$G3)
colnames(resultados) <- c('Previsto', 'Real')
resultados <- as.data.frame(resultados)

resultados
head(resultados)

# - Na primeira linha nosso modelo fez a previsão de G3 com base na v1 e previu a nota de 3.8
#   (neste caso ele errou pois a nota original foi 6)
#   No índice 16 ele quase acertou (previu 13.8 enquanto o original foi 14)


# - Observando também que existem alguns valores negativos nas previsões (o que seria irreal pois não existem notas negativas)

min(resultados) # menor nota prevista no modelo


## Tratando os resultados negativos das previsoes
tratar_valor_negativo <- function(x) {
  if (x < 0) {
    return(0)
  }else{
    return(x)
  }
}

# Aplicando função para tratar valores negativos

resultados$Previsto <- sapply(resultados$Previsto, tratar_valor_negativo)
resultados$Previsto

min(resultados)




## Vamos calcular 3 métricas de avaliação do desempenho do modelo de regressão

# MSE
mse <- mean((resultados$Real - resultados$Previsto)^2)
mse

# -> O MSE é a média dos quadrados das diferenças entre as notas reais (resultados$Real) e as previsões do modelo (resultados$Previsto).
#    Nesse caso, o MSE foi calculado como 4.411405. Quanto menor o valor do MSE, melhor o modelo está em fazer previsões precisas. 
#    Portanto, um MSE mais baixo é desejado.


# RMSE
rmse <- mse^0.5
rmse

# -> O RMSE é a raiz quadrada do MSE e fornece uma métrica de erro na mesma escala das notas.
#    Nesse caso, o RMSE foi calculado como 2.100335. O RMSE é uma medida de dispersão que indica a dispersão das previsões em torno
#    das notas reais. Quanto menor o RMSE, melhor o modelo está em fazer previsões precisas.


# Calcuando R-squared
SSE <- sum((resultados$Real - resultados$Previsto)^2)
SST <- sum((mean(dados$G3) - resultados$Real)^2)

R2 <- 1 - (SSE/SST)
R2

# - O R-quadrado é uma medida que indica a proporção da variabilidade na variável dependente (nota final, G3) que é explicada pelo
#   modelo.
# - Nesse caso, o R-quadrado foi calculado como 0.7779023. Este valor está na faixa de 0 a 1, o que é apropriado para o R-quadrado.
# - Significa que aproximadamente 77.79% da variabilidade nas notas é explicada pelo modelo.
# - Um valor de R-quadrado próximo a 1 indica que o modelo é capaz de explicar a maior parte da variação nas notas, enquanto um valor 
#   próximo a 0 indica que o modelo não explica bem as variações.

# Em resumo, o seu modelo tem um RMSE de aproximadamente 2.1003, o que significa que, em média, as previsões estão a cerca de 
# 2.1003 unidades de distância das notas reais. Além disso, o R-quadrado de aproximadamente 0.7779 sugere que o modelo explica bem
# a variabilidade nas notas dos estudantes, explicando cerca de 77.79% da variabilidade total. Essas métricas indicam que o modelo 
# tem um desempenho razoável na previsão das notas dos estudantes, mas sempre é possível buscar melhorias, se necessário.












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



