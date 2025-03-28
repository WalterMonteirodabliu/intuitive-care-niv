CREATE TABLE operadoras_ativas (
    registro_ans VARCHAR(20) PRIMARY KEY,
    cnpj VARCHAR(18),
    razao_social VARCHAR(255),
    nome_fantasia VARCHAR(255),
    modalidade VARCHAR(100),
    logradouro VARCHAR(255),
    numero VARCHAR(10),
    complemento VARCHAR(255),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    uf CHAR(2),
    cep VARCHAR(10),
    ddd VARCHAR(3),
    telefone VARCHAR(15),
    fax VARCHAR(15),
    endereco_eletronico VARCHAR(255),
    representante VARCHAR(255),
    cargo_representante VARCHAR(100),
    data_registro_ans DATE
);

CREATE TABLE demonstracoes_contabeis (
    id SERIAL PRIMARY KEY,
    registro_ans VARCHAR(20),
    ano INTEGER,
    trimestre INTEGER,
    ativo_total NUMERIC,
    passivo_total NUMERIC,
    patrimonio_liquido NUMERIC,
    receita_operacional NUMERIC,
    despesa_operacional NUMERIC,
    resultado_liquido NUMERIC,
    FOREIGN KEY (registro_ans) REFERENCES operadoras_ativas(registro_ans)
);

LOAD DATA LOCAL INFILE '/Documents/ans_dados/Relatorio_cadop.csv'
INTO TABLE operadoras_ativas
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT 
    operadora_nome,                    -- Nome ou identificação da operadora
    SUM(despesa_valor) AS total_despesas -- Soma total das despesas
FROM 
    demonstracoes_contabeis            -- Substitua pelo nome correto da tabela
WHERE 
    categoria = 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR' 
    AND data_despesa >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)  -- Últimos 3 meses (trimestre)
GROUP BY 
    operadora_nome
ORDER BY 
    total_despesas DESC                 -- Ordena por maior despesa
LIMIT 10;                              -- Limita a 10 operadoras

SELECT 
    operadora_nome,                    -- Nome ou identificação da operadora
    SUM(despesa_valor) AS total_despesas -- Soma total das despesas
FROM 
    demonstracoes_contabeis            -- Substitua pelo nome correto da tabela
WHERE 
    categoria = 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR'
    AND data_despesa >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)   -- Últimos 12 meses (ano)
GROUP BY 
    operadora_nome
ORDER BY 
    total_despesas DESC                 -- Ordena por maior despesa
LIMIT 10;                              -- Limita a 10 operadoras

