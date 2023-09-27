# Conceito Machine Learning (Processo de Aprendizagem)

# Configurando o diretório de trabalho
setwd("C:/Users/Julia/Desktop/CienciaDeDados/1.Big-Data-Analytics-com-R-e-Microsoft-Azure-Machine-Learning/11.Machine-Learning-em-Linguagem-R")
getwd()



#####################       O Processo de Aprendizagem      #####################

# - Um componente chave do processo de aprendizagem é a generalização!

# - E para poder generalizar a função que melhor resolve o problema, os algoritmos de Machine Learning se baseiam em 3 componentes:

#  -> Representação: é o conjunto de modelos que o algoritmo pode aprender
#  -> Avaliação    : um algoritmo pode criar mais de um modelo, mas ele nao sabe qual modelo é bom ou ruim, para isso o algoritmo de Machine Learning
#                    faz a avaliação dos modelos gerados por ele mesmo e atribui pontos. Cada modelo recebe uma pontuação o que ajude a escolher o
#                    melhor modelo.
#  -> Otimização   : em algum momento produz um conjunto de modelos que produzem o resultado correto. É um algoritmo dentro de outro algoritmo onde
#                    busca a otimização.


# - Os algoritmos de aprendizagem possuem diversos parâmetros internos (valores separados em vetores e matrizes).
#   Esses parâmetros funcionam como uma espécie de memória para o algoritmo, permitindo que o mapeamento ocorra e as características analisadas
#   sejam conectadas.

# - As dimensões e tipos de parâmetros internos delimitam o tipo de funções-alvo que um algoritmo pode aprender. O engine de otimização no algoritmo
#   muda os valores iniciais dos parâmetros durante a aprendizagem para representar função-alvo.








