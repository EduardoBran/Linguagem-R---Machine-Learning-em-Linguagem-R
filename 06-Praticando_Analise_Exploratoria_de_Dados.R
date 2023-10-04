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

# Exibindo Medidas de Tendência Central (valor min, Q1, mediana, média, Q3, max) (valor mediana e média iguais INDICA distribuição normal)
summary(carros$ano)               

# Exibindo Medidas de Tendência Central para duas variáveis de uma vez
summary(carros[c('preco', 'kilometragem')])





####### Análise Exploratória de Dados Para Variáveis NUMÉRICAS #######

# Usando as funções

mean(carros$preco)                               # calcula a média da variável "preco"
median(carros$preco)                             # calcular a mediana da variável "preco" (metade dos valors acima e metade dos valores abaixo)

quantile(carros$preco)                           # calcula os quartis da variável "preco"
quantile(carros$preco, probs = c(0.01, 0.99))    # calcula percentis específicos, neste caso, o 1º e o 99º percentis, que são valores que dividem
#                                                  os dados em 1% e 99% das observações. Isso ajuda a identificar valores extremos nos dados. **

IQR(carros$preco)                                # diferença entre Q3 e Q1

range(carros$preco)                              # exibe a o valor máximo e o valor mínimo

diff(range(carros$preco))                        # calcula a diferença entre o valor máximo e o valor mínimo





####### Plots #######


## Boxplot **

# Leitura de Baixo Para Cima - Q1, Q2 (Mediana) e Q3

boxplot(carros$preco, main = "Boxplot para os Preços de Carros Usados", ylab = "Preço (R$)")
boxplot(carros$kilometragem, main = "Boxplot para a Km de Carros Usados", ylab = "Kilometragem (R$)")


## Histograma

# Indicam a frequência de valores dentro de cada bin (classe de valores)

hist(carros$preco, main = "Histograma para os Preços de Carros Usados", ylab = "Preço (R$)")
hist(carros$preco, main = "Histograma para os Preços de Carros Usados", breaks = 5, ylab = "Preço (R$)")

hist(carros$kilometragem, main = "Histograma para a Km de Carros Usados", ylab = "Kilometragem (R$)")
hist(carros$kilometragem, main = "Histograma para a Km de Carros Usados", breaks = 5, ylab = "Kilometragem (R$)")


## Scatterplot Preço x Km

# Usando o preço como variável dependente (y)

plot(x = carros$kilometragem, y = carros$preco,
     main = "Scatterplot - Preço x Km",
     xlab = "Kilometragem",
     ylab = "Preço (R$)")





####### Medidas de Dispersão ####### (** explicação abaixo)

var(carros$preco)
sd(carros$preco)

var(carros$kilometragem)
sd(carros$kilometragem)

# - Ao interpretar a variância, números maiores indicam que os dados estão espalhados mais amplamente em torno da média.
#   O desvio padrão indica, em média, a quantidade de cada valor diferente da média.














#### Explicando o quantile()

# 0%     25%     50%     75%    100% 
# 3800.0 10995.0 13591.5 14904.5 21992.0 

# 0% (Mínimo): O valor mínimo da variável "preco" nos dados é de $3.800.0. Isso significa que pelo menos uma observação tem esse valor ou um
#              valormenor.

# 25% (Primeiro Quartil - Q1): O primeiro quartil (25%) da variável "preco" é de $10.995.0. Isso significa que 25% das observações têm um valor
#                              de preço igual ou inferior a $10.995.0.

# 50% (Segundo Quartil - Mediana): A mediana (50%) da variável "preco" é de $13.591.5. Isso significa que metade das observações têm um valor de
#                                  preço igual ou inferior a $13.591.5, e metade tem um valor igual ou superior a esse valor. A mediana é uma 
#                                  medida de tendência central que divide os dados ao meio.

# 75% (Terceiro Quartil - Q3): O terceiro quartil (75%) da variável "preco" é de $14.904.5. Isso significa que 75% das observações têm um valor de
#                              preço igual ou inferior a $14.904.5.

# 100% (Máximo): O valor máximo da variável "preco" nos dados é de $21.992.0. Isso significa que pelo menos uma observação tem esse valor ou um 
#                valor maior.




#### Explicando Boxplot - para que serve:
  
# Os gráficos de boxplot são uma ferramenta poderosa para visualizar a distribuição de dados e identificar valores atípicos (outliers). Eles
# fornecem uma representação gráfica das medidas de tendência central e da dispersão dos dados. Aqui está como interpretar os boxplots:
  
# -> Box (Caixa): A caixa representa o intervalo interquartil (IQR), que contém a maioria dos dados (25% a 75%). A altura da caixa mostra a
#                 variação dentro desse intervalo.

# -> Linha dentro da Caixa: A linha dentro da caixa representa a mediana (Q2), que é a medida de tendência central que divide os dados ao meio.

# -> Whiskers (Hastes): As hastes que se estendem para cima e para baixo a partir da caixa são os "whiskers". Eles indicam a variação além do IQR.
#                       Valores fora das hastes são considerados outliers.

# -> Outliers (Valores Atípicos): Os pontos fora das hastes são considerados valores atípicos (outliers). Eles são observações que estão
#                                 significativamente distantes da maioria dos dados.

## Interpretação:
  
# - No primeiro boxplot (preço), a caixa mostra a variação de preços entre o primeiro quartil (Q1) e o terceiro quartil (Q3).
#   A mediana (linha dentro da caixa) está próxima a Q3, o que indica que a distribuição pode estar ligeiramente inclinada para a direita.

# - No segundo boxplot (quilometragem), a caixa mostra a variação da quilometragem entre Q1 e Q3. A mediana está próxima a Q1, sugerindo que
#   a distribuição pode estar inclinada para a esquerda. Há um outlier visível acima das hastes superiores, indicando um valor atípico na 
#   quilometragem.

# Os boxplots são úteis para identificar a distribuição, tendência central e valores atípicos nos dados de forma visual. Eles ajudam na análise 
# exploratória de dados e na compreensão da natureza das variáveis.




#### Explicando a Interpretação das Medidas de Dispersão

# Variância (var):
  
# - A variância é uma medida que indica o quanto os valores em um conjunto de dados se dispersam em relação à média.
# - Para a variável "preco," a variância é de 9,749,892. Isso significa que os preços dos carros usados se dispersam ao redor da média em uma
#   quantidade considerável. Valores maiores de variância indicam uma dispersão maior dos dados em relação à média.
# - Para a variável "kilometragem," a variância é de 728,033,954. Isso significa que as quilometragens dos carros usados também se dispersam 
#   amplamente em relação à média. 

# Desvio Padrão (sd - Standard Deviation):
  
# - O desvio padrão é uma medida de dispersão que indica, em média, a quantidade pela qual cada valor difere da média.
# - Para a variável "preco," o desvio padrão é de aproximadamente 3,122.482. Isso significa que, em média, os preços dos carros usados estão cerca
#   de 3,122.482 reais de distância da média de preços.
# - Para a variável "kilometragem," o desvio padrão é de aproximadamente 26,982.1. Isso significa que, em média, as quilometragens dos carros
#   usados estão cerca de 26,982.1 quilômetros de distância da média de quilometragem.

# A interpretação geral é que valores maiores de variância e desvio padrão indicam maior dispersão dos dados em relação à média, o que significa 
# que os valores estão mais espalhados. Valores menores indicam uma dispersão menor, o que significa que os valores tendem a estar mais próximos
# da média.

# Portanto, no seu conjunto de dados, tanto os preços quanto as quilometragens dos carros usados têm uma dispersão considerável em relação às
# médias, conforme indicado pelos valores de variância e desvio padrão. Isso pode ser útil para entender a variabilidade dos dados e avaliar o
# grau de consistência ou variação nos preços e quilometragens dos carros usados.




