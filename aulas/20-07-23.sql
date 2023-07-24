CREATE OR REPLACE PROCEDURE sp_adiciona_depto(
  p_nome IN tb_departamento.nm_departamento%TYPE := 'Desconhecido',
  p_localizacao IN tb_departamento.id_localizacao%TYPE DEFAULT 1700
) IS
BEGIN
  INSERT INTO tb_departamento(id_departamento, nm_departamento, id_localizacao)
  VALUES (sq_departamento.NEXTVAL, p_nome, p_localizacao);
END sp_adiciona_depto;

EXECUTE sp_adiciona_depto;

EXECUTE sp_adiciona_depto('Publicidade', p_localizacao => 1200);

EXECUTE sp_adiciona_depto(p_localizacao => 1200);

CREATE OR REPLACE PROCEDURE sp_processando_emp
IS
  CURSOR emp_cursor IS
    SELECT id_empregado
    FROM tb_empregado;
BEGIN
  FOR emp_rec IN emp_cursor
  LOOP
    sp_incremento_salario(emp_rec.id_empregado, 10);
  END LOOP;
  COMMIT;
END;

EXECUTE sp_processando_emp;

SELECT nome, salario
FROM tb_empregado
WHERE ROWNUM < 5;

CREATE OR REPLACE PROCEDURE sp_inserir_empregado(
  p_nome VARCHAR2, p_sobrenome VARCHAR2,
  p_email VARCHAR2, p_telefone NUMBER,
  p_dt_admissao DATE, p_id_funcao VARCHAR2,
  p_salario NUMBER, p_percentual_comissao NUMBER,
  p_id_gerente NUMBER,
  p_id_departamento NUMBER
) IS
BEGIN
  INSERT INTO tb_empregado (id_empregado, nome, sobrenome, email, telefone, data_admissao, id_funcao, salario, percentual_comissao, id_gerente, id_departamento)
  VALUES (sq_empregado.NEXTVAL, p_nome, p_sobrenome,
  p_email, p_telefone, p_dt_admissao, p_id_funcao,
  p_salario, p_percentual_comissao, p_id_gerente,
  p_id_departamento);
  COMMIT;
END;

BEGIN
sp_inserir_empregado('Geraldo', 'Neto', 'geraldohenr22ique@usp.br', '991366323', SYSDATE - 365, 'IT_PROG', '8500', NULL, 103, 60);
END;

CREATE OR REPLACE PROCEDURE sp_remover_empregado(
  p_id_empregado NUMBER,
  p_msg OUT VARCHAR2
) IS
BEGIN
  DELETE
  FROM tb_empregado
  WHERE id_empregado = p_id_empregado;
  
  IF SQL%ROWCOUNT = 0 THEN
    p_msg := 'Nenhum empregado foi excluído';
  ELSE
    p_msg := SQL%ROWCOUNT || ' tupla(s) excluídas';
  END IF;
  
  COMMIT;
END;

SET serveroutput ON
DECLARE
  v_id_emp NUMBER;
  v_msg VARCHAR2(100);
BEGIN 
  SELECT id_empregado INTO v_id_emp
  FROM Tb_empregado
  WHERE nome = 'Geraldo'
  AND sobrenome = 'Neto';
  
  sp_remover_empregado(v_id_emp, v_msg);
  dbms_output.put_line(v_msg);
END;

CREATE OR REPLACE PROCEDURE sp_selecionar_empregado(
  p_cursor OUT SYS_REFCURSOR
) IS
BEGIN
  OPEN p_cursor FOR
  SELECT nome, sobrenome
  FROM tb_empregado;
END;

SET serveroutput ON
DECLARE
  v_cursor    SYS_REFCURSOR;
  v_nome      tb_empregado.nome%TYPE;
  v_sobrenome tb_empregado.sobrenome%TYPE;
BEGIN
  sp_selecionar_empregado(v_cursor);
  
  LOOP
    FETCH v_cursor INTO v_nome, v_sobrenome;
    EXIT WHEN v_cursor%NOTFOUND;
      dbms_output.put_line(v_nome || ' ' || v_sobrenome);
  END LOOP;
    CLOSE v_cursor;
END;

CREATE OR REPLACE PROCEDURE sp_adiciona_depto_2(p_nome VARCHAR2,
                                                p_id_gerente NUMBER, p_id_localizacao NUMBER) IS
BEGIN
  INSERT INTO tb_departamento(id_departamento,
                              nm_departamento,
                              id_gerente,
                              id_localizacao)
  VALUES
  (sq_departamento.NEXTVAL, p_nome, p_id_gerente, p_id_localizacao);
  
  dbms_output.put_line('Depto Adicionado: ' || p_nome);
  
EXCEPTION
  WHEN others THEN
    dbms_output.put_line('Erro: adicionando depto: ' || p_nome);
   
END sp_adiciona_depto_2;

CREATE OR REPLACE PROCEDURE sp_criar_depto IS
BEGIN
  sp_adiciona_depto_2('Mídia', 100, 1800);
  sp_adiciona_depto_2('Edição', 99, 1800);
  sp_adiciona_depto_2('Publicidade', 101, 1800);
END sp_criar_depto;

SET serveroutput ON
BEGIN
  sp_criar_depto;
END;

SELECT *
FROM tb_departamento
ORDER BY 1 DESC;

CREATE OR REPLACE PROCEDURE sp_adiciona_depto_sem_excep(p_nome VARCHAR2,
                                                        p_id_gerente NUMBER,
                                                        p_id_localizacao NUMBER) IS
BEGIN
  INSERT INTO tb_departamento(id_departamento, nm_departamento, id_gerente, id_localizacao)
  VALUES
  (sq_departamento.NEXTVAL, p_nome, p_id_gerente, p_id_localizacao);
  
  dbms_output.put_line('Depto adicionado: ' || p_nome);
  
END sp_adiciona_depto_sem_excep;

CREATE OR REPLACE PROCEDURE sp_criar_depto_sem_excep IS
BEGIN
  sp_adiciona_depto_sem_excep('Mídia', 100, 1800);
  sp_adiciona_depto_sem_excep('Edição', 99, 1800);
  sp_adiciona_depto_sem_excep('Publicidade', 101, 1800);
END sp_criar_depto_sem_excep;

SET serveroutput ON
BEGIN
  sp_criar_depto_sem_excep;
END;

-- ORA-02291 - "integrity constraint (%s.%s) violated - parent key not found"

DROP PROCEDURE sp_criar_depto_sem_excep;

SELECT text
FROM user_source
WHERE name = 'SP_ADICIONA_DEPTO'
AND type = 'PROCEDURE'
ORDER BY line;

SELECT object_name
FROM user_objects
WHERE object_type = 'PROCEDURE';

SET serveroutput ON
DECLARE
  TYPE emp_info IS RECORD (
    nome        tb_empregado.nome%TYPE,
    sobrenome   tb_empregado.sobrenome%TYPE,
    email       tb_empregado.email%TYPE
  );
  v_empregado_info emp_info;
BEGIN
  SELECT nome, sobrenome, email
  INTO v_empregado_info
  FROM tb_empregado
  WHERE sobrenome = 'Vargas';
  
  dbms_output.put_line('O endereço de e-mail do empregado consultado eh ' || v_empregado_info.email);
  
EXCEPTION
  WHEN no_data_found THEN
    dbms_output.put_line('Nenhum empregado corresponde ao sobrenome fornecido');
END;

SET serveroutput ON
DECLARE
  CURSOR cur_empregado IS
    SELECT nome, sobrenome, email
    FROM tb_empregado
    WHERE id_empregado = 100;
  
  v_empregado cur_empregado%ROWTYPE;

BEGIN
  OPEN cur_empregado;
  FETCH cur_empregado INTO v_empregado;
  IF cur_empregado%FOUND THEN
    CLOSE cur_empregado;
    DBMS_OUTPUT.PUT_LINE(v_empregado.nome || ' ' || v_empregado.sobrenome || ' seu email eh ' || v_empregado.email);
  ELSE
    DBMS_OUTPUT.PUT_LINE('Nenhum empregado corresponde ao ID fornecido');
  END IF;
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Nenhum empregado encontrado');
END;

SET serveroutput ON
BEGIN
  FOR emp IN (SELECT nome, sobrenome, email
              FROM tb_empregado
              WHERE percentual_comissao IS NOT NULL
              )
  LOOP
    DBMS_OUTPUT.PUT_LINE(emp.nome || ' ' || emp.sobrenome || '-' || emp.email);
  END LOOP;
END;

SET serveroutput ON
DECLARE
  CURSOR cur_emp IS
    SELECT nome, sobrenome, email
    FROM tb_empregado
    WHERE percentual_comissao IS NOT NULL;
  v_emp cur_emp%ROWTYPE;
BEGIN
  FOR v_emp IN cur_emp LOOP
    DBMS_OUTPUT.PUT_LINE(v_emp.nome || ' ' || v_emp.sobrenome || '-' || v_emp.email);
  END LOOP;
END;

SET serveroutput ON
<<obtendo_info_usuario>>
DECLARE
  v_user_name   VARCHAR2(100);
  v_ip_address  VARCHAR2(100);
BEGIN
  SELECT SYS_CONTEXT('USERENV', 'SESSION_USER'), SYS_CONTEXT('USERENV', 'IP_ADDRESS')
  INTO v_user_name, v_ip_address
  FROM dual;

  DBMS_OUTPUT.PUT_LINE('O usuário conectado eh: ' || v_user_name || ' e o endereço IP eh ' || v_ip_address );
END;

SET serveroutput ON
DECLARE
  CURSOR cur_emp IS
    SELECT nome, sobrenome, telefone
    FROM tb_empregado;
  v_emp tb_empregado%ROWTYPE;
BEGIN
  FOR v_emp IN cur_emp LOOP
    IF v_emp.telefone IS NOT NULL THEN
      DBMS_OUTPUT.PUT_LINE(RPAD(v_emp.nome || ' ' || v_emp.sobrenome, 35, '.') || v_emp.telefone);
    ELSE
      dbms_output.put_line(v_emp.nome || ' ' || v_emp.sobrenome || ' não possui número de telefone');
    END IF;
  END LOOP;
END;

CREATE OR REPLACE PROCEDURE sp_altera_depto_emp(p_id_emp IN NUMBER,
                                                p_id_depto IN NUMBER)
AS
  v_linha_emp   tb_empregado%ROWTYPE;
  v_depto       tb_departamento.nm_departamento%TYPE;
  v_contador    NUMBER := 0;
BEGIN
  SELECT COUNT(1) INTO v_contador
  FROM tb_empregado
  WHERE id_empregado = p_id_emp;
  
  IF (v_contador = 1) THEN
    SELECT * INTO v_linha_emp
    FROM tb_empregado
    WHERE id_empregado = p_id_emp;
    
    IF (v_linha_emp.id_departamento != p_id_depto) THEN
      v_linha_emp.id_departamento := p_id_depto;
      
      UPDATE tb_empregado SET ROW = v_linha_emp
      WHERE id_empregado = p_id_emp;
      
      SELECT nm_departamento INTO v_depto
      FROM tb_departamento
      WHERE id_departamento = p_id_depto;
      
      DBMS_OUTPUT.PUT_LINE('O empregado ' || v_linha_emp.nome || ' ' || v_linha_emp.sobrenome || ' se encontra alocado no: ' || v_depto );
    ELSE
      DBMS_OUTPUT.PUT_LINE('O empregado já se encontra alocado nesse depto');
    END IF;
  ELSIF (v_contador > 1) THEN
    DBMS_OUTPUT.PUT_LINE('O ID do empregado fornecido não é exclusivo');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Nenhum registro de empregado foilocalizado para esse ID');
  END IF;

EXCEPTION 
   WHEN no_data_found THEN
     DBMS_OUTPUT.PUT_LINE('ID do empregado e ou depto inválido tente novamente');
   WHEN others THEN
     DBMS_OUTPUT.PUT_LINE('Alteraão não realizada, por favor, verifique o ID e tente novamente');
  
END;

SET serveroutput ON
BEGIN
  sp_altera_depto_emp(100, 90);
END;

SET serveroutput ON
BEGIN
  sp_altera_depto_emp(100, 60);
END;

SET serveroutput ON
DECLARE
  CURSOR cur_emp_salario IS
    SELECT *
    FROM tb_empregado
    WHERE id_departamento = 60
    FOR UPDATE;
  
  v_emp_sal     cur_emp_salario%ROWTYPE;
  
BEGIN
  FOR v_emp_sal IN cur_emp_salario LOOP
    DBMS_OUTPUT.PUT_LINE('Salário antigo: '  || v_emp_sal.sobrenome || ' - ' || v_emp_sal.salario);
    
    UPDATE tb_empregado
      SET salario  = salario + (salario * .025)
    WHERE CURRENT OF cur_emp_salario;      
  END LOOP;
  
  -- Exibe os salários atualizados
  FOR v_emp_sal IN cur_emp_salario LOOP
    dbms_output.put_line('Novo salário: ' || v_emp_sal.sobrenome || ' - ' || v_emp_sal.salario);
  END LOOP;
END;

