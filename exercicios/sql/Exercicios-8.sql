-- 1 D

-- 2 C, D

-- 3 D

-- 4 A

-- 5 B

-- 6 A

-- 7 D

-- 8 C

-- 9
SELECT ROUND(AVG(LENGTH(nm_pais))) AS media FROM tb_pais;

-- 10
SELECT TO_CHAR(TO_DATE(data_termino, 'dd-mm-rr'), 'YYYY') AS ano, id_funcao AS função, COUNT(1) as quantidade
FROM tb_historico_funcao
GROUP BY TO_CHAR(TO_DATE(data_termino, 'dd-mm-rr'), 'YYYY'), id_funcao
ORDER BY quantidade asc;

-- 11
SELECT TO_CHAR(TO_DATE(data_admissao, 'dd-mm-yy'), 'DAY') AS dia, COUNT(1) AS quantidade
FROM tb_empregado
GROUP BY TO_CHAR(TO_DATE(data_admissao, 'dd-mm-yy'), 'DAY')
ORDER BY quantidade desc;

-- 12 D

-- 13 B, D

-- 14 A

-- 15 C

-- 16 C

-- 17 D

-- 18 B

-- 19 C

-- 20 B

-- 21 A