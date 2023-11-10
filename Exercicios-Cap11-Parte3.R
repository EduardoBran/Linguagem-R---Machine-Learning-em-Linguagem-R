# Lista de Exercícios Parte 3 - Capítulo 11 (Machine Learning)

# Configurando o diretório de trabalho
setwd("C:/Users/Julia/Desktop/CienciaDeDados/1.Big-Data-Analytics-com-R-e-Microsoft-Azure-Machine-Learning/11.Machine-Learning-em-Linguagem-R")
getwd()

# Informações da massa de Dados (The Boston Housing Dataset)
# http://www.cs.toronto.edu/~delve/data/boston/bostonDetail.html


# Carregando pacotes

library(tidyverse) # manipulação de dados
library(dplyr)     # manipulação de dados
library(corrplot)  # criar gráfico de mapa de correlação
library(ggplot2)   # criar outros gráficos (especificamente de dispersão)
library(caret)     # usado em tarefas de classificação e regressão para simplificar o processo de treinamento de modelos
library(caTools)   # contém a função sample.split() que cria uma amostra que irá fazer a divisão entre dados de treinos e testes
                   # de maneira aleatória

library(neuralnet) # pacote para Redes Neurais

library(MASS)      # fornece funções e conjuntos de dados para realizar análises estatísticas avançadas e modelagem estatística.
                   # contem o conjunto de dados Boston

# -> Contexto           : Analisando dados das casas de Boston, nos EUA e fazendo previsoes.

# -> Problema de negócio: Seu modelo deve prever a MEDV (Valor da Mediana de ocupação das casas).
#                         Utilize um modelo de rede neural!



# Importando os dados do dataset Boston
set.seed(101)

dados <- Boston
head(dados)
View(dados)

View(Boston)

## Analise Exploratória

# Verificando dados ausentes
any(is.na(dados))
colSums(is.na(dados))

# Tipos dos dados
str(dados)
summary(dados)


# Criando/calculando uma matriz de correlação
matriz_cor <- cor(dados)
matriz_cor

# Exibindo correlação entre variáveis numéricas (corrplot)
corrplot(matriz_cor,
         method = "color",
         type = "upper",
         addCoef.col = 'springgreen2',
         tl.col = "black",
         tl.srt = 45)

# Criando um histograma de medv
ggplot(dados, aes(x = medv)) +
  geom_histogram(bins = 20,
                 alpha = 0.5, fill = 'blue') +
  theme_minimal()



## Pré-processamento dos dados

# - É uma boa prática normalizar os dados antes de treinar uma rede neural.
#   A dependeder do conjunto de dados, o fato de não relizar a normalização pode levar a resultados inúteis ou a um processo
#   de treinamento muito difícil onde na maiora das vezes o algoritimo não converge antes do número de iterações máximo perimitido.

# - Existem diferentes métodos para dimensionar os dados (normalizacao-z, escala min-max, etc...)

# - Normalmente escala nos intervalos [0,1] e [1,1] tende a dar os melhores resultados.


# Normalização (colocando os dados na mesma escala)

maxs <- apply(dados, 2, max)
mins <- apply(dados, 2, min)

maxs
mins

# Normalizando
dados_normalizados <- as.data.frame(scale(dados, center = mins, scale = maxs - mins))
head(dados_normalizados)

str(dados_normalizados)
summary(dados_normalizados)



# Criando Dados de Treino e Teste (com dados normalizados)

amostra <- sample.split(dados_normalizados$medv, SplitRatio = 0.70)

treino <- subset(dados_normalizados, amostra == TRUE)
teste <- subset(dados_normalizados, amostra == FALSE)

# -> Lembrando sempre que: Treinamos o modelo com dados de TREINO e fazemos predições com dados de TESTE



##### Modelagem #####

# Obtendo nome das colunas para automatizar a criação da fórmula
coluna_nomes <- names(treino)
coluna_nomes
formula <- as.formula(paste("medv ~", paste(coluna_nomes[!coluna_nomes %in% "medv"], collapse = " + ")))
formula


# Treinando o Modelo (ao invés de 'formula' eu podia escrever o nome das colunas)

rede_neural <- neuralnet(data = treino, formula, hidden = c(5,3), linear.output = TRUE)


# - hidden = c(5,3): Esse argumento define a arquitetura da rede neural. Ele especifica o número de neurônios em cada camada oculta
#                    da rede. No exemplo, a rede possui duas camadas ocultas: a primeira camada oculta tem 5 neurônios, e a segunda 
#                    camada oculta tem 3 neurônios.

# - linear.output = TRUE: Este argumento indica que a saída da rede neural é linear. Isso significa que a rede neural é usada para
#                         prever valores numéricos contínuos, como regressão. Se você estiver fazendo uma tarefa de classificação,
#                         você usaria linear.output = FALSE.


# Plot do modelo
plot(rede_neural)



## Previsões (exibindo as previsões com os dados normalizados)

rede_neural_prev <- compute(rede_neural, teste[1:13])
rede_neural_prev

# - "[1:13]" indica que você está fazendo previsões usando as 13 primeiras colunas do conjunto de dados de teste (teste).
#    Enquanto a última coluna é a variável que você quer prever ("teste" assim como "dados" tem 14 variáveis/colunas)


# Retirando a normalização dos dados em "rede_neural_prev" para a escala original (melhora a observação dos dados)

previsoes_rn <- rede_neural_prev$net.result * (max(dados$medv) - min(dados$medv)) + min(dados$medv)
head(previsoes_rn)

# Retirando a normalização dos dados em "teste" para podermos comparar os resultados originais com "previsoes"

teste_convert <- (teste$medv) * (max(dados$medv) - min(dados$medv)) + min(dados$medv)
teste_convert



## Calculando o Mean Squared Error (métrica de avaliação do desempenho do modelo de regressão)
#  (quanto menor o MSE, melhor o desempenho do modelo de regressão)

MSE_rn <- sum((teste_convert - previsoes_rn)^2) / nrow(teste)
MSE_rn



## Criando um dataframe para comparar os dados reais com os da previsão

resultados_rn <- data.frame(teste_convert, previsoes_rn)
head(resultados_rn)


## Plot dos erros

ggplot(resultados, aes(x = teste_convert, y = previsoes)) +
  geom_point() + stat_smooth()

# - A 'área cinza' em volta da linha azul são as margens de erro, ou seja, nosso modelo precisa prever a linha azul, porém algumas
#   previsões ficaram acima ou abaixo da linha azul (dentro da 'área cinza')




###############################################################################################################################


## Utilizando algoritmo de Regressão Linear lm() sem os dados normalizados

dados <- Boston
head(dados)

# Criando Dados de Treino e Teste Original
amostra_do <- sample.split(dados$medv, SplitRatio = 0.70)
treino_do <- subset(dados, amostra_do == TRUE)
teste_do <- subset(dados, amostra_do == FALSE)

# -> Lembrando sempre que: Treinamos o modelo com dados de TREINO e fazemos predições com dados de TESTE


# Versão 1 (utilizando todas as variáveis e dados originais)                     # 0.7554
modelo_v1 <- lm(data = treino_do, medv ~ .)
summary(modelo_v1)

# Versão 2 (utilizando algumas variáveis e dados originais)                  
modelo_v2 <- lm(data = treino_do, medv ~ nox + rm + dis + rad + ptratio + lstat) # 0.7352
summary(modelo_v2)

# Versão 3 (utilizando algumas variáveis e dados originais)                
modelo_v3 <- lm(data = treino_do, medv ~ nox + rm + dis + ptratio + lstat)       # 0.7334
summary(modelo_v3)


# Obtendo os resíduos dos modelos escolhidos (taxas de erros)
res_v3 <- as.data.frame(residuals(modelo_v3))
colnames(res_v3) <- "residuos"
head(res_v3)

# Histograma dos resíduos
ggplot(res_v3, aes(residuos)) +
  geom_histogram(fill = 'blue',
                 alpha = 0.5,
                 binwidth = 1)





## Previsões

previsoes_v3 <- predict(modelo_v3, teste_do)

# Agora vamos comparar as previsões do modelo com os valores reais.

resultados_do <- cbind(teste_do$medv, previsoes_v3)
colnames(resultados_do) <- c('Real', 'Previsto')
resultados_do <- as.data.frame(resultados_do)

head(resultados_do)


## Calculando o Mean Squared Error (métrica de avaliação do desempenho do modelo de regressão)
#  (quanto menor o MSE, melhor o desempenho do modelo de regressão)

MSE_v3 <- sum((teste_do - previsoes_v3)^2) / nrow(teste_do)
MSE_v3






# -> Para avaliar qual é o melhor modelo, podemos comparar os valores de erro quadrático médio (MSE) de ambos os modelos:

# - O modelo de Regressão Linear (modelo_v3) e o modelo de Rede Neural (rede_neural). Nesse contexto, um valor menor de MSE indica
#   um modelo mais preciso. Vamos comparar os valores de MSE dos dois modelos:
  
# - MSE do modelo de Regressão Linear (modelo_v3): 311580.6
# - MSE do modelo de Rede Neural (rede_neural): 15.1656

# - Comparando os valores de MSE, fica claro que o modelo de Rede Neural (rede_neural) tem um MSE muito menor, o que significa que
#   ele é mais preciso na previsão dos valores da variável alvo "medv".












# O conjunto de dados "Boston" contém informações sobre diversas variáveis relacionadas a habitações na área de Boston, nos
# Estados Unidos. Aqui está o significado de cada variável presente nos dados:
  
# crim   : Taxa de criminalidade per capita por cidade.
# zn     : Proporção de terrenos residenciais com grandes lotes (área superior a 25.000 pés quadrados).
# indus  : Proporção de acres de negócios não-varejistas por cidade.
# chas   : Variável fictícia indicando se a propriedade faz fronteira com o rio Charles (1 se faz fronteira, 0 caso contrário).
# nox    : Concentração de óxidos nítricos (parte por 10 milhões).
# rm     : Número médio de quartos por habitação.
# age    : Proporção de unidades ocupadas por proprietários construídas antes de 1940.
# dis    : Distância ponderada até os cinco centros de emprego de Boston.
# rad    : Índice de acessibilidade às rodovias radiais.
# tax    : Taxa de imposto sobre a propriedade.
# ptratio: Proporção aluno-professor (índice educacional).
# black  : 1000(Bk - 0.63)^2, onde Bk é a proporção de residentes afro-americanos por cidade.
# lstat  : Porcentagem de status inferior da população.
# medv   : Valor mediano das casas ocupadas pelos proprietários em milhares de dólares (a variável alvo que você deseja prever).
#          Em outras palavras, é o valor médio das casas que são ocupadas por seus proprietários, e esse valor é expresso em
#          milhares de dólares.

# - Por exemplo, se o valor de medv for 24, isso significa que o valor mediano das casas ocupadas pelos proprietários naquela área ,
#   específica de Boston é de $24.000. É uma medida do preço médio das casas em uma determinada região, em que as casas são ocupadas
#   pelos seus proprietários, e esse preço é representado em milhares de dólares. Portanto, a variável medv é usada comumente como o
#   alvo de previsão em análises e modelagem de dados relacionados ao mercado imobiliário para estimar o valor das casas.

