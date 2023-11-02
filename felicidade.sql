CREATE database felicidade;

use felicidade;

CREATE TABLE pessoa (
    id_pessoa INT AUTO_INCREMENT PRIMARY KEY,
    permissao BOOLEAN NOT NULL,
    CPF varchar(11) NOT NULL UNIQUE,
    pessoa_nome VARCHAR(150) NOT NULL,
    data_nasc date NOT NULL,
    email VARCHAR(90) NOT NULL,
    senha VARCHAR(90) NOT NULL,
    telefone varchar(11) NOT NULL,
    endereço varchar(150),
    CEP varchar(8) NOT NULL
);

CREATE TABLE setor (
    id_setor INT AUTO_INCREMENT PRIMARY KEY,
    setor_nome varchar(45) NOT NULL UNIQUE
);

CREATE TABLE tipo_ocorrencia (
    id_tipo_ocorrencia INT AUTO_INCREMENT PRIMARY KEY,
    id_setor_fk INT, 
    tipo_ocorrencia_tipo VARCHAR(30) NOT NULL UNIQUE,
    FOREIGN KEY (id_setor_fk) REFERENCES setor(id_setor)
);

CREATE TABLE lugar (
    id_lugar INT AUTO_INCREMENT PRIMARY KEY,
    lugar_nome VARCHAR(90)
);

CREATE TABLE sub_lugar (
    id_sub_lugar INT AUTO_INCREMENT PRIMARY KEY,
    id_lugar_fk INT,
    sub_local_nome VARCHAR(90),
    foreign key (id_lugar_fk) REFERENCES lugar (id_lugar)
);

CREATE TABLE ocorrencia (
    id_ocorrencia INT AUTO_INCREMENT PRIMARY KEY,
    id_tipo_ocorrencia_fk int,
    id_pessoa_fk int,
    id_sub_lugar_fk int,
    ocorrencia_descricao TEXT NOT NULL,
    data_ocorrencia DATE NOT NULL,
    localizacao VARCHAR(100) NOT NULL,
    data_registro datetime NOT NULL,
    ocorrencia_status BOOLEAN NOT NULL,
    FOREIGN KEY (id_tipo_ocorrencia_fk) REFERENCES tipo_ocorrencia (id_tipo_ocorrencia),
    foreign key (id_sub_lugar_fk) REFERENCES sub_lugar (id_sub_lugar),
    FOREIGN KEY (id_pessoa_fk) REFERENCES pessoa(id_pessoa)
);

CREATE TABLE midia (
    id_midia INT AUTO_INCREMENT PRIMARY KEY,
    id_ocorrencia_fk INT,
    midia_descrição text NOT NULL,
    midia longblob,
    FOREIGN KEY (id_ocorrencia_fk) REFERENCES ocorrencia(id_ocorrencia)
);
