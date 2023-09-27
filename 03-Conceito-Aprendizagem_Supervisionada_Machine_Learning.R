# Conceito Machine Learning (Tipos de Aprendizagem - Aprendizagem Supervisionada)

# Configurando o diretório de trabalho
setwd("C:/Users/Julia/Desktop/CienciaDeDados/1.Big-Data-Analytics-com-R-e-Microsoft-Azure-Machine-Learning/11.Machine-Learning-em-Linguagem-R")
getwd()



#####################       Aprendizagem Supervisionada       #####################


# - É o termo usado sempre que o algoritmo é "treinado" sobre um conjunto de dados históricos contendo entradas e saídas.
# - Baseado no treinamento com os dados históricos, o modelo pode tomar decisões precisas quando recebe novos dados.

# - A aprendizagem supervisionada ocorre quando um algoritmo aprende a partir de dados históricos de exemplo, com entradas (inputs) e possíveis
#   saídas (outputs), que podem consistir em valores quantitativos ou qualitativos, a fim de prever a resposta correta quando recebe novos dados.

# - O  aprendizado supervisionado é amplamente utilizado em tarefas de classificação e regressão. Alguns exemplos de aplicação incluem:

# - Classificação de E-mails       : Determinar se um e-mail é spam ou não spam com base em exemplos rotulados.
# - Previsão de Preços Imobiliários: Prever o preço de uma casa com base em características como tamanho, localização, etc.
# - Diagnóstico Médico             : Identificar doenças com base em dados de pacientes e resultados de testes.




# - A Aprendizagem Supervisionada é dividida em duas categorias:

#  -> Regressão: é basicamente você realizar previsão de valores numéricos. Neste caso é necessário escolher um algoritmo para Regressão e apresentar
#                ao algoritimo dados de entrada e saída. O Algoritmo vai então aprender a relação e criar o modelo e com esse modelo nós inserimos 
#                novos conjuntos de dados de entrada e assim ele será capaz de prever as saídas.

# Exemplos:

# - Prever o preço de uma casa com base em características como o número de quartos, banheiros, área, etc.
# - Prever a receita de vendas de um produto com base em fatores como preço, publicidade, tempo, etc.
# - Prever a temperatura máxima diária com base em dados meteorológicos históricos.



#  -> Classificação: como o próprío nome sugere, é para quando quisermos classificar alguma coisa, como classificar por exemplo em sim ou não,
#                    se devo ou não conceder créditos, dividir em categorias, se a imagem é de um cachorro, pato etc.
#                    Com a Classificação nosso objetivo é determinar o rótulo da saída, outro exemplo é a questão de doenças, se tem ou não.
#                    Não estamos prevendo um valor numérico e sim uma classe / rótulo / categoria.

# Exemplos:

# - Classificar e-mails como spam ou não spam com base no conteúdo e em outras características.
# - Classificar transações financeiras como fraudulentas ou legítimas.
# - Classificar imagens como gatos, cachorros, carros, etc., em tarefas de visão computacional.



