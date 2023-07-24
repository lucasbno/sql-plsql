-- 1) Analise cada uma das declarações abaixo. Diferencie quais delas não são adequadas e explique o motivo.
  a - Válido
  b - Invalido pois deve-se declarar uma variavel por linha 
  c - Invalido pois a variavel not null nao foi inicializada
  d - Invalido pois está passando um número para uma variavel do tipo boolean 


-- 2) Analise cada uma das atribuições abaixo e determine o tipo de dado da expressão resultante.
  a - Number
  b - String
  c - String
  d - Boolean
  e - Boolean
  f - NULL

-- 3) Elabore um bloco anônimo para produzir como saída a seguinte frase “Treinamento PL/SQL Essencial” na tela.
-- Observação: utilize pelo menos uma variável
  SET serveroutput ON
  DECLARE
    v_msg VARCHAR2(30);
  BEGIN
    v_msg := 'Treinamento PL/SQL Essencial';
    dbms_output.put_line(v_msg);
  END;

--  4) Elabore um bloco anônimo que utilize duas variáveis. Atribua os valores para essas variáveis PL/SQL conforme
--     descrição abaixo e, imprima os resultados das variáveis PL/SQL na tela. Execute o bloco PL/SQL. --
  SET serveroutput ON
  DECLARE
    v_char  VARCHAR2(30);
    v_num   NUMBER(11, 2);
  BEGIN
    v_char := '42';
    v_num := to_number(substr(v_char, 1, 2));
    dbms_output.put_line(v_char);
    dbms_output.put_line(v_num);
  END;

-- 5) Analise o bloco PL/SQL abaixo e determine o tipo de dado e o valor de cada uma das variáveis de acordo com
-- as regras de escopo.
  a - Valor 2 tipo Number
  b - Valor Ocidental Europa tipo String
  c - Valor 601 tipo Number
  d - Valor 'produto 10012 esta em stoque' tipo String
  e - Null pois está fora do subbloco

  -- 6 - Exemplo de Escopo de Variáveis
  a - Valor 201 tipo Number
  b - Valor 'Joao' tipo String
  c - Valor 'Excelente' tipo String
  d - Valor 'Pedro' tipo String
  e - Valor 'Pedro' tipo String
  f - Valor 'Excelente' tipo String

-- 7 - Elabore um bloco PL/SQL que aceite dois números por meio do uso de varáveis de substituição. O primeiro
-- número deve ser dividido pelo segundo e este deve ser adicionado ao resultado. O resultado deve ser
-- armazenado em uma variável PL/SQL e exibido na tela.
  SET serveroutput ON
  v_input1 PROMPT;
  v_input2 PROMPT;
  DECLARE
    v_num_1 NUMBER(9, 2) := &v_input1;
    v_num_2 NUMBER(9, 2) := &v_input2;
    v_resultado NUMBER(9, 2);
  BEGIN
    v_resultado := (v_num_1 / v_num_2 ) + v_num_2;
    dbms_output.put_line(v_resultado);
  END;

--   8) Elabore um bloco PL/SQL que calcule a remuneração total por um ano. O salário anual e o percentual de bônus
-- anual são passados ao bloco PL/SQL por meio do uso das variáveis de substituição e o bônus precisa ser
-- convertido de um número inteiro em um número decimal (por exemplo: 15 em 1,5). Se o salário for nulo, defina-o
-- como zero antes de calcular a remuneração total. Execute o bloco PL/SQL criado por você.
-- Observação: utilize a função NVL para tratar valores nulos.
  SET serveroutput ON
  ACCEPT input_salario PROMPT 'Digite o salario'
  ACCEPT input_bonus PROMPT 'Digite o bonus'
  DECLARE
    v_salario NUMBER := &input_salario;
    v_bonus NUMBER := &input_bonus;
  BEGIN
    dbms_output.put_line(TO_CHAR(NVL(v_salario, 0) * (1 + NVL(v_bonus, 0) / 100)));
  END;

-- 9) Elabore um bloco PL/SQL que selecione o número máximo do departamento na TB_DEPARTAMENTO e
-- armazene-o em uma variável. Exibir os resultados na tela.
  SET serveroutput ON
  DECLARE
    v_max NUMBER;
  BEGIN
    SELECT MAX(id_departamento)
    INTO v_max
    FROM tb_departamento;

    dbms_output.put_line(v_max);
  END;

-- 10) Altere o bloco PL/SQL criado anteriormente para inserir uma nova linha na TB_DEPARTAMENTO.
-- a. Ao invés de exibir o número de departamento recuperado no exercício anterior, adicione 10 a esse
-- número e use-o como o número do novo departamento;
-- b. Use um parâmetro de substituição para o nome do departamento;
-- c. Por enquanto, deixe um valor nulo na localização.

  ACCEPT input_nome_departamento PROMPT 'Digite o nome do departamento'
  SET serveroutput ON
  DECLARE
    v_max tb_departamento.id_departamento%TYPE;
  BEGIN
    SELECT MAX(id_departamento) + 10
    INTO v_max
    FROM tb_departamento;
    
    INSERT INTO tb_departamento (id_departamento, nm_departamento, id_localizacao)
    VALUES (v_max, '&input_nome_departamento', NULL );
    COMMIT;
  END;