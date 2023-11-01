CREATE database felicidade;

use felicidade;

CREATE TABLE pessoa (
    id_pessoa INT AUTO_INCREMENT PRIMARY KEY,
    permissao BOOLEAN NOT NULL,
    CPF varchar(11) NOT NULL UNIQUE,
    nome VARCHAR(150) NOT NULL,
    data_nasc date NOT NULL,
    email VARCHAR(90) NOT NULL,
    telefone varchar(11) NOT NULL,
    endereço varchar(150),
    CEP varchar(8) NOT NULL
);

CREATE TABLE setor (
    id_setor INT AUTO_INCREMENT PRIMARY KEY,
    nome_setor varchar(45) NOT NULL UNIQUE
);

CREATE TABLE tipo_ocorrencia (
	id_tipo_ocorrencia INT AUTO_INCREMENT PRIMARY KEY,
    id_setor INT, 
    tipo VARCHAR(30) NOT NULL UNIQUE,
    FOREIGN KEY (id_setor) REFERENCES setor(id_setor)
);

CREATE TABLE lugar (
	id_lugar INT AUTO_INCREMENT PRIMARY KEY,
    lugar_nome VARCHAR(90)
);

CREATE TABLE sub_lugar (
	id_sub_lugar INT AUTO_INCREMENT PRIMARY KEY,
    lugar_id INT,
    sub_local_name VARCHAR(90),
    foreign key (lugar_id) REFERENCES lugar (id_lugar)
);

CREATE TABLE ocorrencia (
    id_ocorrencia INT AUTO_INCREMENT PRIMARY KEY,
    id_tipo_ocorrencia int,
    id_pessoa_ref int,
    id_sub_lugar int,
    descricao TEXT NOT NULL,
    data_ocorrencia DATE NOT NULL,
    localizacao VARCHAR(100) NOT NULL,
    data_registro datetime NOT NULL,
    ocorrencia_status BOOLEAN NOT NULL,
    FOREIGN KEY (id_tipo_ocorrencia) REFERENCES tipo_ocorrencia (id_tipo_ocorrencia),
    foreign key (id_sub_lugar) REFERENCES sub_lugar (id_sub_lugar),
    FOREIGN KEY (id_pessoa_ref) REFERENCES pessoa(id_pessoa)
);

CREATE TABLE midia (
	id_midia INT AUTO_INCREMENT PRIMARY KEY,
    id_ocorrencia INT,
    descrição text NOT NULL,
	midia longblob,
    FOREIGN KEY (id_ocorrencia) REFERENCES ocorrencia(id_ocorrencia)
);
