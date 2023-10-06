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


# install.packages("gmodels")

# Carregando pacotes
library(dplyr)
library('ggplot2')
library(readr)
library(gmodels)   # pacote de gráficos e funções estatísticas que oferece funcionalidades adicionais para criar tabelas de contingência e realizar
#                    análises estatísticas.


# Carregando o dataset
carros <- read_csv("carros-usados.csv")
head(carros)
View(carros)


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







####### Análise Exploratória de Dados Para Variáveis CATEGÓRIAS #######



# Vamos criar tabelas de contingência que representam uma única variável categórica 
# (e assim lista as categorias das variáveis nominais)

str(carros)               # percebemos que a variável cor / modelo é "chr" e por isso uma variável categórica

table(carros$cor)         # mostra a quantidade de cada carro de acordo com a cor
table(carros$modelo)      # mostra a quantidade de cada carro de acordo com o modelo


# Calculando a proporção de cada categoria

model_table <- table(carros$modelo)
model_table

prop.table(model_table)              

model_table <- prop.table(model_table) * 100  # arredonda o valor
model_table <- round(model_table, digits = 1) # arredonda o valor

model_table                                   # 52% dos carros modelo SE, 15.3% modelo SEL e 32.7% modelo SES



# Cria uma nova variável indicando cores conservadoras, ou seja que as pessoas compram com mais frequência
# (cria uma nova variável booleana com "TRUE" para carros com as cores conservadoras e "FALSE" para outras cores)

head(carros)

carros$conserv <- carros$cor %in% c("Preto", "Cinza", "Prata", "Branco")

View(carros)
head(carros)

table(carros$conserv)                                      # 51 FALSE  99 TRUE
round(prop.table(table(carros$conserv)) * 100, digits = 1) # arredonda o valor



# Outra forma de criar uma tabela de contingência (explicação abaixo)
# (vamos verificar o relacionamento entre 2 variáveis categóricas através da criação de uma CrossTable)
# (as tabelas de contingência fornecem uma maneira de exibir as frequências e frequências relativas de observaçoes que são classificados de
#  acordo com duas variáveis categórias. Os elementos de uma categoria são exibidos através das colunas, enquanto os elementos de outra
#  categoria são exibidas sobre as linhas)

?CrossTable

CrossTable(x = carros$modelo, y = carros$conserv)
CrossTable(x = carros$modelo, y = carros$cor)
CrossTable(x = carros$modelo, y = carros$transmissao)

head(carros)




# Teste do Qui-quadrado

# - Simbolizado por X2 é um teste de hipóteses usado para determinar se existe uma associação significativa entre duas variáveis
#   categóricas. Ou seja, quando precisarmos realizar um teste de hipótese entre variáveis categorias, o Qui-quadrado é uma opção.

# - É um teste não paramétrico, ou seja, não depende dos parâmetros populacionais como média e variância.

# - O princípio básico deste método é comparar proporções, isto é, as possíveis divergências entre as frequências observadas e esperadas
#   para um certo evento. Evidentemente, pode-se dizer que dois grupos se comportam de forma semelhante se as diferenças entre as
#   frequências observadas e as esperadas em cada categoria forem muito pequenas, próximas a zero.

# - Ou seja, Se a probabilidade é muito baixa, ele fornece fortes evidências de que as duas variáveis estão associadas.

CrossTable(x = carros$modelo, y = carros$conserv, chisq = TRUE)   # calcula qui-quadrado direto com "chisq = TRUE"
chisq.test(x = carros$modelo, y = carros$conserv)                 # calcula valor de qui


# Trabalhamos com 2 hipóteses:

#  -> Hipótese nula        : As frequências observadas não são diferentes das frequências esperadas. 
#                            Não existe diferença entre as frequências (contagens) dos grupos.
#                            Portanto, não há associação entre os grupos

#  -> Hipótese alternativa : As frequências observadas são diferentes das frequências esperadas, 
#                            Existe diferença entre as frequências.
#                            Portanto, há associação entre os grupos.


# Neste caso, o valor do Chi = 0.15  
# E graus de liberdade (df)  = 2

# Portanto, não há associação entre os grupos
# O valor alto do p-value confirma esta conclusão.





#### Após realizar a análise exploratória e entender melhor os dados podemos:

#  -> aplicar testes estatísticos
#  -> aplicar resumo
#  -> criar gráficos
#  -> documentar tudo que foi feito

# Após compreender e entender melhor os dados estaremos prontos para o pré-processamento onde faremos:

#  -> transformação
#  -> limpeza dos dados
#  -> preparação dos dados para a modelagem preditiva


















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




#### Explicando Tabela de Contingência (CrossTable):

# A tabela tem as seguintes seções:
  
#  -> Cell Contents (Conteúdo da Célula): Esta seção mostra os tipos de informações contidas nas células da tabela.

# - "N" indica o número de observações em cada célula.
# - "Chi-square contribution" (Contribuição qui-quadrado) é relevante para análises estatísticas mais avançadas, como o teste qui-quadrado.
# - "N / Row Total" mostra a proporção do número de observações em relação ao total de observações na mesma linha.
# - "N / Col Total" mostra a proporção do número de observações em relação ao total de observações na mesma coluna.
# - "N / Table Total" mostra a proporção do número de observações em relação ao total geral de observações na tabela.

# - Total Observations in Table (Total de Observações na Tabela): Esta seção indica o número total de observações na tabela, que é 150
#   neste caso.

# - Conteúdo da Tabela: A tabela principal mostra as frequências de combinações entre as categorias das variáveis "modelo" e "conserv."

# - As colunas representam a variável "conserv" (com valores "FALSE" ou "TRUE").
# - As linhas representam a variável "modelo" (com valores "SE," "SEL," e "SES").

# Agora, interpretemos a tabela com base nos dados fornecidos (modelo x conserv):
  
# - Na célula (linha "SE," coluna "FALSE"), há 27 observações de carros que são do modelo "SE" e não têm cores conservadoras.
# - A contribuição qui-quadrado para essa célula é 0.009, que é relevante para testes estatísticos.
# - A proporção de observações "SE" não conservadoras em relação ao total de "SE" é de 0.346.
# - A proporção de observações "SE" não conservadoras em relação ao total de "FALSE" é de 0.529.
# - A proporção de observações "SE" não conservadoras em relação ao total geral da tabela é de 0.180.

# Você pode aplicar a mesma lógica para as outras células da tabela para entender o relacionamento entre as duas variáveis.
# Por exemplo, na célula (linha "SES," coluna "TRUE"), há 32 observações de carros do modelo "SES" que têm cores conservadoras.

# Essa tabela de contingência é útil para visualizar como as variáveis categóricas estão relacionadas e pode ser usada em análises
# estatísticas mais avançadas, como o teste qui-quadrado, para determinar se há associação significativa entre as duas variáveis.


# Interpretando a relação de modelo x transmissao

# - Na célula (linha "SE," coluna "AUTO"), há 63 observações de carros do modelo "SE" com transmissão automática.
# - A contribuição qui-quadrado para essa célula é 0.190, que é relevante para testes estatísticos.
# - A proporção de observações "SE" com transmissão automática em relação ao total de "SE" é de 0.808.
# - A proporção de observações "SE" com transmissão automática em relação ao total de "AUTO" é de 0.492.
# - A proporção de observações "SE" com transmissão automática em relação ao total geral da tabela é de 0.420.




