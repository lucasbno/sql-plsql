-- Aula (28/07/2023)

CREATE OR REPLACE FUNCTION fn_get_empregado (p_id_emp NUMBER)
  RETURN tb_empregado%ROWTYPE IS
  v_sql         VARCHAR2(200);
  v_reg_emp     tb_empregado%ROWTYPE;
BEGIN
  v_sql := 'SELECT * FROM tb_empregado ' ||
           'WHERE id_empregado = :id';

  EXECUTE IMMEDIATE v_sql INTO v_reg_emp USING p_id_emp;
  
  RETURN v_reg_emp;
  
END fn_get_empregado;

CREATE OR REPLACE PROCEDURE sp_lista_empregados(p_id_depto NUMBER) IS
  TYPE cursor_ref_emp IS REF CURSOR;
  v_cursor_emp  cursor_ref_emp;
  v_reg_emp     tb_empregado%ROWTYPE;
  v_sql VARCHAR2(200) := 'SELECT * FROM tb_empregado';
BEGIN
  IF p_id_depto IS NULL THEN
    OPEN v_cursor_emp FOR v_sql;
  ELSE
    v_sql := v_sql || ' WHERE id_departamento = ' || p_id_depto;
    OPEN v_cursor_emp FOR v_sql;
  END IF;
  LOOP
  FETCH v_cursor_emp INTO v_reg_emp;
  EXIT WHEN v_cursor_emp%NOTFOUND;
  dbms_output.put_line(v_reg_emp.id_departamento || ' ' || v_reg_emp.sobrenome);
  END LOOP;
  CLOSE v_cursor_emp;
  
END;

SET serveroutput ON
BEGIN
sp_lista_empregados(NULL);
END;

SET serveroutput ON
BEGIN
sp_lista_empregados(80);
END;

CREATE OR REPLACE FUNCTION fn_salario_anual(p_id_emp NUMBER) 
   RETURN NUMBER 
IS
  plsql         VARCHAR2(200) := 
                'DECLARE ' ||
                'v_reg_emp  tb_empregado%ROWTYPE; ' ||
                'BEGIN ' ||
                'v_reg_emp := fn_get_empregado(:p_id_emp); ' ||
                ':res := v_reg_emp.salario * 12; ' ||
                'END;';
  v_resultado   NUMBER;          
BEGIN
  EXECUTE IMMEDIATE plsql USING IN p_id_emp, OUT v_resultado;
  
  RETURN v_resultado;
  
END fn_salario_anual;


--Invocando a fn_salario_anual
SET serveroutput ON
EXECUTE dbms_output.put_line('Salário anual eh: ' || fn_salario_anual(100));

SELECT XMLELEMENT("nm_empregado", nome) AS xml_emp
FROM tb_empregado;

SELECT XMLELEMENT(
   "empregado",
   XMLELEMENT("id_empregado", id_empregado),
   XMLELEMENT("nome", nome || ' ' || sobrenome)
  ) AS xml_empregado
FROM tb_empregado
WHERE id_empregado IN (100, 101, 103);

SELECT XMLELEMENT(
   "empregado",
    XMLATTRIBUTES(
      id_empregado AS "id",
      nome || ' ' || sobrenome AS "nome",
      TO_CHAR(data_admissao, 'DD/MM/YYYY') AS "dt_adm")
   ) AS xml_empregado
FROM tb_empregado
WHERE id_empregado IN (100, 101, 103);

SELECT XMLELEMENT(
  "empregado",
    XMLFOREST(
      id_empregado AS "id",
      nome || ' ' || sobrenome AS "nome",
      TO_CHAR(data_admissao, 'DD/MM/YYYY') AS "dt_adm")
  ) AS xml_empregado
FROM tb_empregado
WHERE id_empregado IN (100, 101, 102);

SET serveroutput ON
DECLARE
  queryCtx      dbms_xmlquery.ctxType;
  v_resultado   CLOB;
BEGIN
  --configurando o conteúdo da query
  queryCtx := dbms_xmlquery.newContext(
     'SELECT id_empregado "ID_FUNCIONARIO", nome "NOME", 
             sobrenome "SOBRENOME", email "EMAIL",
             telefone "TELEFONE", salario "SALARIO",
             id_departamento "NR_DEPTO"
      FROM tb_empregado');
  
  v_resultado := dbms_xmlquery.getXml(queryCtx);
  dbms_output.put_line(v_resultado);
  dbms_xmlquery.closeContext(queryCtx);
  
END;

BEGIN
  htp.htmlOpen;
  htp.headOpen;
  htp.title('Connecta Treinamentos em TI');
  htp.headClose;
  htp.bodyOpen;
  htp.print('Treinamento PL/SQL Essencial');
  htp.bodyClose;
  htp.htmlClose;
END;

DECLARE
  CURSOR cr_emp_depto_60 IS SELECT *
                            FROM tb_empregado
                            WHERE id_departamento = 60;
  
  reg_empregado     cr_emp_depto_60%ROWTYPE;
BEGIN
  OPEN cr_emp_depto_60;
  htp.htmlOpen;
  htp.headOpen;
  htp.title('Relatório Empregados - Depto Nr. 60');
  htp.headClose;
  htp.bodyOpen;
  
  LOOP
    FETCH cr_emp_depto_60 INTO reg_empregado;
    EXIT WHEN cr_emp_depto_60%NOTFOUND;
    
    htp.print('Departamento: ' || reg_empregado.id_departamento 
                  || ' , Empregado: ' || reg_empregado.id_empregado || ' - ' 
                  || reg_empregado.sobrenome || ', ' || reg_empregado.nome);
  END LOOP;
  
  htp.bodyClose;
  htp.htmlClose;
  
  CLOSE cr_emp_depto_60;
  
END;

SET serveroutput ON
ACCEPT input_dep PROMPT 'Insira o número do departamento';
DECLARE
  v_dep     NUMBER := &input_dep;
  v_linhas  NUMBER;
BEGIN
  DELETE FROM tb_departamento
  WHERE id_departamento = v_dep;
--  
  IF SQL%NOTFOUND THEN
    dbms_output.put_line('Departamento não localizado');
  ELSIF SQL%FOUND THEN
    v_linhas := SQL%ROWCOUNT;
    dbms_output.put_line(v_linhas || ' Departamento(s) removidos');
  END IF;
END;