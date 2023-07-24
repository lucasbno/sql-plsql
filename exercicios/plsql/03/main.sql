/*
1) Elabore um bloco PL/SQL que atualize a localização de um departamento existente, conforme as especificações
abaixo:
a. Faça uso de uma variável de substituição para obter o número do departamento
b. Faça uso de uma variável de substituição para obter a nova localização do departamento
c. Teste o bloco PL/SQL
d. Exibir o nome e o número do departamento, além da localização do departamento atualizado
*/

SET serveroutput ON
ACCEPT input_dep PROMPT 'Insira o número do departamento';
ACCEPT input_loc PROMPT 'Insira a localização do departamento';
DECLARE
  v_dep   NUMBER := &input_dep;
  v_loc   NUMBER := &input_loc;
  v_nome  VARCHAR2(40);
BEGIN
  SELECT nm_departamento INTO v_nome
  FROM tb_departamento
  WHERE id_departamento = v_dep;

  UPDATE tb_departamento
  SET id_localizacao = v_loc
  WHERE id_departamento = v_dep;
  COMMIT;
  
  dbms_output.put_line('A localização do departamento ' || v_nome || ' de numero '
  || v_dep || ' Foi atualizada para ' || v_loc);
END;

-------------------------------------------------------------------------------
/*
2) Elabore um bloco PL/SQL que remova o departamento criado no exercício anterior. Utilize as seguintes
especificações abaixo:
a. Utilize uma variável de substituição para obter o número do departamento
b. Exibir o número de linhas afetadas
c. Teste o bloco PL/SQL
d. O que ocorre se for informado um número de departamento inexistente?
e. Certifique de que o departamento foi removido com êxito
*/

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

--------------------------------------------------------------------------------
/*
3) Elabore um bloco PL/SQL para inserir números na TB_MENSAGENS
CREATE TABLE tb_mensagens(
resultado VARCHAR2(60));
a. Insira números inteiros de 1 a 10, excluindo 6 e 8
b. Aplique um COMMIT antes de finalizar o bloco
c. Realize uma consulta na TB_MENSAGENS para certificar-se de que o bloco PL/SQL obteve êxito no
seu propósito
*/

CREATE TABLE tb_mensagens(
  resultado VARCHAR2(60)
);

SET serveroutput ON
DECLARE
  v_count   NUMBER(2);
BEGIN
  FOR v_count IN 1..10 LOOP
    IF (NOT v_count = 6 AND NOT v_count = 8) THEN
      INSERT INTO tb_mensagens VALUES (v_count);
    END IF;
  END LOOP;
  COMMIT;
END;

SELECT * FROM tb_mensagens;

--------------------------------------------------------------------------------
/*
4) Elabore um bloco PL/SQL que calcule a comissão de um determinado empregado de acordo com o seu salário.
a. Capturar o número do funcionário como entrada do usuário por meio do uso de uma variável de
substituição
b. Caso o salário do funcionário seja inferior que R$ 1.000,00, defina o valor da comissão do funcionário
como 10% do salário
c. Se o salário do funcionário estiver entre R$ 1.000,00 e R$ 1.500,00, defina o valor da comissão do
funcionário como 15% do salário
d. Se o salário do funcionário exceder R$ 1.500,00, defina o valor da comissão do funcionário como 20%
do salário
e. Se o salário do funcionário for NULL, defina o valor da comissão do funcionário como 0 (zero)
f. Realize um COMMIT
*/

ALTER TABLE tb_empregado
ADD nova_comissao NUMBER;

SET serveroutput ON
ACCEPT input_id_funcionario PROMPT 'Insira o id do funcionario';
DECLARE
  v_id  NUMBER := &input_id_funcionario;
  v_nova_comissao NUMBER;
  v_salario NUMBER;
BEGIN
  SELECT salario INTO v_salario
  FROM tb_empregado
  WHERE id_empregado = v_id;
  
  IF (v_salario < 1000) THEN
    v_nova_comissao := v_salario * 0.10;
  ELSIF (v_salario BETWEEN 1000 AND 1500) THEN
    v_nova_comissao := v_salario * 0.15;
  ELSIF (v_salario IS NULL) THEN
    v_nova_comissao := 0;
  ELSE
    v_nova_comissao := v_salario * 0.20;
  END IF;
  
  dbms_output.put_line('salario é ' || v_salario || ' nova comissao é ' || v_nova_comissao);
  
  UPDATE tb_empregado
  SET nova_comissao = v_nova_comissao
  WHERE id_empregado = v_id;
  
  COMMIT;
END;

--------------------------------------------------------------------------------
/*
5) Elabore um bloco em PL/SQL para exibir as informações sobre um determinado departamento.
a. Declare um registro em PL/SQL de acordo com a estrutura da TB_DEPARTAMENTO
b. Faça uso de uma variável de substituição para obter todos os registros de um departamento específico e
armazene-os no registro criado em PL/SQL
c. Utilize DBMS_OUTPUT.PUT_LINE e exiba informações selecionadas sobre o departamento
*/

SET serveroutput ON
ACCEPT input_id_departamento PROMPT 'Digite o numero do departamento';
DECLARE
  TYPE tipo_reg_dep IS RECORD (
    id_departamento tb_departamento.id_departamento%TYPE,
    nm_departamento tb_departamento.nm_departamento%TYPE,
    id_gerente      tb_departamento.id_gerente%TYPE,
    id_localizacao  tb_departamento.id_localizacao%TYPE
  );
  registro_dep tipo_reg_dep;
  v_id_departamento NUMBER := &input_id_departamento;
BEGIN
  SELECT id_departamento, nm_departamento, id_gerente, id_localizacao INTO registro_dep
  FROM tb_departamento
  WHERE id_departamento = v_id_departamento;
  
  dbms_output.put_line('O id do departamento é ' || registro_dep.id_departamento ||
                       ', o nome do departamento é ' || registro_dep.nm_departamento ||
                       ', o id do gerente é ' || registro_dep.id_gerente ||
                       ' e o id da localização é ' || registro_dep.id_localizacao);
END;