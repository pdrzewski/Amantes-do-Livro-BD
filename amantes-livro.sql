
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


CREATE TABLE movimentacao (
    id_movimentacao INT AUTO_INCREMENT PRIMARY KEY,
    id_exemplar INT,
	tipo varchar(45),
    categoria TEXT,
    data_movimentacao DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_exemplar) REFERENCES exemplar(id_exemplar)
   
);

CREATE TABLE login (
	id_login INT AUTO_INCREMENT PRIMARY KEY,
    usuario varchar(20),
    senha varchar(30)
);

select * from exemplar;






