select sysdate from dual;

SET serveroutput ON
DECLARE
  v_num1 NUMBER := 95;
  v_num2 NUMBER := 85;
  BEGIN
    dbms_output.put_line('Variavel global v_num1: ' || v_num1);
    dbms_output.put_line('Variavel global v_num1: ' || v_num2);
    
  DECLARE
    v_num1 NUMBER := 195;
    v_num2 NUMBER := 185;
  BEGIN
    dbms_output.put_line('Variável local v_num1: ' || v_num1);
    dbms_output.put_line('Variável local v_num2: ' || v_num2);
  END;
END;

SET serveroutput ON
DECLARE
  c_identificador CONSTANT VARCHAR2(30) := 'PL/SQL Essencial';
BEGIN
  dbms_output.put_line('Conteúdo da constante: ' || c_identificador);
END;

SET serveroutput ON
DECLARE
  c_pi CONSTANT NUMBER := 3.141592654;
  
  v_raio            NUMBER(5, 2);
  v_diametro        NUMBER(5, 2);
  v_circunferencia  NUMBER(7, 2);
  v_area            NUMBER(10, 2);
  
BEGIN
  v_raio := 9.5;
  v_diametro := v_raio * 2;
  v_circunferencia := 2.0 * c_pi * v_raio;
  v_area := c_pi * v_raio * v_raio;
  
  dbms_output.put_line('Raio: ' || v_raio);
  dbms_output.put_line('Diâmetro: ' || v_diametro);
  dbms_output.put_line('Circunferência: ' || v_circunferencia);
  dbms_output.put_line('Área: ' || v_area);
END;
--------------------------------------------------------------------------------
/*
-- Select must store result on variables using INTO
SELECT lista_colunas
INTO lista_variavel
FROM tabela
WHERE condition
*/

SET serveroutput ON
DECLARE
  v_soma_salario    NUMBER(10,2);
  v_nome            tb_empregado.nome%TYPE;
  v_sobrenome       tb_empregado.sobrenome%TYPE;
BEGIN
  SELECT SUM (NVL(salario, 0)) INTO v_soma_salario
  FROM tb_empregado
  WHERE id_departamento = 10;
  
  dbms_output.put_line('A soma dos salários é: ' || v_soma_salario);
  
  SELECT nome, sobrenome INTO v_nome, v_sobrenome
  FROM tb_empregado
  WHERE id_empregado = 100;
  
  dbms_output.put_line('O nome completo do empregado é: ' || v_nome || ' ' || v_sobrenome);
END;

BEGIN
  INSERT INTO tb_empregado (id_empregado, nome, sobrenome, email, data_admissao, id_funcao, salario)

  VALUES (sq_empregado.NEXTVAL, 'Geraldo', 'Henrique Neto', 'geraldohenrique@usp.br', SYSDATE, 'IT_PROG', 5000);
  COMMIT;
END;

SELECT *
FROM tb_empregado
WHERE nome = 'Geraldo'
AND sobrenome = 'Henrique Neto';

BEGIN
  UPDATE tb_empregado
  SET salario = 15000
  WHERE nome = 'Geraldo'
  AND sobrenome = 'Henrique Neto';

  COMMIT;
END;

SELECT *
FROM tb_empregado
WHERE nome = 'Geraldo'
AND sobrenome = 'Henrique Neto';

DECLARE
  v_id_empregado NUMBER;
  BEGIN
  SELECT sq_empregado.CURRVAL INTO v_id_empregado
  FROM dual;
  
  DELETE FROM tb_empregado
  WHERE id_empregado = v_id_empregado;
  COMMIT;
END;

SET serveroutput ON
DECLARE
  v_emp_count NUMBER;
BEGIN
  SELECT COUNT(1) INTO v_emp_count
  FROM tb_empregado
  WHERE id_departamento = &&id_departamento;
  
  DBMS_OUTPUT.PUT_LINE('A contagem de empregados eh: ' || v_emp_count || 'para o depto com o ID de: ' || &id_departamento);
END;

SET serveroutput ON
DECLARE
  v_id_depto    NUMBER(4) := &id_depto;
  v_nm_depto    VARCHAR2(30);
  v_emp_count   NUMBER;
  
BEGIN
  SELECT COUNT(1) INTO v_emp_count
  FROM tb_empregado
  WHERE id_departamento = v_id_depto;
  
  SELECT nm_departamento INTO v_nm_depto
  FROM tb_departamento
  WHERE id_departamento = v_id_depto;
  
  DBMS_OUTPUT.PUT_LINE('Existe ' || v_emp_count || ' empregado(s) no departamento ' || v_nm_depto);
END;

SET serveroutput ON
DECLARE 
  v_nome        VARCHAR2(20);
  v_sobrenome   VARCHAR2(25);
  v_emp_sobre   VARCHAR2(25) := '&v_emp_sobre';
  v_emp_count   NUMBER;
BEGIN
  SELECT COUNT(1) INTO v_emp_count
  FROM tb_empregado
  WHERE sobrenome = v_emp_sobre;
  
  IF (v_emp_count > 1) THEN
    DBMS_OUTPUT.PUT_LINE('Existe mais de um empregado com o mesmo sobrenome');
  ELSE
    SELECT nome, sobrenome INTO v_nome, v_sobrenome

    FROM tb_empregado
    WHERE sobrenome = v_emp_sobre;
    
    DBMS_OUTPUT.PUT_LINE('Nome completo do empregado ' || v_nome || ' ' || v_sobrenome);
  END IF;
EXCEPTION
  WHEN no_data_found THEN
    DBMS_OUTPUT.PUT_LINE('Por favor, entre com um sobrenome diferente');
END;

SET serveroutput ON
DECLARE
  v_a NUMBER(2) := 10;
BEGIN
  v_a := 10;
  
  IF (v_a < 20) THEN
    dbms_output.put_line('v_a eh menor que 20');
  END IF;
  dbms_output.put_line('O valor de v_a eh: ' || v_a);
END;

SET serveroutput ON
DECLARE
  v_contador    NUMBER;
BEGIN
  SELECT COUNT(1) INTO v_contador
  FROM tb_empregado;
  
  IF (v_contador = 0) THEN
    dbms_output.put_line('Não existem empregados cadastrados');
  END IF;
END;

SET serveroutput ON
DECLARE
  c_id_cliente      tb_clientes.id_cliente%TYPE := 1;
  c_salario         tb_clientes.salario%TYPE;
BEGIN
  SELECT salario INTO c_salario
  FROM tb_clientes
  WHERE id_cliente = c_id_cliente;
  
  IF (c_salario <= 2000) THEN
    UPDATE tb_clientes
      SET salario = salario + 1000
      WHERE id_cliente = c_id_cliente;
      
      DBMS_OUTPUT.PUT_LINE('Salário alterado com êxito');
      
  END IF;
END;

SET serveroutput ON
DECLARE
  v_a   NUMBER(3) := 100;
BEGIN
  IF (v_a < 20) THEN
    dbms_output.put_line('v_a eh menor que 20');
  ELSE
    dbms_output.put_line('v_a não eh menor que 20');
  END IF;
  
  dbms_output.put_line('O valor de v_a eh: ' || v_a);
  
END;

SET serveroutput ON
DECLARE
  v_contador    NUMBER;
BEGIN
  SELECT COUNT(1) INTO v_contador
  FROM tb_empregado;
  
  IF (v_contador = 0) THEN
    dbms_output.put_line('Nao existe(m) empregado(s) cadastrado(s)');
  ELSE
    dbms_output.put_line('Existe(m) ' || TO_CHAR(v_contador) || ' empregado(s) cadastrado(s)');
  END IF;
END;

SET serveroutput ON
DECLARE
  v_a NUMBER(3) := 100;
BEGIN
  IF (v_a = 10) THEN
    dbms_output.put_line('Valor de v_a eh 10');
  ELSIF (v_a = 20) THEN
    dbms_output.put_line('Valor de v_a eh 20');
  ELSIF (v_a = 30) THEN
    dbms_output.put_line('Valor de v_a eh 30');
  ELSE
    dbms_output.put_line('Nenhuma correspondência com os valores acima');
  END IF;
  dbms_output.put_line('O valor exato de v_a eh: ' || v_a);
END;

SET serveroutput ON
DECLARE
  v_contador NUMBER;
BEGIN
  SELECT COUNT(1) INTO v_contador
  FROM tb_empregado;
  
  IF (v_contador = 0) THEN
    DBMS_OUTPUT.PUT_LINE('Não existe empregado cadastrado');
  ELSIF (v_contador > 100) THEN
    DBMS_OUTPUT.PUT_LINE('Existem mais de 100 empregados cadastrados');
  ELSE 
    DBMS_OUTPUT.PUT_LINE('Existe(m) ' || TO_CHAR(v_contador) || ' empregado(s) cadastrado(s)');
  END IF;
END;

SET serveroutput ON
DECLARE
  v_grade CHAR(1) := 'A';
BEGIN
  CASE v_grade
    WHEN 'A' THEN dbms_output.put_line('Excelente');
    WHEN 'B' THEN dbms_output.put_line('Muito bom');
    WHEN 'C' THEN dbms_output.put_line('Bom');
    WHEN 'D' THEN dbms_output.put_line('Reprovado');
    WHEN 'F' THEN dbms_output.put_line('Tente novamente');
    ELSE dbms_output.put_line('Nenhuma classificação');
  END CASE;
END;

SET serveroutput ON
DECLARE
  v_contador    NUMBER;
  v_msg         VARCHAR2(100);
BEGIN
  SELECT COUNT(1) INTO v_contador
  FROM tb_empregado;

  CASE v_contador
    WHEN 0 THEN dbms_output.put_line('Nenhum empregado cadastrado');
    ELSE dbms_output.put_line('Existe(m)  ' || TO_CHAR(v_contador) || ' empregado(s) cadastrado(s)');
  END CASE;
END;

SET serveroutput ON
DECLARE
  v_grade       CHAR(1) := 'B';
BEGIN
  CASE 
    WHEN v_grade = 'A' THEN dbms_output.put_line('Excelente');
    WHEN v_grade = 'B' THEN dbms_output.put_line('Muito bom');
    WHEN v_grade = 'C' THEN dbms_output.put_line('Bom');
    WHEN v_grade = 'D' THEN dbms_output.put_line('Reprovado');
    WHEN v_grade = 'E' THEN dbms_output.put_line('Tente novamente');
   ELSE dbms_output.put_line('Nenhuma classificação');    
  END CASE;
END;


SELECT COUNT(CASE WHEN salario < 2000 THEN 1 ELSE NULL END) salario_inferior_2000,
       COUNT(CASE WHEN salario BETWEEN 2001 AND 4000 THEN 1 ELSE NULL END) salario_entre_2001_e_4000,
       COUNT(CASE WHEN salario > 4000 THEN 1 ELSE NULL END) salario_maior_4000
FROM tb_empregado;       


SELECT COUNT(1)
FROM tb_empregado
WHERE salario < 2000
UNION ALL
SELECT COUNT(1)
FROM tb_empregado
WHERE salario BETWEEN 2001 AND 4000
UNION ALL
SELECT COUNT(1)
FROM tb_empregado
WHERE salario > 4000;

SET serveroutput ON
DECLARE
  v_a   NUMBER(3) := 100;
  v_b   NUMBER(3) := 200;
BEGIN
  IF (v_a = 100) THEN
    IF (v_b = 200) THEN
      dbms_output.put_line('Valor de v_a eh 100 e v_b eh 200');
    END IF;
  END IF;
  
  dbms_output.put_line('Valor exato de v_a eh: ' || v_a);
  dbms_output.put_line('Valor exato de v_b eh: ' || v_b);
  
END;

SET serveroutput ON
DECLARE
  v_x       NUMBER := 10;
BEGIN
  LOOP
    DBMS_OUTPUT.PUT_LINE (v_x);
    
    v_x := v_x + 10;
    
    IF (v_x > 50) THEN
      EXIT;
    END IF;
  END LOOP;
  dbms_output.put_line('Depois do EXIT v_x eh: ' || v_x);
END;