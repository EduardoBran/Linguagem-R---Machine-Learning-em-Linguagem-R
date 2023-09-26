# Conceito Machine Learning

# Configurando o diretório de trabalho
setwd("C:/Users/Julia/Desktop/CienciaDeDados/1.Big-Data-Analytics-com-R-e-Microsoft-Azure-Machine-Learning/11.Machine-Learning-em-Linguagem-R")
getwd()


# O que vamos aprender neste capítulo:

# -> Definição de Machine Learning
# -> Frameworks de Machine Learning
# -> Processo de Aprendizagem
# -> Treinamento, Validação e Teste
# -> Modelos Preditivos
# -> Algoritmos de Machine Learning
# -> Regressão e Classificação Através de 2 Projetos Completos
# -> Lista de Exercícios com a Construção de Modelos


# Iremos trabalhar com 2 Projetos Inteiros de Regressão e Classificação ao longo do capítulo:

#  -> Projeto Prevendo Despesas Hospitalares
#  -> Projeto Prevendo a Ocorrência de Câncer

# Nestes projetos iremos: definir o problema de negócio, realizar a análise exploratória, transformação e limpeza dos dados, treinar o modelo e
#                         entregar a solução final.





#######################      INTRODUÇÃO AO APRENDIZADO DE MÁQUINA (Machine Learning)      #######################


# - Objetivo é aprender o que é e o que não é Machine Learning.


## O que é Machine Learning ?

#  -> Machine Learning é um método de análise de dados que automatiza a construção de modelos analíticos usando algoritmos que imperativamente
#     aprendem a partir dos dados, portando Machine Learning permite que computadores encontrem insights ocultos sem que sejam programados para isso.

#  -> Os algoritmos processam os dados de maneira específicas e criam previsões baseados em padrões detectados nos dados.


## E como as máquinas aprendem ?

#  -> As máquinas aprendem através de um processo de treinamento supervisionado em que algoritmos de Machine Learning aprendem a partir de dados, 
#     ajustando seus parâmetros internos para fazer previsões ou tomar decisões com base em padrões detectados nos dados de treinamento. 
#     Esse processo é iterativo e envolve a coleta de dados, a preparação, o treinamento, a validação e a aplicação do modelo para resolver 
#     problemas do mundo real.



## Inteligência Artificial x Machine Learning x Deep Learning

# - Machine Learning é um subcampo da Inteligência Artificial e o Deep Learning é uma categoria de Machine Learning.
#   Nós temos várias algoritmos de Machine Learning e uma família de algoritmos é o que chamamos de Deep Learning.

# - Portanto Inteligência Artificial inclui Machine Learning, mas Machine Learning por si só não define Inteligência Artificial.

# - Inteligência Aritificial é baseada em Machine Learning e Machine Learning é essencialmente diferente de Estatística.



# - Machine Learning se baseia em alguns importantes conceitos de:

#  -> Matemática            (Manipulação de Matrizes)
#  -> Estatística           (Teoria da Probabilidade e Inferência Estatística)
#  -> Ciência da Computação (Programação / Armazenamento e Processamento de Dados)


## O que são Algoritmos ?

# - Algoritmos são procedimentos (lista de ações) ou fórmulas usados para resolver problemas.
# - Machine Learning usa algoritmos para analisar grandes conjuntos de dados!



## O que são e quais são Os Machine Learning Frameworks

# - Para criar modelos de Machine Learning você tem duas opções:

#  -> Desenvolver os algoritmos a partir do zero
#  -> Utilizar Frameworks prontos

# Decidir se desenvolve do zero ou utiliza um Framework dependerá do problema de negócio.


# - Um framework é um conjunto de softwares que produzem um resultado específico. Um framework nos permite focar mais no problema de negócio e 
#   menos na parte de codificação.
# - Frameworks de Machine Learning permitem que você trabalhe em um problema, sem ter que saber muito sobre programação.
# - O framework cuida da gestão de infraestrutura, enquanto você pode focar mais na parte inteligente da sua aplicação.


# E por que usar Machine Learning frameworks ?

# - Para acelarmos o tempo de desenvolvimento de modelos preditivos.



## Principais Machine Learning Frameworks

#  Pacote caret       - oferece uma série de algoritmos prontos que você faz a chamada através de funções.
# (Linguagem R)         (preparamos os dados, organizamos os dados para o treinamento, fazemos a chamada a função,
#                       digo qual algoritmo utilizar, feito o treinamento, faz as previsões e entrega o resultado)

# Microsoft Azure     - ferramenta onde basta soltar e arrastar. É mais plataforma do que Framework, mas ainda assim ele oferece
# Machine Learning      alguns algoritmos prontos que podemos utilizar. Podemos também usar a linguagem R dentro do Azure.
#                       A principal vantagem é ser quase tudo visual, onde basta arrastar e soltar os módulos o que acelera o processo.

#   Scikit-Learn      - É uma biblioteca de código aberto em Python que oferece uma ampla variedade de algoritmos de Machine Learning para 
# (Linguagem Python)    tarefas de classificação, regressão, clusterização, seleção de características e muito mais. É uma ótima escolha para
#                       iniciantes e profissionais experientes.

# Apache Spark MLlib  - Integrado com o Apache Spark, o MLlib é uma biblioteca de Machine Learning distribuída que permite a execução de tarefas
#                       de Machine Learning em grandes conjuntos de dados distribuídos.

#   TensorFlow        - Desenvolvido pelo Google, o TensorFlow é um framework de Machine Learning de código aberto que se concentra principalmente
#                       em redes neurais e aprendizado profundo (Deep Learning). Ele oferece uma grande flexibilidade e é amplamente utilizado em
#                       pesquisa e produção. Recomendável quando já se tem algum conhecimento em Machine Learning em linguagem R ou Python.

#    Keras            - Keras é uma API de alto nível que pode ser executada em cima de outros frameworks, como TensorFlow e Theano. É conhecido 
#                       por ser fácil de usar e é uma escolha popular para prototipagem rápida de modelos de Deep Learning.

#   Caffe             - É um framework de Deep Learning especializado em visão computacional, amplamente utilizado em tarefas de reconhecimento
#                       de imagem.



