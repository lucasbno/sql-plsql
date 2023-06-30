INSERT INTO tb_clientes
VALUES (
    12, 'Geraldo', 'Henrique', '31-JUL-1977', '800-112233', 1
);

COMMIT;

UPDATE tb_clientes
SET nome = 'José'
WHERE id_cliente = 1;

SELECT * FROM tb_clientes
ORDER BY 1;

ROLLBACK;

SELECT id_produto, preco
FROM tb_produtos
WHERE id_produto IN (4, 6); -- 13.95, 49.99

UPDATE tb_produtos
SET preco = preco * 1.20
WHERE id_produto = 4;

COMMIT;

UPDATE tb_produtos
SET preco = preco * 1.30
WHERE id_produto = 6;

SELECT id_produto, preco
FROM tb_produtos
WHERE id_produto IN (4, 6); -- 16.74, 64.99

ROLLBACK TO SAVEPOINT save1;

SELECT id_produto, preco
FROM tb_produtos
WHERE id_produto IN (4, 6);

SELECT id_produto, nm_produto, preco
FROM tb_produtos
WHERE id_produto <= 5; --40, 35, 25.99, 16.74

UPDATE tb_produtos
SET preco = preco * 0.75
WHERE id_produto <= 5;

COMMIT;

SELECT id_produto, nm_produto, preco
FROM tb_produtos
WHERE id_produto <= 5; --30, 26.25, 19.49, 12.56

--24H x 60M = 1440M
--SYSDATE - 10/1440 = DATA menos dez minutos atras

EXECUTE DBMS_FLASHBACK.ENABLE_AT_TIME(SYSDATE - 10/1440);

SELECT id_produto, nm_produto, preco
FROM tb_produtos
WHERE id_produto <= 5;

EXECUTE DBMS_FLASHBACK.DISABLE();

VARIABLE scn_atual NUMBER;

EXECUTE :scn_atual := DBMS_FLASHBACK.GET_SYSTEM_CHANGE_NUMBER();

PRINT scn_atual;

INSERT INTO tb_produtos(id_produto, id_tipo_produto, nm_produto, ds_produto, preco, fg_ativo)
VALUES (16, 1, 'Física', 'Livro sobre Física', 39.95, 1);

COMMIT;

EXECUTE DBMS_FLASHBACK.ENABLE_AT_SYSTEM_CHANGE_NUMBER(:scn_atual);

SELECT * FROM tb_produtos
WHERE id_produto = 16;

EXECUTE DBMS_FLASHBACK.DISABLE();

CREATE TABLE tb_teste (
    ID          INTEGER,
    valor       VARCHAR2(100)
);

BEGIN 
    FOR v_loop IN 1..100 LOOP
        INSERT INTO tb_teste(id, valor)
        VALUES (v_loop, 'DBA_' || v_loop);
    END LOOP;
END;

COMMIT;

SELECT * FROM tb_teste;

DROP TABLE tb_teste;

FLASHBACK TABLE tb_teste TO BEFORE DROP;

SELECT * FROM all_users;

----------------------------------- SYS USER -----------------------------------
alter session set "_ORACLE_SCRIPT"=true;

CREATE USER jean IDENTIFIED BY master;

CREATE USER henrique IDENTIFIED BY 0800
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp;

GRANT CREATE SESSION TO jean;

CREATE USER fernando IDENTIFIED BY fernando1234;
CREATE USER sonia IDENTIFIED BY sonia1234;
GRANT CREATE SESSION TO fernando, sonia;

ALTER USER jean IDENTIFIED BY senha123alterada;

GRANT CREATE SESSION, CREATE USER, CREATE TABLE TO fernando;

GRANT EXECUTE ANY PROCEDURE TO fernando WITH ADMIN OPTION;

SELECT *
FROM user_sys_privs
ORDER BY privilege;

REVOKE CREATE TABLE FROM fernando;

GRANT CREATE SYNONYM TO fernando;

GRANT CREATE SYNONYM TO loja;

GRANT CREATE PUBLIC SYNONYM TO loja;

GRANT CREATE ROLE TO loja;
GRANT CREATE USER TO loja WITH ADMIN OPTION;

CREATE ROLE gerenciamento_produtos;
CREATE ROLE gerenciamento_funcionarios;
CREATE ROLE gerenciamento_global IDENTIFIED BY senha_gerenciamento;

--------------------------  FERNANDO USER  ---------------------------------

GRANT EXECUTE ANY PROCEDURE TO sonia;

SELECT *
FROM user_sys_privs
ORDER BY privilege;

CREATE USER roberto IDENTIFIED BY roberto1234;

DROP USER roberto;

GRANT SELECT ON loja.tb_clientes TO sonia;

SELECT * FROM loja.tb_clientes;

SELECT * FROM loja.tb_compras;

CREATE SYNONYM clientes FOR loja.tb_clientes;

SELECT * FROM clientes;

--------------------------------------------------------------------------------

GRANT SELECT, INSERT, UPDATE ON tb_produtos TO fernando;
GRANT SELECT ON tb_funcionarios TO fernando;

GRANT UPDATE(sobrenome, salario) ON tb_funcionarios TO fernando;

GRANT SELECT ON tb_clientes TO fernando WITH GRANT OPTION;

GRANT SELECT ON loja.tb_clientes TO sonia;

SELECT * FROM user_tab_privs_made
WHERE table_name = 'TB_PRODUTOS';

SELECT *
FROM user_col_privs_made;

CREATE PUBLIC SYNONYM produtos FOR loja.tb_produtos;

SELECT * FROM produtos;

REVOKE INSERT ON produtos FROM fernando;

REVOKE SELECT ON loja.tb_clientes FROM fernando;
