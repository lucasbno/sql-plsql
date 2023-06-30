CREATE TABLE homem (
    id_homem        INTEGER,
    nome_homem      VARCHAR2(20),
    id_mulher       INTEGER,
    CONSTRAINT pk_homem_id_homem PRIMARY KEY (id_homem),
    CONSTRAINT fk_homem_id_mulher FOREIGN KEY (id_mulher) REFERENCES mulher(id_mulher)
);

CREATE TABLE mulher (
    id_mulher       INTEGER,
    nome_mulher     VARCHAR2(20),
    CONSTRAINT pk_mulher_id_mulher PRIMARY KEY (id_mulher)
);

--------------------------------------------------------------------------------

INSERT INTO mulher (id_mulher, nome_mulher)
VALUES (1, 'Edna');
INSERT INTO mulher (id_mulher, nome_mulher)
VALUES (2, 'Stefanny');
INSERT INTO mulher (id_mulher, nome_mulher)
VALUES (3, 'Cássia');

INSERT INTO homem (id_homem, nome_homem, id_mulher)
VALUES (10, 'Anderson', NULL);
INSERT INTO homem (id_homem, nome_homem, id_mulher)
VALUES (20, 'Jander', 1);
INSERT INTO homem (id_homem, nome_homem, id_mulher)
VALUES (30, 'Rogério', 2);
--------------------------------------------------------------------------------

--3-A
SELECT h.nome_homem "Nome do marido", m.nome_mulher "Nome da esposa"
FROM homem h, mulher m
WHERE h.id_mulher = m.id_mulher;

--3-B
SELECT h.nome_homem "Nome do marido", m.nome_mulher "Nome da esposa"
FROM homem h
NATURAL JOIN mulher m;

--3-C
SELECT h.nome_homem "Nome do marido", m.nome_mulher "Nome da esposa"
FROM homem h
INNER JOIN mulher m
USING (id_mulher);

--3-D
SELECT h.nome_homem "Nome do marido", m.nome_mulher "Nome da esposa"
FROM homem h
INNER JOIN mulher m ON (h.id_mulher = m.id_mulher);

--3-E
SELECT h.nome_homem "Nome do marido", m.nome_mulher "Nome da esposa"
FROM homem h, mulher m;

SELECT h.nome_homem "Possivel marido", m.nome_mulher "Possivel esposa"
FROM homem h
CROSS JOIN mulher m;

--------------------------------------------------------------------------------
--4-A
SELECT h.nome_homem "Nome do marido", m.nome_mulher "Nome da esposa"
FROM homem h, mulher m
WHERE h.id_mulher = m.id_mulher (+);

--4-B
SELECT h.nome_homem "Nome do marido", m.nome_mulher "Nome da esposa"
FROM homem h, mulher m
WHERE h.id_mulher (+) = m.id_mulher;

--4-C
SELECT h.nome_homem "Nome do marido", m.nome_mulher "Nome da esposa"
FROM homem h
NATURAL LEFT OUTER JOIN mulher m;

--4-D
SELECT h.nome_homem "Nome do marido", m.nome_mulher "Nome da esposa"
FROM homem h
NATURAL RIGHT OUTER JOIN mulher m;

--4-E
SELECT h.nome_homem "Nome do marido", m.nome_mulher "Nome da esposa"
FROM homem h
LEFT OUTER JOIN mulher m
USING (id_mulher);

SELECT h.nome_homem "Nome do marido", m.nome_mulher "Nome da esposa"
FROM homem h
RIGHT OUTER JOIN mulher m
USING (id_mulher);

SELECT h.nome_homem "Nome do marido", m.nome_mulher "Nome da esposa"
FROM homem h
LEFT OUTER JOIN mulher m
ON (h.id_mulher = m.id_mulher);


SELECT h.nome_homem "Nome do marido", m.nome_mulher "Nome da esposa"
FROM homem h
RIGHT OUTER JOIN mulher m
ON (h.id_mulher = m.id_mulher);

--4-F
SELECT h.nome_homem "Nome do marido", m.nome_mulher "Nome da esposa"
FROM homem h
NATURAL FULL OUTER JOIN mulher m;

--4-G
SELECT h.nome_homem "Nome do marido", m.nome_mulher "Nome da esposa"
FROM homem h
FULL OUTER JOIN mulher m
USING (id_mulher);

SELECT h.nome_homem "Nome do marido", m.nome_mulher "Nome da esposa"
FROM homem h
FULL OUTER JOIN mulher m
ON (h.id_mulher = m.id_mulher);
