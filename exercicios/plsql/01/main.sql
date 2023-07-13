-- 1)
SELECT id_empregado, nome
sal x 12 SALARIO ANUAL
FROM tb_empregado;

--------------------------------------------------------------------------------

-- 2)
@ /home/lucasbno/dev/sql/exercicios/plsql/01/script-02.sql;
/*
SELECT a.telefone, a.nome, b.ds_funcao AS "Função", data_admissao
FROM tb_empregado a 
INNER JOIN tb_funcao b
USING (id_funcao)
*/

--------------------------------------------------------------------------------

-- 4)
SELECT a.nome || ' ' || a.sobrenome || ', ' || b.ds_funcao AS "Empregado e Função"
FROM tb_empregado a
INNER JOIN tb_funcao b
USING(id_funcao);

--------------------------------------------------------------------------------

-- 5)
--Elabore uma consulta para exibir todos os registros a partir da TB_EMPREGADO.
--Separe cada coluna por uma vírgula. Identifique a coluna resultante como SAÍDA.
SELECT
id_empregado || ', ' || nome || ', ' || sobrenome || ', ' ||
email || ', ' || telefone || ', ' || data_admissao || ', ' ||
id_funcao || ', ' || salario || ', ' || NVL(to_char(percentual_comissao), 'null') || ', ' ||
NVL(to_char(id_gerente), 'null') || ', ' || NVL(to_char(id_departamento), 'null') AS "SAÍDA"
FROM tb_empregado;

--------------------------------------------------------------------------------

-- 6)
@ /home/lucasbno/dev/sql/exercicios/plsql/01/script-06.sql;
/*
SELECT nome, salario
FROM tb_empregado
WHERE salario > 2850.00
*/

--------------------------------------------------------------------------------

-- 7)
SELECT nome, id_departamento
FROM tb_empregado
WHERE id_empregado = 141;

--------------------------------------------------------------------------------

-- 8)
@ /home/lucasbno/dev/sql/exercicios/plsql/01/script-08.sql;
/*
SELECT nome, salario
FROM tb_empregado
WHERE salario NOT BETWEEN 1500.00 AND 2850.00;
*/

--------------------------------------------------------------------------------

-- 9)
SELECT a.nome, b.ds_funcao, a.data_admissao
FROM tb_empregado a
INNER JOIN tb_funcao b
USING (id_funcao)
WHERE data_admissao BETWEEN TO_DATE('20-FEB-87') AND TO_DATE('01-MAY-89')
ORDER BY data_admissao;

--------------------------------------------------------------------------------

-- 10)
SELECT nome, id_departamento
FROM tb_empregado
WHERE id_departamento IN (10, 30)
ORDER BY 1;

--------------------------------------------------------------------------------

-- 11)
SELECT nome AS "Funcionário", salario AS "Salário Mensal"
FROM tb_empregado
WHERE salario > 1500.00
AND id_departamento IN (10, 30);

--------------------------------------------------------------------------------

-- 12)
SELECT nome, data_admissao
FROM tb_empregado
WHERE TO_CHAR(TO_DATE(data_admissao, 'dd-mm-rr'), 'YYYY') = 1987;

--------------------------------------------------------------------------------

-- 13) Exibir o nome e a função de todos os funcionários que não tenham gerente associado.

SELECT a.nome, b.ds_funcao
FROM tb_empregado a
INNER JOIN tb_funcao b
USING (id_funcao)
WHERE id_gerente IS NULL;

--------------------------------------------------------------------------------

--14) Selecione o nome, o salário e a comissão de todos os funcionários que recebem comissão. Classifique as tuplas
--    resultantes em ordem decrescente de salário e comissão.

SELECT nome, salario, percentual_comissao
FROM tb_empregado
WHERE percentual_comissao IS NOT NULL
ORDER BY 2 DESC, 3 DESC;

--------------------------------------------------------------------------------

-- 15) Exibir os nomes de todos os funcionários cuja terceira letra do nome corresponda à letra "a".

SELECT nome
FROM tb_empregado
WHERE nome LIKE '__a%'

--------------------------------------------------------------------------------

--16) Exibir os nomes de todos os funcionários cujo nome tem duas letras "l" trabalhe no departamento 30 ou cujo seu
--    gerente seja equivalente ao número 108.

SELECT nome
FROM tb_empregado
WHERE nome like '%l%l%';

--------------------------------------------------------------------------------

--17) Exibir o número do funcionário, o nome, o salário e o aumento salarial de 15% expresso como inteiro. Coloque
--um label na coluna resultante como "Novo Salário".

SELECT id_empregado, nome, salario, salario * 1.15 AS "Novo salário"
from tb_empregado;

--------------------------------------------------------------------------------

--18) Modifique a consulta anterior para adicionar uma coluna a qual subtrairá o salário anterior do novo salário. Insira
--um label "Aumento" para a coluna

SELECT id_empregado, nome, salario, salario * 1.15 AS "Novo salário", salario * 0.15 AS "Aumento"
from tb_empregado;

--------------------------------------------------------------------------------

--19) Exibir o nome do funcionário, a data de admissão e a data de revisão do salário, que corresponde a primeira
--segunda-feira após seis meses de serviço. Coloque um label "Revisão" para a coluna.
--Formate as datas para que sejam exibidas em formato semelhante a "Sunday, the Seventh of September, 1981".

SELECT nome,
RTRIM(TO_CHAR(data_admissao, 'Day' )) || ', the ' || TO_CHAR(TO_DATE(TO_CHAR(data_admissao, 'dd' ),'j'), 'Jspth') || ' of ' || RTRIM(TO_CHAR(data_admissao, 'Month')) || ', ' || TO_CHAR(data_admissao, 'yyyy') AS "Data de admissao",
RTRIM(TO_CHAR(NEXT_DAY(ADD_MONTHS(data_admissao, 6), 'MONDAY'), 'Day' )) || ', the ' || TO_CHAR(TO_DATE(TO_CHAR(NEXT_DAY(ADD_MONTHS(data_admissao, 6), 'MONDAY'), 'dd' ),'j'), 'Jspth') || ' of ' || RTRIM(TO_CHAR(NEXT_DAY(ADD_MONTHS(data_admissao, 6), 'MONDAY'), 'Month')) || ', ' || TO_CHAR(NEXT_DAY(ADD_MONTHS(data_admissao, 6), 'MONDAY'), 'yyyy') AS "Revisão"
FROM tb_empregado;

--------------------------------------------------------------------------------