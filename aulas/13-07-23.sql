SET serveroutput ON
DECLARE
  v_x   NUMBER := 10;
BEGIN
  LOOP
    dbms_output.put_line(v_x);
    v_x := v_x + 10;
    EXIT WHEN v_x > 50;  
  END LOOP;
  
  dbms_output.put_line('Depois do EXIT v_x eh: ' || v_x);  
END;


SET serveroutput ON
DECLARE
  v_a   NUMBER(2) := 10;
BEGIN
  WHILE v_a < 20 LOOP
    dbms_output.put_line('Valor de v_a: ' || v_a);
    v_a := v_a + 1;
  END LOOP;
END;


SET serveroutput ON
DECLARE
  v_a   NUMBER(2);
BEGIN
  FOR v_a IN 10..20 LOOP
    dbms_output.put_line('Valor de v_a: ' || v_a);
  END LOOP;
END;


SET serveroutput ON
DECLARE
  v_contador    NUMBER := 0;
BEGIN
  FOR i IN 1..100 LOOP
    v_contador := v_contador + 1;
  END LOOP;
  
  dbms_output.put_line('O valor final de v_contador eh: ' || v_contador);
  
END;


SET serveroutput ON
BEGIN
  FOR i IN 0..100 LOOP
    dbms_output.put_line('O valor de i eh: ' || i);
  END LOOP;  
END;


SET serveroutput ON
DECLARE
  v_a   NUMBER(2);
BEGIN
  FOR v_a IN REVERSE 10..20 LOOP
    dbms_output.put_line('Valor de v_a: ' || v_a);
  END LOOP;
END;


SET serveroutput ON
DECLARE
  v_contador    NUMBER := 1;
BEGIN
  <<loop_pai>>
  FOR i IN 1..1000 LOOP
    <<loop_filho>>
    LOOP
      EXIT loop_pai WHEN v_contador > 10;
      EXIT loop_filho WHEN MOD(v_contador, 10) = 0;
      
      v_contador := v_contador + 1;
    END LOOP loop_filho;
    
    v_contador := v_contador + 1;
  END LOOP loop_pai;
  
  dbms_output.put_line('O valor de v_contador eh: ' || v_contador);
  
END;


SET serveroutput ON
DECLARE
  v_a   NUMBER(2) := 10;
BEGIN
  WHILE v_a < 20 LOOP
    dbms_output.put_line('O valor de v_a: ' || v_a);
    v_a := v_a + 1;
    
    IF (v_a > 15) THEN
      --finalizando o loop usando a instrução EXIT
      EXIT;
    END IF;  
  END LOOP;
END;


SET serveroutput ON
DECLARE
  v_a   NUMBER(2) := 10;
BEGIN
  WHILE v_a < 20 LOOP
    dbms_output.put_line('O valor de v_a: ' || v_a);
    v_a := v_a + 1;
    -- finalizando o loop usando a instrução EXIT WHEN
    EXIT WHEN v_a > 15;
  END LOOP;
END;

SET serveroutput ON
DECLARE
  v_a  NUMBER(2) := 10;
BEGIN
  WHILE v_a < 20 LOOP
    dbms_output.put_line('Valor de v_a: ' || v_a);
    v_a := v_a + 1;
    
    IF (v_a = 15) THEN
      v_a := v_a + 1;
      CONTINUE;
    END IF;    
  END LOOP;
END;

SET serveroutput ON
DECLARE
  v_a   NUMBER(2) := 10;
BEGIN
  <<inicio_loop>>
  WHILE v_a < 20 LOOP
    dbms_output.put_line('Valor de v_a: ' || v_a);
    v_a := v_a + 1;
    IF v_a = 15 THEN
      v_a := v_a + 1;
      GOTO inicio_loop;
    END IF;
  END LOOP;
END;

SET serveroutput ON
DECLARE
  v_resultado BOOLEAN;
  v_compare1  BOOLEAN;
  v_Compare2  BOOLEAN;
BEGIN
  v_compare1:= true;
  v_compare2 := null;
  v_resultado := v_compare1 AND v_compare2;
  dbms_output.put_line(
  'O valor de v_resultado é: ' || 
  CASE v_resultado
    WHEN TRUE THEN 'TRUE'
    WHEN FALSE THEN 'FALSE'
    ELSE 'NULL' END
  );
END;

SELECT DECODE(cidade, 'Sao Paulo', 'São Paulo', cidade) AS cidade
FROM tb_localizacao;
  
SELECT nome || ' ' || sobrenome, salario + (salario * NVL(percentual_comissao, 0)) AS total_salario
FROM tb_empregado;

SELECT COALESCE(NULL, NULL, NULL, 1)
FROM dual;

ALTER TABLE tb_empregado
ADD (percentual_comissao_maxima NUMBER);
  
SELECT * FROM tb_empregado;

SELECT percentual_comissao,
COALESCE(percentual_comissao_maxima, percentual_comissao, 0.1),
COALESCE(percentual_comissao_maxima, percentual_comissao, 0.1) * salario AS valor_comissao
FROM tb_empregado
WHERE id_departamento IN (70, 80);
  
SELECT AVG(salario)
FROM tb_empregado
WHERE id_departamento = 100;

SELECT MIN(salario)
FROM tb_empregado
WHERE id_departamento = 100;

SELECT nome, sobrenome, salario
FROM tb_empregado
WHERE salario = (SELECT MIN(salario) FROM tb_empregado WHERE id_departamento = 100);

SELECT nome, sobrenome, (SELECT MIN(salario) FROM tb_empregado WHERE id_departamento = 100)
FROM tb_empregado;

SELECT MAX (salario)
FROM tb_empregado
WHERE id_departamento = 100;

SELECT SUM(salario)
FROM tb_empregado
WHERE id_departamento = 100;

SELECT TO_DATE('03/JAN/2019')
FROM dual;

SELECT LENGTH ('PL/SQL ESSENCIAL')
FROM dual;

SELECT LOWER(nome)
FROM tb_empregado;

SELECT nome, sobrenome, REPLACE(sobrenome, 'a')
FROM tb_empregado;

SET serveroutput ON
DECLARE
  TYPE tipo_reg_emp IS RECORD (
    id_empregado  NUMBER(6),
    nome          VARCHAR2(20),
    sobrenome     VARCHAR2(25)
  );
  registro_emp tipo_reg_emp;
BEGIN
  SELECT id_empregado, nome, sobrenome INTO registro_emp
  FROM tb_empregado
  WHERE ROWNUM = 1;
  
  dbms_output.put_line('O nome do empregado com ID '
                        || registro_emp.id_empregado
                        || ' eh ' 
                        || registro_emp.nome 
                        || ' ' || registro_emp.sobrenome);
END;

SET serveroutput ON
DECLARE
  registro_emp  tb_empregado%ROWTYPE;
BEGIN
  SELECT * INTO registro_emp
  FROM tb_empregado
  WHERE ROWNUM = 1;
  
  dbms_output.put_line('O nome do empregado com ID ' || registro_emp.id_empregado ||
                        ' eh: ' || registro_emp.nome || ' ' || registro_emp.sobrenome);
END;

SET serveroutput ON
DECLARE
  TYPE tipo_emp IS TABLE OF tb_empregado%ROWTYPE;
  registro_emp  TIPO_EMP;
BEGIN
  SELECT * BULK COLLECT INTO registro_emp
  FROM tb_empregado
  WHERE ROWNUM = 1;
  
  FOR i IN registro_emp.first..registro_emp.last LOOP
    dbms_output.put_line('O nome do empregado com ID ' || registro_emp(i).id_empregado || ' eh ' 
                           || registro_emp(i).nome || ' ' || registro_emp(i).sobrenome);
  END LOOP;  
END;

SET serveroutput ON
DECLARE
  TYPE tipo_emp IS TABLE OF tb_empregado%ROWTYPE;
  registro_emp  TIPO_EMP;
BEGIN
  SELECT * BULK COLLECT INTO registro_emp
  FROM tb_empregado;
  --WHERE ROWNUM = 1;
  
  FOR i IN registro_emp.first .. registro_emp.last LOOP
    dbms_output.put_line('O nome do empregado com ID ' || registro_emp(i).id_empregado || ' eh ' 
                           || registro_emp(i).nome || ' ' || registro_emp(i).sobrenome);
  END LOOP;  
END;

SET serveroutput ON
DECLARE
  TYPE tipo_emp IS TABLE OF tb_empregado%ROWTYPE;
  registro_emp  TIPO_EMP;
BEGIN
  SELECT * BULK COLLECT INTO registro_emp
  FROM tb_empregado
  WHERE ROWNUM = 1;
  
  IF (NOT(registro_emp.EXISTS(10))) THEN
    dbms_output.put_line('Não existe o 10º elemento na coleção');
  END IF;
  
  dbms_output.put_line('Existe(m) ' || TO_CHAR(registro_emp.COUNT) || ' elemento(s) na coleção');
  
  registro_emp.DELETE;
  
  dbms_output.put_line('Após excluir todos os elementos, existe(m) ' || TO_CHAR(registro_emp.COUNT) || ' elemento(s) na coleção');
END;

SET serveroutput ON
DECLARE
  TYPE tipo_emp IS TABLE OF tb_empregado%ROWTYPE;
  registro_emp  TIPO_EMP;
BEGIN
  SELECT * BULK COLLECT INTO registro_emp
  FROM tb_empregado;
  --WHERE ROWNUM = 1;
  
  IF (NOT(registro_emp.EXISTS(10))) THEN
    dbms_output.put_line('Não existe o 10º elemento na coleção');
  END IF;
  
  dbms_output.put_line('Existe(m) ' || TO_CHAR(registro_emp.COUNT) || ' elemento(s) na coleção');
  
  registro_emp.DELETE;
  
  dbms_output.put_line('Após excluir todos os elementos, existe(m) ' || TO_CHAR(registro_emp.COUNT) || ' elemento(s) na coleção');
END;

SET serveroutput ON
DECLARE
  v_nome  VARCHAR2(20);
  v_sobrenome VARCHAR2(25);
BEGIN
  SELECT nome, sobrenome INTO v_nome, v_sobrenome
  FROM tb_empregado
  WHERE email = 'VJONES';
  
  DBMS_OUTPUT.PUT_LINE(v_nome || ' ' || v_sobrenome);
END;

SET serveroutput ON
<<outer_block>>
DECLARE
  v_id_gerente      NUMBER(6) := '&id_gerente_atual';
  v_contador_depto  NUMBER := 0;
BEGIN
  SELECT COUNT(1) INTO v_contador_depto
  FROM tb_departamento
  WHERE id_gerente = outer_block.v_id_gerente;
  
  IF (v_contador_depto > 0) THEN
    <<inner_block>>
    DECLARE
      v_nm_depto    VARCHAR2(30);
      v_id_gerente  NUMBER(6) := '&novo_id_gerente';
    BEGIN
      SELECT nm_departamento INTO v_nm_depto
      FROM tb_departamento
      WHERE id_gerente = outer_block.v_id_gerente;
      
      UPDATE tb_departamento
        SET id_gerente = inner_block.v_id_gerente
      WHERE id_gerente = outer_block.v_id_gerente;
      
      DBMS_OUTPUT.PUT_LINE('ID do gerente do Depto ' || v_nm_depto || ' foi alterado!');
    END inner_block;
  ELSE
    DBMS_OUTPUT.PUT_LINE('Nenhum depto selecionado para o gerente');    
  END IF;
  
EXCEPTION
  WHEN no_data_found THEN
    DBMS_OUTPUT.PUT_LINE('Não existe depto para o gerente');  
END outer_block;

SET serveroutput ON
DECLARE
  v_nm_depto    tb_departamento.nm_departamento%TYPE;
  v_id_depto    NUMBER(6) := &id_departamento;

BEGIN
  SELECT nm_departamento INTO v_nm_depto
  FROM tb_departamento
  WHERE id_departamento = v_id_depto;
  
  dbms_output.put_line('O depto com o ID informado eh: ' || v_nm_depto);

EXCEPTION
  WHEN no_data_found THEN
   dbms_output.put_line('Nenhum depto encontrado para esse ID');
END;

SET serveroutput ON
DECLARE
  v_nome        VARCHAR2(20);
  v_sobrenome   VARCHAR2(25);
  v_email       VARCHAR2(25);
BEGIN
  SELECT nome, sobrenome, email INTO v_nome, v_sobrenome, v_email
  FROM tb_empregado
  WHERE id_empregado = 100;
  
  dbms_output.put_line('Dados do empregado: ' || v_nome || ' ' || v_sobrenome || ' ' || v_email);
EXCEPTION
  WHEN no_data_found THEN
    dbms_output.put_line('Nenhum empregado localizado para esse ID');
  WHEN too_many_rows THEN
    dbms_output.put_line('Mais de um empregado localizado para esse ID');
END;

SET serveroutput ON
DECLARE
  v_nome        VARCHAR2(20);
  v_sobrenome   VARCHAR2(25);
  v_email       VARCHAR2(25);
BEGIN
  SELECT nome, sobrenome, email INTO v_nome, v_sobrenome, v_email
  FROM tb_empregado
  WHERE id_empregado = 99;
  
  dbms_output.put_line('Dados do empregado: ' || v_nome || ' ' || v_sobrenome || ' ' || v_email);
EXCEPTION
  WHEN no_data_found THEN
    dbms_output.put_line('Nenhum empregado localizado para esse ID');
  WHEN too_many_rows THEN
    dbms_output.put_line('Mais de um empregado localizado para esse ID');
END;

CREATE OR REPLACE PROCEDURE sp_recupera_info_emp(sobrenome IN VARCHAR2) AS
v_nome        VARCHAR2(20);
v_sobrenome   VARCHAR2(25);
v_email       VARCHAR2(25);

BEGIN
  SELECT nome, sobrenome, email
  INTO v_nome, v_sobrenome, v_email
  FROM tb_empregado
  WHERE sobrenome = sp_recupera_info_emp.sobrenome;
  
  dbms_output.put_line('Dados do empregado: ' || v_nome || ' ' || v_sobrenome || '-' || v_email);
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      dbms_output.put_line('Nenhum empregado localizado com esse sobrenome' || v_sobrenome);
END;


SET serveroutput ON
BEGIN
  sp_recupera_info_emp('Abel');
END;

SET serveroutput ON
BEGIN
  sp_recupera_info_emp('Henrique');
END;
