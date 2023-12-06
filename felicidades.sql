CREATE database IF NOT EXISTS felicidade;

-- DROP DATABASE felicidade;
use felicidade;

CREATE TABLE IF NOT EXISTS tb_pessoa (
    pessoa_id_pessoa INT AUTO_INCREMENT PRIMARY KEY,
    pessoa_permissao BOOLEAN NOT NULL,
    pessoa_CPF VARCHAR(11) NOT NULL UNIQUE,
    pessoa_nome VARCHAR(150) NOT NULL,
    pessoa_data_nasc date NOT NULL,
    pessoa_email VARCHAR(90) NOT NULL,
    pessoa_senha VARCHAR(90) NOT NULL,
    pessoa_telefone VARCHAR(11),
    pessoa_RA VARCHAR(8) unique
);

CREATE TABLE IF NOT EXISTS tb_setor (
    id_setor INT AUTO_INCREMENT PRIMARY KEY,
    setor_nome varchar(45) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS tb_tipo_ocorrencia (
    id_tipo_ocorrencia INT AUTO_INCREMENT PRIMARY KEY,
    id_setor_fk INT NOT NULL, 
    tipo_ocorrencia_nome VARCHAR(45) NOT NULL UNIQUE,
    FOREIGN KEY (id_setor_fk) REFERENCES tb_setor(id_setor)
);

CREATE TABLE IF NOT EXISTS tb_lugar (
    id_lugar INT AUTO_INCREMENT PRIMARY KEY,
    lugar_nome VARCHAR(90) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS tb_sub_lugar (
    id_sub_lugar INT AUTO_INCREMENT PRIMARY KEY,
    id_lugar_fk INT NOT NULL,
    sub_lugar_nome VARCHAR(90) NOT NULL,
    foreign key (id_lugar_fk) REFERENCES tb_lugar (id_lugar)
);

CREATE TABLE IF NOT EXISTS tb_ocorrencia (
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
    FOREIGN KEY (id_pessoa_fk) REFERENCES tb_pessoa(pessoa_id_pessoa)
);

CREATE TABLE IF NOT EXISTS tb_midia (
    id_midia INT AUTO_INCREMENT PRIMARY KEY,
    id_ocorrencia_fk INT NOT NULL,
    midia_descricao text,
    midia longblob NOT NULL,
    FOREIGN KEY (id_ocorrencia_fk) REFERENCES tb_ocorrencia(id_ocorrencia)
);

INSERT INTO tb_pessoa(pessoa_permissao,pessoa_CPF,pessoa_nome,pessoa_data_nasc,pessoa_email,pessoa_senha,pessoa_telefone,pessoa_RA) VALUES 
    (true,'14375943859','Arthur Arash Heidari','1997-05-24','arthur.arash@sempreceub.com','3c5ea4769c6160dfca95af6c4ddd1c5714360137','61986241548','22209170'),
    (false,'14375943857','Guilherme Nobrega Gomes Dantas','2003-09-16','guilherme.nobrega@sempreceub.com','d3203512b024f45dd11b0c4087c4aebba1b64263','61982453661','22201381'),
    (false,'14375943856','Lucas David Carvalho Vieira De Matos','2003-09-15','lucas.david@sempreceub.com','480079dc8b61724ac80d0d08988f6aaf53966750','61982454947','22255032'),
    (true,'14375943858','Vinicius Gurgel Serrao','2003-05-01','vinicius.gurgel@sempreceub.com','6643029389643fe4f9225b402a2d66dc1abb4b50','61981479944','22207295'),
    (false,'14375943855','Guilherme Claudio','2003-09-25','gui.clau09@sempreceub.com','5ff04542276e15c9e941963a7ca2d74b33b25afc','61948123433','22203662'),
    (false,'14375943854','Humberto Nascimento Santos Junior','2004-06-16','humberto.nj@sempreceub.com','5f1a7be72de2a8324c9bc977d432325ed3a4adc7','79991135630','22264943'),
    (true,'14375943853','Guilherme Paes','2003-08-28','guilhermehzf@sempreceub.com','0fece84f4e944ede78c9824d7c9d7d9d58285007','61998072040','22250592'),
    (false,'14375943852','Raul Erick Cordeiro Alves','2003-06-28','raulerick@sempreceub.com','1c536b62b034b260d4b1fa2a6d638c5174a0f0d5','61983545388','22207984'),
    (false,'14375943851','Felipe Soares Alencar Trindade','2003-06-28','damnbruh@sempreceub.com','adbea3f929d0e9a6e4f2d7959ec95e9f5d2f6c9c','61983546388','22212059'),
    (false,'14375943850','Giovanni Leles Nogueira','2003-05-02','hexadem@sempreceub.com','bc1871e408dcd6310bce6c641c74d656d292d897','61945546388','22287954'),
    (false, '12345678901', 'Ana Silva Santos', '1995-03-18', 'ana@sempreceub.com', 'beec983e1d29e81bde7148cec004bbbc9e1034f5', '9876543210','22287955'),
    (false, '23456789012', 'Bruno Oliveira Lima', '1990-08-22', 'bruno@sempreceub.com', '04556b581f269b79f4ed5801f8532331c7cffaf5', '1234567890','22287956'),
    (false, '34567890123', 'Catarina Pereira Costa', '1988-12-05', 'catarina@sempreceub.com', '0b94fdf8dfa620dd1f2b0147e94ad71f9697ac25', '5555444433', '22201923'),
    (false, '45678901234', 'Daniel Santos Souza', '1992-05-27', 'daniel@sempreceub.com', 'f700a6934e78cd908cb5665cd84f89318bfa2d43', '9999888877', '22203960'),
    (false, '56789012345', 'Eva Oliveira Lima', '1997-11-14', 'eva@sempreceub.com', '0050a3a1ab3d2530b34577213a85f11e8add3b42', '1111222233', '22204295'),
    (false, '67890123456', 'Felipe Pereira Santos', '1984-06-10', 'felipe@sempreceub.com', '0234e2fb0e1bde2fb56bd4687a2ec97ffc1fd25a', '4444555566', '22207859'),
    (false, '78901234567', 'Gabriela Lima Oliveira', '1989-09-25', 'gabriela@sempreceub.com', '598c1713e8190ce0ddc064f6f01a117ab818f34a', '6666777788', '22201235'),
    (false, '89012345678', 'Hugo Costa Pereira', '1993-02-18', 'hugo@sempreceub.com', '74ce7fcefd5b3f91ffb54157247c9902e0e44c72', '2222333344', '22209604'),
    (false, '90123456789', 'Isabela Oliveira Lima', '1996-07-03', 'isabela@sempreceub.com', '75900329206de39a67e738d34755609835640bb3', '7777666655', '22204532'),
    (false, '12345678909', 'João Silva Santos', '1987-10-08', 'joao@sempreceub.com', 'fdf079fa33e55fd158c6bfbf01b9852e5d5513a8', '8888999911', '22200295');


INSERT INTO tb_setor(setor_nome) VALUES
    ('Coordenacao de campo'),
    ('Setor de TI'),
    ('Setor de infraestrutura');

INSERT INTO tb_tipo_ocorrencia(id_setor_fk,tipo_ocorrencia_nome) VALUES
    (1,'Acidente de transito'),
    (1,'Assedio'),
    (1,'Desaparecimento de pessoa'),
    (1,'Extravio/Perda'),
    (1,'Fraudes e Apropriacoes'),
    (1,'Furtos'),
    (1,'Lesao Corporal'),
    (1,'Brigas e ameacas'),
    (2,'Manutencao de equipamentos eletronicos'),
    (3,'Danos a instalacoes'),
    (3,'Problemas de infraestrutura'),
    (1,'Outros');

INSERT INTO tb_lugar(lugar_nome) VALUES 
    ('Bloco 1'),
    ('Bloco 2'),
    ('Bloco 3'),
    ('Bloco 4'),
    ('Bloco 5'),
    ('Bloco 6'),
    ('Bloco 7'),
    ('Bloco 8'),
    ('Bloco 9'),
    ('Bloco 10'),
    ('Bloco 12'),
    ('Piscina'),
    ('Praca Sul'),
    ('Praca Norte'),
    ('Portarias'),
    ('Biblioteca'),
    ('Estacionamento Infinito'),
    ('Estacionamento publico'),
    ('Estacionamento para colaboradores'),
    ('Bosque');

INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES 
    (1, 'Externo'),
    (1, 'Elevador'),
    (1, 'Corredores Terreo'),
    (1, 'Banheiro terreo masculino perto 1001'),
    (1, 'Banheiro terreo feminino perto 1001'),
    (1, 'Banheiro terreo masculino perto 1019'),
    (1, 'Banheiro terreo feminino perto 1019'),
    (1, 'Par de banheiro de acessibilidade perto 1019'),
    (1, 'Sala 1001: laboratorio de informatica'),
    (1, 'Sala 1002-1007'),
    (1, 'Sala 1015'),
    (1, 'Sala 1016: Laboratorio de informatica'),
    (1, 'Sala 1017: Laboratorio de informatica'),
    (1, 'Sala 1018: Laboratorio de informatica'),
    (1, 'Sala 1019'),
    (1, 'Sala 1025: gerencia de atendimentos e registros'),
    (1, 'academicos'),
    (1, '1102-1110'),
    (1, 'Banheiro masculino 1 pavimento'),
    (1, 'Banheiro feminino 1 pavimento'),
    (1, 'Departamento de TI'),
    (1, 'Atendimento comercial'),
    (1, 'CEUB EAD'),
    (1, 'FATECS'),
    (1, 'Lanchonete'),
    (1, 'Auditorio'),
    (1, 'Central de atendimento'),
    (1, 'Tesouraria'),
    (1, 'Schooltilha'),
    (1, 'Reitoria'),
    (1, 'Ouvidoria'),
    (1, 'RH'),
    (1, 'NEAD');

INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES 
    (2, '2301-2338'),
    (2, 'Seminario'),
    (2, '2302: assessoria de extensao e integracao comunitaria'),
    (2, '2311: assessoria de pos-graduacao e pesquisa agencia de mobilidade academica'),
    (2, '2325: NAD'),
    (2, '2330: medicina do trabalho'),
    (2, '2335: NAD'),
    (2, 'Sala de achados e perdidos'),
    (2, 'Hub de inovacao'),
    (2, 'Sala de reprografia'),
    (2, 'Corredores'),
    (2, 'Banheiro terreo masculino entrada'),
    (2, 'Banheiro terreo feminino entrada'),
    (2, 'Banheiro terreo masculino fundo'),
    (2, 'Banheiro terreo feminino fundo'),
    (2, 'Elevador de acessibilidades'),
    (2, 'Estacionamento subsolo 1'),
    (2, 'Sesmt  subsolo 1'),
    (2, 'Banheiro masculino subsolo 1'),
    (2, 'Banheiro feminino subsolo 1'),
    (2, 'Divisao de infraestrutura'),
    (2, 'Supervisao geral de campus');

INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES 
    (3, 'Multiespaco'),
    (3, 'Auditorio'),
    (3, 'Elevador'),
    (3, 'Area lazer terreo'),
    (3, 'Banheiro masculino terreo'),
    (3, 'Banheiro feminino terreo'),
    (3, 'ICPD- Inst. Ceub de Pesquisa e Desenv.'),
    (3, 'Secretaria de Apoio da Pos - Grad.'),
    (3, 'Coord. FAJS Direito / Rel. Internacionais'),
    (3, 'Nucleo de Pratica Juridica - NPJ'),
    (3, 'NPJ - atendimento a comunidade'),
    (3, 'Nucleo de Pesquisa'),
    (3, 'Sala 3001-3009'),
    (3, 'Sala 3010: Sala dos professores'),
    (3, 'Sala 3011-3020'),
    (3, 'Sala 3101-3118'),
    (3, 'Banheiro masculino 1 pavimento'),(3, 'Banheiro feminino 1 pavimento'),
    (3, 'Sala 3201-3224'),
    (3, 'Area de lazer 1 pavimento'),(3, 'Banheiro masculino 2 pavimento'),
    (3, 'Banheiro feminino 2 pavimento'),
    (3, 'Sala 3301-3325'),
    (3, 'Banheiro masculino 3 pavimento'),(3, 'Banheiro feminino 3 pavimento');

INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES 
    (4, 'Sala 4001'),
    (4, 'Sala 4002'),
    (4, 'Sala 4101'),
    (4, 'Sala 4102'),
    (4, 'Sala 4201'),
    (4, 'Sala 4202'),
    (4, 'Ginasio Quadra'),
    (4, 'Ginasio Arquibancada'),
    (4, 'Ginasio Banheiro masculino'),
    (4, 'Ginasio Banheiro feminino');


INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES 
    (5, 'Sala 5000'),
    (5, 'Sala 5001'),
    (5, 'Sala 5002'),
    (5, 'Banheiro masculino 1 pavimento'),
    (5, 'Banheiro feminino 1 pavimento'),
    (5, 'Sala 5100'),
    (5, 'Sala 5101'),
    (5, 'Sala 5200'),
    (5, 'Sala 5201'),
    (5, 'Sala 5202: Equipamento');

INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES
    (6, 'Laboratorio de habilidades cirurgicas'),
    (6, 'Laboratorio de microbiologia'),
    (6, 'Laboratorio de parasitologia'),
    (6, 'Laboratorio de psicoeducacional 3'),
    (6, 'Laboratorio de fisiologia humana'),
    (6, 'Laboratorio de ciencias naturais'),
    (6, 'Laboratorio de necropsia veterinaria animal'),
    (6, 'Laboratorio de simulacao realistica'),
    (6, 'Apoio logistico'),
    (6, 'NAPA'),
    (6, 'Gabinete dos professores'),
    (6, 'Sala dos professores'),
    (6, 'Coordenacao de medicina'),
    (6, 'Suporte de medicina'),
    (6, 'Laboratorio de informatica'),
    (6, 'Laboratorio de hab. - Morfofuncional 1'),
    (6, 'Laboratorio de hab. - Morfofuncional 2'),
    (6, 'Sala de reuniao'),
    (6, 'Elevador'),
    (6, 'Auditorio 2 pavimento'),
    (6, 'Banheiro masculino subsolo'),
    (6, 'Banheiro feminino subsolo'),
    (6, 'Banheiro masculino terreo'),
    (6, 'Banheiro feminino terreo'),
    (6, 'Sala 6101-6117'),
    (6, 'Banheiro feminino 1 pavimento'),
    (6, 'Banheiro feminino 1 pavimento'),
    (6, 'Sala 6201-6212'),
    (6, 'Banheiro feminino 2 pavimento'),
    (6, 'Banheiro feminino 2 pavimento');

INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES 
    (7, 'Sala de emergencia'),
    (7, 'Sala de monitoramento'),
    (7, 'Sala de observacao'),
    (7, 'Sala ultrassom'),
    (7, 'Sala raio X'),
    (7, 'Sala cme'),
    (7, 'Sala consultorio de infeccao'),
    (7, 'Sala consultorio de felino'),
    (7, 'Banheiro masculino terreo'),
    (7, 'Banheiro feminino terreo'),
    (7, 'Sala laboratorio patologia'),
    (7, 'Elevador'),
    (7, 'Sala consultorio'),
    (7, 'Banheiro masculino 1 pavimento'),
    (7, 'Banheiro feminino 1 pavimento'),
    (7, 'Sala 7101'),
    (7, 'Sala 7102'),
    (7, 'Sala 7103'),
    (7, 'Sala 7104'),
    (7, 'Banheiro masculino 2 pavimento'),
    (7, 'Banheiro feminino 2 pavimento'),
    (7, 'Sala 7201'),
    (7, 'Sala 7202'),
    (7, 'Sala 7203'),
    (7, 'Sala 7204'),
    (7, 'Subsolo: clinica escola de medicina veterinaria'),
    (7, 'Espaco pet');

INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES 
    (8, 'Externo'),
    (8, 'Elevador'),
    (8, 'Escadas'),
    (8, 'Sala 8300'),
    (8, 'Sala 8301'),
    (8, 'Sala 8302: laboratorio de informatica'),
    (8, 'Sala 8303'),
    (8, 'Sala 8304: coord. de mestrado de arquitetura'),
    (8, 'Sala 8305: atelie'),
    (8, 'Sala 8306'),
    (8, 'Banheiro masculino 3 andar'),
    (8, 'Banheiro feminino 3 andar'),
    (8, 'Corredor 3 andar'),
    (8, 'Sala 8200'),
    (8, 'Sala 8201'),
    (8, 'Sala 8202: laboratorio de informatica'),
    (8, 'Sala 8203'),
    (8, 'Sala 8204'),
    (8, 'Sala 8205: atelie'),
    (8, 'Sala 8206'),
    (8, 'Banheiro masculino 2 andar'),
    (8, 'Banheiro feminino 2 andar'),
    (8, 'Corredor 2 andar'),
    (8, 'Sala 8100'),
    (8, 'Sala 8101'),
    (8, 'Sala 8104'),
    (8, 'Corredor 1 andar'),
    (8, 'Banheiro masculino 1 andar'),
    (8, 'Banheiro feminino 1 andar'),
    (8, 'Seminario'),
    (8, 'Sala 8001: atelie'),
    (8, 'Sala 8002: atelie'),
    (8, 'Sala 8004: atelie'),
    (8, 'Sala 8005: laboratorio de informatica'),
    (8, 'Sala 8007: sala dos professores'),
    (8, 'Corredor terreo');

INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES
    (9, 'Elevador'),
    (9, 'Escada de Incendio'),
    (9, 'Sala 9513/9514: Laboratorio de habilidades'),
    (9, 'Sala 9502 - 9511: Laboratorio multidisciplinar'),
    (9, 'Sala 9420: Anatomia Animal'),
    (9, 'Bioterio'),
    (9, '9414/9415 Laboratorio de Exatas'),
    (9, '9412: Laboratório de Habilidades Alimentares II'),
    (9, '9411: Laboratório de Eletrotermofototerapia'),
    (9, '9410: Sala de Apoio Teorico 2'),
    (9, '9409: Psicoeducacional 4'),
    (9, '9407: Laboratório de Pesquisa (Convênio)'),
    (9, '9404: Laboratório de Anatomia'),
    (9, '9403: Sala de Apoio Teorico 1'),
    (9, '9402: Laboratório de Morfofuncional 3'),
    (9, '9401: Laboratório de Habilidades Alimentares'),
    (9, 'Banheiro Masculino 1 Subsolo'),
    (9, 'Banheiro Feminino 1 Subsolo'),
    (9, '9001: Laboratório de Informática'),
    (9, '9007: Orientação de Monografia'),
    (9, '9008: Sala de Aplicação de Testes Psicológicos'),
    (9, '9009: Psicoeducacional 2'),
    (9, 'Sala 9000-9006'),
    (9, 'Sala 9010'),
    (9, 'Sala 9011'),
    (9, 'Banheiro Masculino 1 pavimento'),
    (9, 'Banheiro Feminino 1 pavimento'),
    (9, 'Salas 9101-9113'),
    (9, 'Banheiro Masculino 2 pavimento'),
    (9, 'Banheiro Feminino 2 pavimento'),
    (9, 'Salas 9201-9213'),
    (9, 'Banheiro Masculino 3 pavimento'),
    (9, 'Banheiro Feminino 3 pavimento'),
    (9, 'Salas 9301-313');

INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES 
    (10, 'Laboratorio multidisciplinar maquete'),
    (10, 'Laboratorio desenho'),
    (10, 'Laboratorio instalacoes'),
    (10, 'Laboratorio confortes'),
    (10, 'Copa'),
    (10, 'Apoio tecnico administrativo'),
    (10, 'Laboratorio canteiro de obras e estruturas'),
    (10, 'Campo de futebol'),
    (10, 'Lanchonete'),
    (10, 'Banheiro masculino'),
    (10, 'Banheiro feminino'),
    (10, 'Vestiario masculino'),
    (10, 'Vestiario feminino'),
    (10, 'DCE'),
    (10, 'Area de lazer'),
    (10, 'Quadra esportiva 1'),
    (10, 'Quadra esportiva 2');

INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES 
    (11, 'Marketing Ceub'),
    (11, '12028: Laboratorio de multimedia'),
    (11, '12022: Laboratorio estudio de radio'),
    (11, '12026: Sala dos professores'),
    (11, '12025: Coord. comunicacao social'),
    (11, '12014-12020: Laboratorio jornal esquina'),
    (11, 'Sala 12003-12013'),
    (11, 'Sala 12021'),
    (11, 'Sala 12023'),
    (11, 'Sala 12024'),
    (11, 'Sala 12027'),
    (11, 'Banheiro masculino'),
    (11, 'Banheiro feminino'),
    (11, 'Posto Medico');

INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES
	(12, 'Piscina');

INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES
	(13, 'Ricardo sushi'),
    (13, 'Suco & tal'),
    (13, 'Fast grill'),
    (13, 'Geleia hamburguer'),
    (13, 'Johns cookies'),
    (13, 'Kmart'),
    (13, 'Zei lanches'),
    (13, 'Banco Santander'),
    (13, 'Bebedouros'),
    (13, 'Area dos microondas'),
    (13, 'Banheiro masculino'),
    (13, 'Banheiro feminino');

INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES
	(14,'Aprovados lanches'),
    (14,'Apetits'),
    (14,'Creparia'),
    (14,'Sorveteria'),
    (14, 'Area dos microondas'),
    (14,'Maquina de vendas automaticas'),
    (14,'Mesas');

INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES 
    (15, 'Acesso Principal'),
    (15, 'Acesso C'),
    (15, 'Acesso D'),
    (15, 'Acesso E'),
    (15, 'Acesso F'),
    (15, 'Acesso K'),
    (15, 'Acesso O');

INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES
	(16,'Entradas'),
    (16,'Auditorio'),
    (16,'Sala de espera'),
    (16,'Sala de estudos privada'),
    (16,'Area dos minerais'),
    (16,'Area de fotos'),
    (16,'Escadaria norte'),
    (16,'Escadaria sul'),
    (16,'Elevadores'),
    (16,'Escadaria de emergencia'),
    (16,'Diretoria'),
    (16,'Area de estudos norte'),
    (16,'Area de estudos sul'),
    (16,'Escadaria traseira'),
    (16,'Secao cinza sul'),
    (16,'Secao amarela sul'),
    (16,'Secao vermelha sul'),
	(16,'Secao cinza norte'),
    (16,'Secao amarela norte'),
    (16,'Secao vermelha norte'),
    (16,'Bebedouro 1 pavimento'),
	(16,'Banheiro masculino 1 pavimento'),
    (16,'Banheiro feminino 1 pavimento'),
    (16,'Area de estudos mesa'),
    (16,'Area de estudos individuais'),
    (16,'Mini patio'),
    (16,'Bebedouro 2 pavimento'),
    (16,'Banheiro masculino 2 pavimento'),
    (16,'Banheiro feminino 2 pavimento');

INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES 
	(17, 'Cancelas'),
	(17, 'Estacionamento infinito');

INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES 
    (18, 'Lateral Acesso E'),
    (18, 'Lateral Acesso C'),
    (18, 'Lateral Acesso B'),
    (18, 'Interno Bloco 1'),
    (18, 'Lateral Acesso F'),
    (18, 'Lateral Acesso H'),
    (18, 'Lateral Acesso K');

INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES 
    (19, 'Estacionamento pelo acesso C'),
    (19, 'Estacionamento pelo acesso E'),
    (19, 'Estacionamento pelo acesso O'),
    (19, 'Estacionamento subsolo bloco 2');

INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES 
	(20, 'Area verde');

INSERT INTO tb_ocorrencia(id_tipo_ocorrencia_fk,id_pessoa_fk,id_sub_lugar_fk,ocorrencia_descricao,ocorrencia_data,ocorrencia_data_registro,ocorrencia_status) VALUES
	(1,2,1,'Teste','2023-05-01','2023-01-06',true),(2,2,21,'Teste','2023-05-01','2023-01-06',false),(2,2,41,'Teste','2023-05-01','2023-01-06',false),(1,2,61,'Teste','2023-01-01','2023-12-06',false),
    (1,2,81,'Teste','2023-05-01','2023-02-06',false),(3,2,101,'Teste','2023-05-01','2023-02-06',false),(3,2,121,'Teste','2023-05-01','2023-02-06',false),(3,2,141,'Teste','2023-02-01','2023-12-06',false),
    (4,2,161,'Teste','2023-05-01','2023-03-06',false),(4,2,181,'Teste','2023-05-01','2023-05-06',true),(4,2,201,'Teste','2023-05-01','2023-05-06',false),(5,2,221,'Teste','2023-05-01','2023-12-06',false),
    (5,2,241,'Teste','2023-05-01','2023-03-06',false),(5,2,261,'Teste','2023-05-01','2023-03-06',false),(5,2,281,'Teste','2023-05-01','2023-05-06',false),(5,2,301,'Teste','2023-05-01','2023-12-06',true),
    (5,2,321,'Teste','2023-05-01','2023-04-06',false),(5,2,328,'Teste','2023-05-01','2023-04-06',false),(6,2,22,'Teste','2023-05-01','2023-09-06',false),(6,2,21,'Teste','2023-05-01','2023-12-06',false),
    (6,2,7,'Teste','2023-05-01','2023-04-06',false),(6,2,23,'Teste','2023-05-01','2023-05-06',false),(6,2,103,'Teste','2023-05-01','2023-09-06',true),(6,2,29,'Teste','2023-05-01','2023-11-06',false),
    (6,2,5,'Teste','2023-05-01','2023-04-06',false),(6,2,73,'Teste','2023-05-01','2023-06-06',false),(6,2,143,'Teste','2023-05-01','2023-09-06',false),(7,2,76,'Teste','2023-05-01','2023-01-06',false), 
    (7,2,19,'Teste','2023-05-01','2023-04-06',false),(7,2,83,'Teste','2023-05-01','2023-07-06',false),(7,2,113,'Teste','2023-05-01','2023-09-06',false),(7,2,102,'Teste','2023-05-01','2023-02-06',false),
    (7,2,12,'Teste','2023-05-01','2023-05-06',false),(7,2,93,'Teste','2023-05-01','2023-08-06',false),(7,2,293,'Teste','2023-05-01','2023-10-06',false),(8,2,223,'Teste','2023-05-01','2023-04-06',false),
    (8,2,65,'Teste','2023-05-01','2023-05-06',false),(8,2,33,'Teste','2023-05-01','2023-08-06',true),(8,2,123,'Teste','2023-05-01','2023-10-06',false),(8,2,213,'Teste','2023-05-01','2023-03-06',false),
    (8,2,94,'Teste','2023-05-01','2023-06-06',false),(8,2,33,'Teste','2023-05-01','2023-08-06',false),(8,2,23,'Teste','2023-05-01','2023-10-06',false),(9,2,323,'Teste','2023-05-01','2023-05-06',false),
    (9,2,83,'Teste','2023-05-01','2023-06-06',false),(9,2,43,'Teste','2023-05-01','2023-07-06',false),(9,2,223,'Teste','2023-05-01','2023-10-06',true),(9,2,232,'Teste','2023-05-01','2023-07-06',false),
    (9,2,73,'Teste','2023-05-01','2023-07-06',false),(9,2,43,'Teste','2023-05-01','2023-07-06',false),(9,2,213,'Teste','2023-05-01','2023-10-06',false),(9,2,236,'Teste','2023-05-01','2023-08-06',false),
    (9,2,63,'Teste','2023-05-01','2023-07-06',false),(10,2,53,'Teste','2023-05-01','2023-07-06',false),(10,2,233,'Teste','2023-05-01','2023-11-06',false),(10,2,273,'Teste','2023-05-01','2023-05-06',false),
    (11,2,63,'Teste','2023-05-01','2023-08-06',false),(12,2,243,'Teste','2023-05-01','2023-09-06',false),(12,2,319,'Teste','2023-05-01','2023-11-06',false);

SELECT sl.*,l.lugar_nome
FROM tb_sub_lugar sl
JOIN tb_lugar l ON sl.id_lugar_fk = l.id_lugar ORDER BY id_sub_lugar;

SELECT * FROM tb_lugar ORDER BY id_lugar;

SELECT sl.*,l.setor_nome
FROM tb_tipo_ocorrencia sl
JOIN tb_setor l ON sl.id_setor_fk = l.id_setor ORDER BY id_setor;


SELECT
    s.setor_nome AS SETOR,
    tipo.tipo_ocorrencia_nome AS TIPO_OCORRENCIA,
    p.pessoa_nome AS NOME,
    o.ocorrencia_descricao AS DESCRICAO,
    o.ocorrencia_data AS DATA_OCORRIDO,
    o.ocorrencia_data_registro AS DATA_REGISTRO,
    o.ocorrencia_status AS OCORRENCIA_STATUS,
    l.lugar_nome AS LOCAL,
    sub.sub_lugar_nome AS SUB_LOCAL
FROM
    tb_ocorrencia o
    JOIN tb_tipo_ocorrencia tipo ON o.id_tipo_ocorrencia_fk = tipo.id_tipo_ocorrencia
    JOIN tb_setor s ON tipo.id_setor_fk = s.id_setor
    JOIN tb_pessoa p ON o.id_pessoa_fk = p.pessoa_id_pessoa
    JOIN tb_sub_lugar sub ON o.id_sub_lugar_fk = sub.id_sub_lugar
    JOIN tb_lugar l ON sub.id_lugar_fk = l.id_lugar
    ORDER BY s.setor_nome;

