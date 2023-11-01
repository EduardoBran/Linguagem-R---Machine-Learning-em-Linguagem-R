# Lista de Exercícios Parte 1 - Capítulo 11 (Machine Learning)

# Configurando o diretório de trabalho
setwd("C:/Users/Julia/Desktop/CienciaDeDados/1.Big-Data-Analytics-com-R-e-Microsoft-Azure-Machine-Learning/11.Machine-Learning-em-Linguagem-R")
getwd()


# Carregando pacotes

library(tidyverse) # manipulação de dados
library(dplyr)     # manipulação de dados
library(corrplot)  # criar gráfico de mapa de correlação
library(ggplot2)   # criar outros gráficos (especificamente de dispersão)
library(caret)     # usado em tarefas de classificação e regressão para simplificar o processo de treinamento de modelos




##### Exercício 1 - Massa de dados aleatória

# Criando a massa de dados (apesar de aleatória, y possui uma relação com os dados de x)
x <- seq(0, 100)
y <- 2 * x + 35

x
y

# Gerando uma distribuição normal
y1 <- y + rnorm(101, 0, 50)
y1

# Histograma
hist(y1)



# -> Crie um plot do relacionamento de x e y1 (criando um Scatter plot)

plot(x, y1, type = 'p')

# Usando ggplot
dados <- data.frame(x = x, y1 = y1)

ggplot(dados, aes(x = x, y = y1)) +
  geom_point() +
  labs(x = "Eixo X", y = "Eixo Y") +
  ggtitle("Gráfico de Dispersão de x e y1")



# -> Crie um modelo de regressão para as duas variáveis x e y1:

modelo <- lm(data = dados, x ~ y1)
modelo
summary(modelo)



# -> Capture os coeficentes:

coeficientes <- coef(modelo)

a <- coeficientes[1]
b <- coeficientes[2]

# Capturar os coeficientes de um modelo de regressão linear é útil por várias razões:

# -> Interpretação dos efeitos: Os coeficientes do modelo indicam como uma unidade de mudança na variável independente 
#    (no caso, y1) está associada a uma mudança na variável dependente (x). No seu modelo, o coeficiente 0.2625 indica que,
#    para cada unidade de aumento em y1, x aumenta em média 0.2625 unidades. O coeficiente de interceptação (14.0219542) 
#    representa o valor estimado de x quando y1 é igual a zero.

# -> Previsões: Você pode usar esses coeficientes para fazer previsões. Por exemplo, se você tiver um novo valor de y1, poderá
#    usar o modelo e os coeficientes para prever o valor correspondente de x.



# Fórmula de Regressão (utilizando dados dos coeficientes)
y2 <- a + b*x

# -> Visualize a linha de regressão: (antes tem que carregar a linha de código com o plot)

plot(x, y1, type = 'p')

lines(x, y2, lwd = 2)


# Simulando outras possíveis linhas de regressão

y3 <- (y2[51]-50*(b-1))+(b-1)*x
y4 <- (y2[51]-50*(b+1))+(b+1)*x
y5 <- (y2[51]-50*(b+2))+(b+2)*x
lines(x,y3,lty=3)
lines(x,y4,lty=3)
lines(x,y5,lty=3)





##### Exercício 2 - Pesquisa sobre idade e tempo de reação

# Criando os dados

Idade <- c(9,13,14,21,15,18,20,8,14,23,16,21,10,12,20,
           9,13,5,15,21)

Tempo <- c(17.87,13.75,12.72,6.98,11.01,10.48,10.19,19.11,
           12.72,0.45,10.67,1.59,14.91,14.14,9.40,16.23,
           12.74,20.64,12.34,6.44)


# -> Crie um Gráfico de Dispersão (ScatterPlot):

plot(Idade, Tempo, type = 'p')


# -> Crie um modelo de regressão:

modelo <- lm(Idade ~ Tempo)
modelo
summary(modelo)


# -> Calcule a reta (linha) de regressão: 

## Opção 1 (capturando coeficientes)

# Capturando os coeficentes:

coeficientes <- coef(modelo)
coeficientes
a <- coeficientes[1]
b <- coeficientes[2]

# Aplicando a Fórmula de Regressão (utilizando dados dos coeficientes)
formula <- a + b*Idade


## Opção 2 (aplicando a fórmula colocando os dados direto)

formula2 <- 25.7485266 + -0.9299878 * Idade



## Visualizando a linha de regressão: 

formula
formula2



# -> Crie o gráfico da reta: (antes tem que carregar a linha de código com o plot)

plot(Idade, Tempo, type = 'p')
lines(Idade, formula, lwd = 2)






##### Exercício 3 - Relação entre altura e peso

# Criando os dados
alturas = c(176, 154, 138, 196, 132, 176, 181, 169, 150, 175)
pesos = c(82, 49, 53, 112, 47, 69, 77, 71, 62, 78)

dados <- data.frame(alturas = alturas, pesos = pesos)
head(dados)

plot(alturas, pesos, pch = 16, cex = 1.3, col = "blue", 
     main = "Altura x Peso", 
     ylab = "Peso Corporal (kg)", 
     xlab = "Altura (cm)")


# -> Crie o modelo de regressão:
modelo <- lm(data = dados, pesos ~ alturas)


# -> Visualizando o modelo:
modelo
summary(modelo)


# -> Gere a linha de regressão (utilizando abline())
coeficientes <- coef(modelo)
coeficientes
a <- coeficientes[1]
b <- coeficientes[2]

plot(alturas, pesos, pch = 16, cex = 1.3, col = "blue", 
     main = "Altura x Peso", 
     ylab = "Peso Corporal (kg)", 
     xlab = "Altura (cm)")

abline(a, b)

# - abline() é uma função específica para traçar linhas de um modelo de regressão linear simples (com duas variáveis) em um gráfico,
#   enquanto lines() é uma função geral para traçar linhas em um gráfico. Ambas podem ser usadas para traçar uma linha de regressão,
#   mas abline() é mais conveniente quando você já tem um modelo de regressão linear.




# -> Faça as previsões de pesos com base na nova lista de alturas:
alturas2 = data.frame(c(179, 152, 134, 197, 131, 178, 185, 162, 155, 172))

previsao <- predict(modelo, newdata = alturas2, type = 'response')
previsao


# Plot
plot(alturas, pesos, pch = 16, cex = 1.3, 
     col = "blue", 
     main = "Altura x Peso", 
     ylab = "Peso (kg)", 
     xlab = "Altura (cm)")

# Construindo a linha de regressão
abline(lm(pesos ~ alturas)) 

# Obtendo o tamanho de uma das amostras de dados
num <- length(alturas)
num

# Gerando um gráfico com os valores residuais
for (k in 1: num)  
  lines(c(alturas[k], alturas[k]), 
        c(pesos[k], pesos[k]))

# Gerando gráficos com a distribuição dos resíduos
par(mfrow = c(2,2))
plot(modelo)

