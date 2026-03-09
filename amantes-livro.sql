CREATE DATABASE sebo_estoque;
USE sebo_estoque;


CREATE TABLE autor (
    id_autor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL
);


CREATE TABLE categoria (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL
);


CREATE TABLE livro (
    id_livro INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(200) NOT NULL,
    isbn VARCHAR(20),
    ano_publicacao YEAR,
    id_autor INT,
    id_categoria INT,
    FOREIGN KEY (id_autor) REFERENCES autor(id_autor),
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

-- ======================
-- TABELA EXEMPLAR (CADA LIVRO FÍSICO)
-- ======================

CREATE TABLE exemplar (
    id_exemplar INT PRIMARY KEY AUTO_INCREMENT,
    id_livro INT NOT NULL,
    codigo_barras VARCHAR(50) UNIQUE,
    condicao ENUM('novo','seminovo','usado','danificado') NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    status ENUM('disponivel','reservado','vendido') DEFAULT 'disponivel',
    data_entrada DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_livro) REFERENCES livro(id_livro)
);

-- ======================
-- TABELA FORNECEDOR
-- ======================

CREATE TABLE fornecedor (
    id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
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



CREATE TABLE movimentacao (
    id_movimentacao INT PRIMARY KEY AUTO_INCREMENT,
    id_exemplar INT,
    tipo ENUM('entrada','venda','ajuste','perda') NOT NULL,
    observacao TEXT,
    data_movimentacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_exemplar) REFERENCES exemplar(id_exemplar)
);
