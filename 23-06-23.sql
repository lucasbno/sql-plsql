-- DECODE(x, y, a, b) if x == y return a if not return b
SELECT DECODE (1, 2, 1, 3)
FROM dual;

-- DECODE(x, y, a, b) if x == y return a if not return b
SELECT id_produto, disponivel, DECODE(disponivel, 'Y', 'Produto está disponivel', 'Produto não está disponivel')
FROM tb_mais_produtos;

-- DECODE(x, y, a, y, a, y, a, y, a... b) if x == y return a if not return b
SELECT id_produto, id_tipo_produto, DECODE(id_tipo_produto, 1, 'Book', 2, 'Video', 3, 'DVD', 4,'CD', 'Magazine')
FROM tb_produtos;

SELECT id_produto, id_tipo_produto,
CASE id_tipo_produto
    WHEN 1 THEN 'Book'
    WHEN 2 THEN 'Video'
    WHEN 3 THEN 'DVD'
    WHEN 4 THEN 'CD'
    ELSE 'Magazine'
END
FROM tb_produtos;

SELECT id_produto, preco,
CASE
    WHEN preco > 15.00 THEN 'Caro'
    ELSE 'Barato'
END AS "Status"
FROM tb_produtos;

SELECT * FROM tb_mais_funcionarios;

SELECT id_funcionario, id_gerente, nome, sobrenome
FROM tb_mais_funcionarios
START WITH id_funcionario = 1
CONNECT BY PRIOR id_funcionario = id_gerente
ORDER BY 1;

SELECT LEVEL, id_funcionario, id_gerente, nome, sobrenome
FROM tb_mais_funcionarios
START WITH id_funcionario = 1
CONNECT BY PRIOR id_funcionario = id_gerente
ORDER BY LEVEL;

SELECT COUNT(DISTINCT(LEVEL)) AS "Níveis na Árvore"
FROM tb_mais_funcionarios
START WITH id_funcionario = 1
CONNECT BY PRIOR id_funcionario = id_gerente;

SELECT LEVEL, LPAD(' ', 2 * LEVEL -1) || nome || ' ' || sobrenome AS funcionario
FROM tb_mais_funcionarios
START WITH id_funcionario = 1
CONNECT BY PRIOR id_funcionario = id_gerente;

SELECT LEVEL, LPAD(' ', 2 * level - 1) || nome || ' ' || sobrenome AS funcionario
FROM tb_mais_funcionarios
START WITH sobrenome = 'Jones'
CONNECT BY PRIOR id_funcionario = id_gerente;

SELECT LEVEL, LPAD(' ', 2 * level - 1) || nome || ' ' || sobrenome AS funcionario
FROM tb_mais_funcionarios
START WITH id_funcionario = 4
CONNECT BY PRIOR id_funcionario = id_gerente;

SELECT LEVEL, LPAD(' ', 2 * LEVEL - 1) || nome || ' ' || sobrenome AS funcionario
FROM tb_mais_funcionarios
START WITH id_funcionario = (SELECT id_funcionario
                             FROM tb_mais_funcionarios
                             WHERE nome = 'Kevin'
                             AND sobrenome = 'Black')
CONNECT BY PRIOR id_funcionario = id_gerente;

SELECT LEVEL, LPAD(' ', 2 * LEVEL - 1) || nome || ' ' || sobrenome AS funcionario
FROM tb_mais_funcionarios
START WITH sobrenome = 'Blue'
CONNECT BY PRIOR id_gerente = id_funcionario;

SELECT LEVEL, LPAD (' ', 2 * LEVEL - 1) || nome || ' ' || sobrenome AS funcionario
FROM tb_mais_funcionarios
WHERE sobrenome != 'Johnson'
START WITH id_funcionario = 1
CONNECT BY PRIOR id_funcionario = id_gerente;

SELECT LEVEL, LPAD(' ', 2 * level - 1) || nome || ' ' || sobrenome AS funcionario, salario
FROM tb_mais_funcionarios
WHERE salario <= 50000.00
START WITH id_funcionario = 1
CONNECT BY PRIOR id_funcionario = id_gerente;

SELECT id_divisao, SUM(salario)
FROM tb_funcionarios_2
GROUP BY id_divisao
ORDER BY id_divisao;

SELECT id_divisao, SUM(salario)
FROM tb_funcionarios_2
GROUP BY ROLLUP (id_divisao)
ORDER BY id_divisao;

SELECT id_divisao, id_cargo, ROUND(AVG(salario), 3)
FROM tb_funcionarios_2
GROUP BY ROLLUP (id_divisao, id_cargo)
ORDER BY id_divisao, id_cargo;

SELECT GROUPING(id_divisao), id_divisao, SUM(salario)
FROM tb_funcionarios_2
GROUP BY ROLLUP(id_divisao)
ORDER BY id_divisao;

SELECT
CASE GROUPING(id_divisao)
    WHEN 1 THEN 'Todas as Divisões'
    ELSE id_divisao
END AS DIV, SUM(salario) AS "Soma do salario"
FROM tb_funcionarios_2
GROUP BY ROLLUP(id_divisao)
ORDER BY id_divisao;

SELECT
CASE GROUPING(id_divisao)
    WHEN 1 THEN 'Todas as Divisões'
    ELSE id_divisao
END AS Divisão,
CASE GROUPING(id_cargo)
    WHEN 1 THEN 'Todos os cargos'
    ELSE id_cargo
END AS CARGO, SUM(salario)
FROM tb_funcionarios_2
GROUP BY ROLLUP(id_divisao, id_cargo)
ORDER BY id_divisao, id_cargo;

SELECT
    CASE GROUPING(id_divisao)
      WHEN 1 THEN 'Todas as Divisões'
      ELSE id_divisao
    END AS Divisão,
    CASE GROUPING(id_cargo)
      WHEN 1 THEN 'Todos os Cargos'
      ELSE id_cargo
    END AS Cargo, SUM(salario)
FROM tb_funcionarios_2
GROUP BY CUBE(id_divisao, id_cargo)
ORDER BY id_divisao, id_cargo;

SELECT id_divisao, id_cargo, SUM(salario)
FROM tb_funcionarios_2
GROUP BY GROUPING SETS(id_divisao, id_cargo)
ORDER BY id_divisao, id_cargo;

--------------------------------------------------------------------------------

INSERT INTO tb_clientes (id_cliente, nome, sobrenome, dt_nascimento, telefone, fg_ativo)
VALUES (7, 'Joaquim', 'Silva', '26-FEB-1977', '800-666-2522', 1);

INSERT INTO tb_clientes
VALUES (8, 'Jane', 'Green', '01-JAN-1970', '800-555-9999', 1);

INSERT INTO tb_clientes
VALUES(9, 'Sophie', 'White', NULL, NULL, 1);

INSERT INTO tb_clientes
VALUES (10, 'kyle', '')
10 kyle omalley null null 1

INSERT INTO tb_produtos (id_produto, id_tipo_produto, nm_produto, ds_produto, preco, fg_ativo)
VALUES (14, 1, 'The "Great" Gatsby', NULL, 12.99, 1);

SELECT * FROM tb_clientes;

SET serveroutput ON

DECLARE media_preco_produto NUMBER;

BEGIN
  UPDATE tb_produtos
     SET preco = preco * 0.75
     RETURNING AVG(preco) INTO media_preco_produto;
     
  DBMS_OUTPUT.PUT_LINE('Valor da variável: ' || media_preco_produto);   
END;

DELETE
FROM tb_clientes
WHERE id_cliente = 10;

ROLLBACK;


-- Violates constraint primary key duplicated
INSERT INTO tb_clientes(id_cliente, nome, sobrenome, dt_nascimento, telefone, fg_ativo)
VALUES (1, 'Jason', 'Price', '01-JAN-60', '800-555-1211', 1);

-- Violates constraint primary key duplicated
UPDATE tb_clientes
SET id_cliente = 1
WHERE id_cliente = 2;

-- ORA-02291: integrity constraint (LOJA.FK_TB_PRODUTOS_ID_TIPO_PRODUTO) violated - parent key not found
INSERT INTO tb_produtos(id_produto, id_tipo_produto, nm_produto, ds_produto, preco, fg_ativo)
VALUES (15, 6, 'Teste', 'Teste', NULL, 1);

--ORA-02291: integrity constraint (LOJA.FK_TB_PRODUTOS_ID_TIPO_PRODUTO) violated - parent key not found
UPDATE tb_produtos
SET id_tipo_produto = 6
WHERE id_produto = 2;

--ORA-02292: integrity constraint (LOJA.SYS_C008394) violated - child record found
DELETE FROM tb_tipos_produtos
WHERE id_tipo_produto = 1;

CREATE TABLE tb_status_encomenda (
    id_status_encomenda     INTEGER,
    status                  VARCHAR2(40) DEFAULT 'Encomenda disponibilizada' NOT NULL,
    ultima_modificacao      DATE DEFAULT SYSDATE,
    PRIMARY KEY (id_status_encomenda)
);

INSERT INTO tb_status_encomenda(id_status_encomenda)
VALUES(1);

INSERT INTO tb_status_encomenda(id_status_encomenda, status, ultima_modificacao)
VALUES (2, 'Encomenda enviada', '01-MAY-2013');

UPDATE tb_status_encomenda
SET status = DEFAULT
WHERE id_status_encomenda = 2;

SELECT * FROM tb_status_encomenda;

SELECT * FROM tb_produtos_alterados;

MERGE INTO tb_produtos p
USING tb_produtos_alterados pa ON (p.id_produto = pa.id_produto)
WHEN MATCHED THEN
    UPDATE
    SET
    p.id_tipo_produto = pa.id_tipo_produto,
    p.nm_produto = pa.nm_produto,
    p.ds_produto = pa.ds_produto,
    p.preco = pa.preco,
    p.fg_ativo = pa.fg_ativo
WHEN NOT MATCHED THEN
    INSERT (
        p.id_produto, p.id_tipo_produto, p.nm_produto,
        p.ds_produto, p.preco, p.fg_ativo )
    VALUES (
        pa.id_produto, pa.id_tipo_produto, pa.nm_produto,
        pa.ds_produto, pa.preco, pa.fg_ativo
    );

COMMIT;








