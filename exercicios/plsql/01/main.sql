--1) Na instrução SELECT abaixo, existe quatro erros de codificação. Identifique-os corretamente.
--SELECT id_empregado, nome
--sal x 12 SALARIO ANUAL
--FROM tb_empregado;

SELECT id_empregado, nome,
salario * 12 AS "SALARIO ANUAL"
FROM tb_empregado;

--------------------------------------------------------------------------------

--2) Apresente a estrutura da TB_EMPREGADO. Elabore uma consulta para exibir o nome, a função, a data de
--admissão e o número de cada funcionário, com o número do funcionário aparecendo primeiro.
--Salve a instrução SQL em um arquivo nomeado de exerc_revisao_2.sql
--Execute a consulta armazenada no arquivo nomeado de exerc_revisao_2.sql

@ /home/lucasbno/dev/sql/exercicios/plsql/01/script-02.sql;
/*
SELECT a.telefone, a.nome, b.ds_funcao AS "Função", data_admissao
FROM tb_empregado a 
INNER JOIN tb_funcao b
USING (id_funcao)
*/

--------------------------------------------------------------------------------

--3) Elabore uma consulta para exibir as funções exclusivas a partir TB_EMPREGADO.

SELECT DISTINCT(id_funcao)
FROM tb_empregado;

--------------------------------------------------------------------------------

--4) Exibir o nome concatenado com a função, separado por uma vírgula e espaço, nomeando a coluna resultante
--para "Empregado e Função".

SELECT a.nome || ' ' || a.sobrenome || ', ' || b.ds_funcao AS "Empregado e Função"
FROM tb_empregado a
INNER JOIN tb_funcao b
USING(id_funcao);

--------------------------------------------------------------------------------

-- 5) Elabore uma consulta para exibir todos os registros a partir da TB_EMPREGADO.
--Separe cada coluna por uma vírgula. Identifique a coluna resultante como SAÍDA.

SELECT
id_empregado || ', ' || nome || ', ' || sobrenome || ', ' ||
email || ', ' || telefone || ', ' || data_admissao || ', ' ||
id_funcao || ', ' || salario || ', ' || NVL(to_char(percentual_comissao), 'null') || ', ' ||
NVL(to_char(id_gerente), 'null') || ', ' || NVL(to_char(id_departamento), 'null') AS "SAÍDA"
FROM tb_empregado;

--------------------------------------------------------------------------------

--6) Elabore uma consulta para exibir todos os registros a partir da TB_EMPREGADO.
--Separe cada coluna por uma vírgula. Identifique a coluna resultante como SAÍDA.

@ /home/lucasbno/dev/sql/exercicios/plsql/01/script-06.sql;
/*
SELECT nome, salario
FROM tb_empregado
WHERE salario > 2850.00
*/

--------------------------------------------------------------------------------

-- 7) Elabore uma consulta para exibir o nome do funcionário e o número do departamento pertinente ao funcionário
-- de número 141.

SELECT nome, id_departamento
FROM tb_empregado
WHERE id_empregado = 141;

--------------------------------------------------------------------------------

--8) Exibir o nome e o salário de todos os funcionários cujos salários não estejam no intervalo entre R$ 1.500,00 e
--R$2.850,00. Salve a instrução SQL em um arquivo nomeado exerc_revisao_8.sql. Execute a consulta a partir do
--arquivo.

@ /home/lucasbno/dev/sql/exercicios/plsql/01/script-08.sql;
/*
SELECT nome, salario
FROM tb_empregado
WHERE salario NOT BETWEEN 1500.00 AND 2850.00;
*/

--------------------------------------------------------------------------------

--9) Apresente o nome do funcionário, a função e a data de admissão dos funcionários admitidos entre o período de
--20 de fevereiro de 1987 e 1 de maio de 1989. Ordene a consulta resultante de modo crescente pela data de
--admissão.

SELECT a.nome, b.ds_funcao, a.data_admissao
FROM tb_empregado a
INNER JOIN tb_funcao b
USING (id_funcao)
WHERE data_admissao BETWEEN TO_DATE('20-FEB-87') AND TO_DATE('01-MAY-89')
ORDER BY data_admissao;

--------------------------------------------------------------------------------

--10) Visualizar o nome do funcionário e o número do departamento de todos os funcionários vinculados aos
--departamentos de número 10 e 30 em ordem alfabética de nome.

SELECT nome, id_departamento
FROM tb_empregado
WHERE id_departamento IN (10, 30)
ORDER BY 1;

--------------------------------------------------------------------------------

--11) Exibir o nome e o salário dos funcionários que possuem salário superior à R$1.500,00 e trabalham no
--departamento 10 ou 30. Coloque um label "Funcionário" e "Salário Mensal" respectivamente nas colunas
--resultantes.

SELECT nome AS "Funcionário", salario AS "Salário Mensal"
FROM tb_empregado
WHERE salario > 1500.00
AND id_departamento IN (10, 30);

--------------------------------------------------------------------------------

--12) Exibir o nome e a data de admissão de todos os funcionários admitidos em 1987.

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
--resultantes em ordem decrescente de salário e comissão.

SELECT nome, salario, percentual_comissao
FROM tb_empregado
WHERE percentual_comissao IS NOT NULL
ORDER BY 2 DESC, 3 DESC;

--------------------------------------------------------------------------------

-- 15) Exibir os nomes de todos os funcionários cuja terceira letra do nome corresponda à letra "a".

SELECT nome
FROM tb_empregado
WHERE nome LIKE '__a%';

--------------------------------------------------------------------------------

--16) Exibir os nomes de todos os funcionários cujo nome tem duas letras "l" trabalhe no departamento 30 ou cujo seu
--gerente seja equivalente ao número 108.

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

--20) Exibir o nome de cada funcionário e calcule o número de meses entre a data atual e a data em que o funcionário
--foi admitido. Coloque um label "Meses Trabalhado" para a coluna.
--Ordene as tuplas resultantes pelo número de meses desde a data de admissão.
--Arredonde o número de meses para o inteiro mais próximo.

SELECT nome, ROUND(MONTHS_BETWEEN((SELECT sysdate FROM dual), TO_DATE(data_admissao, 'DD-MON-RR'))) AS meses
from tb_empregado;

--------------------------------------------------------------------------------

--21) Elabore uma consulta que produza as seguintes informações para cada funcionário:
--• <nome do funcionário> recebe <salário> mensalmente, mas deseja <salário multiplicado por 3>.
--• Insira um label "Salário dos Sonhos" para a coluna.

SELECT nome || ' recebe ' || salario || ' mensalmente, mas deseja ' || salario * 3 AS "Salário dos Sonhos"
FROM tb_empregado;

--------------------------------------------------------------------------------

--22) Elabore uma consulta para exibir o nome e o salário de todos os funcionários. Formate o salário para ter 15
--caracteres e acrescente o símbolo R$ à esquerda. Coloque um label "Salário" para a coluna

SELECT nome, 'R' || LTRIM(TO_CHAR(salario, '$9999999999999D99')) AS "Salário"
FROM tb_empregado;

--------------------------------------------------------------------------------

--23) Elabore uma consulta para exibir o nome do funcionário com a primeira letra em maiúscula e todas as outras
--letras em minúsculas, além do tamanho do nome, para todos os funcionários cujo nome inicia-se pelos
--caracteres J, A ou M. Forneça um label apropriado para cada coluna.

SELECT UPPER(SUBSTR(nome, 1, 1)) || LOWER(SUBSTR(nome, 2, 9999)) AS "Nome", LENGTH(nome) AS "Tamanho do nome"
FROM tb_empregado
WHERE nome LIKE 'J%'
OR nome LIKE 'A%'
OR nome LIKE 'M%';

--------------------------------------------------------------------------------

--24) Exibir o nome, a data de admissão e o dia da semana em que o funcionário começou a trabalhar. Insira um label
--"DIA" para a coluna. Ordene os resultados por dia da semana, iniciando por Segunda-Feira.

SELECT nome, data_admissao, TO_CHAR(data_admissao, 'Day') AS "DIA"
FROM tb_empregado
ORDER BY TO_CHAR(data_admissao, 'D');

--------------------------------------------------------------------------------

--25) Elabore uma consulta que exibirá o nome do funcionário e o valor da comissão. Caso o funcionário não tenha
--comissão, coloque "Nenhuma Comissão". Insira um label "COMISSÃO" para a coluna.

SELECT nome, LTRIM(NVL(TO_CHAR(ROUND(percentual_comissao, 3), '0.99'), 'Nenhuma comissão')) AS "COMISSÃO"
FROM tb_empregado;

--------------------------------------------------------------------------------

--26) Elabore uma consulta para exibir os nomes dos funcionários e indique o valor dos salários por meio de
--asteriscos.
--Cada asterisco representa mil reais.
--Classifique os dados em ordem decrescente de salário.
--Insira um label "FUNCIONARIOS_E_SEUS_SALARIOS" para a coluna.

SELECT nome, rpad('*', salario / 1000, '*') AS "FUNCIONARIOS_E_SEUS_SALARIOS"
FROM tb_empregado
ORDER BY salario DESC;

--------------------------------------------------------------------------------

--27) Crie uma consulta que exiba a classe de todos os funcionários com base no valor da coluna ID_FUNCAO, de
--acordo com a tabela apresentada abaixo:

SELECT nome,
CASE
    WHEN id_funcao = 'SH_CLERK' THEN 'A'
    WHEN id_funcao = 'ST_MAN' THEN 'B'
    WHEN id_funcao = 'AC_ACCOUNT' THEN 'C'
    WHEN id_funcao = 'AC_MGR' THEN 'D'
    WHEN id_funcao = 'IT_PROG' THEN 'E'
    ELSE '0'
END AS Grade
FROM tb_empregado;

--------------------------------------------------------------------------------

--28) Elabore uma consulta para exibir o nome, o número do departamento e o nome do departamento de todos os
--funcionários.

SELECT a.nome, a.id_departamento AS numero, b.nm_departamento
FROM tb_empregado a
INNER JOIN tb_departamento b
ON (a.id_departamento = b.id_departamento);

--------------------------------------------------------------------------------

--
--29) Elabore uma lista única de todas as funções existentes no departamento 30. Insira a localização (cidade) do
--departamento 30 na saída.

SELECT b.ds_funcao, d.cidade
FROM tb_empregado a
JOIN tb_funcao b ON a.id_funcao = b.id_funcao
JOIN tb_departamento c ON a.id_departamento = c.id_departamento
JOIN tb_localizacao d ON c.id_localizacao = d.id_localizacao
WHERE a.id_departamento = 30;

--------------------------------------------------------------------------------
--
--30) Elabore uma consulta para exibir o nome do funcionário, o nome do departamento e a localização (cidade e
--estado) de todos os funcionários que recebem comissão.

SELECT a.nome, b.nm_departamento AS "Nome do departamento", c.cidade || ' - ' || c.estado AS "Cidade - Estado"
FROM tb_empregado a
JOIN tb_departamento b ON a.id_departamento = b.id_departamento
JOIN tb_localizacao c ON b.id_localizacao = c.id_localizacao
WHERE percentual_comissao IS NOT NULL;

