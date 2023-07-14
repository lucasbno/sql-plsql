SET serveroutput ON
DECLARE
  v_total_linhas  NUMBER(2);
BEGIN
  UPDATE tb_clientes
    SET salario = salario + 500;
  
  IF SQL%NOTFOUND THEN
    dbms_output.put_line('Nenhum cliente selecionado');
  ELSIF SQL%FOUND THEN
    v_total_linhas := SQL%ROWCOUNT;
    dbms_output.put_line(v_total_linhas || ' clientes selecionados');
  END IF;
END;

----------------------------------------------------------------------------------------------

SET serveroutput ON
BEGIN
  UPDATE tb_empregado
  SET nome = nome
  WHERE ROWNUM = 1;
  
  IF SQL%FOUND THEN
    dbms_output.put_line('Foi(ram) atualizada(s) ' || SQL%ROWCOUNT || ' linha(s)');
  ELSE
    dbms_output.put_line('Nehuma linha foi atualizada');
  END IF;
END;

----------------------------------------------------------------------------------------------

SET serveroutput ON
DECLARE
  v_n NUMBER;
BEGIN
  SELECT 1 INTO v_n
  FROM dual;
  
  dbms_output.put_line('Selecionado(s) ' || SQL%ROWCOUNT || ' linha(s)');
END;

----------------------------------------------------------------------------------------------

SET serveroutput ON
DECLARE
  TYPE reg_emp IS RECORD (
    id_emp      tb_empregado.id_empregado%TYPE,
    nome        tb_empregado.nome%TYPE,
    sobrenome   tb_empregado.sobrenome%TYPE);

  dataset   REG_EMP;
BEGIN  
    SELECT id_empregado, nome,sobrenome INTO dataset
    FROM tb_empregado
    WHERE ROWNUM < 2;
    
    dbms_output.put_line('Empregado selecionado ' || dataset.nome);
END;  

----------------------------------------------------------------------------------------------

SET serveroutput ON
BEGIN
  FOR i IN (SELECT nome, sobrenome, salario FROM tb_empregado) LOOP
    dbms_output.put_line('Nome:' || i.nome ||
                          'Sobrenome: ' || i.sobrenome ||
                          'Salário: ' || i.salario);
  END LOOP;
END;

----------------------------------------------------------------------------------------------

SET serveroutput ON
DECLARE
  TYPE reg_emp IS RECORD (
    id_emp      tb_empregado.id_empregado%TYPE,
    nome        tb_empregado.nome%TYPE,
    sobrenome   tb_empregado.sobrenome%TYPE);

  dataset   REG_EMP;
BEGIN  
    SELECT id_empregado, nome,sobrenome INTO dataset
    FROM tb_empregado
    WHERE ROWNUM < 2;
    
    dbms_output.put_line('Empregado selecionado ' || dataset.nome);
END;  

----------------------------------------------------------------------------------------------

SET serveroutput ON
BEGIN
  FOR i IN (SELECT nome, sobrenome, salario
            FROM tb_empregado) LOOP
    dbms_output.put_line('Nome: ' || i.nome || ' Sobrenome: ' || i.sobrenome || ' Salário: ' || i.salario);
  END LOOP;
END;

----------------------------------------------------------------------------------------------

SET serveroutput ON
DECLARE 
  v_id          tb_clientes.id_cliente%TYPE;
  v_nome        tb_clientes.nm_cliente%TYPE;
  v_endereco    tb_clientes.endereco%TYPE;
  
  CURSOR c_clientes IS
    SELECT id_cliente, nm_cliente, endereco
    FROM tb_clientes;

BEGIN
  OPEN c_clientes;
  
  LOOP
    FETCH c_clientes INTO v_id, v_nome, v_endereco;
    EXIT WHEN c_clientes%NOTFOUND;
      dbms_output.put_line(v_id || ' ' || v_nome || ' ' || v_endereco);
  END LOOP;
  CLOSE c_clientes;
END;

----------------------------------------------------------------------------------------------

SET serveroutput ON
DECLARE
  CURSOR cur_emp IS
    SELECT id_empregado, nome, sobrenome
    FROM tb_empregado
    WHERE ROWNUM < 5;
  v_id_emp      tb_empregado.id_empregado%TYPE;
  v_nome        tb_empregado.nome%TYPE;
  v_sobrenome   tb_empregado.sobrenome%TYPE;
BEGIN
  OPEN cur_emp;
  
  IF (cur_emp%ISOPEN) THEN
    LOOP
      FETCH cur_emp INTO v_id_emp, v_nome, v_sobrenome;
      EXIT WHEN cur_emp%NOTFOUND;
      
        DBMS_OUTPUT.PUT_LINE('O nome do empregado com ID ' || v_id_emp || ' eh ' || v_nome || ' ' || v_sobrenome);      
    END LOOP;
  END IF;
  CLOSE cur_emp;
END;

----------------------------------------------------------------------------------------------

SET serveroutput ON
DECLARE
  CURSOR cur_emp IS
    SELECT id_empregado, nome, sobrenome
    FROM tb_empregado
    WHERE ROWNUM < 5;

BEGIN
  FOR emp_linha IN cur_emp LOOP
    dbms_output.put_line('O nome do empregado com ID ' || emp_linha.id_empregado || ' eh ' 
                           || emp_linha.nome || ' ' || emp_linha.sobrenome);
  END LOOP;
END;

----------------------------------------------------------------------------------------------

SET serveroutput ON
BEGIN
  FOR emp_linha IN (SELECT id_empregado, nome, sobrenome
                    FROM tb_empregado
                    WHERE ROWNUM < 5) LOOP
    DBMS_OUTPUT.PUT_LINE('O nome do empregado com ID ' || emp_linha.id_empregado || ' eh ' ||
                           emp_linha.nome || ' ' || emp_linha.sobrenome);
  END LOOP;                    
END;

----------------------------------------------------------------------------------------------

SET serveroutput ON
DECLARE
  CURSOR cur_emp(p_id_emp NUMBER) IS
    SELECT id_empregado, nome, sobrenome
    FROM tb_empregado
    WHERE id_empregado = p_id_emp;
  
  v_id_emp      tb_empregado.id_empregado%TYPE;
  v_nome        tb_empregado.nome%TYPE;
  v_sobrenome   tb_empregado.sobrenome%TYPE;
BEGIN
  OPEN cur_emp(100);
  FETCH cur_emp INTO v_id_emp, v_nome, v_sobrenome;
    dbms_output.put_line('O nome do empregado com ID ' || v_id_emp || ' eh ' || v_nome || ' ' || v_sobrenome);
    
  CLOSE cur_emp;  
  
  OPEN cur_emp(101);
  FETCH cur_emp INTO v_id_emp, v_nome, v_sobrenome;
    dbms_output.put_line('O nome do empregado com ID ' || v_id_emp || ' eh ' || v_nome || ' ' || v_sobrenome);
  
  CLOSE cur_emp;  
END;

----------------------------------------------------------------------------------------------

SET serveroutput ON
DECLARE
  v_id_cliente      tb_clientes.id_cliente%TYPE := 8;
  v_nome            tb_clientes.nm_cliente%TYPE;
  v_endereco        tb_clientes.endereco%TYPE;
BEGIN
  SELECT nm_cliente, endereco INTO v_nome, v_endereco
  FROM tb_clientes
  WHERE id_cliente = v_id_cliente;
  
  DBMS_OUTPUT.PUT_LINE('Nome: ' || v_nome);
  DBMS_OUTPUT.PUT_LINE('Endereço: ' || v_endereco);
  
EXCEPTION
  WHEN no_data_found THEN
    dbms_output.put_line('Cliente inexistente');
  WHEN others THEN
    dbms_output.put_line('Erro!');  
END;


SET serveroutput ON
DECLARE
  v_nome    tb_empregado.nome%TYPE;
BEGIN
  SELECT nome INTO v_nome
  FROM tb_empregado
  WHERE nome = 'David';

EXCEPTION
  WHEN too_many_rows THEN
    dbms_output.put_line('A consulta retornou mais que uma linha. Utlize coleções ou cursores');
END;

SET serveroutput ON
DECLARE
  v_nome    NUMBER;
BEGIN
  SELECT nome INTO v_nome
  FROM tb_empregado
  WHERE ROWNUM = 1;

EXCEPTION
  WHEN others THEN
    dbms_output.put_line('Ocorreu um erro! ' || SQLERRM);
END;
-- Ocorreu um erro! ORA-06502: PL/SQL: numeric or value error: character to number conversion error

SET serveroutput ON
DECLARE
  v_id_cliente      tb_clientes.id_cliente%TYPE := &id_cliente;
  v_nome            tb_clientes.nm_cliente%TYPE;
  v_endereco        tb_clientes.endereco%TYPE;
  -- exceção definida pelo desenvolvedor
  ex_id_invalido    EXCEPTION;
BEGIN
  IF (v_id_cliente <= 0) THEN
    RAISE ex_id_invalido;
  ELSE
    SELECT nm_cliente, endereco INTO v_nome, v_endereco
    FROM tb_clientes
    WHERE id_cliente = v_id_cliente;    
  
  dbms_output.put_line('Nome: ' || v_nome);
  dbms_output.put_line('Endereço: ' || v_endereco);
  END IF;
  
EXCEPTION
  WHEN ex_id_invalido THEN
    dbms_output.put_line('ID deve ser maior que zero!');
  WHEN no_data_found THEN
    dbms_output.put_line('Nenhum cliente encontrado!');
  WHEN others THEN
    dbms_output.put_line('Erro!');
END;


SET serveroutput ON
DECLARE
  v_nome    tb_empregado.nome%TYPE;
BEGIN
  SELECT nome INTO v_nome
  FROM tb_empregado
  WHERE nome = 'David';

EXCEPTION
  WHEN too_many_rows THEN
    dbms_output.put_line(SQLERRM);
    RAISE_APPLICATION_ERROR(-20000, 'Erro adaptado. Não é possível gravar valores de múltiplas linhas em uma varável escalar');
END;
-- ORA-20000: Erro adaptado. Não é possível gravar valores de múltiplas linhas em uma varável escalar


SET serveroutput ON
DECLARE
  v_nome        tb_empregado.nome%TYPE;
  v_contador    NUMBER;
BEGIN
  SELECT COUNT(1) INTO v_contador
  FROM tb_empregado
  WHERE nome = 'David';
  
  IF (v_contador > 0) THEN
    BEGIN --início do bloco filho
      SELECT nome INTO v_nome
      FROM tb_empregado
      WHERE nome = 'David';
    EXCEPTION 
      WHEN too_many_rows THEN
        dbms_output.put_line('A consulta retornou mais de uma linha');
      WHEN others THEN
        dbms_output.put_line(SQLERRM);
    END; --fim do bloco filho
  END IF;
END;


SET serveroutput ON
DECLARE
  v_nome        tb_empregado.nome%TYPE;
  v_contador    NUMBER;
BEGIN
  SELECT COUNT(1) INTO v_contador
  FROM tb_empregado
  WHERE nome = 'David';
  
  IF (v_contador > 0) THEN
    BEGIN --início do bloco filho
      SELECT nome INTO v_nome
      FROM tb_empregado 
      WHERE nome = 'David';
    END; --fim do bloco filho
  END IF;

EXCEPTION
  WHEN too_many_rows THEN
    dbms_output.put_line('A consulta retornou mais que uma linha');
  WHEN others THEN
    dbms_output.put_line(SQLERRM);
END;

----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE sp_incremento_salario (p_id_emp IN tb_empregado.id_empregado%TYPE, p_percentual IN NUMBER)
IS
BEGIN
  UPDATE tb_empregado
  SET salario = salario * (1 + p_percentual / 100)
  WHERE id_empregado = p_id_emp;

END sp_incremento_salario;

EXECUTE sp_incremento_salario(176, 10);

SELECT * FROM tb_empregado
WHERE id_empregado = 176;

----------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE sp_query_emp
(
  p_id_emp IN tb_empregado.id_empregado%TYPE,
  p_nome OUT tb_empregado.nome%TYPE,
  p_salario OUT tb_empregado.salario%TYPE
) IS
BEGIN
  SELECT nome, salario INTO p_nome, p_salario
  FROM tb_empregado
  WHERE id_empregado = p_id_emp;
END sp_query_emp;

SET serveroutput ON
DECLARE
  v_nome    tb_empregado.nome%TYPE;
  v_salario tb_empregado.salario%TYPE;
BEGIN
  sp_query_emp(171, v_nome, v_salario);
  dbms_output.put_line('Nome: ' || v_nome);
  dbms_output.put_line('Salário: ' || v_salario);
END;

----------------------------------------------------------------------------

SET serveroutput ON
DECLARE
  v_a   NUMBER;
  v_b   NUMBER;
  v_c   NUMBER;
  
  PROCEDURE sp_menor_valor(p_x IN NUMBER, p_y IN NUMBER, p_z OUT NUMBER) IS
  BEGIN
    IF (p_x < p_y) THEN
      p_z := p_x;
    ELSE
      p_z := p_y;
    END IF;
  END;

BEGIN
  v_a := -1;
  v_b := 9;
  
  sp_menor_valor(v_a, v_b, v_c);
  dbms_output.put_line('O menor valor entre (-1, 9) eh: ' || v_c);
END;

SET serveroutput ON
DECLARE
  v_a number;

PROCEDURE sp_quadrado_num(p_x IN OUT number) IS
BEGIN
  p_x := p_x * p_x;
END;

BEGIN
  v_a := 43;
  sp_quadrado_num(v_a);
  dbms_output.put_line('O quadrado de (43): ' || v_a);
END;

------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE sp_formata_fone(p_nr_fone IN OUT VARCHAR2) IS
BEGIN
  p_nr_fone := '(' || SUBSTR(p_nr_fone, 1, 3) ||
               ')' || SUBSTR(p_nr_fone, 4, 3) || 
               '-' || SUBSTR(p_nr_fone, 7);
END sp_formata_fone;

SET serveroutput ON
DECLARE
  out_valor VARCHAR2(13) := '8006330575';
BEGIN
  sp_formata_fone(out_valor);
  dbms_output.put_line(out_valor);
END;
  
------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE sp_adiciona_depto(
  p_nome    IN tb_departamento.nm_departamento%TYPE,
  p_localizacao IN tb_departamento.id_localizacao%TYPE
) IS
BEGIN
  INSERT INTO tb_departamento (id_departamento, nm_departamento, id_localizacao)
  VALUES (sq_departamento.NEXTVAL, p_nome, p_localizacao);
END sp_adiciona_depto;

EXECUTE sp_adiciona_depto(p_localizacao => 2400, p_nome => 'Educação');

SELECT * FROM tb_departamento;
