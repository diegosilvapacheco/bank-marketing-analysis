# Análise de Marketing Bancário

## 1. Introdução

Este projeto apresenta uma análise de dados utilizando **SQL**, desenvolvida no **MySQL Workbench 8.0**.

A análise utiliza o conjunto de dados **Bank Marketing**, disponibilizado pelo UCI Machine Learning Repository, com o objetivo de explorar o desempenho de campanhas de marketing bancário e identificar diferenças nas taxas de conversão entre diferentes grupos de clientes.

O foco do projeto está na utilização do SQL para transformar perguntas de negócio em análises quantitativas.

---

## 2. Contexto

Os dados referem-se a campanhas de marketing realizadas por telefone por uma instituição bancária portuguesa.

O conjunto possui **45.211 registros e 17 variáveis**.

A variável original `y`, responsável por indicar se o cliente contratou ou não o depósito a prazo, foi renomeada no projeto para `conversion_target`.

---

## 3. Objetivo

Identificar diferenças nas taxas de conversão entre os clientes e compreender quais características estão presentes entre aqueles que contrataram o depósito a prazo.

Para alcançar esse objetivo, a análise foi organizada em quatro dimensões:

* Desempenho da campanha
* Perfil dos clientes
* Efetividade do contato
* Desempenho ao longo dos meses

---

## 4. Base de dados

As principais variáveis utilizadas nas análises foram:

| Variável            | Descrição                            |
| ------------------- | ------------------------------------ |
| `age`               | Idade                                |
| `job`               | Trabalho                             |
| `marital`           | Estado civil                         |
| `education`         | Escolaridade                         |
| `contact`           | Meio de contato                      |
| `month_of_year`     | Mês do contato                       |
| `conversion_target` | Cliente assinou um depósito a prazo? |

A base também possui outras variáveis relacionadas às características financeiras dos clientes e ao histórico de contatos.

---

## 5. Ferramentas utilizadas

* **MySQL Workbench 8.0**
* **SQL**
* **GitHub**
* **Google Docs**

---

# 6. Perguntas e respostas

A análise foi desenvolvida a partir de perguntas de negócio.

Para cada pergunta, foram identificadas as variáveis necessárias e construída uma consulta SQL para obter o resultado.

---

## 6.1 Desempenho da campanha

### Qual foi a taxa geral de conversão da campanha?

**Dado utilizado:** `conversion_target`

### Consulta SQL

```sql
SELECT
    ROUND(
        SUM(conversion_target = 'yes')
        / COUNT(conversion_target) * 100,
        2
    ) AS conversion_rate
FROM bank_marketing;
```

### Entendendo a consulta

A função `SUM()` é utilizada para contabilizar os registros cujo valor de `conversion_target` é `yes`, representando os clientes que contrataram o depósito a prazo.

A função `COUNT()` contabiliza o total de clientes.

A divisão entre esses valores, multiplicada por 100, resulta na taxa percentual de conversão.

### Resultado

**Taxa de conversão: 11,70%**

### Resposta

A campanha apresentou uma taxa geral de conversão de **11,70%**.

---

# 6.2 Perfil dos clientes

Para compreender as diferenças de conversão entre os clientes, foram analisadas as variáveis de idade, ocupação, escolaridade e estado civil.

---

## 6.2.1 Faixa etária

### A taxa de conversão varia conforme a faixa etária?

**Dados utilizados:** `age`, `conversion_target`

### Consulta SQL

```sql
SELECT
    CASE
        WHEN age <= 27 THEN '18-27'
        WHEN age <= 37 THEN '28-37'
        WHEN age <= 47 THEN '38-47'
        WHEN age <= 57 THEN '48-57'
        WHEN age >= 58 THEN '58+'
    END AS age_group,
    ROUND(
        SUM(conversion_target = 'yes')
        / COUNT(conversion_target) * 100,
        2
    ) AS conversion_rate
FROM bank_marketing
GROUP BY age_group
ORDER BY conversion_rate DESC;
```

### Entendendo a consulta

A coluna `age` foi utilizada para criar faixas etárias por meio da expressão `CASE`.

Depois, `GROUP BY` agrupa os clientes de acordo com essas faixas.

Para cada grupo é calculada a taxa de conversão.

### Resultado

| Faixa etária | Taxa de conversão |
| ------------ | ----------------: |
| 18–27        |        **19,51%** |
| 28–37        |            11,29% |
| 38–47        |             9,25% |
| 48–57        |             9,09% |
| 58+          |        **23,07%** |

### Resposta

Na análise realizada, os maiores percentuais de conversão foram observados entre os clientes de **18 a 27 anos** e os clientes com **58 anos ou mais**.

---

## 6.2.2 Ocupação

### A taxa de conversão varia de acordo com a ocupação dos clientes?

**Dados utilizados:** `job`, `conversion_target`

### Consulta SQL

```sql
SELECT
    job,
    ROUND(
        SUM(conversion_target = 'yes')
        / COUNT(conversion_target) * 100,
        2
    ) AS conversion_rate
FROM bank_marketing
GROUP BY job
ORDER BY conversion_rate DESC;
```

### Entendendo a consulta

A coluna `job` é utilizada para agrupar os clientes de acordo com sua ocupação.

Para cada grupo, a taxa de conversão é calculada e os resultados são ordenados do maior para o menor percentual.

### Resultado

| Ocupação | Taxa de conversão |
| -------- | ----------------: |
| Student  |            28,68% |
| Retired  |            22,79% |
| ...      |               ... |

### Resposta

Estudantes e aposentados apresentaram os maiores percentuais de conversão entre as ocupações analisadas.

---

## 6.2.3 Escolaridade

### Existem diferenças na taxa de conversão entre os níveis de escolaridade?

**Dados utilizados:** `education`, `conversion_target`

### Consulta SQL

```sql
SELECT
    education,
    ROUND(
        SUM(conversion_target = 'yes')
        / COUNT(conversion_target) * 100,
        2
    ) AS conversion_rate
FROM bank_marketing
GROUP BY education
ORDER BY conversion_rate DESC;
```

### Entendendo a consulta

Os clientes são agrupados de acordo com a variável `education`.

Em seguida, a taxa de conversão é calculada para cada nível de escolaridade.

### Resultado

**Ensino superior (`tertiary`): 15,01%**

### Resposta

Na base analisada, clientes com ensino superior apresentaram a maior taxa de conversão entre os níveis de escolaridade.

---

## 6.2.4 Estado civil

### A taxa de conversão apresenta diferenças de acordo com o estado civil?

**Dados utilizados:** `marital`, `conversion_target`

### Consulta SQL

```sql
SELECT
    marital,
    ROUND(
        SUM(conversion_target = 'yes')
        / COUNT(conversion_target) * 100,
        2
    ) AS conversion_rate
FROM bank_marketing
GROUP BY marital
ORDER BY conversion_rate DESC;
```

### Entendendo a consulta

A coluna `marital` é utilizada para agrupar os clientes por estado civil.

A taxa de conversão é calculada para cada grupo e os resultados são ordenados de acordo com o percentual obtido.

### Resultado

| Estado civil | Taxa de conversão |
| ------------ | ----------------: |
| Single       |            14,95% |
| Divorced     |            11,95% |
| Married      |            10,12% |

### Resposta

Clientes solteiros apresentaram o maior percentual de conversão entre os grupos de estado civil analisados.

---

# 6.3 Efetividade do contato

### A taxa de conversão varia de acordo com o meio de contato utilizado?

**Dados utilizados:** `contact`, `conversion_target`

### Consulta SQL

```sql
SELECT 
    contact,
    COUNT(*) AS tot_clients,
    SUM(conversion_target = 'yes') AS subscribers,
    ROUND(
        SUM(conversion_target = 'yes')
        / COUNT(*) * 100,
        2
    ) AS conversion_perc
FROM bank_marketing
GROUP BY contact
ORDER BY conversion_perc DESC;
```

### Entendendo a consulta

A coluna `contact` é utilizada para agrupar os clientes conforme o meio de contato.

Além da quantidade total de clientes e de conversões, a consulta calcula a taxa de conversão de cada meio.

### Resultado

| Meio de contato | Taxa de conversão |
| --------------- | ----------------: |
| Cellular        |            14,92% |
| Telephone       |            13,42% |
| Unknown         |             4,07% |

### Resposta

Foram observadas diferenças nas taxas de conversão entre os meios de contato analisados.

---

# 6.4 Desempenho ao longo dos meses

### Como a taxa de conversão variou entre os meses da campanha?

**Dados utilizados:** `month_of_year`, `conversion_target`

### Consulta SQL

```sql
SELECT 
    month_of_year,
    ROUND(
        SUM(conversion_target = 'yes')
        / COUNT(conversion_target) * 100,
        2
    ) AS conversion_rate
FROM bank_marketing
GROUP BY month_of_year
ORDER BY FIELD(
    month_of_year,
    'jan', 'feb', 'mar', 'apr', 'may', 'jun',
    'jul', 'aug', 'sep', 'oct', 'nov', 'dec'
);
```

### Entendendo a consulta

A coluna `month_of_year` é utilizada para agrupar os clientes por mês.

O comando `FIELD()` foi utilizado para ordenar os meses na sequência do calendário, evitando que fossem apresentados em ordem alfabética.

### Resultado

| Mês      | Taxa de conversão |
| -------- | ----------------: |
| Março    |            51,99% |
| Dezembro |            46,73% |
| Setembro |            46,46% |
| Outubro  |            43,77% |
| ...      |               ... |

O menor percentual apresentado na análise foi registrado em maio, com **6,72%**.

### Resposta

Foram observadas diferenças nas taxas de conversão entre os meses analisados.

---

# 7. Principais insights

A análise permitiu identificar:

* Taxa geral de conversão de **11,70%**.
* Diferenças nas taxas de conversão entre as faixas etárias.
* Estudantes e aposentados apresentaram os maiores percentuais entre as ocupações analisadas.
* Clientes com ensino superior apresentaram taxa de conversão de **15,01%**.
* Clientes solteiros apresentaram taxa de conversão de **14,95%**.
* O contato por celular apresentou taxa de conversão de **14,92%**.
* Foram observadas diferenças relevantes entre os meses analisados.

Esses resultados representam **diferenças observadas na base de dados** e não permitem afirmar, isoladamente, que determinada característica seja responsável por causar uma maior ou menor conversão.

---

# 8. Conclusão

A análise permitiu explorar os resultados de uma campanha de marketing bancário utilizando SQL como principal ferramenta.

A partir de perguntas de negócio, foram utilizadas funções de agregação, agrupamentos, cálculos percentuais, criação de faixas etárias e ordenação de dados para comparar diferentes grupos de clientes e características da campanha.

**O projeto demonstra como consultas SQL podem ser utilizadas para transformar dados em informações e responder perguntas de negócio sem depender necessariamente de uma visualização gráfica.**

---

# 9. Limitações

* A base não informa o ano em que os contatos foram realizados.
* Dessa forma, não é possível comparar o desempenho de um mesmo mês entre anos diferentes.
* A análise identifica diferenças entre grupos, mas não permite estabelecer relações de causa e efeito.
* As conclusões estão limitadas às variáveis disponíveis no conjunto de dados.

---

# 10. Estrutura do projeto

```text
bank-marketing-analysis/
│
├── README.md
├── sql/
│   └── bank_marketing.sql
├── csv/
│   └── dataset_bank_marketing.csv
├── docs/
│   └── Análise de Marketing Bancário.pdf
└── images/
    └── age_group.png
    └── conversion_perc.png
    └── conversion_rate.png
    └── education.png
    └── job.png
    └── marital.png
    └── month_of_year.png

```

### `README.md`

Apresentação, metodologia, consultas selecionadas, resultados e conclusões.

### `bank_marketing.sql`

Arquivo com o código SQL completo utilizado no projeto.

### `dataset/`

Base de dados utilizada na análise.

---

# 11. Como reproduzir o projeto

1. Baixe o dataset **Bank Marketing** no UCI Machine Learning Repository.
2. Crie a tabela `bank_marketing` utilizando o código disponível no arquivo `bank_marketing.sql`.
3. Importe os dados para o MySQL.
4. Execute as consultas presentes no arquivo `bank_marketing.sql`.
5. Compare os resultados obtidos com os apresentados neste README.

---

## Fonte dos dados

**UCI Machine Learning Repository — Bank Marketing**

https://archive.ics.uci.edu/dataset/222/bank%2Bmarketing
