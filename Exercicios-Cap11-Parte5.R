# Lista de Exercícios Parte 5 - Base de Dados Seguradora

# Configurando o diretório de trabalho
setwd("C:/Users/Julia/Desktop/CienciaDeDados/1.Big-Data-Analytics-com-R-e-Microsoft-Azure-Machine-Learning/11.Machine-Learning-em-Linguagem-R")
getwd()


# Carregando pacotes

library(tidyverse) # manipulação de dados
library(dplyr)     # manipulação de dados
library(corrplot)  # criar gráfico de mapa de correlação
library(ggplot2)   # criar outros gráficos (especificamente de dispersão)
library(caret)     # usado em tarefas de classificação e regressão para simplificar o processo de treinamento de modelos
library(caTools)   # contém a função sample.split() que cria uma amostra que irá fazer a divisão entre dados de treinos e testes
# de maneira aleatória

library(kernlab)
library(readxl)
library(MASS) 
library(neuralnet)


# Base de dados de uma Carteira de Property (Propriedade) de uma Seguradora


# -> Podemos criar um problema de negócio de previsão da variável "PRÊMIO NET_Corrigido".
#    Vamos considerar a tarefa de machine learning como a previsão do valor do prêmio líquido do seguro com base
#    em outras informações disponíveis nos dados.

# -> Problema de Negócio: Previsão de Prêmio Líquido do Seguro

# -> Objetivo: O objetivo é desenvolver um modelo de machine learning que possa prever o valor do prêmio líquido 
#    do seguro (variável "PRÊMIO NET_Corrigido") com base em informações disponíveis nos dados.

# -> Variável Alvo        : PRÊMIO NET_Corrigido: Esta é a variável que queremos prever.
# -> Variáveis Preditoras : As variáveis que podem ser usadas como recursos para a previsão incluiriam 
#                           todas as outras informações disponíveis nos dados, como o "LMG", "LMG Facility",
#                           "% RESSEGURO", "% COMISSÃO", "DATA INÍCIO DA VIGÊNCIA", "DATA TÉRMINO DA VIGÊNCIA", 
#                           "RAMO", "TIPO EMISSÃO", entre outras.

# -> Metodologia: Podemos aplicar técnicas de regressão, como regressão linear, regressão de árvore de decisão,
#                 ou até mesmo métodos mais avançados, como modelos de florestas aleatórias ou redes neurais,
#                 para prever o valor do prêmio líquido.

# -> Avaliação do Modelo: O desempenho do modelo pode ser avaliado usando métricas de regressão, como o erro
#                         quadrático médio (RMSE), o coeficiente de determinação (R²) e outros, dependendo da
#                         escolha do algoritmo.

# -> Implementação: Após a construção do modelo, ele pode ser implementado em um ambiente de produção para prever
#                   o valor do prêmio líquido do seguro com base nos novos dados de entrada.


## Carregando dados
dados <- as.data.frame(read_xlsx("Book1.xlsx"))


## Carregando Dados já pré processados
dados <- as.data.frame(read_xlsx("Book1.xlsx"))
dados_

head(dados)
#View(dados)


## Analise Exploratória

# Verificando dados ausentes
any(is.na(dados))
colSums(is.na(dados))

# Removendo dados ausentes
dados <- na.omit(dados)


# Crie um novo índice
novo_indice <- 1:nrow(dados)

# Atribua o novo índice como nomes de linha
rownames(dados) <- novo_indice


# Removendo as linhas 5, 9 e 427 (que ainda tinham valores ausentes)
dados <- dados[-c(5, 9, 427), ]
head(dados)
View(dados)


# Removendo Coluna Repetida "LMG Facility"
dados$`LMG Facility` <- NULL
dados$`LMG Facility Unique` <- NULL
dados$`PRÊMIO SEGURO` <- NULL

# Renomeando as Variáveis Utilizadas
names(dados)[names(dados) == "PRÊMIO NET_Corrigido"] <- "PREMIO_NET_Corrigido"
names(dados)[names(dados) == "TIPO EMISSÃO"] <- "TIPO_EMISSAO"
names(dados)[names(dados) == "COMISSÃO SEGURO"] <- "COMISSAO_SEGURO"
names(dados)[names(dados) == "PREMIO SEGURO LIQUIDO"] <- "PREMIO_SEGURO_LIQUIDO"
names(dados)[names(dados) == "% RESSEGURO"] <- "%_RESSEGURO"
names(dados)[names(dados) == "PRÊMIO Resseguro Bruto"] <- "PREMIO_Resseguro_Bruto"
names(dados)[names(dados) == "% COMISSÃO RESSEGURO"] <- "%_COMISSAO_RESSEGURO"
names(dados)[names(dados) == "COMISSÃO Resseguro"] <- "COMISSAO_Resseguro"
names(dados)[names(dados) == "Check Quantidade"] <- "Check_Quantidade"
names(dados)[names(dados) == "Chave c Endosso"] <- "Chave_Endosso"
names(dados)[names(dados) == "Check Quantidade de Chaves"] <- "Check_Quantidade_de_Chaves"
names(dados)[names(dados) == "Apolice_Ultima"] <- "Apolice_Ultima"
names(dados)[names(dados) == "Chave_Apolice_Ultima LMG_Facility"] <- "Chave_Apolice_Ultima_LMG_Facility"
names(dados)[names(dados) == "COMISSÃO de Resseguro_Corrigida"] <- "COMISSAO_de_Resseguro_Corrigida"
names(dados)[names(dados) == "Check Premio de Resseguro"] <- "Check_Premio_de_Resseguro"



## Modificando Tipo Variáveis
dados <- dados %>%
  mutate(TIPO_EMISSAO = as.factor(TIPO_EMISSAO),
         MOEDA = as.factor(MOEDA),
         PREMIO_SEGURO_LIQUIDO = as.numeric(PREMIO_SEGURO_LIQUIDO),
         PREMIO_Resseguro_Bruto = as.numeric(PREMIO_Resseguro_Bruto),
         COMISSAO_Resseguro = as.numeric(COMISSAO_Resseguro),
         LMG_Ultimo_Unique = as.numeric(LMG_Ultimo_Unique),
         PREMIO_NET_Corrigido = as.numeric(PREMIO_NET_Corrigido),
         COMISSAO_de_Resseguro_Corrigida = as.numeric(COMISSAO_de_Resseguro_Corrigida),
         Check_Premio_de_Resseguro = as.numeric(Check_Premio_de_Resseguro))


## Selecionando as variáveis
dados <- dados[, c("PREMIO_SEGURO_LIQUIDO", "PREMIO_Resseguro_Bruto",
                   "COMISSAO_Resseguro", "LMG_Ultimo_Unique", "PREMIO_NET_Corrigido", 
                   "COMISSAO_de_Resseguro_Corrigida", "Check_Premio_de_Resseguro")]


# Verificando dados ausentes
any(is.na(dados))
colSums(is.na(dados))

# Removendo dados ausentes
dados <- na.omit(dados)
head(dados)




## Aplicando método IQR para identificar outliers em todas as variáveis numéricas

# Selecione apenas as variáveis numéricas
dados_numericos <- dados[, sapply(dados, is.numeric)]

# Converta as colunas numéricas para tipo numérico
dados_numericos[] <- lapply(dados_numericos, as.numeric)

# Calcular o IQR para cada coluna numérica
IQR_valores <- apply(dados_numericos, 2, IQR)

# Calcular os limites superior e inferior para identificar outliers
limite_superior <- colMeans(dados_numericos) + 1.5 * IQR_valores
limite_inferior <- colMeans(dados_numericos) - 1.5 * IQR_valores

# Identifique os outliers
outliers <- sapply(1:ncol(dados_numericos), function(i) {
  dados_numericos[, i] < limite_inferior[i] | dados_numericos[, i] > limite_superior[i]
})

# Mostre as linhas que contêm outliers
dados_outliers <- dados[outliers, ]

# Remova as linhas que contêm outliers
dados_sem_outliers <- dados[!apply(outliers, 1, any), ]

# Verifique as dimensões
dim(dados_sem_outliers)

dados <- dados_sem_outliers
head(dados)

# Tipos dos dados
str(dados)
summary(dados_sem_outliers)
dim(dados)

head(dados)
View(dados)


## APLICANDO NORMALIZAÇÃO NOS DADOS

dados_norma <- dados
str(dados_norma)

# Selecionar apenas as variáveis numéricas
dados_numericos <- dados_norma[, sapply(dados_norma, is.numeric)]

# Calcular os máximos e mínimos
maxs <- apply(dados_numericos, 2, max)
mins <- apply(dados_numericos, 2, min)

# Normalizar
dados_norma[, names(dados_numericos)] <- as.data.frame(scale(dados_numericos, center = mins, scale = maxs - mins))

# Verificar a estrutura dos dados normalizadose originais
summary(dados)
summary(dados_norma)

# write.csv(dados, "Dados_Seguro.csv", row.names = FALSE)
# write.csv(dados_norma, "Dados_Seguro_Norma.csv", row.names = FALSE)




## Criando Dados de Treino e Teste (dados originais e com dados normalizados)

set.seed(120)

amostra_original <- sample.split(dados$PREMIO_NET_Corrigido, SplitRatio = 0.85)
treino_original <- subset(dados, amostra_original == TRUE)
teste_original <- subset(dados, amostra_original == FALSE)

amostra_norma <- sample.split(dados_norma$PREMIO_NET_Corrigido, SplitRatio = 0.85)
treino_norma <- subset(dados, amostra_norma == TRUE)
teste_norma <- subset(dados, amostra_norma == FALSE)


# -> Lembrando sempre que: Treinamos o modelo com dados de TREINO e fazemos predições com dados de TESTE


str(treino_norma)

######## MODELAGEM


## UTILIZANDO REGRESSÃO LINEAR SIMPLES E MÚLTIPLA

# Uilizando todas as variáveis
modelo_v1_original <- lm(data = treino_original, PREMIO_NET_Corrigido ~ .)
modelo_v1_norma <- lm(data = treino_norma, PREMIO_NET_Corrigido ~ .)

summary(modelo_v1_original)  # 0.4767
summary(modelo_v1_norma)     # 0.487

# Uilizando as variáveis "PREMIO_Resseguro_Bruto" e "COMISSAO_Resseguro"
modelo_v2_original <- lm(data = treino_original, PREMIO_NET_Corrigido ~ PREMIO_Resseguro_Bruto + COMISSAO_Resseguro)
modelo_v2_norma <- lm(data = treino_norma, PREMIO_NET_Corrigido ~ PREMIO_Resseguro_Bruto + COMISSAO_Resseguro)

summary(modelo_v2_original)  # 0.476
summary(modelo_v2_norma)     # 0.4866

# Uilizando a variável "PREMIO_Resseguro_Bruto"
modelo_v3_original <- lm(data = treino_original, PREMIO_NET_Corrigido ~ PREMIO_Resseguro_Bruto)
modelo_v3_norma <- lm(data = treino_norma, PREMIO_NET_Corrigido ~ PREMIO_Resseguro_Bruto)

summary(modelo_v3_original)  # 0.99
summary(modelo_v3_norma)     # 0.99


# Uilizando a variável "COMISSAO_Resseguro"
modelo_v4_original <- lm(data = treino_original, PREMIO_NET_Corrigido ~ COMISSAO_Resseguro)
modelo_v4_norma <- lm(data = treino_norma, PREMIO_NET_Corrigido ~ COMISSAO_Resseguro)

summary(modelo_v4_original)  # 0.99
summary(modelo_v4_norma)     # 0.99


# -> MODELO ESCOLHIDO - modelo_v2





## Utilizando kenel


# Utilizando kernel vannilladot

modelo_ksvm_van_ori <- ksvm(data = treino_original, PREMIO_NET_Corrigido ~ ., kernel = "vanilladot")
modelo_ksvm_van_nor <- ksvm(data = treino_norma, PREMIO_NET_Corrigido ~ ., kernel = "vanilladot")

modelo_ksvm_van_ori # Training error : 0.001316 
modelo_ksvm_van_nor # Training error : 0.001317








## FAZENDO AS PREVISÕES E ESCOLHENDO MELHOR MODELO

# Previsões com modelo de Regressão Linear

modelo_v2_original_predictions <- predict(modelo_v2_original, teste_original)
head(modelo_v2_original_predictions)
modelo_v2_norma_predictions <- predict(modelo_v2_norma, teste_norma)
head(modelo_v2_original_predictions)



## Criando um dataframe para comparar os dados reais com os da previsão

resultados_v2_original <- data.frame(Valor_Real = teste_original$PREMIO_NET_Corrigido,
                                     Valor_Prev = modelo_v2_original_predictions)
resultados_v2_original$Valor_Prev <- floor(resultados_v2_original$Valor_Prev)
resultados_v2_norma <- data.frame(Valor_Real = teste_norma$PREMIO_NET_Corrigido,
                                  Valor_Prev = modelo_v2_norma_predictions)
resultados_v2_norma$Valor_Prev <- floor(resultados_v2_norma$Valor_Prev)

head(resultados_v2_original)
head(resultados_v2_norma)



## Criando um vetor de TRUE/FALSE indicando previsões CORRETAS/INCORRETAS
vetor_modelo_v2_ori <- resultados_v2_original == teste_original$PREMIO_NET_Corrigido
vetor_modelo_v2_nor <- resultados_v2_norma == teste_norma$PREMIO_NET_Corrigido

table(vetor_modelo_v2_ori)                    # FALSE 52           TRUE 208
table(vetor_modelo_v2_nor)                    # FALSE 44           TRUE 216
prop.table(table(vetor_modelo_v2_ori))        # FALSE 0.2          TRUE 0.8
prop.table(table(vetor_modelo_v2_nor))        # FALSE 0.1692308    TRUE 0.8307692  





# Previsões com modelo de Rede Neural

modelo_rn_original_predictions <- predict(modelo_rede_v1_original, teste_original)
head(modelo_rn_original_predictions)
modelo_v2_norma_predictions <- predict(modelo_v2_norma, teste_norma)
head(modelo_v2_original_predictions)



## Criando um dataframe para comparar os dados reais com os da previsão

resultados_rn_original <- data.frame(Valor_Real = teste_original$PREMIO_NET_Corrigido,
                                     Valor_Prev = modelo_v2_original_predictions)
resultados_v2_original$Valor_Prev <- floor(resultados_v2_original$Valor_Prev)
resultados_v2_norma <- data.frame(Valor_Real = teste_norma$PREMIO_NET_Corrigido,
                                  Valor_Prev = modelo_v2_norma_predictions)
resultados_v2_norma$Valor_Prev <- floor(resultados_v2_norma$Valor_Prev)

head(resultados_v2_original)
head(resultados_v2_norma)



## Criando um vetor de TRUE/FALSE indicando previsões CORRETAS/INCORRETAS
vetor_modelo_v2_ori <- resultados_v2_original == teste_original$PREMIO_NET_Corrigido
vetor_modelo_v2_nor <- resultados_v2_norma == teste_norma$PREMIO_NET_Corrigido

table(vetor_modelo_v2_ori)                    # FALSE 52           TRUE 208
table(vetor_modelo_v2_nor)                    # FALSE 44           TRUE 216
prop.table(table(vetor_modelo_v2_ori))        # FALSE 0.2          TRUE 0.8
prop.table(table(vetor_modelo_v2_nor))        # FALSE 0.1692308    TRUE 0.8307692  











# Previsões com modelo de Kernel













# TIPO_EMISSAO  - TIPO FACTOR
# PREMIO_SEGURO  - NUM
# PREMIO_SEGURO_LIQUIDO - TIPO NUM
# PREMIO_Resseguro_Bruto - TIPO NUM
# COMISSAO_Resseguro - TIPO NUM
# LMG_Ultimo_Unique - TIPO NUM
# PREMIO_NET_Corrigido - TIPO NUM
# COMISSAO_de_Resseguro_Corrigida - TIPO NUM
# Check_Premio_de_Resseguro - TIPO NUM


# - Você tem uma base de dados de uma carteira de seguros de propriedades (Property) de uma seguradora. Aqui está uma explicação das
#   principais variáveis presentes na base de dados:


# CONTRATO                       : Número de contrato ou identificação única de cada apólice de seguro.
# TIPO EMISSÃO                   : Indica o tipo de emissão da apólice, possivelmente "LIDERANÇA" referindo-se à apólice principal.
# APÓLICE                        : Número da apólice de seguro.
# Endosso                        : Número de endosso, que representa alterações ou adições às condições da apólice.
# RAMO                           : Código que identifica o ramo de seguro, como Property (propriedade).
# DATA EMISSÃO                   : Data em que a apólice foi emitida.
# DATA INÍCIO DA VIGÊNCIA        : Data de início da vigência da apólice.
# DATA TÉRMINO DA VIGÊNCIA       : Data de término da vigência da apólice.
# MOEDA                          : Moeda em que a apólice está denominada, possivelmente BRL (Real brasileiro).
# LMG                            : Limite Máximo de Garantia, que é o valor máximo que a seguradora pagará em caso de sinistro.
# LMG Facility                   : Limite Máximo de Garantia da apólice.
# PRÊMIO SEGURO                  : Prêmio de seguro a ser pago pelo segurado.
# COMISSÃO %                     : Porcentagem da comissão de seguro.
# COMISSÃO SEGURO                : Valor da comissão de seguro.
# PRÊMIO SEGURO LIQUIDO          : Valor líquido do prêmio de seguro após dedução da comissão.
# % RESSEGURO                    : Porcentagem de resseguro.
# PRÊMIO Resseguro Bruto         : Prêmio de resseguro bruto.
# % COMISSÃO RESSEGURO           : Porcentagem da comissão de resseguro.
# COMISSÃO Resseguro             : Valor da comissão de resseguro.
# Check Quantidade               : Quantidade de verificações.
# Chave c Endosso                : Chave que pode estar relacionada ao número do endosso.
# Check Quantidade de Chaves     : Quantidade de chaves.
# Apolice_Ultima                 : Informação sobre a apólice mais recente.
# Chave_Apolice_Ultima           : Chave relacionada à apólice mais recente.
# LMG_Facility                   : Limite Máximo de Garantia da apólice.
# LMG_Corrigido                  : Limite Máximo de Garantia corrigido.
# LMG_Ultimo_Dup                 : Limite Máximo de Garantia do último dup.
# LMG_Ultimo_Unique              : Limite Máximo de Garantia do último único.
# PRÊMIO NET_Corrigido           : Prêmio líquido corrigido.
# COMISSÃO de Resseguro_Corrigida: Comissão de resseguro corrigida.
# Check Comissao de Resseguro    : Verificação da comissão de resseguro.
# Check Premio de Resseguro      : Verificação do prêmio de resseguro.
# Check Premio de Resseguro Bruto: Verificação do prêmio de resseguro bruto.
# Ano de Contrato                : Ano do contrato.
# APÓLICE&INICIODEVIG            : Combinação da apólice e data de início de vigência.
# UWY                            : Possivelmente, um ano de subscrição ou data relevante.
# LMG Facility Unique            : Limite Máximo de Garantia da apólice único
# Year&Month                     : Ano e mês da transação.













