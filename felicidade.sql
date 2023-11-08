CREATE database felicidade;

use felicidade;

CREATE TABLE tb_pessoa (
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

CREATE TABLE tb_setor (
    id_setor INT AUTO_INCREMENT PRIMARY KEY,
    setor_nome varchar(45) NOT NULL UNIQUE
);

CREATE TABLE tb_tipo_ocorrencia (
    id_tipo_ocorrencia INT AUTO_INCREMENT PRIMARY KEY,
    id_setor_fk INT NOT NULL, 
    tipo_ocorrencia_nome VARCHAR(30) NOT NULL UNIQUE,
    FOREIGN KEY (id_setor_fk) REFERENCES tb_setor(id_setor)
);

CREATE TABLE tb_lugar (
    id_lugar INT AUTO_INCREMENT PRIMARY KEY,
    lugar_nome VARCHAR(90) NOT NULL UNIQUE
);

CREATE TABLE tb_sub_lugar (
    id_sub_lugar INT AUTO_INCREMENT PRIMARY KEY,
    id_lugar_fk INT NOT NULL,
    sub_lugar_nome VARCHAR(90),
    foreign key (id_lugar_fk) REFERENCES tb_lugar (id_lugar)
);

CREATE TABLE tb_ocorrencia (
    id_ocorrencia INT AUTO_INCREMENT PRIMARY KEY,
    id_tipo_ocorrencia_fk int NOT NULL,
    id_pessoa_fk int NOT NULL,
    id_sub_lugar_fk int NOT NULL,
    ocorrencia_descricao TEXT NOT NULL,
    ocorrencia_data DATE NOT NULL,
    ocorrencia_data_registro datetime NOT NULL,
    ocorrencia_status BOOLEAN NOT NULL,
    FOREIGN KEY (id_tipo_ocorrencia_fk) REFERENCES tb_tipo_ocorrencia (id_tipo_ocorrencia),
    foreign key (id_sub_lugar_fk) REFERENCES tb_sub_lugar (id_sub_lugar),
    FOREIGN KEY (id_pessoa_fk) REFERENCES tb_pessoa(id_pessoa)
);

CREATE TABLE tb_midia (
    id_midia INT AUTO_INCREMENT PRIMARY KEY,
    id_ocorrencia_fk INT,
    midia_descrição text,
    midia longblob,
    FOREIGN KEY (id_ocorrencia_fk) REFERENCES tb_ocorrencia(id_ocorrencia)
);
