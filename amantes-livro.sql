CREATE DATABASE sebo_estoque;
USE sebo_estoque;


CREATE TABLE autor (
    id_autor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL
);


CREATE TABLE categoria (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nome_categoria VARCHAR(100) NOT NULL
);

CREATE TABLE editora (
    id_editora INT PRIMARY KEY AUTO_INCREMENT,
    nome_editora VARCHAR(150) NOT NULL
);

CREATE TABLE livro (
    id_livro INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(200) NOT NULL,
    isbn VARCHAR(20),
    ano_publicacao YEAR,
    id_autor INT,
    id_editora INT,
    FOREIGN KEY (id_autor) REFERENCES autor(id_autor),
    FOREIGN KEY (id_editora) REFERENCES editora(id_editora)
);

CREATE TABLE categoria_livro(
id_livro INT,
id_categoria INT,
PRIMARY KEY(id_livro, id_categoria),
FOREIGN KEY(id_livro) REFERENCES livro(id_livro),
FOREIGN KEY(id_categoria) REFERENCES categoria(id_categoria)
);

-- ======================
-- TABELA EXEMPLAR (CADA LIVRO FÍSICO)
-- ======================

CREATE TABLE condicao (
id_condicao INT PRIMARY KEY AUTO_INCREMENT,
nome_condicao VARCHAR(50)
);

CREATE TABLE status_exemplar(
id_status INT PRIMARY KEY AUTO_INCREMENT,
nome_status VARCHAR(75)
);

CREATE TABLE exemplar (
    id_exemplar INT PRIMARY KEY AUTO_INCREMENT,
    id_livro INT NOT NULL,
    codigo_barras VARCHAR(50) UNIQUE,
    id_condicao INT NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    id_status INT NOT NULL,
    data_entrada DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_livro) REFERENCES livro(id_livro),
    FOREIGN KEY (id_condicao) REFERENCES condicao(id_condicao),
    FOREIGN KEY (id_status) REFERENCES status_exemplar(id_status)
);

-- ======================
-- TABELA FORNECEDOR
-- ======================

CREATE TABLE fornecedor (
    id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    nome_fornecedor VARCHAR(150) NOT NULL,
    telefone VARCHAR(20)
);


CREATE TABLE entrada_estoque (
    id_entrada INT PRIMARY KEY AUTO_INCREMENT,
    id_exemplar INT,
    id_fornecedor INT,
    valor_pago DECIMAL(10,2),
    data_entrada DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_exemplar) REFERENCES exemplar(id_exemplar),
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id_fornecedor)
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
