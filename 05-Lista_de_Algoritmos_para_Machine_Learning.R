# Conceito Machine Learning (Algoritmos de Machine Learning)

# Configurando o diretório de trabalho
setwd("C:/Users/Julia/Desktop/CienciaDeDados/1.Big-Data-Analytics-com-R-e-Microsoft-Azure-Machine-Learning/11.Machine-Learning-em-Linguagem-R")
getwd()



#####################       Algoritmos de Machine Learning          #####################


# - Há tantos algoritmos disponíveis com tantos métodos diferentes, que somente o processo de escolha de qual deve ser usado, já vai consumir 
#   bastante do seu tempo como Cientista de Dados. A dica é usar mais de um algoritmo. É importante conhecer mais de um algoritmo, criar mais de uma
#   versão do modelo para assim chegar na melhor versão do resultado.



# - Podemos categorizar os algoritmos de Machine Learning em 2 grupos principais:



##### Estilo de Aprendizagem #####


## Aprendizado Supervisionado:
  
#  - Quando Usar: Use aprendizado supervisionado quando tiver um conjunto de dados com exemplos rotulados e desejar prever valores ou classes com
#                 base nesses rótulos.

# - Exemplos de Algoritmos: Regressão Linear, Árvores de Decisão, Redes Neurais, Support Vector Machines (SVM), Naive Bayes, etc.


## Aprendizado Não Supervisionado:
  
# - Quando Usar: Use aprendizado não supervisionado quando não tiver rótulos em seus dados e quiser encontrar estruturas ou padrões intrínsecos.

# - Exemplos de Algoritmos: K-Means, Hierarchical Clustering, Principal Component Analysis (PCA), Autoencoders, etc.


## Aprendizado por Reforço:

# - Quando Usar: Use aprendizado por reforço quando estiver lidando com problemas de decisão sequencial e quiser treinar agentes para tomar ações
#   em um ambiente para maximizar recompensas.

# -  Exemplos de Algoritmos: Q-Learning, Deep Q-Networks (DQN), Actor-Critic, etc.





##### Similaridade (Funcionamento) ##### 


## Árvores de Decisão:

# - Como Funcionam: As árvores de decisão dividem os dados em subconjuntos com base nas características dos dados e tomam decisões com base nas
#   regras definidas na árvore.

# - Quando Usar: São eficazes em tarefas de classificação e regressão e são interpretações intuitivas.


## Redes Neurais:

# - Como Funcionam: As redes neurais são modelos inspirados no cérebro humano, compostos por neurônios artificiais interconectados.

# - Quando Usar: São poderosas em problemas complexos, como visão computacional, processamento de linguagem natural e tarefas de aprendizado 
#   profundo.


## Métodos de Clustering:

# - Como Funcionam: Os métodos de clustering agrupam dados semelhantes em clusters ou grupos com base na proximidade entre os pontos de dados.

# - Quando Usar: São úteis quando você deseja identificar grupos ou padrões nos dados.


## Métodos Ensemble:

# - Como Funcionam: Os métodos ensemble combinam as previsões de vários modelos individuais para melhorar o desempenho geral.

# - Quando Usar: São eficazes quando você deseja aumentar a precisão e a robustez do modelo.


## Métodos de Decomposição de Matriz:

# - Como Funcionam: Esses métodos decompoem matrizes de dados em partes menores e mais significativas, muitas vezes usadas para redução de 
#   dimensionalidade.

# - Quando Usar: Úteis quando você deseja representar dados de maneira mais compacta.





################### Lista com algoritmos de Machine Learning ###################


#  -> Algoritmos de Regressão: (Regressão refere-se a modelar a relação entre variáveis ajustando as medidas de erros nas previsões feitas pelo
#                               modelo)

# - Ordinary Least Squares Regression (OLSR)
# - Linear Regression
# - Logistic Regression
# - Stepwise Regression
# - Multivariae Adaptive Regression Splines (MARS)
# - Locally Estimated Scatterplot Smoothing (LOESS)



#  -> Algoritmos Regulatórios: (são normalmente uma extensão para os métodos de regressão que penalizam os modelos baseados em sua complexidade
#                              favorecendo assim modelos mais simples)

# - Ridge Regression
# - Least Absolute Shrinkage and Selection Operator (LASSO)
# - Elastic Net
# - Least-Angle Regression (LARS)



#  -> Algoritmos Baseados em Instância: (esses algortimos geralmente constroem uma espécie de banco de dados e comparam novos dados com esse banco
#          (Instance=based)             de dados usando uma medida de similaridade a fim de encontrar a melhor correspondência e assim fazer as
#                                       previsões)

# - k-Nearest Neighbour (kNN)
# - Learning Vector Quantization (LVQ)
# - Self-Organizing Map (SOM)
# - Locally Wighted Learning (LWL)



#  -> Algoritmos de Árvore de Decisão: (esses algoritmos são baseados em árvores de decisão e constroem modelos de decisão com base em valores
#                                      reais dos atributos dos dados. Eles criam uma estrutura de árvore mesmo até que uma decisão de previsão
#                                      seja feita para um determinado registro. São treinadas com dados para problemas de classificação e regressão
#                                      São muitas vezes rápidas e precisas e é um dos métodos preferido em Machine Learning)

# - Classification and Regression Tree (CART)
# - Conditional Decision Trees
# - Iterative Dichotomiser 3 (ID3)
# - C4.5 and C5.0 (different versions of a powerful approach)
# - Chi-squared Automatic Interaction Detection (CHAID)
# - Decision Stump
# - M5



#  -> Algoritmos Bayesianos: (são aqueles que explicitamente aplicam o teorema de Bayes para problemas de classificação e regressão.
#                            o teorema de Bayes é uma das bases para a teoria da probabilidade)

# - Naive Bayes
# - Gaussian Naive Bayes
# - Multinomial Naive Bayes
# - Averaged One-Dependence Estimators (AODE)
# - Bayesian Belief Network (BBN)
# - Bayesian Network (BN)



#  -> Algoritmos de Clustering: (nesta categoria de algoritmos, os dados são organizados em grupos chamado de clusters. esses algoritmos são na
#                               verdade de aprendizagem não supervisionada)

# - k-Means
# - k-Mediasn
# - Expectation Maximisation (EM)
# - Hierarchical Clustering



#  ->  Algoritmos Baseados em Regras de Associação:

# - Apriori algorithm
# - Eclat algorithm



#  -> Redes Neurais Artificiais: (as redes neurais são modelos inspirados pela estrutura das redes neurais biológicas. eles são uma classe de 
#                                correspondência padrão que são comunentemente usada em problemas de regressão e classificação.
#                                Mas não são apenas isso, são composto de centetas de algoritmos e variações para todos os tipos de problemas)

# - Perceptron
# - Back-Propagation
# - Hopfield Network
# - Radial Basis Function Network (RBFN)



#  -> Deep Learning: (os métodos de Deep Learning são uma atualização moderna para as redes neurais artificiais. Com esses algoritmos construímos
#                    redes bem mais complexas voltadas para soluções de problemas mais complexos.)

# - Deep Boltzmann Machine (DBM)
# - Deep Belief Networks (DBN)
# - Convolutional Neural Network (CNN)
# - Stacked Auto-Encoders



#  -> Algoritmos de Redução de   (esses algoritmos são de categoria de aprendizagem não supervisionada e pode ser usados durante um projeto de
#        Dimensionalidade:       construção de modelo preditivo. Pode usar a redução de dimensionalidade para processar os dados antes de treinar
#                                um outro algoritmo de Machine Learning)

# - Principal Component Analysis (PCA)
# - Principal COmponent Regression (PCR)
# - Partial Least Squares Regression (PLSR)
# - Multidimensional Scaling (MDS)
# - Projection Pursuit
# - Linear Discriminant Analysis (LDA)
# - Mixture Discriminant Analysis (MDA)
# - Quadratic Discriminant Analysys (QDA)
# - Flexible Discriminant Analysis (FDS)








