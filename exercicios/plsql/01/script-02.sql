SELECT a.telefone, a.nome, b.ds_funcao AS "Função", data_admissao
FROM tb_empregado a 
INNER JOIN tb_funcao b
USING (id_funcao);
