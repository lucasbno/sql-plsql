--1. Elabore uma consulta para exibir o nome do empregado e o valor da comissão. Caso o empregado não
--tenha comissão, exibir o string Nenhuma comissão. Insira um label COMISSÃO para a coluna resultante.

SELECT nome, NVL(TO_CHAR(percentual_comissao), 'Nenhuma comissão') AS COMISSÃO FROM tb_empregado;

---------------------------------------------------------------------------------------------------------------------------------------------
--2. Elabore uma consulta para exibir os nomes e as datas de admissão de todos os empregados junto com
--o nome do gerente e a data de admissão de todos os empregados admitidos antes dos respectivos
--gerentes. Insira um label Empregado, Empregado Data Admissão, Gerente e Gerente Data Admissão,
--nas respectivas colunas.

SELECT a.nome Empregado, a.data_admissao AS "Empregado Data Admissão", b.nome, b.data_admissao
FROM tb_empregado a, tb_empregado b
WHERE a.id_gerente = b.id_empregado
AND a.data_admissao < b.data_admissao;

---------------------------------------------------------------------------------------------------------------------------------------------
--3. Elabore uma consulta para exibir o maior salário, o salário médio, o menor salário e a soma de todos os
--salários de todos os empregados. Insira um label Máximo, Mínimo, Média e Somatório nas respectivas
--colunas. Realize o arredondamento dos resultados para o número inteiro mais próximo.

SELECT ROUND(MAX(salario)) AS Máximo, ROUND(AVG(salario)) AS Mínimo, ROUND(MIN(salario)) AS Média, ROUND(SUM(salario)) AS Somatório
FROM tb_empregado;

---------------------------------------------------------------------------------------------------------------------------------------------
--4. Elabore uma consulta para exibir o número do gerente e o salário do empregado com menor salário sob
--a supervisão desse gerente. Desconsidere todos cujo o gerente não seja conhecido. Desconsidere
--qualquer grupo cujo salário mínimo seja inferior a R$ 1.000,00. Ordene a saída de forma descendente
--pelo menor salário.

SELECT a.id_empregado AS "Número do gerente", MIN(b.salario) AS "Menor salário"
FROM tb_empregado a, tb_empregado b
WHERE a.id_empregado = b.id_gerente
GROUP BY a.id_empregado
HAVING MIN(b.salario) > 1000
ORDER BY 2 DESC;

---------------------------------------------------------------------------------------------------------------------------------------------
--5. Elabore uma consulta responsável por exibir o número total de empregados e, desse total, o número
--total de empregados contratados em 1990, 1991, 1992 e 1993. Insira os cabeçalhos apropriados nas
--colunas.

SELECT count(1) AS "Empregados contratados em 1990, 1991, 1992 e 1993", (SELECT count(1) from tb_empregado) AS "Todos empregados"
FROM tb_empregado
WHERE EXTRACT(YEAR FROM data_admissao) IN (1990, 1991, 1992, 1993)
GROUP BY 1;

---------------------------------------------------------------------------------------------------------------------------------------------
--6. Elabore uma consulta para exibir os nomes dos empregados e indique o valor dos salários por meio de
--asteriscos. Cada asterisco representa mil reais. Classifique as tuplas resultantes de forma descendente
--pelo salário. Insira um label Funcionários e seus Salários para a coluna resultante.

SELECT nome, rpad('*', salario / 1000, '*') AS "Funcionarios e seus Salários"
FROM tb_empregado
ORDER BY salario DESC;

---------------------------------------------------------------------------------------------------------------------------------------------
--7. Elabore uma consulta para exibir todos os atributos da tb_empregado. Separe cada atributo por uma
--vírgula. Identifique a coluna resultante como Saída.
SELECT
id_empregado || ', ' || nome || ', ' || sobrenome || ', ' || email || ', ' ||
telefone || ', ' || data_admissao || ', ' || id_funcao || ', ' || salario || ', ' ||
percentual_comissao || ', ' || id_gerente || ', ' || id_departamento AS Saída
FROM tb_empregado;

---------------------------------------------------------------------------------------------------------------------------------------------
--8. Elabore uma consulta cuja finalidade é exibir a classe de todos os empregados com base no valor da
--coluna id_funcao, de acordo com a tabela apresentada abaixo:
--Descrição da Função Grade
--SH_CLERK A
--ST_MAN B
--AC_ACCOUNT C
--AC_MGR D
--IT_PROG E
--Nenhuma das alternativas acima 0 (zero)

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

---------------------------------------------------------------------------------------------------------------------------------------------
--9. Elabore uma consulta para exibir o nome de cada empregado e calcule o número de meses entre a data
--atual e a data em que o empregado foi admitido. Coloque um label Meses Trabalhado para a coluna
--resultante. Ordene as tuplas resultantes pelo número de meses desde a data de admissão.

SELECT nome, ROUND(MONTHS_BETWEEN((SELECT sysdate FROM dual), data_admissao)) AS "Meses trabalhado"
FROM tb_empregado;

---------------------------------------------------------------------------------------------------------------------------------------------
--10. Elabore uma consulta para exibir o nome do empregado, o nome do departamento e a localização
--(cidade e estado) de todos os empregados que recebem comissão.

SELECT a.nome, b.nm_departamento AS "Nome do departamento", c.cidade || ' - ' || c.estado AS "Cidade e estado"
FROM tb_empregado a
JOIN tb_departamento b ON a.id_departamento  = b.id_departamento
JOIN tb_localizacao c ON b.id_localizacao = c.id_localizacao
WHERE percentual_comissao IS NOT NULL;

---------------------------------------------------------------------------------------------------------------------------------------------
--11. Você deseja conceder a Joao o privilégio de atualizar os dados na tb_departamento. Você também quer
--permitir que Joao conceda esse privilégio a outros usuários. Que comando você utilizaria?
GRANT UPDATE ON tb_departamento TO joao WITH GRANT OPTION;

---------------------------------------------------------------------------------------------------------------------------------------------
--12. Crie a tabela nomeada de tb_departamento_2 com base na descrição abaixo. Confirme se a tabela foi
--criada corretamente demonstrando sua estrutura.
CREATE TABLE tb_departamento2(
  ID        NUMBER(7),
  NM_DEPTO  VARCHAR2(25)
);

--a. Insira tuplas na tb_departamento_2 com os dados da tb_departamento. Inclua apenas as
--colunas necessárias.
INSERT INTO tb_departamento_2(id, nm_depto)
SELECT id_departamento, nm_departamento
FROM tb_departamento;

--b. Acrescente um comentário na tb_departamento_2. Em seguida, consulte o dicionário de dados
--(catálogo) responsável pelo armazenamento, verificando se o comentário se encontra presente.
COMMENT ON TABLE tb_departamento_2 IS 'Essa é a tabela departamento 2';

SELECT * FROM user_tab_comments
WHERE table_name = 'TB_DEPARTAMENTO_2';

---------------------------------------------------------------------------------------------------------------------------------------------
--13. Crie a tabela nomeada de tb_empregado_2 com base na estrutura abaixo. Confirme se a tabela foi
--criada apresentando sua estrutura.

CREATE TABLE tb_empregado_2 (
  ID          NUMBER(7),
  SOBRENOME   VARCHAR2(25),
  NOME        VARCHAR2(25),
  ID_DEPTO    NUMBER(7)
);

--a. Modifique a tb_empregado_2 para permitir a inclusão de sobrenomes maiores. Confirme a
--sua modificação apresentando a estrutura da tabela.
ALTER TABLE tb_empregado_2
MODIFY nome VARCHAR2(50);

DESCRIBE tb_empregado_2;

--b. Adicione na tb_empregado_2 uma restrição de chave primária na coluna ID. A restrição deve
--ser nomeada na sua criação como pk_emp_id.
ALTER TABLE tb_empregado_2
ADD ( CONSTRAINT pk_emp_id PRIMARY KEY (id));

--c. Adicione uma referência de chave estrangeira na tb_empregado_2 que garanta que o
--empregado não seja atribuído a um departamento inexistente. Nomeie a restrição de
--fk_emp_dept_id.
ALTER TABLE tb_empregado_2
ADD (CONSTRAINT fk_emp_dept_id FOREIGN KEY (id_depto) REFERENCES tb_departamento (id_departamento))

---------------------------------------------------------------------------------------------------------------------------------------------
--14. Crie a tabela intitulada tb_empregado_3 com base na estrutura da tabela tb_empregado. Inclua apenas
--as colunas id_empregado, nome, sobrenome, salario e id_departamento. Nomeie as colunas em sua
--nova tabela como ID, FIRST_NAME, LAST_NAME, SALARY e DEPT_ID, respectivamente.

CREATE TABLE tb_empregado_3 (
  ID               NUMBER(7),
  FIRST_NAME       VARCHAR2(25),
  LAST_NAME        VARCHAR2(25),
  SALARY           NUMBER(8, 2),
  DEPT_ID          NUMBER(4)
);

--a. Remova a coluna FIRST_NAME da tb_empregado_3. Confirmar a remoção da coluna
--apresentando a estrutura atual da tabela.
ALTER TABLE tb_empregado_3
DROP COLUMN FIRST_NAME;

describe tb_empregado_3;
---------------------------------------------------------------------------------------------------------------------------------------------
--15. Exibir o número do empregado, o nome, o salário e o aumento salarial de 15%, esse expresso como
--inteiro. Adicione um label na coluna resultante como Novo Salário.

SELECT id_empregado, nome, salario, salario * 1.15 AS "Novo Salário"
FROM tb_empregado;
---------------------------------------------------------------------------------------------------------------------------------------------
--16. Exibir o nome do empregado, a data de admissão e a data de revisão do salário, que corresponde a
--primeira segunda-feira após seis meses de trabalho. Coloque um label Revisão para a coluna.
SELECT nome, data_admissao, NEXT_DAY(ADD_MONTHS(data_admissao, 6), 'MONDAY') AS "Revisão"
FROM tb_empregado;

---------------------------------------------------------------------------------------------------------------------------------------------
--17. Elabore uma consulta para exibir o nome do empregado com a primeira letra em maiúsculo e todas as
--outras em minúsculos, além do tamanho do nome, para todos os empregados cujo nome inicia-se pelos
--caracteres J, A ou M. Forneça um label apropriado para cada coluna.
SELECT UPPER(SUBSTR(nome, 1, 1)) || LOWER(SUBSTR(nome, 2, 9999)) AS "Nome", LENGTH(nome) AS "Tamanho do nome"
FROM tb_empregado
WHERE nome LIKE 'J%'
OR nome LIKE 'A%'
OR nome LIKE 'M%';

---------------------------------------------------------------------------------------------------------------------------------------------
--18. Elabore uma consulta responsável por substituir o string SH para SHIPPING da coluna id_funcao
--presenta na tb_empregado, para todos as funções que iniciam com o string SH.

SELECT REPLACE(id_funcao, 'SH', 'SHIPPING')
FROM tb_empregado;

---------------------------------------------------------------------------------------------------------------------------------------------
--19. Elabore uma consulta para exibir o id_departamento, o menor e o maior salário, onde os menores
--salários sejam inferiores a R$ 7.000,00. Ordene as tuplas resultantes pelos menores salários.

SELECT id_departamento , MIN(salario) AS Minimo, MAX(salario) AS Maximo
FROM tb_empregado
GROUP BY id_departamento
HAVING MIN(salario) < 7000
ORDER BY 2;
---------------------------------------------------------------------------------------------------------------------------------------------
--20. Crie um índice composto para as colunas id_empregado e id_gerente, essas existentes na
--tb_empregado. Na sequência, remova o índice com a instrução adequada.

CREATE INDEX indice_composto
ON tb_empregado (id_empregado, id_gerente);

DROP INDEX indice_composto;