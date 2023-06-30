--1
  SELECT 'O identificador para ' || DS_FUNCAO || ' é o ID_FUNCAO ' || ID_FUNCAO  AS "Descrição da função"
  FROM tb_funcao;
--2
  SELECT 22/7 * (6000 * 6000) AS "Área"
  FROM DUAL;
--------------------------------------------------------------------------------
-- 3 B
-- 4 A C
-- 5 B, E 
-- 6 A, D
-- 7 B, D
-- 8 B, D
-- 9 B, D
-- 10 D
-- 11 B
-- 12 D
--------------------------------------------------------------------------------
-- 13
SELECT nm_departamento
FROM tb_departamento
WHERE nm_departamento LIKE '%ing';
--------------------------------------------------------------------------------
-- 14
SELECT DS_FUNCAO, BASE_SALARIO, TETO_SALARIO - BASE_SALARIO "Diferença"
FROM TB_FUNCAO
WHERE DS_FUNCAO LIKE '%Presidente%' OR DS_FUNCAO LIKE '%Gerente%'
ORDER BY 3 DESC, 1 ASC;
--------------------------------------------------------------------------------
-- 15
SELECT 
ID_EMPREGADO, NOME, SALARIO, SALARIO * 12 "Salario Anual",
&&v_aliquota "Aliquota atual",
&&v_aliquota * (SALARIO * 12) "Aliquota sobre o salario"
FROM tb_empregado
WHERE ID_EMPREGADO = &v_id_empregado;

UNDEFINE v_aliquota;
--------------------------------------------------------------------------------
-- 16 C
-- 17 B
-- 18 C
-- 19 B
-- 20 A, D
-- 21 C, D, E
-- 22 C
