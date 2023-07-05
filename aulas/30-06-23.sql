GRANT SELECT, INSERT, UPDATE, DELETE
ON tb_tipos_produtos TO gerenciamento_produtos1;

GRANT SELECT, INSERT, UPDATE, DELETE
ON tb_produtos TO gerenciamento_produtos1;

GRANT SELECT, INSERT, UPDATE, DELETE
ON tb_grades_salarios TO gerenciamento_funcionarios1;

GRANT SELECT, INSERT, UPDATE, DELETE
ON tb_funcionarios TO gerenciamento_funcionarios1;

GRANT CREATE USER TO gerenciamento_funcionarios1;

GRANT gerenciamento_produtos1, gerenciamento_funcionarios1 TO gerenciamento_global1;

SELECT * FROM role_sys_privs
ORDER BY privilege;

SELECT *
FROM role_tab_privs
WHERE ROLE = 'GERENCIAMENTO_GLOBAL1'
ORDER BY table_name;

GRANT gerenciamento_global1 TO fernando;

SET ROLE NONE;

SET ROLE ALL EXCEPT gerenciamento_global1;

REVOKE gerenciamento_global1 FROM fernando;

REVOKE ALL ON tb_produtos FROM gerenciamento_produtos1;
REVOKE ALL ON tb_tipos_Produtos FROM gerenciamento_produtos1;

DROP ROLE gerenciamento_global1;
DROP ROLE gerenciamento_produtos1;
DROP ROLE gerenciamento_funcionarios1;

DROP ROLE gerenciamento_global;

CREATE TABLE teste1 (
    id  NUMBER,
    nome    VARCHAR2(30)
);

SELECT username, extended_timestamp, audit_option
FROM user_audit_trail
WHERE audit_option = 'CREATE TABLE';

SELECT username, extended_timestamp, action_name
FROM user_audit_trail
WHERE action_name = 'CREATE TABLE'
ORDER BY 2 DESC;