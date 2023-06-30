CREATE TABLE tb_clientes(
id_cliente INTEGER,
nome VARCHAR2(10) NOT NULL,
sobrenome VARCHAR2(10) NOT NULL,
dt_nascimento DATE,
telefone VARCHAR2(12),
fg_ativo INTEGER,
CONSTRAINT pk_tb_clientes_id_cliente PRIMARY KEY(id_cliente)
);

CREATE TABLE tb_tipos_produtos(
id_tipo_produto INTEGER ,
nm_tipo_produto VARCHAR2(10) NOT NULL,
fg_ativo INTEGER,
CONSTRAINT pk_tb_tipos_produtos_id_tipo_produto

PRIMARY KEY(id_tipo_produto)

);

CREATE TABLE tb_produtos(
id_produto INTEGER,
id_tipo_produto INTEGER,
nm_produto VARCHAR2(30) NOT NULL,
ds_produto VARCHAR2(50),
preco NUMBER(5,2),
fg_ativo INTEGER,
CONSTRAINT pk_tb_produtos_id_produto PRIMARY KEY(id_produto),
CONSTRAINT fk_tb_produtos_id_tipo_produto

FOREIGN KEY(id_tipo_produto)

REFERENCES tb_tipos_produtos(id_tipo_produto));

CREATE TABLE tb_compras(
id_produto INTEGER,
id_cliente INTEGER,
quantidade INTEGER,
fg_ativo INTEGER,
CONSTRAINT fk_tb_compras_id_produto FOREIGN KEY(id_produto)

REFERENCES tb_produtos(id_produto),

CONSTRAINT fk_tb_compras_id_cliente FOREIGN KEY(id_cliente)

REFERENCES tb_clientes(id_cliente),

CONSTRAINT pk_tb_compras_id_produto_id_cliente

PRIMARY KEY(id_produto, id_cliente));

CREATE TABLE tb_funcionarios(
id_funcionario INTEGER,
id_gerente INTEGER,
nome VARCHAR2(10) NOT NULL,
sobrenome VARCHAR2(10) NOT NULL,
cargo VARCHAR2(20),
salario NUMBER(8,2),
fg_ativo INTEGER,
CONSTRAINT pk_tb_funcionarios_id_func PRIMARY KEY(id_funcionario),
CONSTRAINT fk_tb_funcionarios_id_gerente FOREIGN KEY(id_gerente)

REFERENCES tb_funcionarios(id_funcionario));

CREATE TABLE tb_grades_salarios(
id_salario INTEGER,
base_salario NUMBER(8,2),
teto_salario NUMBER(8,2),
fg_ativo INTEGER,
CONSTRAINT pk_tb_grades_salarios_id_salario

PRIMARY KEY(id_salario)

);

--------------------------------------------------------------------

INSERT INTO tb_clientes (id_cliente, nome, sobrenome, dt_nascimento,
telefone, fg_ativo)
VALUES (1, 'John', 'Brown', '01/Jan/1965', '800-555-1211', 1);

INSERT INTO tb_clientes (id_cliente, nome, sobrenome, dt_nascimento,
telefone, fg_ativo)
VALUES (2, 'Cynthia', 'Green', '05/Feb/1968', '800-555-1212', 1);

INSERT INTO tb_clientes
VALUES (3, 'Steve', 'White', '16/Mar/1971', '800-555-1213', 1);

INSERT INTO tb_clientes (id_cliente, nome, sobrenome, dt_nascimento,
telefone, fg_ativo)
VALUES (4, 'Gail', 'Black','', '800-555-1214', 1);

INSERT INTO tb_clientes (id_cliente, nome, sobrenome, dt_nascimento,
telefone, fg_ativo)
VALUES (5, 'Doreen', 'Blue', '20/May/1970', NULL, 1);

INSERT INTO tb_clientes (id_cliente, nome, sobrenome, dt_nascimento,
telefone, fg_ativo)
VALUES (6, 'Fred', 'Brown', '01/Jan/1970', '800-555-1215', 1);

COMMIT;

INSERT INTO tb_tipos_produtos(id_tipo_produto, nm_tipo_produto,
fg_ativo)
VALUES (1, 'Book', 1);

INSERT INTO tb_tipos_produtos(id_tipo_produto, nm_tipo_produto,
fg_ativo)
VALUES (2, 'Video', 1);

INSERT INTO tb_tipos_produtos(id_tipo_produto, nm_tipo_produto,
fg_ativo)
VALUES (3, 'DVD', 1);

INSERT INTO tb_tipos_produtos(id_tipo_produto, nm_tipo_produto,
fg_ativo)
VALUES (4, 'CD', 1);

INSERT INTO tb_tipos_produtos(id_tipo_produto, nm_tipo_produto,
fg_ativo)
VALUES (5, 'Magazine', 1);

COMMIT;

INSERT INTO tb_produtos(id_produto, id_tipo_produto, nm_produto,
ds_produto, preco, fg_ativo)
VALUES (1, 1, 'Modern Science', 'A description of modern science',
19.95, 1);

INSERT INTO tb_produtos(id_produto, id_tipo_produto, nm_produto,
ds_produto, preco, fg_ativo)
VALUES (2, 1, 'Chemistry', 'Introduction to Chemistry', 30, 1);

INSERT INTO tb_produtos(id_produto, id_tipo_produto, nm_produto,
ds_produto, preco, fg_ativo)
VALUES (3, 2, 'Supernova', 'A star explodes', 25.99, 1);

INSERT INTO tb_produtos(id_produto, id_tipo_produto, nm_produto,
ds_produto, preco, fg_ativo)
VALUES (4, 2, 'Tank War', 'Action movie about a future war', 13.95,1);

COMMIT;

INSERT INTO tb_compras(id_cliente, id_produto, quantidade, fg_ativo)
VALUES (1, 1, 1, 1);

INSERT INTO tb_compras(id_cliente, id_produto, quantidade, fg_ativo)
VALUES (2, 1, 3, 1);

INSERT INTO tb_compras(id_cliente, id_produto, quantidade, fg_ativo)
VALUES (1, 4, 1, 1);

INSERT INTO tb_compras(id_cliente, id_produto, quantidade, fg_ativo)
VALUES (2, 2, 1, 1);

INSERT INTO tb_compras(id_cliente, id_produto, quantidade, fg_ativo)
VALUES (1, 3, 1, 1);

COMMIT;

INSERT INTO tb_funcionarios (id_funcionario, id_gerente, nome,
sobrenome, cargo, salario, fg_ativo)
VALUES (1, NULL, 'James', 'Smith', 'CEO', 8000.00, 1);

INSERT INTO tb_funcionarios (id_funcionario, id_gerente, nome,
sobrenome, cargo, salario, fg_ativo)
VALUES (2, 1, 'Ron', 'Johnson', 'Sales Manager', 6000.00, 1);

INSERT INTO tb_funcionarios (id_funcionario, id_gerente, nome,
sobrenome, cargo, salario, fg_ativo)
VALUES (3, 2, 'Fred', 'Hobbs', 'Salesperson', 1500.00,1 );

INSERT INTO tb_funcionarios (id_funcionario, id_gerente, nome,
sobrenome, cargo, salario, fg_ativo)
VALUES (4, 2, 'Susan', 'Jones', 'Salesperson', 5000.00,1 );

COMMIT;

INSERT INTO tb_grades_salarios (id_salario, base_salario, teto_salario,
fg_ativo)
VALUES (1, 1, 2500.00, 1);

INSERT INTO tb_grades_salarios (id_salario, base_salario, teto_salario,
fg_ativo)
VALUES (2, 2500.01, 5000.00, 1);

INSERT INTO tb_grades_salarios (id_salario, base_salario, teto_salario,
fg_ativo)
VALUES (3, 5000.01, 7500.00, 1);

INSERT INTO tb_grades_salarios (id_salario, base_salario, teto_salario,
fg_ativo)
VALUES (4, 7500.01, 9999.99, 1);

COMMIT;

INSERT INTO tb_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo) 
VALUES 
(5, 2, 'Rob', 'Green', 'Sales Person', 400000, 1);

INSERT INTO tb_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo) 
VALUES 
(6, 4, 'Jane', 'Brown', 'Support Person', 450000, 1);

INSERT INTO tb_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo) 
VALUES 
(7, 4, 'John', 'Grey', 'Support Manager', 300000, 1);

INSERT INTO tb_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo) 
VALUES 
(8, 7, 'Jean', 'Blue', 'Support Person', 290000, 1);

INSERT INTO tb_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo)  
VALUES 
(9, 6, 'Henry', 'Heyson', 'Support Person', 300000, 1);

INSERT INTO tb_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo)  
VALUES 
(10, 1, 'Kevin', 'Black', 'Ops Manager', 100000, 1);

INSERT INTO tb_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo)  
VALUES 
(11, 10, 'Keith', 'Long', 'Ops Person', 500000, 1);

INSERT INTO tb_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo)  
VALUES 
(12, 10, 'Frank', 'Howard', 'Ops Person', 450000, 1);

INSERT INTO tb_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo)  
VALUES 
(13, 10, 'Doreen', 'Penn', 'Ops Person', 470000, 1);

-- commit the transaction
COMMIT;

INSERT INTO tb_produtos (id_produto, id_tipo_produto, nm_produto, ds_produto, preco, fg_ativo) 
VALUES 
(6, 2, 'Z Files', 'Series on mysterious activities', 49.99, 1);

INSERT INTO tb_produtos (id_produto, id_tipo_produto, nm_produto, ds_produto, preco, fg_ativo) 
VALUES 
(7, 2, '2412: The Return', 'Aliens return', 14.95, 1);

INSERT INTO tb_produtos (id_produto, id_tipo_produto, nm_produto, ds_produto, preco, fg_ativo)
VALUES 
(8, 3, 'Space Force 9', 'Adventures of heroes', 13.49, 1);

INSERT INTO tb_produtos (id_produto, id_tipo_produto, nm_produto, ds_produto, preco, fg_ativo) 
VALUES 
(9, 3, 'From Another Planet', 'Alien from another planet lands on Earth', 12.99, 1);

INSERT INTO tb_produtos (id_produto, id_tipo_produto, nm_produto, ds_produto, preco, fg_ativo)
VALUES 
(10, 4, 'Classical Music', 'The best classical music', 10.99, 1);

INSERT INTO tb_produtos (id_produto, id_tipo_produto, nm_produto, ds_produto, preco, fg_ativo) 
VALUES 
(11, 4, 'Pop 3', 'The best popular music', 15.99, 1);

INSERT INTO tb_produtos (id_produto, id_tipo_produto, nm_produto, ds_produto, preco, fg_ativo) 
VALUES 
(12, 4, 'Creative Yell', 'Debut album', 14.99, 1);

INSERT INTO tb_produtos (id_produto, id_tipo_produto, nm_produto, ds_produto, preco, fg_ativo) 
VALUES 
(13, NULL, 'My Front Line', 'Their greatest hits', 13.49, 1);

-- commit the transaction
COMMIT;

CREATE TABLE tb_promocao (
  id_promocao        INTEGER CONSTRAINT pk_promocao PRIMARY KEY,
  nome               VARCHAR2(30) NOT NULL,
  duracao            INTERVAL DAY(3) TO SECOND (4)
);

INSERT INTO tb_promocao (id_promocao, nome, duracao)
VALUES 
(1, '10% off Z Files', INTERVAL '3' DAY);

INSERT INTO tb_promocao (id_promocao, nome, duracao)
VALUES 
(2, '20% off Pop 3', INTERVAL '2' HOUR);

INSERT INTO tb_promocao (id_promocao, nome, duracao)
VALUES 
(3, '30% off Modern Science', INTERVAL '25' MINUTE);

INSERT INTO tb_promocao (id_promocao, nome, duracao)
VALUES 
(4, '20% off Tank War', INTERVAL '45' SECOND);

INSERT INTO tb_promocao (id_promocao, nome, duracao)
VALUES 
(5, '10% off Chemistry', INTERVAL '3 2:25' DAY TO MINUTE);

INSERT INTO tb_promocao (id_promocao, nome, duracao)
VALUES 
(6, '20% off Creative Yell', INTERVAL '3 2:25:45' DAY TO SECOND);

INSERT INTO tb_promocao (id_promocao, nome, duracao)
VALUES 
(7, '15% off My Front Line', INTERVAL '123 2:25:45.12' DAY(3) TO SECOND(2));

COMMIT;

CREATE TABLE tb_alteracoes_produtos (
  id_produto          INTEGER,
  id_tipo_produto     INTEGER,
  nm_produto          VARCHAR2(30) NOT NULL,
  descricao           VARCHAR2(50),
  preco               NUMBER(5, 2),
  PRIMARY KEY(id_produto),
  FOREIGN KEY(id_tipo_produto) REFERENCES tb_tipos_produtos(id_tipo_produto)
);

INSERT INTO tb_alteracoes_produtos (id_produto, id_tipo_produto, nm_produto, descricao, preco) 
VALUES (1, 1, 'Modern Science', 'A description of modern science', 40.00);

INSERT INTO tb_alteracoes_produtos (id_produto, id_tipo_produto, nm_produto, descricao, preco) 
VALUES (2, 1, 'New Chemistry', 'Introduction to Chemistry', 35.00);

INSERT INTO tb_alteracoes_produtos (id_produto, id_tipo_produto, nm_produto, descricao, preco) 
VALUES (3, 1, 'Supernova', 'A star explodes', 25.99);

INSERT INTO tb_alteracoes_produtos (id_produto, id_tipo_produto, nm_produto, descricao, preco) 
VALUES (13, 2, 'Lunar Landing', 'Documentary', 15.99);

INSERT INTO tb_alteracoes_produtos (id_produto, id_tipo_produto, nm_produto, descricao, preco) 
VALUES (14, 2, 'Submarine', 'Documentary', 15.99);

INSERT INTO tb_alteracoes_produtos (id_produto, id_tipo_produto, nm_produto, descricao, preco) 
VALUES (15, 2, 'Airplane', 'Documentary', 15.99);

-- commit the transaction
COMMIT;

CREATE TABLE tb_cargos (
id_cargo  CHAR(3),
nm_cargo  VARCHAR2(20) NOT NULL,
PRIMARY KEY(id_cargo)
);

-- insert sample data into jobs table
INSERT INTO tb_cargos (id_cargo, nm_cargo) 
VALUES ('WOR', 'Worker');

INSERT INTO tb_cargos (id_cargo, nm_cargo) 
VALUES ('MGR', 'Manager');

INSERT INTO tb_cargos (id_cargo, nm_cargo) 
VALUES ('ENG', 'Engineer');

INSERT INTO tb_cargos (id_cargo, nm_cargo) 
VALUES ('TEC', 'Technologist');

INSERT INTO tb_cargos (id_cargo, nm_cargo) 
VALUES ('PRE', 'President');

-- commit the transaction
COMMIT;

CREATE TABLE tb_divisoes (
id_divisao    CHAR(3),
nm_divisao    VARCHAR2(15) NOT NULL,
PRIMARY KEY (id_divisao)
);

-- insert sample data into divisions table
INSERT INTO tb_divisoes (id_divisao, nm_divisao) 
VALUES ('SAL', 'Sales');

INSERT INTO tb_divisoes (id_divisao, nm_divisao) 
VALUES ('OPE', 'Operations');

INSERT INTO tb_divisoes (id_divisao, nm_divisao) 
VALUES ('SUP', 'Support');

INSERT INTO tb_divisoes (id_divisao, nm_divisao) 
VALUES ('BUS', 'Business');

-- commit the transaction
COMMIT;

CREATE TABLE tb_funcionarios_2 (
id_funcionario      INTEGER,
id_divisao          CHAR(3),
id_cargo            CHAR(3),
nome                VARCHAR2(10) NOT NULL,
sobrenome           VARCHAR2(10) NOT NULL,
salario             NUMBER(6,0),
PRIMARY KEY(id_funcionario),
FOREIGN KEY(id_divisao) REFERENCES tb_divisoes(id_divisao),
FOREIGN KEY(id_cargo) REFERENCES tb_cargos(id_cargo)
);

-- insert sample data into employees2 table
INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario) 
VALUES (1, 'BUS', 'PRE', 'James', 'Smith', 800000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)   
VALUES (2, 'SAL', 'MGR', 'Ron', 'Johnson', 350000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (3, 'SAL', 'WOR', 'Fred', 'Hobbs', 140000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (4, 'SUP', 'MGR', 'Susan', 'Jones', 200000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)   
VALUES (5, 'SAL', 'WOR', 'Rob', 'Green', 350000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)   
VALUES (6, 'SUP', 'WOR', 'Jane', 'Brown', 200000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)   
VALUES (7, 'SUP', 'MGR', 'John', 'Grey', 265000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (8, 'SUP', 'WOR', 'Jean', 'Blue', 110000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (9, 'SUP', 'WOR', 'Henry', 'Heyson', 125000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (10, 'OPE', 'MGR', 'Kevin', 'Black', 225000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (11, 'OPE', 'MGR', 'Keith', 'Long', 165000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)   
VALUES (12, 'OPE', 'WOR', 'Frank', 'Howard', 125000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (13, 'OPE', 'WOR', 'Doreen', 'Penn', 145000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (14, 'BUS', 'MGR', 'Mark', 'Smith', 155000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (15, 'BUS', 'MGR', 'Jill', 'Jones', 175000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (16, 'OPE', 'ENG', 'Megan', 'Craig', 245000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (17, 'SUP', 'TEC', 'Matthew', 'Brant', 115000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)   
VALUES (18, 'OPE', 'MGR', 'Tony', 'Clerke', 200000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (19, 'BUS', 'MGR', 'Tanya', 'Conway', 200000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (20, 'OPE', 'MGR', 'Terry', 'Cliff', 215000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)   
VALUES (21, 'SAL', 'MGR', 'Steve', 'Green', 275000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)   
VALUES (22, 'SAL', 'MGR', 'Roy', 'Red', 375000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)   
VALUES (23, 'SAL', 'MGR', 'Sandra', 'Smith', 335000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)   
VALUES (24, 'SAL', 'MGR', 'Gail', 'Silver', 225000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (25, 'SAL', 'MGR', 'Gerald', 'Gold', 245000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (26, 'SAL', 'MGR', 'Eileen', 'Lane', 235000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (27, 'SAL', 'MGR', 'Doreen', 'Upton', 235000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)   
VALUES (28, 'SAL', 'MGR', 'Jack', 'Ewing', 235000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (29, 'SAL', 'MGR', 'Paul', 'Owens', 245000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)   
VALUES (30, 'SAL', 'MGR', 'Melanie', 'York', 255000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)   
VALUES (31, 'SAL', 'MGR', 'Tracy', 'Yellow', 225000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (32, 'SAL', 'MGR', 'Sarah', 'White', 235000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (33, 'SAL', 'MGR', 'Terry', 'Iron', 225000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (34, 'SAL', 'MGR', 'Christine', 'Brown', 247000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (35, 'SAL', 'MGR', 'John', 'Brown', 249000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)  
VALUES (36, 'SAL', 'MGR', 'Kelvin', 'Trenton', 255000);

INSERT INTO tb_funcionarios_2 (id_funcionario, id_divisao, id_cargo, nome, sobrenome, salario)   
VALUES (37, 'BUS', 'WOR', 'Damon', 'Jones', 280000);

-- commit the transaction
COMMIT;

CREATE TABLE tb_mais_funcionarios (
id_funcionario          INTEGER,
id_gerente              INTEGER,
nome                    VARCHAR2(10) NOT NULL,
sobrenome               VARCHAR2(10) NOT NULL,
cargo                   VARCHAR2(20),
salario                 NUMBER(6, 0),
fg_ativo                INTEGER,
PRIMARY KEY (id_funcionario),
FOREIGN KEY (id_gerente) REFERENCES tb_mais_funcionarios(id_funcionario)
);

INSERT INTO tb_mais_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo)
VALUES (1, NULL, 'James', 'Smith', 'CEO', 800000, 1);
     
INSERT INTO tb_mais_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo) 
VALUES (2, 1, 'Ron', 'Johnson', 'Sales Manager', 600000, 1);

INSERT INTO tb_mais_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo) 
VALUES (3, 2, 'Fred', 'Hobbs', 'Sales Person', 200000, 1);

INSERT INTO tb_mais_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo) 
VALUES (4, 1, 'Susan', 'Jones', 'Support Manager', 500000, 1);

INSERT INTO tb_mais_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo) 
VALUES (5, 2, 'Rob', 'Green', 'Sales Person', 40000, 1);

INSERT INTO tb_mais_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo) 
VALUES (6, 4, 'Jane', 'Brown', 'Support Person', 45000, 1);

INSERT INTO tb_mais_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo) 
VALUES (7, 4, 'John', 'Grey', 'Support Manager', 30000, 1);

INSERT INTO tb_mais_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo) 
VALUES (8, 7, 'Jean', 'Blue', 'Support Person', 29000, 1);

INSERT INTO tb_mais_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo) 
VALUES (9, 6, 'Henry', 'Heyson', 'Support Person', 30000, 1);

INSERT INTO tb_mais_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo) 
VALUES (10, 1, 'Kevin', 'Black', 'Ops Manager', 100000, 1);

INSERT INTO tb_mais_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo) 
VALUES (11, 10, 'Keith', 'Long', 'Ops Person', 50000, 1);

INSERT INTO tb_mais_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo) 
VALUES (12, 10, 'Frank', 'Howard', 'Ops Person', 45000, 1);

INSERT INTO tb_mais_funcionarios (id_funcionario, id_gerente, nome, sobrenome, cargo, salario, fg_ativo) 
VALUES (13, 10, 'Doreen', 'Penn', 'Ops Person', 47000, 1);

-- commit the transaction
COMMIT;


CREATE TABLE tb_mais_produtos (
  id_produto          INTEGER,
  id_tipo_produto     INTEGER,
  nm_produto          VARCHAR2(30) NOT NULL,
  disponivel          CHAR(1),
  PRIMARY KEY (id_produto),
  FOREIGN KEY (id_tipo_produto) REFERENCES tb_tipos_produtos(id_tipo_produto)
);

INSERT INTO tb_mais_produtos (id_produto, id_tipo_produto, nm_produto, disponivel) 
VALUES (1, 1, 'Modern Science', 'Y');

INSERT INTO tb_mais_produtos (id_produto, id_tipo_produto, nm_produto, disponivel)
VALUES (2, 1, 'Chemistry', 'Y');

INSERT INTO tb_mais_produtos (id_produto, id_tipo_produto, nm_produto, disponivel) 
VALUES (3, NULL, 'Supernova', 'N');

INSERT INTO tb_mais_produtos (id_produto, id_tipo_produto, nm_produto, disponivel) 
VALUES (4, 2, 'Lunar Landing', 'N');

INSERT INTO tb_mais_produtos (id_produto, id_tipo_produto, nm_produto, disponivel) 
VALUES (5, 2, 'Submarine', 'Y');

-- commit the transaction
COMMIT;

CREATE TABLE tb_produtos_alterados(
id_produto          INTEGER,
id_tipo_produto     INTEGER,
nm_produto          VARCHAR2(30) NOT NULL,
ds_produto          VARCHAR2(50),
preco               NUMBER(5, 2),
fg_ativo            INTEGER,
PRIMARY KEY (id_produto),
FOREIGN KEY (id_tipo_produto) REFERENCES tb_tipos_produtos(id_tipo_produto)
);

INSERT INTO tb_produtos_alterados(id_produto, id_tipo_produto, nm_produto, preco, fg_ativo)
VALUES 
(1, 1, 'Modern Science',40, 1);

INSERT INTO tb_produtos_alterados(id_produto, id_tipo_produto, nm_produto, preco, fg_ativo)
VALUES 
(2, 1, 'New Chemistry',35, 1);

INSERT INTO tb_produtos_alterados(id_produto, id_tipo_produto, nm_produto, preco, fg_ativo)
VALUES 
(3, 1, 'Super Nova',25.99, 1);

INSERT INTO tb_produtos_alterados(id_produto, id_tipo_produto, nm_produto, preco, fg_ativo)
VALUES 
(13, 2, 'Lunar Landing',15.99, 1);

INSERT INTO tb_produtos_alterados(id_produto, id_tipo_produto, nm_produto, preco, fg_ativo)
VALUES 
(14, 2, 'Submarine',15.99, 1);

INSERT INTO tb_produtos_alterados(id_produto, id_tipo_produto, nm_produto, preco, fg_ativo)
VALUES 
(15, 2, 'Airplane',15.99, 1);

COMMIT;



