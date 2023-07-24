SELECT sysdate FROM dual;

CREATE OR REPLACE FUNCTION fn_get_salario(
  p_id tb_empregado.id_empregado%TYPE
) RETURN NUMBER IS
v_salario tb_empregado.salario%TYPE := 0;
BEGIN
  SELECT salario INTO v_salario
  FROM tb_empregado
  WHERE id_empregado = p_id;
  
  RETURN v_salario;
  
END fn_get_salario;

SET serveroutput ON
EXECUTE dbms_output.put_line(fn_get_salario(100));

VARIABLE v_sal NUMBER
EXECUTE :v_sal := fn_get_salario(100);
PRINT v_sal;

SET serveroutput ON
DECLARE
  v_sal tb_empregado.salario%TYPE;
BEGIN
  v_sal := fn_get_salario(100);
  dbms_output.put_line(v_sal);
END;

SELECT id_funcao, fn_get_salario(id_empregado)
FROM tb_empregado;

CREATE OR REPLACE FUNCTION fn_taxa(p_valor IN NUMBER)
RETURN NUMBER IS
BEGIN
  RETURN (p_valor * 0.08);
END fn_taxa;

SELECT id_empregado, sobrenome, salario, fn_taxa(salario)
FROM tb_empregado
WHERE id_departamento = 100;

SELECT id_empregado, fn_taxa(salario)
FROM tb_empregado
WHERE fn_taxa(salario) > (SELECT MAX(fn_taxa(salario))
                          FROM tb_empregado
                          WHERE id_departamento = 30)
ORDER BY fn_taxa(salario) DESC;

CREATE OR REPLACE FUNCTION fn_dml_call_sql(p_sal NUMBER) RETURN NUMBER IS
BEGIN
  INSERT INTO tb_empregado(id_empregado, sobrenome, email, data_admissao, id_funcao, salario)
  VALUES(1, 'Sobrenome', 'jteste@connecta.com.br', SYSDATE, 'SA_MAN', p_sal);
  RETURN (p_sal + 100);
END;

UPDATE tb_empregado
  SET salario = fn_dml_call_sql(2000)
WHERE id_empregado = 170;

DECLARE
  v_sal NUMBER; 
BEGIN
  v_sal := fn_dml_call_sql(2000);
END;

CREATE OR REPLACE FUNCTION fn_recupera_email(p_id_emp tb_empregado.id_empregado%TYPE) 
    RETURN VARCHAR2
IS
  v_email   VARCHAR2(100);
BEGIN
  SELECT email INTO v_email
  FROM tb_empregado
  WHERE id_empregado = p_id_emp;
  
  RETURN v_email;
  
EXCEPTION
  WHEN no_data_found THEN
    v_email := 'Erro ao recuperar e-mail. Empregado inexistente!';
    RETURN v_email;
END;

SELECT fn_recupera_email(101)
FROM dual;

SET serveroutput ON
DECLARE
  v_email     VARCHAR2(100);
  v_id_empregado  tb_empregado.id_empregado%TYPE := 101;
BEGIN
  SELECT fn_recupera_email(v_id_empregado) INTO v_email
  FROM dual;
  
  dbms_output.put_line('ID: ' || v_id_empregado || ' e-mail: ' || v_email);
  
END;

CREATE OR REPLACE FUNCTION fn_valor_comissao (p_id_empregado NUMBER) RETURN NUMBER IS
v_valor_comissao  NUMBER;
BEGIN
  SELECT ROUND(NVL(percentual_comissao, 0) * salario, 2)
  INTO v_valor_comissao
  FROM tb_empregado
  WHERE id_empregado = p_id_empregado;
  
  RETURN v_valor_comissao;
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      v_valor_comissao := -1;
END;

SELECT nome || ' ' || sobrenome, salario, fn_valor_comissao(id_empregado) AS Valor_Comissão
FROM tb_empregado;

SELECT text
FROM USER_SOURCE
WHERE type = 'FUNCTION'
ORDER BY line;

SELECT owner, name, text
FROM ALL_SOURCE
WHERE TYPE = 'FUNCTION'
ORDER BY 1, 2, line;

SELECT object_name
FROM USER_OBJECTS
WHERE object_type = 'FUNCTION';

SELECT owner, object_name
FROM ALL_OBJECTS
WHERE object_type = 'FUNCTION';

CREATE TABLE tb_maior_menor (
  resultado   VARCHAR2(100)
);

CREATE OR REPLACE FUNCTION fn_maior_menor (a INTEGER, b INTEGER, c INTEGER) RETURN VARCHAR2 IS
  v_maior  INTEGER := a;
  v_menor  INTEGER := b;
  v_result  VARCHAR2(100);
BEGIN
  IF (v_maior < v_menor ) THEN
    v_maior := b;
    v_menor := a;
  END IF;
  
  IF (c > v_maior) THEN
    v_maior := c;
  END IF;
  
  IF (c < v_menor) THEN
    v_menor := c;
  END IF;
  
  v_result := 'O maior número é: ' || TO_CHAR(v_maior) || ' e o menor número é: ' || TO_CHAR(v_menor);
  
  INSERT INTO tb_maior_menor VALUES (v_result);
  
  RETURN v_result;
  
  COMMIT;
END;

DECLARE
  v_result VARCHAR2(100);
BEGIN
  v_result := fn_maior_menor(5, -4, 2);
  
  dbms_output.put_line(v_result);
END;

select * from tb_maior_menor;

CREATE OR REPLACE PACKAGE pkg_comissao IS
  v_comissao_padrao     NUMBER := 0.10;
  PROCEDURE sp_reset_comissao(p_nova_comissao NUMBER);
END pkg_comissao;  


CREATE OR REPLACE PACKAGE BODY pkg_comissao IS
  FUNCTION fn_validacao(p_comissao NUMBER) RETURN BOOLEAN IS
    v_comissao_maxima   tb_empregado.percentual_comissao%TYPE;
  BEGIN
    SELECT MAX(percentual_comissao) INTO v_comissao_maxima
    FROM tb_empregado;
    
    RETURN (p_comissao BETWEEN 0.0 AND v_comissao_maxima);
    
  END fn_validacao;
  
  PROCEDURE sp_reset_comissao(p_nova_comissao NUMBER) IS
  BEGIN
    IF (fn_validacao(p_nova_comissao)) THEN
      --reset variável pública (especificação)
      v_comissao_padrao := p_nova_comissao;
    ELSE
      RAISE_APPLICATION_ERROR(-20210, 'Comissão Inválida');
    END IF;    
  END sp_reset_comissao;  
END pkg_comissao;

EXECUTE pkg_comissao.sp_reset_comissao(0.15);

CREATE OR REPLACE PACKAGE pkg_const_global IS
  c_milha_to_km CONSTANT NUMBER := 1.6093;
  c_km_to_milha CONSTANT NUMBER := 0.6214;
END pkg_const_global;

SET serveroutput ON
BEGIN
  dbms_output.put_line('20 milhas = ' || 20 * pkg_const_global.c_milha_to_km || ' km');
END;


CREATE OR REPLACE FUNCTION fn_milha_to_km(p_milha NUMBER) 
  RETURN NUMBER IS
BEGIN
  RETURN (p_milha * pkg_const_global.c_milha_to_km);
END fn_milha_to_km;

SET serveroutput ON
EXECUTE dbms_output.put_line(fn_milha_to_km(1));

SELECT text
FROM user_source
WHERE name = 'PKG_COMISSAO'
AND type = 'PACKAGE';

SELECT text
FROM user_source
WHERE name = 'PKG_COMISSAO'
AND type = 'PACKAGE BODY';


CREATE OR REPLACE PACKAGE pkg_std
IS
  FUNCTION fn_to_char_aula(p_valor DATE) RETURN VARCHAR2;
  FUNCTION fn_to_char_aula(p_valor NUMBER) RETURN VARCHAR2;
END pkg_std;
/


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


SELECT pkg_std.fn_to_char_aula(SYSDATE)
FROM dual;

SELECT pkg_std.fn_to_char_aula(1)
FROM dual;

SELECT pkg_std.fn_formata_data(SYSDATE)
FROM dual;
-- ORA-00904: "PKG_STD"."FN_FORMATA_DATA": invalid identifier

SELECT nome, LTRIM(NVL(TO_CHAR(ROUND(percentual_comissao, 3), '0.99'), 'Nenhuma comissão')) AS "COMISSÃO"
FROM tb_empregado;

SELECT nome, rpad('*', salario / 1000, '*') AS "FUNCIONARIOS_E_SEUS_SALARIOS"
FROM tb_empregado
ORDER BY salario DESC;