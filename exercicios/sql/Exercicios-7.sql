-- 1
SELECT *
FROM tb_clientes
WHERE nome LIKE '%li%';

-- 2
SELECT nome || ' ' || sobrenome as Destinatarios
FROM tb_clientes
WHERE LENGTH(nome) + LENGTH(sobrenome) <= 10
UNION
SELECT SUBSTR(nome, 1, 1) || SUBSTR(sobrenome, 1, 10)
FROM tb_clientes
WHERE LENGTH(nome) + LENGTH(sobrenome) > 10;

-- 3 - D, B

-- 4 - A

-- 5 - B

-- 6 - A

-- 7 - D

-- 8 - C

-- 9 - C

-- 10 - A

-- 11 - A

-- 12 - D
