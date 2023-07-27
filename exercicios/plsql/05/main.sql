--2)
SET serveroutput ON
BEGIN
  UPDATE tb_empregado
  SET salario = salario * 1.15
  WHERE id_departamento = 10;
  
  dbms_output.put_line('Foi atualizado o salario de ' || SQL%ROWCOUNT || 'Empregado(s)' );
  
  COMMIT;
END;

------------------------------------------------------------------------------------------

--3)
SET serveroutput ON
ACCEPT input_antiga_funcao PROMPT 'Digite o nome da função antiga';
ACCEPT input_nova_funcao PROMPT 'Digite o nome da função nova';
DECLARE
  v_antiga_funcao tb_empregado.id_funcao%TYPE := '&input_antiga_funcao';
  v_nova_funcao tb_empregado.id_funcao%TYPE := '&input_nova_funcao';
  e_antiga_inexistente EXCEPTION;
  e_nova_inexistente EXCEPTION;
  v_check NUMBER;
BEGIN
  
  SELECT count(1) INTO v_check FROM tb_funcao
  WHERE UPPER(id_funcao) = UPPER(v_antiga_funcao);
  
  IF (v_check = 0) THEN
    RAISE e_antiga_inexistente;
  END IF;
  
  SELECT count(1) INTO v_check FROM tb_funcao
  WHERE UPPER(id_funcao) = UPPER(v_nova_funcao);
  
  IF (v_check = 0) THEN
    RAISE e_nova_inexistente;
  END IF;
  
  UPDATE tb_empregado
  SET id_funcao = UPPER(v_nova_funcao)
  WHERE UPPER(id_funcao) = UPPER (v_antiga_Funcao);
  
  dbms_output.put_line('Foi atualizado a função de ' || SQL%ROWCOUNT || ' Empregado(s)');

  COMMIT;
  EXCEPTION
    WHEN
      e_antiga_inexistente THEN
        dbms_output.put_line('Função antiga não existe no banco de dados');
        
    WHEN
      e_nova_inexistente THEN
        dbms_output.put_line('Função nova não existe no banco de dados');
END;

----------------------------------------------------------------------------------------------

--8)
 EXCEPTION
   WHEN NO_DATA_FOUND THEN
     DBMS_OUTPUT.PUT_LINE('Empregado não existe');

----------------------------------------------------------------------------------------------

--12)
SET serveroutput ON
ACCEPT input_num_1 PROMPT 'Digite o primeiro numero'
ACCEPT input_num_2 PROMPT 'Digite o segundo numero'
DECLARE
  v_num_1 NUMBER := &input_num_1;
  v_num_2 NUMBER := &input_num_2;
  e_maior EXCEPTION;
BEGIN
  IF (v_num_1 > v_num_2) THEN
    RAISE e_maior;
  END IF;
  
  EXCEPTION
    WHEN e_maior THEN
      dbms_output.put_line('O primeiro numero ' || v_num_1 || ' é maior que o segundo ' || v_num_2);
END;

----------------------------------------------------------------------------------------------

--13)
BEGIN
  EXECUTE IMMEDIATE 'ALTER TABLE tb_mensagens RENAME COLUMN
                     resultado TO "THIS IS A COMMENT LINE" ';
END;



