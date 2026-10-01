CREATE TABLE bank_marketing (
    age INT,
    job VARCHAR(50),
    marital VARCHAR(30),
    education VARCHAR(30),
    credit_default VARCHAR(10),
    balance INT,
    housing VARCHAR(10),
    loan VARCHAR(10),
    contact VARCHAR(30),
    day_of_month INT,
    month_of_year VARCHAR(10),
    duration INT,
    campaign INT,
    pdays INT,
    previous INT,
    poutcome VARCHAR(30),
    conversion_target VARCHAR(10) -- Coluna 'y' renomeada para clareza
);

-- Compreendendo os dados
SELECT * FROM bank_marketing
LIMIT 10;

-- Perguntas de negócio
-- 1. Desempenho da Campanha
-- 1.1 Qual foi a taxa geral de conversão da campanha?
SELECT
    ROUND(SUM(conversion_target = 'yes') / COUNT(conversion_target) * 100, 2) AS conversion_rate
FROM bank_marketing;

-- 2. Perfil dos Clientes
-- 2.1 A taxa de conversão apresenta diferenças entre as faixas etárias?
SELECT
    CASE
        WHEN age <= 27 THEN '18-27'
        WHEN age <= 37 THEN '28-37'
        WHEN age <= 47 THEN '38-47'
        WHEN age <= 57 THEN '48-57'
        WHEN age >= 58 THEN '58+'
    END AS age_group,
    ROUND(SUM(conversion_target = 'yes') / COUNT(conversion_target) * 100, 2) as conversion_rate
FROM bank_marketing
GROUP BY age_group
ORDER BY conversion_rate DESC;
 
-- 2.2 A taxa de conversão varia de acordo com a ocupação dos clientes?
SELECT
    job,
    ROUND(SUM(conversion_target = 'yes') / COUNT(conversion_target) * 100, 2) as conversion_rate
FROM bank_marketing
GROUP BY job
ORDER BY conversion_rate DESC;

-- 2.3 Existem diferenças na taxa de conversão entre os níveis de escolaridade?
SELECT
    education,
    ROUND(SUM(conversion_target = 'yes') / COUNT(conversion_target) * 100, 2) as conversion_rate
FROM bank_marketing
GROUP BY education
ORDER BY conversion_rate DESC;

-- 2.4 A taxa de conversão apresenta diferenças de acordo com o estado civil?
SELECT
    marital,
    ROUND(SUM(conversion_target = 'yes') / COUNT(conversion_target) * 100, 2) as conversion_rate
FROM bank_marketing
GROUP BY marital
ORDER BY conversion_rate DESC;

-- 3. Efetividade do Contato
-- 3.1 A taxa de sucesso da campanha muda de acordo com o meio de contato?
SELECT 
    contact,
    COUNT(*) AS tot_clients,
    SUM(conversion_target = 'yes') AS subscribers,
    ROUND((SUM(conversion_target = 'yes') / COUNT(*)) * 100, 2) AS conversion_perc
FROM bank_marketing
GROUP BY contact
ORDER BY conversion_perc DESC;

-- 4. Desempenho ao Longo do Tempo
-- 4.1 Como a taxa de conversão variou entre os meses da campanha?
SELECT 
    month_of_year,
    ROUND(SUM(conversion_target = 'yes') / COUNT(conversion_target) * 100, 2) AS conversion_rate
FROM bank_marketing
GROUP BY month_of_year
ORDER BY FIELD(
    month_of_year,
    'jan', 'feb', 'mar', 'apr', 'may', 'jun', 
    'jul', 'aug', 'sep', 'oct', 'nov', 'dec'
);

