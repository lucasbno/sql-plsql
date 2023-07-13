@/home/lucasbno/dev/sql/cenario_plsql.sql

SELECT *
FROM tb_departamento;

SET serveroutput ON
DECLARE
  v_texto VARCHAR2(30) := 'Treinamento Oracle Essencial';
BEGIN
  dbms_output.put_line(v_texto);
END;

SET serveroutput ON
DECLARE
  v_contador NUMBER;
BEGIN
  SELECT COUNT(1) INTO v_contador
  FROM tb_departamento;
  
  IF v_contador = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Nenhum funcionario cadastrado no esquema do RH');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Existem ' || to_char(v_contador) || ' funcionario(s) cadastrado(s) no esquema do RH');
  END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

SET serveroutput ON
DECLARE
  v_contador NUMBER;
BEGIN
  BEGIN
    SELECT 1 INTO v_contador
    FROM tb_empregado
    WHERE ROWNUM = 1;
    
    EXCEPTION
      WHEN OTHERS THEN
      v_contador := 0;
  END;
  
  IF v_contador = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Nenhum funcionário cadastrado no esquema de RH');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Existe ' || to_char(v_contador) || ' funcionário cadastrado no esquema RH');
  END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

SET serveroutput ON
DECLARE
  v_contador NUMBER;
BEGIN
  SELECT 1 INTO v_contador
  FROM tb_empregado
  WHERE ROWNUM = 2;
  IF v_contador = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Nenhum funcionario cadastrado no esquema RH');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Existe(m) ' || to_char(v_contador) || 'funcionário(s) cadastrado(s) no esquema RH');
  END IF;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

VARIABLE v_minha_string VARCHAR2(30);

BEGIN
  :v_minha_string := 'Um string literal';
END;

SET serveroutput ON
BEGIN
  dbms_output.put_line(:v_minha_string);
END;

SET serveroutput ON
DECLARE
  v_minha_string VARCHAR2(30);
BEGIN
  v_minha_string := '&input';
  dbms_output.put_line('Testando: ' || v_minha_string);
END;

SET serveroutput ON
DECLARE
  v_id_emp tb_empregado.id_empregado%TYPE;
  v_sobrenome tb_empregado.sobrenome%TYPE;
BEGIN
  v_id_emp := 100301;
  v_sobrenome := 'Silva';
  
  dbms_output.put_line('ID: ' || v_id_emp);
  dbms_output.put_line('Sobrenome: ' || v_sobrenome);
END;

SET serveroutput ON
DECLARE
  v_emp_reg tb_empregado%ROWTYPE;
BEGIN
  SELECT * INTO v_emp_reg FROM tb_empregado
  WHERE id_empregado = 125;
  dbms_output.put_line('Nome: ' || v_emp_reg.nome || ' ' || v_emp_reg.sobrenome);
END;

CREATE TABLE "tb_Demo" (
  "id_Demo" NUMBER,
  valor_demo  VARCHAR2(20)
);

INSERT INTO "tb_Demo"
VALUES (1, 'Linha um apenas');

SET serveroutput ON
BEGIN
  FOR I IN (SELECT "id_Demo", valor_demo FROM "tb_Demo") LOOP
  dbms_output.put_line(i."id_Demo");
  dbms_output.put_line(i.valor_demo);
  END LOOP;
END;

SET serveroutput ON
DECLARE
  v_nome VARCHAR2(50);
BEGIN
  V_NOME := 'Treinamento PL/SQL Essencial';
  dbms_output.put_line('O conteúdo eh: ' || v_nome);
END;

SET serveroutput ON
DECLARE
  v_salario             NUMBER(6, 2);
  v_horas_trabalhada    NUMBER := 40;
  v_valor_hora          NUMBER := 22.50;
  v_bonus               NUMBER := 150;
  v_pais                VARCHAR2(128);
  v_contador            NUMBER := 0;
  v_controle            BOOLEAN := FALSE;
  v_id_validade         BOOLEAN;
BEGIN
  v_salario := (v_horas_trabalhada * v_valor_hora) + v_bonus;
  v_pais := 'Brasil';
  v_pais := UPPER('Canada');
  v_controle := (v_contador > 100);
  v_id_validade := TRUE;
END;

DECLARE
  v_finalizado BOOLEAN := TRUE;
  v_completo BOOLEAN;
  v_true_or_false BOOLEAN;
BEGIN
  v_finalizado := FALSE;
  v_completo := NULL;
  v_true_or_false := (3 = 4);
  v_true_or_false := (3 < 4);
END;

DECLARE
  v_id_empregado        NUMBER(6);
  v_emp_ativo           BOOLEAN NOT NULL := TRUE;
  v_salario_mensal      NUMBER(6) NOT NULL := 2000;
  v_salario_diaria      NUMBER(6, 2);
  v_media_dias_trab_mes NUMBER(2) DEFAULT 21;
  
BEGIN
  NULL;
END;

SET serveroutput ON
DECLARE
  TYPE registro_demo IS RECORD(
  id_aluno NUMBER DEFAULT 1,
  nome VARCHAR2(10) := 'Mário');
  reg_demo REGISTRO_DEMO;
BEGIN
  dbms_output.put_line('[' || reg_demo.id_aluno || '][' || reg_demo.nome ||']');
END;

SET serveroutput ON
DECLARE
  TYPE tp_full_name IS RECORD(
  nome VARCHAR2(10) := 'Ricardo',
  sobrenome VARCHAR2(10) := 'Vargas');
  TYPE tp_reg_aluno IS RECORD(
  id_aluno NUMBER DEFAULT 1,
  nm_aluno TP_FULL_NAME);
  reg_demo TP_REG_ALUNO;
BEGIN
  dbms_output.put_line('[' || reg_demo.id_aluno || ']');
  dbms_output.put_line('[' || reg_demo.nm_aluno.nome || ']');
  dbms_output.put_line('[' || reg_demo.nm_aluno.sobrenome || ']');
END;

SET serveroutput ON
DECLARE
  TYPE varray_numerico IS VARRAY(5) OF NUMBER;
  v_lista VARRAY_NUMERICO := varray_numerico(1, 2, 3, NULL, NULL);
BEGIN
  FOR i IN 1 .. v_lista.LIMIT LOOP
    dbms_output.put('[' || v_lista(i) || ']');
  END LOOP;
  dbms_output.new_line;
END;

SET serveroutput ON
<<outer>>
DECLARE
  v_contador NUMBER;
BEGIN
  <<inner>>
  DECLARE
    v_contador NUMBER;
  BEGIN
    SELECT 1 INTO inner.v_contador
    FROM tb_empregado
    WHERE ROWNUM = 1;
    outer.v_contador := inner.v_contador;
    
    EXCEPTION
      WHEN OTHERS THEN
        outer.v_contador := 0;
  END;
  IF v_contador = 0 THEN
    dbms_output.put_line('Nenhum registro no esquema RH');
  ELSE
    dbms_output.put_line('Existe ' || to_char(outer.v_contador) || ' registro no esquema RH');
  END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line(SQLERRM);
END;