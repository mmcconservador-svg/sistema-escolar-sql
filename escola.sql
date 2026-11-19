-- =====================================================================
-- Sistema Escolar - Projeto de banco de dados (MySQL)
-- Script completo: esquema, tabelas, INSERT, UPDATE, DELETE e VIEWs
-- =====================================================================

-- ---------------------------------------------------------------------
-- PASSO 2.1 - Criar o banco de dados e selecioná-lo
-- ---------------------------------------------------------------------
DROP DATABASE IF EXISTS escola;
CREATE DATABASE escola CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE escola;

-- ---------------------------------------------------------------------
-- PASSO 2.2 - Tabela PROFESSORES
-- ---------------------------------------------------------------------
CREATE TABLE professores (
    id_professor INT          NOT NULL AUTO_INCREMENT,
    nome         VARCHAR(100) NOT NULL,
    email        VARCHAR(100) NOT NULL,
    disciplina   VARCHAR(50)  NOT NULL,
    telefone     VARCHAR(15),
    PRIMARY KEY (id_professor),
    UNIQUE KEY uq_professores_email (email)
);
DESCRIBE professores;

-- ---------------------------------------------------------------------
-- PASSO 2.3 - Tabela TURMAS  (turno VARCHAR(20), igual ao diagrama)
-- ---------------------------------------------------------------------
CREATE TABLE turmas (
    id_turma INT         NOT NULL AUTO_INCREMENT,
    nome     VARCHAR(50) NOT NULL,
    serie    VARCHAR(20) NOT NULL,
    turno    VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_turma)
);
DESCRIBE turmas;

-- ---------------------------------------------------------------------
-- PASSO 2.4 - Tabela ALUNOS (depende de turmas)
-- ---------------------------------------------------------------------
CREATE TABLE alunos (
    id_aluno             INT          NOT NULL AUTO_INCREMENT,
    nome                 VARCHAR(100) NOT NULL,
    data_nascimento      DATE         NOT NULL,
    responsavel          VARCHAR(100) NOT NULL,
    telefone_responsavel VARCHAR(15),
    id_turma             INT          NOT NULL,
    PRIMARY KEY (id_aluno),
    CONSTRAINT fk_alunos_turmas
        FOREIGN KEY (id_turma) REFERENCES turmas (id_turma)
);
DESCRIBE alunos;

-- ---------------------------------------------------------------------
-- PASSO 2.5 - Tabela PROFESSORES_TURMAS (relação N:N, PK composta)
-- ---------------------------------------------------------------------
CREATE TABLE professores_turmas (
    id_professor INT NOT NULL,
    id_turma     INT NOT NULL,
    PRIMARY KEY (id_professor, id_turma),
    CONSTRAINT fk_prof_turmas_professores
        FOREIGN KEY (id_professor) REFERENCES professores (id_professor),
    CONSTRAINT fk_prof_turmas_turmas
        FOREIGN KEY (id_turma) REFERENCES turmas (id_turma)
);
SHOW TABLES;

-- ---------------------------------------------------------------------
-- PASSO 3.1 - Inserir PROFESSORES
-- ---------------------------------------------------------------------
INSERT INTO professores (nome, email, disciplina, telefone) VALUES
('Carlos Silva',  'carlos.silva@escola.com',  'Matemática',      '11987654321'),
('Maria Santos',  'maria.santos@escola.com',  'Português',       '11976543210'),
('João Oliveira', 'joao.oliveira@escola.com', 'História',        '11965432109'),
('Ana Costa',     'ana.costa@escola.com',     'Ciências',        '11954321098'),
('Paulo Lima',    'paulo.lima@escola.com',    'Educação Física', '11943210987');
SELECT * FROM professores;

-- ---------------------------------------------------------------------
-- PASSO 3.2 - Inserir TURMAS
-- ---------------------------------------------------------------------
INSERT INTO turmas (nome, serie, turno) VALUES
('6A', '6º ano', 'manhã'),
('7B', '7º ano', 'tarde'),
('8A', '8º ano', 'manhã'),
('9C', '9º ano', 'tarde');
SELECT * FROM turmas;

-- ---------------------------------------------------------------------
-- PASSO 3.3 - Inserir ALUNOS (datas no formato AAAA-MM-DD)
-- ---------------------------------------------------------------------
INSERT INTO alunos (nome, data_nascimento, responsavel, telefone_responsavel, id_turma) VALUES
('Pedro Alves',      '2010-03-15', 'Roberto Alves',    '11999887766', 1),
('Júlia Mendes',     '2010-05-20', 'Carla Mendes',     '11988776655', 1),
('Lucas Rocha',      '2010-08-10', 'Fernanda Rocha',   '11977665544', 1),
('Beatriz Souza',    '2009-02-28', 'Marcos Souza',     '11966554433', 2),
('Gabriel Lima',     '2009-07-12', 'Patrícia Lima',    '11955443322', 2),
('Mariana Costa',    '2009-11-05', 'José Costa',       '11944332211', 2),
('Rafael Santos',    '2008-01-18', 'Ana Santos',       '11933221100', 3),
('Larissa Oliveira', '2008-04-22', 'Paulo Oliveira',   '11922110099', 3),
('Felipe Martins',   '2008-09-30', 'Sandra Martins',   '11911009988', 3),
('Camila Ferreira',  '2008-12-15', 'Ricardo Ferreira', '11900998877', 3),
('Thiago Ribeiro',   '2007-03-08', 'Juliana Ribeiro',  '11899887766', 4),
('Amanda Silva',     '2007-06-25', 'Carlos Silva',     '11888776655', 4),
('Bruno Carvalho',   '2007-10-14', 'Márcia Carvalho',  '11877665544', 4),
('Isabela Gomes',    '2007-12-20', 'Fernando Gomes',   '11866554433', 4),
('Vitor Pereira',    '2008-02-11', 'Lúcia Pereira',    '11855443322', 4);
SELECT COUNT(*) AS total_alunos FROM alunos;   -- deve ser 15

-- ---------------------------------------------------------------------
-- PASSO 3.4 - Associar PROFESSORES às TURMAS
-- ---------------------------------------------------------------------
INSERT INTO professores_turmas (id_professor, id_turma) VALUES
(1, 1), (2, 1), (4, 1),
(1, 2), (2, 2), (3, 2),
(1, 3), (3, 3), (5, 3),
(2, 4), (3, 4), (4, 4);
SELECT * FROM professores_turmas;

-- ---------------------------------------------------------------------
-- PASSO 4.1 - Pedro (id=1) mudou para a turma 7B (id=2)
-- ---------------------------------------------------------------------
UPDATE alunos SET id_turma = 2 WHERE id_aluno = 1;
SELECT nome, id_turma FROM alunos WHERE id_aluno = 1;

-- ---------------------------------------------------------------------
-- PASSO 4.2 - Novo telefone do professor Carlos (id=1)
-- ---------------------------------------------------------------------
UPDATE professores SET telefone = '11999999999' WHERE id_professor = 1;
SELECT nome, telefone FROM professores WHERE id_professor = 1;

-- ---------------------------------------------------------------------
-- PASSO 4.3 - Turma 8A (id=3) passou para a tarde
-- ---------------------------------------------------------------------
UPDATE turmas SET turno = 'tarde' WHERE id_turma = 3;
SELECT * FROM turmas WHERE id_turma = 3;

-- ---------------------------------------------------------------------
-- PASSO 5.1 - Remover o aluno Vitor (id=15)
-- ---------------------------------------------------------------------
DELETE FROM alunos WHERE id_aluno = 15;
SELECT COUNT(*) AS total_alunos FROM alunos;   -- deve ser 14

-- ---------------------------------------------------------------------
-- PASSO 5.2 - Remover a associação do professor Paulo (5) com a turma 8A (3)
-- ---------------------------------------------------------------------
DELETE FROM professores_turmas WHERE id_professor = 5 AND id_turma = 3;
SELECT * FROM professores_turmas WHERE id_professor = 5;   -- vazio

-- ---------------------------------------------------------------------
-- PASSO 5.3 - DESAFIO: tentar excluir a turma 6A (id=1)
-- Este comando DÁ ERRO de propósito (erro 1451 - chave estrangeira).
-- Está comentado para o script continuar rodando no Workbench.
-- Para testar, remova os "-- " da linha abaixo e execute-a sozinha:
-- ---------------------------------------------------------------------
-- DELETE FROM turmas WHERE id_turma = 1;
--
-- Resposta: Não foi possível excluir a turma porque existem alunos
-- vinculados a ela através da chave estrangeira. Para excluir a turma,
-- seria necessário primeiro remover ou realocar todos os alunos.

-- ---------------------------------------------------------------------
-- PASSO 6.1 - VIEW: lista de alunos
-- ---------------------------------------------------------------------
CREATE VIEW vw_lista_alunos AS
SELECT t.nome  AS turma,
       t.serie AS serie,
       a.nome  AS aluno
FROM alunos a
INNER JOIN turmas t ON t.id_turma = a.id_turma
ORDER BY t.nome, a.nome;
SELECT * FROM vw_lista_alunos;

-- ---------------------------------------------------------------------
-- PASSO 6.2 - VIEW: professores por turma
-- ---------------------------------------------------------------------
CREATE VIEW vw_professores_turmas AS
SELECT t.nome       AS turma,
       p.nome       AS professor,
       p.disciplina AS disciplina
FROM professores_turmas pt
INNER JOIN professores p ON p.id_professor = pt.id_professor
INNER JOIN turmas      t ON t.id_turma     = pt.id_turma
ORDER BY t.nome, p.nome;
SELECT * FROM vw_professores_turmas;

-- ---------------------------------------------------------------------
-- PASSO 6.3 - VIEW: total de alunos por turma
-- ---------------------------------------------------------------------
CREATE VIEW vw_total_alunos_turma AS
SELECT t.nome  AS turma,
       t.serie AS serie,
       t.turno AS turno,
       COUNT(a.id_aluno) AS total_alunos
FROM turmas t
LEFT JOIN alunos a ON a.id_turma = t.id_turma
GROUP BY t.id_turma, t.nome, t.serie, t.turno
ORDER BY t.nome;
SELECT * FROM vw_total_alunos_turma;

-- ---------------------------------------------------------------------
-- PASSO 6.4 - VIEW: alunos menores de idade
-- ---------------------------------------------------------------------
CREATE VIEW vw_alunos_menores AS
SELECT a.nome AS aluno,
       a.data_nascimento,
       TIMESTAMPDIFF(YEAR, a.data_nascimento, CURDATE()) AS idade,
       a.responsavel,
       a.telefone_responsavel
FROM alunos a
WHERE TIMESTAMPDIFF(YEAR, a.data_nascimento, CURDATE()) < 18
ORDER BY a.nome;
SELECT * FROM vw_alunos_menores;
