
CREATE SCHEMA IF NOT EXISTS sebo_estoques;

USE sebo_estoques;

CREATE TABLE autor (
    id_autor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL
);

CREATE TABLE editora (
    id_editora INT AUTO_INCREMENT PRIMARY KEY,
    nome_editora VARCHAR(150) NOT NULL
);

CREATE TABLE livro (
    id_livro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    isbn VARCHAR(20),
    ano_publicacao INT,
    id_autor INT,
    id_editora INT,

    FOREIGN KEY (id_autor) REFERENCES autor(id_autor),
    FOREIGN KEY (id_editora) REFERENCES editora(id_editora)
);

CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome_categoria VARCHAR(100) NOT NULL
);

CREATE TABLE categoria_livro (
    id_livro INT NOT NULL,
    id_categoria INT NOT NULL,
    PRIMARY KEY (id_livro, id_categoria),

    FOREIGN KEY (id_livro) REFERENCES livro(id_livro),
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);


CREATE TABLE condicao (
    id_condicao INT AUTO_INCREMENT PRIMARY KEY,
    nome_condicao VARCHAR(50)
);





CREATE TABLE exemplar (
    id_exemplar INT AUTO_INCREMENT PRIMARY KEY,
    id_livro INT NOT NULL,
    id_condicao INT NOT NULL,
    quantidade INT NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    data_entrada DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_livro) REFERENCES livro(id_livro) ON DELETE RESTRICT,
    FOREIGN KEY (id_condicao) REFERENCES condicao(id_condicao)
    
);

CREATE TABLE tipo_movimentacao(
id_tipo INT PRIMARY KEY AUTO_INCREMENT,
nome_tipo VARCHAR(75)
);


CREATE TABLE movimentacao (
    id_movimentacao INT PRIMARY KEY AUTO_INCREMENT,
    id_exemplar INT,
    id_tipo_movimentacao INT NOT NULL,
    observacao TEXT,
    data_movimentacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_tipo_movimentacao) REFERENCES tipo_movimentacao(id_tipo),
    FOREIGN KEY (id_exemplar) REFERENCES exemplar(id_exemplar)
);


CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    ativo BOOLEAN DEFAULT TRUE,
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP
);

select * from exemplar;


INSERT INTO autor (nome) VALUES
('Machado de Assis'),
('Clarice Lispector'),
('George Orwell'),
('J.R.R. Tolkien'),
('Stephen King');

-- EDITORAS
INSERT INTO editora (nome_editora) VALUES
('Companhia das Letras'),
('Rocco'),
('Penguin Books'),
('HarperCollins'),
('Suma');

-- CATEGORIAS
INSERT INTO categoria (nome_categoria) VALUES
('Romance'),
('Fantasia'),
('Terror'),
('Ficção Científica'),
('Clássico');
-- CONDIÇÕES
INSERT INTO condicao (nome_condicao) VALUES
('Novo'),
('Seminovo'),
('Usado'),
('Danificado');

-- TIPOS DE MOVIMENTAÇÃO
INSERT INTO tipo_movimentacao (nome_tipo) VALUES
('Entrada'),
('Saída'),
('Ajuste de Estoque'),
('Perda');

-- LIVROS
INSERT INTO livro (
    titulo,
    isbn,
    ano_publicacao,
    id_autor,
    id_editora
) VALUES
(
    'Dom Casmurro',
    '9788535914849',
    1899,
    1,
    1
),
(
    'A Hora da Estrela',
    '9788532505705',
    1977,
    2,
    2
),
(
    '1984',
    '9780451524935',
    1949,
    3,
    3
),
(
    'O Senhor dos Anéis',
    '9780261102385',
    1954,
    4,
    4
),
(
    'It: A Coisa',
    '9781501142970',
    1986,
    5,
    5
);

-- RELAÇÃO CATEGORIA/LIVRO
INSERT INTO categoria_livro (id_livro, id_categoria) VALUES
(1, 5),
(1, 1),

(2, 1),

(3, 4),
(3, 5),

(4, 2),

(5, 3);

-- EXEMPLARES
INSERT INTO exemplar (
    id_livro,
    id_condicao,
    quantidade,
    preco
) VALUES
(1, 2, 5, 29.90),
(2, 1, 3, 34.50),
(3, 3, 7, 19.99),
(4, 1, 2, 89.90),
(5, 2, 4, 49.90);

-- MOVIMENTAÇÕES
INSERT INTO movimentacao (
    id_exemplar,
    id_tipo_movimentacao,
    observacao
) VALUES
(
    1,
    1,
    'Entrada inicial de estoque'
),
(
    2,
    1,
    'Compra de novos exemplares'
),
(
    3,
    2,
    'Venda de 2 unidades'
),
(
    4,
    3,
    'Correção manual de estoque'
),
(
    5,
    4,
    'Livro danificado no armazenamento'
);

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
),
(
    'funcionario1',
    'func1@sebo.com',
    '$2a$10$abcdefghijklmnopqrstuv',
    'Carlos Silva'
);





