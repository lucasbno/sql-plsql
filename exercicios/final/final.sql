--1. Elabore um bloco PL/SQL anônimo o qual deverá selecionar todas as colunas da
--TB_EMPREGADO por meio do uso de um cursor explícito. Apenas as tuplas cujos valores
--associados à coluna nomeada de DATA_ADMISSAO que sejam equivalentes ao mês de MAIO
--deverão ser exibidos. Não há necessidade de formatar a saída, basta selecionar todas as
--colunas e todas as tuplas que contemplam tal condição.
SET serveroutput ON
DECLARE
  CURSOR cursor_empregado IS
    SELECT nome, sobrenome, data_admissao
    FROM tb_empregado
    WHERE EXTRACT(MONTH FROM data_admissao) = 5;
    v_emp cursor_empregado%ROWTYPE;
BEGIN
  FOR v_emp IN cursor_empregado LOOP
    DBMS_OUTPUT.PUT_LINE(v_emp.nome || ' ' || v_emp.sobrenome ||' - ' || v_emp.data_admissao);
  END LOOP;
END;

--------------------------------------------------------------------------------
--2. Elabore um bloco PL/SQL anônimo o qual será responsável por exibir o ID da função dos
--empregados que possuem a média salarial superior a R$ 10.000,00. Faça uso de um cursor
--explícito.

SET serveroutput ON
DECLARE
  CURSOR cursor_empregado IS
    SELECT id_funcao
    FROM tb_empregado
    GROUP BY id_funcao
    HAVING AVG(salario) > 10000;
  v_emp cursor_empregado%ROWTYPE;
BEGIN
  FOR v_emp IN cursor_empregado LOOP
    DBMS_OUTPUT.PUT_LINE(v_emp.id_funcao);
  END LOOP;
END;

--------------------------------------------------------------------------------
--3. Elabore um bloco PL/SQL anônimo o qual deverá exibir o ID do empregado com seu respectivo
--nome, dos empregados que desempenharam mais de uma função. Na sequência, exibir a
--quantidade de empregados selecionados. Para esse exercício, utilize também um cursor
--explícito.

SET serveroutput ON
DECLARE
  CURSOR cursor_empregado IS
    SELECT a.id_empregado, b.nome
    FROM tb_historico_funcao a
    JOIN tb_empregado b ON b.id_empregado = a.id_empregado
    GROUP BY a.id_empregado, b.nome
    HAVING COUNT(a.id_empregado) > 1;
  v_emp cursor_empregado%ROWTYPE;
  v_linhas NUMBER;
BEGIN
  FOR v_emp IN cursor_empregado LOOP
    DBMS_OUTPUT.PUT_LINE(v_emp.id_empregado || ' ' || v_emp.nome);
    v_linhas := cursor_empregado%ROWCOUNT;
  END LOOP;
    DBMS_OUTPUT.PUT_LINE(v_linhas || ' Empregado(s) encontrado(s)' );
END;

--------------------------------------------------------------------------------
--4- Elabore uma função utilizando a linguagem PL/SQL a qual deverá receber como parâmetro de
--entrada o ID do departamento. Utilizando o parâmetro de entrada para realizar o
--processamento, a função deverá retorna o nome do gerente desse departamento.

CREATE OR REPLACE FUNCTION fn_encontra_gerente(p_id_departamento NUMBER)
  RETURN VARCHAR2 IS
  v_nome tb_empregado.nome%TYPE;
BEGIN
    SELECT b.nome INTO v_nome
    FROM tb_departamento a
    JOIN tb_empregado b ON a.id_gerente = b.id_empregado
    WHERE a.id_departamento = p_id_departamento;
  
  RETURN v_nome;
END;

--Teste da função
SET SERVEROUTPUT ON
DECLARE v_nome tb_empregado.nome%TYPE;
BEGIN
  v_nome := fn_encontra_gerente(20);
  dbms_output.put_line(v_nome);
END;
--------------------------------------------------------------------------------

--5. Elabore uma função utilizando a linguagem PL/SQL a qual deverá receber como parâmetro de
--entrada o ID do empregado e retornar o número de funções de trabalho exercidas pelo
--empregado no passado.
CREATE OR REPLACE FUNCTION fn_encontra_funcao(p_id_empregado NUMBER)
  RETURN NUMBER IS
  v_funcoes_exercidas NUMBER;
BEGIN
  SELECT COUNT(1) INTO v_funcoes_exercidas
  FROM tb_historico_funcao
  WHERE id_empregado = p_id_empregado;
  
  RETURN v_funcoes_exercidas;
END;

--Teste da função
SET serveroutput ON
BEGIN
  DBMS_OUTPUT.PUT_LINE(fn_encontra_funcao(101));
END;

--------------------------------------------------------------------------------

--6. Elabore um procedimento utilizando a linguagem PL/SQL o qual deverá receber como
--parâmetro de entrada o ID do departamento e alterar o ID do gerente do departamento para o
--ID do empregado do departamento que possuir o maior salário.
CREATE OR REPLACE PROCEDURE sp_altera_id_gerente (p_id_departamento IN tb_departamento.id_departamento%TYPE)
IS
  v_id_empregado tb_empregado.id_empregado%TYPE;
BEGIN

  SELECT id_empregado INTO v_id_empregado
  FROM tb_empregado
  WHERE salario = ( SELECT max(salario)
                  from tb_empregado
                  WHERE id_departamento = p_id_departamento)
  AND id_departamento = p_id_departamento;
  
  UPDATE tb_departamento
  SET id_gerente = v_id_empregado
  WHERE id_departamento = p_id_departamento;
  
  COMMIT;

END sp_altera_id_gerente;

--------------------------------------------------------------------------------
--7. Elabore uma função utilizando a linguagem PL/SQL o qual deverá receber como parâmetro de
--entrada o ID do gerente. A função deverá retornar os nomes dos empregados subordinados a
--esse gerente. Os nomes devem ser retornados como uma string com uma vírgula separando os
--nomes dos subordinados.

CREATE OR REPLACE FUNCTION lista_subordinados(p_id_gerente IN tb_empregado.id_empregado%TYPE)
  RETURN VARCHAR2 IS
  v_lista VARCHAR2(999);
BEGIN
  SELECT listagg(nome, ', ') INTO v_lista
  FROM tb_empregado
  WHERE id_gerente = p_id_gerente;
  
  RETURN v_lista;
END;

--------------------------------------------------------------------------------
--8. Elabore um gatilho (trigger) utilizando a linguagem PL/SQL o qual deverá garantir que não haja
--nenhuma alteração nas tuplas (inserção, alteração e ou remoção) da TB_EMPREGADO antes da
--06:00 AM e posterior as 10:00 PM.

CREATE OR REPLACE TRIGGER checa_insert_fora_hora
AFTER INSERT ON tb_empregado
FOR EACH ROW
DECLARE
  v_hora_atual number;
BEGIN
    SELECT EXTRACT(HOUR FROM systimestamp) INTO v_hora_atual FROM dual;

    IF (v_hora_atual > 22 OR v_hora_atual < 6) THEN
          RAISE_APPLICATION_ERROR(-20000, 'Erro. Não é possivel fazer inserts nesse horario');
    END IF;
END checa_insert_fora_hora;

--------------------------------------------------------------------------------
--9. Elabore um gatilho (trigger) utilizando a linguagem PL/SQL o qual deverá garantir que o salário
--do empregado nunca seja decrementado.

CREATE OR REPLACE TRIGGER checa_reducao_salario
  BEFORE UPDATE ON tb_empregado
  FOR EACH ROW
BEGIN
  IF (:old.salario > :new.salario) THEN
    RAISE_APPLICATION_ERROR(-20000, 'Erro. Não é possivel diminuir o salario de um empregado');
  END IF;
END checa_reducao_salario;