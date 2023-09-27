# Conceito Machine Learning (Tipos de Aprendizagem)

# Configurando o diretório de trabalho
setwd("C:/Users/Julia/Desktop/CienciaDeDados/1.Big-Data-Analytics-com-R-e-Microsoft-Azure-Machine-Learning/11.Machine-Learning-em-Linguagem-R")
getwd()



## Tipos de Aprendizagem em Machine Learning

# - O processo de Aprendizagem ocorre de diferentes formas e podemos dividir os algoritmos de Machine Learning em três grupos principais:


# ----> Algortimos de Aprendizagem Supervisionada

# - É o termo usado sempre que o algoritmo é "treinado" sobre um conjunto de dados históricos contendo entradas e saídas.
# - Baseado no treinamento com os dados históricos, o modelo pode tomar decisões precisas quando recebe novos dados.

# - A aprendizagem supervisionada ocorre quando um algoritmo aprende a partir de dados históricos de exemplo, com entradas (inputs) e possíveis
#   saídas (outputs), que podem consistir em valores quantitativos ou qualitativos, a fim de prever a resposta correta quando recebe novos dados.

# - O  aprendizado supervisionado é amplamente utilizado em tarefas de classificação e regressão. Alguns exemplos de aplicação incluem:

# - Classificação de E-mails       : Determinar se um e-mail é spam ou não spam com base em exemplos rotulados.
# - Previsão de Preços Imobiliários: Prever o preço de uma casa com base em características como tamanho, localização, etc.
# - Diagnóstico Médico             : Identificar doenças com base em dados de pacientes e resultados de testes.



# ----> Algortimos de Aprendizagem Não Supervisionada

# - A aprendizagem não supervisionada ocorre quando um algoritmo aprende com exemplos simples, sem qualquer resposta associada, deixando a cargo
#   do algoritmo determinar os padrões de dados por conta própria.

# - O aprendizado não supervisionado é frequentemente usado em tarefas de clusterização e redução de dimensionalidade. Alguns exemplos:

# - Segmentação de Mercado     : Agrupar clientes com base em seu comportamento de compra para direcionar estratégias de marketing.
# - Análise de Tópicos em Texto: Identificar tópicos relevantes em um conjunto de documentos sem rótulos.
# - Redução de Dimensionalidade: Reduzir a dimensionalidade de dados para visualização ou acelerar algoritmos de aprendizado.



# ----> Algortimos de Aprendizagem Por Reforço

# - O conceito de Aprendizagem Por Reforço é como aprender por tentativa e erro. Os erros ajudam a aprender, porque eles têm uma grande penalidade
#   associada a eles (custo, perda de tempo e assim por diante), ensinando que um determinado curso de ação tem menor probabilidade de êxito do 
#   que outros.

# - Usada em: robótica, videogames, sistemas de navegação como google maps


