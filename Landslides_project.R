### Instalando a biblioteca para ler o csv
install.packages('readr')
library(readr)

### lendo o csv
df <- read_csv("Global_Landslide_Catalog_Export_20240517.csv")
View(df)
head(df)

### Informações da base
str(df)
summary(df)

### Linhas duplicadas
linhas_duplicadas <- duplicated(df)
df[linhas_duplicadas, ]

### Valores núlos por coluna
for (coluna in names(df)) {    # Percorrendo todas as colunas da base
  porcentagem_na <- sum(is.na(df[[coluna]])) / nrow(df) * 100                  # Calcula a porcentagem de núlos na coluna atual
  cat("Porcentagem de núlos na coluna", coluna, ":", porcentagem_na, "%\n")    # Imprime o resultado para a coluna atual
}

### Removendo as colunas com porcentagem alta
colunas_para_remover <- c()    # Criando uma variável para armazenar as colunas

for (coluna in names(df)) {    # Percorrendo todas as colunas da base
  porcentagem_na <- sum(is.na(df[[coluna]])) / nrow(df) * 100    # Calcula a porcentagem de núlos
  if (porcentagem_na > 50) {                                     # Verificando se a porcentagem é maior que 50%
    colunas_para_remover <- c(colunas_para_remover, coluna)      # Adicionando o nome da coluna na lista
  }
}

df <- df[, !(names(df) %in% colunas_para_remover)]    # Removendo as colunas do dataframe

### Removendo as colunas com porcentagem baixa
for (coluna in names(df)) {    # Percorrendo todas as colunas da base
  porcentagem_na <- sum(is.na(df[[coluna]])) / nrow(df) * 100    # Calcula a porcentagem de núlos
  if (porcentagem_na < 8) {                                      # Verificando se a porcentagem é menor que 8%
    df <- df[!is.na(df[[coluna]]), ]                             # Removendo as linhas do dataframe
  }
}

