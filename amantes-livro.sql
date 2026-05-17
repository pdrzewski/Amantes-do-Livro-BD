CREATE SCHEMA IF NOT EXISTS sebo_estoques;

USE sebo_estoques;

-- =========================================================
-- AUTORES
-- =========================================================

CREATE TABLE autor (
    id_autor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL
);

-- =========================================================
-- EDITORAS
-- =========================================================

CREATE TABLE editora (
    id_editora INT AUTO_INCREMENT PRIMARY KEY,
    nome_editora VARCHAR(150) NOT NULL
);

-- =========================================================
-- LIVROS
-- ALTERAÇÕES:
-- - descricao -> sinopse
-- =========================================================

CREATE TABLE livro (
    id_livro INT AUTO_INCREMENT PRIMARY KEY,

    titulo VARCHAR(200) NOT NULL,

    isbn VARCHAR(20),

    ano_publicacao INT,

    sinopse TEXT,

    id_autor INT,

    id_editora INT,

    FOREIGN KEY (id_autor)
        REFERENCES autor(id_autor),

    FOREIGN KEY (id_editora)
        REFERENCES editora(id_editora)
);

-- =========================================================
-- CATEGORIAS
-- =========================================================

CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome_categoria VARCHAR(100) NOT NULL
);

-- =========================================================
-- RELAÇÃO LIVRO/CATEGORIA
-- =========================================================

CREATE TABLE categoria_livro (
    id_livro INT NOT NULL,
    id_categoria INT NOT NULL,

    PRIMARY KEY (id_livro, id_categoria),

    FOREIGN KEY (id_livro)
        REFERENCES livro(id_livro),

    FOREIGN KEY (id_categoria)
        REFERENCES categoria(id_categoria)
);

-- =========================================================
-- CONDIÇÕES
-- =========================================================

CREATE TABLE condicao (
    id_condicao INT AUTO_INCREMENT PRIMARY KEY,
    nome_condicao VARCHAR(50)
);

-- =========================================================
-- USUÁRIOS
-- =========================================================

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,

    usuario VARCHAR(50) NOT NULL UNIQUE,

    email VARCHAR(100) NOT NULL UNIQUE,

    senha VARCHAR(255) NOT NULL,

    nome VARCHAR(100) NOT NULL,

    ativo BOOLEAN DEFAULT TRUE,

    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- =========================================================
-- EXEMPLARES
-- ALTERAÇÕES:
-- - preco permanece aqui
-- =========================================================

CREATE TABLE exemplar (
    id_exemplar INT AUTO_INCREMENT PRIMARY KEY,

    id_livro INT NOT NULL,

    id_condicao INT NOT NULL,

    quantidade INT NOT NULL,

    preco DECIMAL(10,2) NOT NULL,

    data_entrada DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_livro)
        REFERENCES livro(id_livro)
        ON DELETE RESTRICT,

    FOREIGN KEY (id_condicao)
        REFERENCES condicao(id_condicao)
);


CREATE TABLE movimentacao (
    id_movimentacao INT PRIMARY KEY AUTO_INCREMENT,

    id_exemplar INT,

    id_usuario INT NOT NULL,

    observacao TEXT,

    data_movimentacao DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_exemplar)
        REFERENCES exemplar(id_exemplar),

    FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id)
);



-- AUTORES

INSERT INTO autor (nome) VALUES
('J.R.R. Tolkien'),
('George Orwell'),
('Stephen King'),
('J.K. Rowling'),
('Machado de Assis'),
('Frank Herbert'),
('Isaac Asimov'),
('Agatha Christie');

-- EDITORAS

INSERT INTO editora (nome_editora) VALUES
('Companhia das Letras'),
('DarkSide Books'),
('Rocco'),
('HarperCollins'),
('Suma'),
('Aleph'),
('Record');

-- CATEGORIAS

INSERT INTO categoria (nome_categoria) VALUES
('Fantasia'),
('Ficção Científica'),
('Terror'),
('Suspense'),
('Romance'),
('Distopia'),
('Drama'),
('Aventura'),
('Mistério'),
('Medieval');

-- CONDIÇÕES

INSERT INTO condicao (nome_condicao) VALUES
('Novo'),
('Seminovo'),
('Usado'),
('Danificado');

-- USUÁRIOS

INSERT INTO usuarios (
    usuario,
    email,
    senha,
    nome
) VALUES
(
    'admin',
    'admin@sebo.com',
    '$2a$10$abcdefghijklmnopqrstuv',
    'Administrador'
),
(
    'michel',
    'michel@sebo.com',
    '$2a$10$abcdefghijklmnopqrstuv',
    'Michel Tito'
);

-- LIVROS

INSERT INTO livro (
    titulo,
    isbn,
    ano_publicacao,
    sinopse,
    id_autor,
    id_editora
) VALUES
(
    'O Senhor dos Anéis',
    '9788595084742',
    1954,
    'Fantasia medieval épica envolvendo anéis mágicos, guerras entre reinos e criaturas místicas.',
    1,
    4
),
(
    '1984',
    '9788535914849',
    1949,
    'Distopia política sobre vigilância extrema, manipulação da verdade e controle social.',
    2,
    1
),
(
    'It: A Coisa',
    '9788556510785',
    1986,
    'Terror psicológico envolvendo uma entidade sobrenatural que aterroriza crianças.',
    3,
    5
),
(
    'Harry Potter e a Pedra Filosofal',
    '9788532511010',
    1997,
    'Fantasia com magia, escola de bruxos, amizade e aventuras sobrenaturais.',
    4,
    3
),
(
    'Dom Casmurro',
    '9788535902778',
    1899,
    'Clássico da literatura brasileira focado em ciúmes, romance e drama psicológico.',
    5,
    1
),
(
    'Duna',
    '9788576573135',
    1965,
    'Ficção científica épica com política, religião, guerra e exploração espacial.',
    6,
    6
),
(
    'Fundação',
    '9788576572008',
    1951,
    'Saga futurista sobre impérios galácticos, ciência e sobrevivência da humanidade.',
    7,
    6
),
(
    'Assassinato no Expresso do Oriente',
    '9788594318602',
    1934,
    'Mistério investigativo envolvendo assassinato em um trem luxuoso.',
    8,
    7
);


INSERT INTO categoria_livro VALUES (1,1);
INSERT INTO categoria_livro VALUES (1,8);
INSERT INTO categoria_livro VALUES (1,10);

INSERT INTO categoria_livro VALUES (2,6);
INSERT INTO categoria_livro VALUES (2,7);

INSERT INTO categoria_livro VALUES (3,3);
INSERT INTO categoria_livro VALUES (3,4);

INSERT INTO categoria_livro VALUES (4,1);
INSERT INTO categoria_livro VALUES (4,8);

INSERT INTO categoria_livro VALUES (5,5);
INSERT INTO categoria_livro VALUES (5,7);

INSERT INTO categoria_livro VALUES (6,2);
INSERT INTO categoria_livro VALUES (6,8);

INSERT INTO categoria_livro VALUES (7,2);

INSERT INTO categoria_livro VALUES (8,4);
INSERT INTO categoria_livro VALUES (8,9);


INSERT INTO exemplar (
    id_livro,
    id_condicao,
    quantidade,
    preco
) VALUES
(1,1,5,89.90),
(2,2,8,39.90),
(3,3,3,49.90),
(4,1,10,59.90),
(5,2,6,29.90),
(6,1,4,79.90),
(7,2,5,64.90),
(8,3,2,34.90);



INSERT INTO movimentacao (
    id_exemplar,
    id_usuario,
    observacao
) VALUES
(1,1,'Entrada inicial do estoque'),
(2,1,'Entrada inicial do estoque'),
(3,1,'Entrada inicial do estoque'),
(4,1,'Entrada inicial do estoque'),
(5,2,'Entrada inicial do estoque'),
(6,2,'Entrada inicial do estoque'),
(7,1,'Entrada inicial do estoque'),
(8,2,'Entrada inicial do estoque');
