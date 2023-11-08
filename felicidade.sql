CREATE database felicidade;

-- DROP DATABASE felicidade;
use felicidade;

CREATE TABLE tb_pessoa (
    pessoa_id_pessoa INT AUTO_INCREMENT PRIMARY KEY,
    pessoa_permissao BOOLEAN NOT NULL,
    pessoa_CPF varchar(11) NOT NULL UNIQUE,
    pessoa_nome VARCHAR(150) NOT NULL,
    pessoa_data_nasc date NOT NULL,
    pessoa_email VARCHAR(90) NOT NULL,
    pessoa_senha VARCHAR(90) NOT NULL,
    pessoa_telefone varchar(11) NOT NULL,
    pessoa_RA int unique
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
    FOREIGN KEY (id_pessoa_fk) REFERENCES tb_pessoa(pessoa_id_pessoa)
);

CREATE TABLE tb_midia (
    id_midia INT AUTO_INCREMENT PRIMARY KEY,
    id_ocorrencia_fk INT,
    midia_descrição text,
    midia longblob,
    FOREIGN KEY (id_ocorrencia_fk) REFERENCES tb_ocorrencia(id_ocorrencia)
);

INSERT INTO tb_lugar(lugar_nome) VALUES ("Bloco 1");
INSERT INTO tb_lugar(lugar_nome) VALUES ("Bloco 2");
INSERT INTO tb_lugar(lugar_nome) VALUES ("Bloco 3");
INSERT INTO tb_lugar(lugar_nome) VALUES ("Bloco 4");
INSERT INTO tb_lugar(lugar_nome) VALUES ("Bloco 5");
INSERT INTO tb_lugar(lugar_nome) VALUES ("Bloco 6");
INSERT INTO tb_lugar(lugar_nome) VALUES ("Bloco 7");
INSERT INTO tb_lugar(lugar_nome) VALUES ("Bloco 8");
INSERT INTO tb_lugar(lugar_nome) VALUES ("Bloco 9");
INSERT INTO tb_lugar(lugar_nome) VALUES ("Bloco 10");
INSERT INTO tb_lugar(lugar_nome) VALUES ("Bloco 12");
INSERT INTO tb_lugar(lugar_nome) VALUES ("Piscina");
INSERT INTO tb_lugar(lugar_nome) VALUES ("Praça Sul");
INSERT INTO tb_lugar(lugar_nome) VALUES ("Praça Norte");
INSERT INTO tb_lugar(lugar_nome) VALUES ("Portaria");
INSERT INTO tb_lugar(lugar_nome) VALUES ("Biblioteca");
INSERT INTO tb_lugar(lugar_nome) VALUES ("Estacionamento Infinito");
INSERT INTO tb_lugar(lugar_nome) VALUES ("Estacionamento público");
INSERT INTO tb_lugar(lugar_nome) VALUES ("Estacionamento para colaboradores");

INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","Externo");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","Elevador");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","Corredores Terreo");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","Banheiro terreo masculino perto 1001");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","Banheiro terreo feminino perto 1001");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","Banheiro terreo masculino perto 1019");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","Banheiro terreo feminino perto 1019");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","Par de banheiro de acessibilidade perto 1019");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","Sala 1001: laboratorio de informatica");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","Sala 1002");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","Sala 1003");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","Sala 1004");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","Sala 1005");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","Sala 1006");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","Sala 1007");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","Sala 1015");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","Sala 1016: Laboratorio de informatica");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","Sala 1017: Laboratorio de informatica");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","Sala 1018: Laboratorio de informatica");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","Sala 1019");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","Sala 1025: gerencia de atendimentos e registros");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","academicos");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","1102-1110");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","Banheiro masculino 1 pavimento");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","Banheiro feminino 1 pavimento");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","Departamento de TI");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","Atendimento comercial");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","CEUB EAD");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","FATECS");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","Lanchonete");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","Auditorio");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","Central de atendimento");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","Tesouraria");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","Schooltilha");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","Reitoria");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","Ouvidoria");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","RH");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("1","NEAD");

INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("2","2301-2338");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("2","Seminario");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("2","2302: assessoria de extensao e integracao comunitaria");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("2","2311: assessoria de pos-graduacao e pesquisa agencia de mobilidade academica");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("2","2325: NAD");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("2","2330: medicina do trabalho");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("2","2335: NAD");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("2","Sala de achados e perdidos");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("2","Hub de inovacao");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("2","Sala de reprografia");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("2","Corredores");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("2","Banheiro terreo masculino entrada");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("2","Banheiro terreo feminino entrada");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("2","Banheiro terreo masculino fundo");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("2","Banheiro terreo feminino fundo");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("2","Elevador de acessibilidades");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("2","Estacionamento subsolo 1");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("2","Sesmt  subsolo 1");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("2","Banheiro masculino subsolo 1");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("2","Banheiro feminino subsolo 1");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("2","Divisao de infraestrutura");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("2","Supervisao geral de campus");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("2","Estacionamento subsolo 2");

INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("3","Multiespaco");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("3","Auditorio");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("3","Elevador");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("3","Area lazer terreo");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("3","Banheiro masculino terreo");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("3","Banheiro feminino terreo");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("3","ICPD- Inst. Ceub de Pesquisa e Desenv.");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("3","Secretaria de Apoio da Pos - Grad.");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("3","Coord. FAJS Direito / Rel. Internacionais");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("3","Nucleo de Pratica Juridica - NPJ");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("3","NPJ - atendimento a comunidade");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("3","Nucleo de Pesquisa");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES (3, 'Sala 3001');
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES (3, 'Sala 3002');
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES (3, 'Sala 3003');
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES (3, 'Sala 3004');
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES (3, 'Sala 3005');
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES (3, 'Sala 3006');
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES (3, 'Sala 3007');
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES (3, 'Sala 3008');
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES (3, 'Sala 3009');
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("3","Sala 3010: Sala dos professores");
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3011');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3012');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3013');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3014');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3015');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3016');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3017');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3018');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3019');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3020');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3101');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3102');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3103');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3104');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3105');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3106');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3107');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3108');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3109');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3110');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3111');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3112');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3113');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3114');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3115');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3116');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3117');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3118');
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("3","Banheiro masculino 1 pavimento");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("3","Banheiro feminino 1 pavimento");
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3201');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3202');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3203');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3204');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3205');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3206');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3207');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3208');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3209');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3210');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3211');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3212');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3213');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3214');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3215');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3216');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3217');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3218');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3219');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3220');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3221');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3222');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3223');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3224');
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("3","Area de lazer 1 pavimento");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("3","Banheiro masculino 2 pavimento");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("3","Banheiro feminino 2 pavimento");
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3301');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3302');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3303');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3304');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3305');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3306');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3307');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3308');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3309');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3310');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3311');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3312');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3313');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3314');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3315');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3316');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3317');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3318');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3319');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3320');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3321');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3322');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3323');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3324');
INSERT INTO tb_sub_lugar (id_lugar_fk, sub_lugar_nome) VALUES (3, 'Sala 3325');
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("3","Banheiro masculino 3 pavimento");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("3","Banheiro feminino 3 pavimento");


INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("5", "Sala 5000");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("5", "Sala 5001");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("5", "Sala 5002");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("5", "Banheiro masculino 1 pavimento");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("5", "Banheiro feminino 1 pavimento");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("5", "Sala 5100");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("5", "Sala 5101");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("5", "Sala 5200");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("5", "Sala 5201");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("5", "Sala 5202: Equipamento");

INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("7", "Sala de emergência");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("7", "Sala de monitoramento");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("7", "Sala de observação");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("7", "Sala ultrassom");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("7", "Sala raio X");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("7", "Sala cme");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("7", "Sala consultório de infecção");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("7", "Sala consultório de felino");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("7", "Banheiro masculino terreo");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("7", "Banheiro feminino terreo");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("7", "Sala laboratorio patologia");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("7", "Elevador");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("7", "Sala consultorio");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("7", "Banheiro masculino 1 pavimento");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("7", "Banheiro feminino 1 pavimento");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("7", "Sala 7101");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("7", "Sala 7102");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("7", "Sala 7103");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("7", "Sala 7104");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("7", "Banheiro masculino 2 pavimento");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("7", "Banheiro feminino 2 pavimento");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("7", "Sala 7201");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("7", "Sala 7202");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("7", "Sala 7203");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("7", "Sala 7204");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("7", "Subsolo: clínica escola de medicina veterinária");


INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("8","Externo");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("8","Elevador");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("8","Escadas");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("8","Sala 8300");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("8","Sala 8301");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("8","Sala 8302: laboratorio de informatica");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("8","Sala 8303");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("8","Sala 8304: coordenação de mestrado de arquitetura");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("8","Sala 8305: atelie");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("8","Sala 8306");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("8","Banheiro masculino 3 andar");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("8","Banheiro feminino 3 andar");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("8","Corredor 3 andar");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("8","Sala 8200");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("8","Sala 8201");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("8","Sala 8202: laboratorio de informatica");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("8","Sala 8203");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("8","Sala 8204");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("8","Sala 8205: atelie");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("8","Sala 8206");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("8","Banheiro masculino 2 andar");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("8","Banheiro feminino 2 andar");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("8","Corredor 2 andar");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("8","Sala 8100");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("8","Sala 8101");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("8","Sala 8104");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("8","Corredor 1 andar");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("8","Banheiro masculino 1 andar");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("8","Banheiro feminino 1 andar");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("8","Seminário");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("8","Sala 8001: atelie");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("8","Sala 8002: atelie");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("8","Sala 8004: atelie");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("8","Sala 8005: laboratorio de informatica");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("8","Sala 8007: sala dos professores");
INSERT INTO tb_sub_lugar(id_lugar_fk,sub_lugar_nome) VALUES ("8","Corredor terreo");

INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("10", "Laboratirio multidisciplinar maquete");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("10", "Laboratirio desenho");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("10", "Laboratirio instalacoes");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("10", "Laboratirio confortes");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("10", "Copa");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("10", "Apoio tecnico administrativo");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("10", "Laboratirio canteiro de obras e estruturas");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("10", "Campo de futebol");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("10", "Lanchonete");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("10", "Banheiro masculino");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("10", "Banheiro feminino");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("10", "Vestiario masculino");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("10", "Vestiario feminino");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("10", "DCE");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("10", "Area de lazer");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("10", "Quadra esportiva 1");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("10", "Quadra esportiva 2");

INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("15", "Acesso A, B , Q , R");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("15", "Acesso C");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("15", "Acesso D");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("15", "Acesso E");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("15", "Acesso F");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("15", "Acesso K");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("15", "Acesso O");

INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("18", "Lateral Acesso E");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("18", "Lateral Acesso C");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("18", "Lateral Acesso B");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("18", "Interno Bloco 1");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("18", "Lateral Acesso F");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("18", "Lateral Acesso H");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("18", "Lateral Acesso K");

INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("19", "Acesso C");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("19", "Acesso E");
INSERT INTO tb_sub_lugar(id_lugar_fk, sub_lugar_nome) VALUES ("19", "Acesso O");

SELECT sl.*,l.lugar_nome
FROM tb_sub_lugar sl
JOIN tb_lugar l ON sl.id_lugar_fk = l.id_lugar ORDER BY id_sub_lugar;
SELECT * FROM tb_lugar ORDER BY id_lugar;
