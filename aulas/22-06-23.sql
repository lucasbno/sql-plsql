SELECT sobrenome, id_departamento, salario
FROM tb_empregado
WHERE (salario, id_departamento) IN (SELECT salario, id_departamento
                                     FROM tb_empregado
                                     WHERE percentual_comissao IS NOT NULL);
                                     
--------------------------------------------------------------------------------

SELECT e.sobrenome, d.nm_departamento, e.salario
FROM tb_empregado e, tb_departamento d
WHERE e.id_departamento = d.id_departamento
AND (salario, NVL(percentual_comissao, 0)) IN (SELECT salario, NVL(percentual_comissao, 0)
                                               FROM tb_empregado e, tb_departamento d
                                               WHERE e.id_departamento = d.id_departamento
                                               AND d.id_localizacao = 1700);
--------------------------------------------------------------------------------

SELECT sobrenome, salario
FROM tb_empregado
WHERE sobrenome != 'Kochhar'
AND  (salario, NVL(percentual_comissao, 0)) IN (SELECT salario, NVL(percentual_comissao, 0)
                                     FROM tb_empregado
                                     WHERE sobrenome = 'Kochhar');
--------------------------------------------------------------------------------

SELECT id_empregado, sobrenome, id_departamento
FROM tb_empregado
WHERE id_departamento IN (SELECT id_departamento)

SELECT e.id_empregado, e.sobrenome, e.id_departamento, d.nm_departamento
FROM tb_empregado e
INNER JOIN tb_departamento d
ON (e.id_departamento = d.id_departamento)
WHERE (SELECT id_localizacao
     FROM tb_localizacao
     WHERE cidade LIKE 'T%');
     
--------------------------------------------------------------------------------

SELECT * FROM tb_empregado;

SELECT nome, sobrenome, id_funcao, salario
FROM tb_empregado externa
WHERE salario > ALL (SELECT max(salario)
                 FROM tb_empregado
                 WHERE id_funcao = 'SA_MAN')
ORDER BY 3 DESC;
                 
SELECT id_produto, id_tipo_produto, nm_produto, preco
FROM tb_produtos externa
WHERE preco > (SELECT AVG(preco)
               FROM tb_produtos interna
               WHERE interna.id_tipo_produto = externa.id_tipo_produto);

SELECT id_produto, id_tipo_produto, nm_produto, preco
FROM tb_produtos externa
WHERE preco > ALL (SELECT AVG(preco)
               FROM tb_produtos
               WHERE interna.id_tipo_produto = externa.id_tipo_produto);

SELECT *
FROM tb_localizacao
WHERE cidade LIKE 'T%';

select * from tb_localizacao;

SELECT * FROM tb_empregado;
SELECT * FROM tb_departamento;
SELECT * FROM tb_localizacao;