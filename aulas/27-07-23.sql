-- Aula (27/07/2023)

CREATE OR REPLACE PACKAGE BODY pkg_std
IS
  --função invisível externamente
  FUNCTION fn_formata_data(p_valor DATE) RETURN VARCHAR2 IS
  BEGIN
    RETURN TO_CHAR(p_valor, 'DD/MM/YYYY HH24:MI:SS');
  END fn_formata_data;

  FUNCTION fn_to_char_aula(p_valor DATE) RETURN VARCHAR2 IS
  BEGIN
    --necessidade de declarar antes essa função
    RETURN fn_formata_data(p_valor);
  END fn_to_char_aula;

  FUNCTION fn_to_char_aula(p_valor NUMBER) RETURN VARCHAR2 IS
  BEGIN
    RETURN TO_CHAR(p_valor + 1 );
  END fn_to_char_aula;
END pkg_std;
/


CREATE OR REPLACE PACKAGE pkg_empregados IS
  FUNCTION fn_valor_comissao(p_id_emp NUMBER) RETURN NUMBER;
  PROCEDURE sp_empregado_s(p_cursor OUT SYS_REFCURSOR);
END;  

CREATE OR REPLACE PACKAGE BODY pkg_empregados IS
  FUNCTION fn_valor_comissao(p_id_emp NUMBER) RETURN NUMBER IS
    v_valor_com NUMBER;
  BEGIN
    SELECT ROUND(NVL(percentual_comissao, 0) * salario, 2) INTO v_valor_com
    FROM tb_empregado
    WHERE id_empregado = p_id_emp;
    
    RETURN v_valor_com;
  
  EXCEPTION
     WHEN no_data_found THEN
       v_valor_com := - 1;       
  END fn_valor_comissao;
  
  PROCEDURE sp_empregado_s(p_cursor OUT SYS_REFCURSOR) IS
  BEGIN
    OPEN p_cursor FOR
      SELECT nome, sobrenome
      FROM tb_empregado;  
  END sp_empregado_s;
END;  

SET serveroutput ON
DECLARE
  v_cursor  SYS_REFCURSOR;
  v_nome    tb_empregado.nome%TYPE;
  v_sobrenome   tb_empregado.sobrenome%TYPE;
BEGIN
  pkg_empregados.sp_empregado_s(v_cursor);
  
  LOOP
    FETCH v_cursor INTO v_nome, v_sobrenome;
    EXIT WHEN v_cursor%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(v_nome || ' ' || v_sobrenome);
  END LOOP;
  
  CLOSE v_cursor;
  
END;



SELECT pkg_empregados.fn_valor_comissao(151)
FROM dual;

CREATE OR REPLACE PROCEDURE sp_remove_historico_funcao(p_id_depto IN NUMBER) 
AS
  CURSOR cur_historico_funcao IS
    SELECT *
    FROM tb_historico_funcao
    WHERE id_departamento = p_id_depto
    FOR UPDATE;
  
  reg_historico_funcao cur_historico_funcao%ROWTYPE;

BEGIN
  FOR reg_historico_funcao IN cur_historico_funcao LOOP
    DELETE
    FROM tb_historico_funcao
    WHERE CURRENT OF cur_historico_funcao;
    
    DBMS_OUTPUT.PUT_LINE('Histórico da função removido para o depto ' || p_id_depto);
  END LOOP;
END sp_remove_historico_funcao;
  


SET serveroutput ON
BEGIN
  sp_remove_historico_funcao(20);
END;

CREATE TABLE tb_replica_empregado
AS
SELECT *
FROM tb_empregado;

SELECT *
FROM tb_replica_empregado;


SELECT *
FROM tb_replica_empregado
ORDER BY 1 ASC;

INSERT INTO tb_replica_empregado
VALUES
(100,	'Steven',	'King',	'SKING',	'515.123.4567',	'17/JUN/87', 'AD_PRES',	24000,	null, null, 90, NULL);



SET serveroutput ON
<<consultando_emp_duplicados>>
DECLARE
  CURSOR cur_empregado IS
    SELECT *
    FROM tb_empregado
    ORDER BY id_empregado;
  
  v_count_emp   NUMBER := 0;
  v_count_total NUMBER := 0;

BEGIN
  DBMS_OUTPUT.PUT_LINE('Você vai ver cada funcionário duplicado listado mais ');
  DBMS_OUTPUT.PUT_LINE('de uma vez na lista abaixo. Isto irá permitir que você ');
  DBMS_OUTPUT.PUT_LINE('analise a lista e certifique-se que de fato ... há mais ');
  DBMS_OUTPUT.PUT_LINE('do que um destes registros na tb_replica_empregado');
  
  DBMS_OUTPUT.PUT_LINE('Empregados Duplicados:');
  
  FOR reg_empregado IN cur_empregado LOOP
    --recupera a quantidade de registros na tabela que possui o mesmo ID do registro atual
    SELECT COUNT(1) INTO v_count_emp
    FROM tb_replica_empregado
    WHERE id_empregado = reg_empregado.id_empregado;    
    
     -- se a contagem for superior a 1, registros dupliacos foram localizados  
    IF (v_count_emp > 1) THEN
        DBMS_OUTPUT.PUT_LINE(reg_empregado.id_empregado || ' - ' || reg_empregado.nome || ' ' || reg_empregado.sobrenome || ' - ' || v_count_emp);
        v_count_total := v_count_total + 1;
    END IF;     
  END LOOP;  
END;



DELETE 
FROM tb_replica_empregado A
WHERE ROWID > (SELECT MIN(rowid)
               FROM tb_replica_empregado B
               WHERE A.id_empregado = B.id_empregado);
-- 3 rows deleted.


SET serveroutput ON
DECLARE
  v_empregado   tb_empregado%ROWTYPE;
  v_count_emp   NUMBER := 0;
BEGIN
  SELECT COUNT(1) INTO v_count_emp
  FROM tb_empregado
  WHERE id_empregado = 100;
  
  IF (v_count_emp > 0) THEN
    SELECT * INTO v_empregado
    FROM tb_empregado
    WHERE id_empregado = 100;
    
    IF (v_empregado.id_gerente IS NOT NULL) THEN
      DBMS_OUTPUT.PUT_LINE(v_empregado.nome || ' ' || v_empregado.sobrenome || ' possui um gerente responsável');
    ELSE
      DBMS_OUTPUT.PUT_LINE(v_empregado.nome || ' ' || v_empregado.sobrenome || ' NÃO possui gerente responsável');
    END IF;
  ELSE
    DBMS_OUTPUT.PUT_LINE('Empregado não localizado, por favor, tente novamente');  
  END IF;
  
EXCEPTION
  WHEN no_data_found THEN
    DBMS_OUTPUT.PUT_LINE('Tente informar um outro ID para o empregado');  
END;


CREATE OR REPLACE TRIGGER tg_empregado_funcao
  AFTER UPDATE OF id_funcao ON tb_empregado
   REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW
BEGIN
  --Inserindo o histórico de função "antigo" do empregado
  INSERT INTO tb_historico_funcao(id_empregado, data_inicio, data_termino, id_funcao, id_departamento)
  VALUES
  (:OLD.id_empregado, :OLD.data_admissao, SYSDATE, :OLD.id_funcao, :OLD.id_departamento);
END;


UPDATE tb_empregado
  SET id_funcao = 'AC_ACCOUNT',
      data_admissao = SYSDATE
WHERE id_empregado = 103;

SELECT *
FROM tb_historico_funcao
WHERE id_empregado = 103;


ROLLBACK;

CREATE OR REPLACE TRIGGER tg_empregado_funcao
  AFTER UPDATE OF id_funcao ON tb_empregado
    REFERENCING OLD AS OLD NEW AS NEW 
      FOR EACH ROW
DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  --inserindo o histórico de função "antigo" do empregado
  INSERT INTO tb_historico_funcao(id_empregado, data_inicio, data_termino, id_funcao, id_departamento)
  VALUES
  (:OLD.id_empregado, :OLD.data_admissao, SYSDATE, :OLD.id_funcao, :OLD.id_departamento);
  
  COMMIT; --obrigatório em transação autônoma

EXCEPTION
  WHEN others THEN
    NULL;  
END;



UPDATE tb_empregado 
  SET id_funcao = 'MK_REP',
      data_admissao = SYSDATE
WHERE id_empregado = 103;  

SELECT *
FROM tb_historico_funcao
WHERE id_empregado = 103;


ROLLBACK;

SELECT *
FROM tb_historico_funcao
WHERE id_empregado = 103;


-- Criando tabela de log nomeada tb_log_empregado
CREATE TABLE tb_log_empregado(
id              VARCHAR2(20 BYTE),
dt_inclusao     DATE,
nm_user         VARCHAR2(30 BYTE),
tp_operacao     VARCHAR2(20 BYTE)
);


CREATE OR REPLACE TRIGGER tg_empregado_log
  AFTER INSERT OR DELETE ON tb_empregado
    REFERENCING OLD AS OLD NEW AS NEW
      FOR EACH ROW
DECLARE
  v_operacao    VARCHAR2(20);
BEGIN
  v_operacao  := CASE WHEN DELETING THEN 'DELETE' ELSE 'INSERT' END;
  
  --insere os dados na "tb_log_empregado"
  INSERT INTO tb_log_empregado(id, dt_inclusao, nm_user, tp_operacao)
  VALUES
  (DECODE(v_operacao, 'INSERT', :NEW.id_empregado, :OLD.id_empregado), SYSDATE, USER, v_operacao);

EXCEPTION
  WHEN others THEN
    NULL;
  
END;

INSERT INTO tb_empregado (id_empregado, nome, sobrenome, email, telefone, data_admissao, id_funcao, salario, percentual_comissao, id_gerente, id_departamento)
VALUES
(400, 'Geraldo', 'Neto', 'geraldohenrique_2@usp.br', '0800 6655', SYSDATE, 'IT_PROG', 8000.00, NULL, 101, 60);


SELECT *
FROM tb_empregado
ORDER BY 1 DESC;

SELECT *
FROM tb_log_empregado;


DELETE 
FROM tb_empregado
WHERE id_empregado = 400;

SELECT *
FROM tb_empregado
ORDER BY 1 DESC;

SELECT *
FROM tb_log_empregado;


CREATE OR REPLACE TRIGGER tg_empregado_log
  BEFORE DELETE ON tb_empregado
BEGIN
  --insere os dados na "tb_log_empregado"
  INSERT INTO tb_log_empregado(id, dt_inclusao, nm_user, tp_operacao)
  VALUES
  (0, SYSDATE, USER, 'ALL');

EXCEPTION
  WHEN others THEN
    NULL;
END;


INSERT INTO tb_empregado(id_empregado, nome, sobrenome, email, telefone, data_admissao, id_funcao, salario, percentual_comissao, id_gerente, id_departamento)
VALUES
(401, 'Geraldo', 'Neto_1', 'geraldohenrique1@usp.br', '0800 6655', SYSDATE, 'IT_PROG', 8000.00, NULL, 101, 60);

INSERT INTO tb_empregado(id_empregado, nome, sobrenome, email, telefone, data_admissao, id_funcao, salario, percentual_comissao, id_gerente, id_departamento)
VALUES
(402, 'Geraldo', 'Neto_2', 'geraldohenrique2@usp.br', '0800 6655', SYSDATE, 'IT_PROG', 8000.00, NULL, 101, 60);


DELETE 
FROM tb_empregado
WHERE id_empregado IN (401, 402);

SELECT *
FROM tb_log_empregado;


SET serveroutput ON
INSERT INTO tb_clientes(id_cliente, nm_cliente, idade, endereco, salario)
VALUES
(7, 'Kriti', 22, 'HP', 7500.00);

SET serveroutput ON
UPDATE tb_clientes
  SET salario = salario + 500
WHERE id_cliente = 2;  


SELECT *
FROM all_triggers
WHERE owner = 'PLSQL';

-- Conectado como SYSTEM
GRANT CREATE TABLE TO plsql;


CREATE OR REPLACE PROCEDURE sp_create_table(p_nm_tabela VARCHAR2, p_especificacao_coluna VARCHAR2) IS
BEGIN
  EXECUTE IMMEDIATE 'CREATE TABLE ' || p_nm_tabela || 
             ' (' || p_especificacao_coluna || ')';
END;


BEGIN
  sp_create_table('tb_nomes_empregados',
                  'id_emp NUMBER(4) PRIMARY KEY,
                   nm_empregado VARCHAR2(40)');
END;

SELECT *
FROM tb_nomes_empregados;


CREATE OR REPLACE FUNCTION fn_remover_linhas(p_nm_tabela VARCHAR2)
  RETURN NUMBER IS
BEGIN
  EXECUTE IMMEDIATE 'DELETE FROM ' || p_nm_tabela;
  RETURN SQL%ROWCOUNT;
END;

SET serveroutput ON
BEGIN
  dbms_output.put_line(fn_remover_linhas('tb_nomes_empregados') || ' linhas removidas');
END;

CREATE OR REPLACE PROCEDURE sp_adiciona_linha(p_nm_tabela VARCHAR2,
                                              p_id NUMBER,
                                              p_nm_coluna VARCHAR2) IS
BEGIN
  EXECUTE IMMEDIATE 'INSERT INTO ' || p_nm_tabela || 
                    ' VALUES (:1, :2)' USING p_id, p_nm_coluna;
END;


BEGIN
  sp_adiciona_linha('TB_NOMES_EMPREGADOS', 100, 'Testando...');
END;
