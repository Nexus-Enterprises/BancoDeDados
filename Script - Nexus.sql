CREATE DATABASE NEXUS;
USE NEXUS;

CREATE TABLE Endereco (
  idEndereco INT AUTO_INCREMENT PRIMARY KEY,
  cep CHAR(8) NULL,
  logradouro VARCHAR(45) NOT NULL,
  bairro VARCHAR(45) NOT NULL,
  localidade VARCHAR(45) NOT NULL,
  uf CHAR(2) NOT NULL,
  complemento VARCHAR(45) NULL
);

CREATE TABLE Empresa (
  idEmpresa INT AUTO_INCREMENT PRIMARY KEY,
  nomeEmpresa VARCHAR(45) NOT NULL,
  CNPJ VARCHAR(14) NOT NULL,
  digito CHAR(3) NOT NULL,
  descricao VARCHAR(45) NULL,
  ispb CHAR(8) NOT NULL,
  situacao TINYINT NULL
);

CREATE TABLE Agencia (
  idAgencia INT AUTO_INCREMENT PRIMARY KEY,
  numero CHAR(5) NULL,
  digitoAgencia CHAR(1) NULL,
  ddd CHAR(2) NULL,
  telefone VARCHAR(9) NULL,
  email VARCHAR(45) NULL,
  fkEmpresa INT NOT NULL,
  fkEndereco INT NOT NULL,
  CONSTRAINT fkEndereco
    FOREIGN KEY (fkEndereco)
    REFERENCES Endereco (idEndereco),
  CONSTRAINT fkEmpresaAgencia
    FOREIGN KEY (fkEmpresa)
    REFERENCES Empresa (idEmpresa)
);

CREATE TABLE Funcionario (
  idFuncionario INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(45) NULL,
  sobrenome VARCHAR(45) NULL,
  emailCorporativo VARCHAR(45) NULL,
  ddd CHAR(2) NULL,
  telefone VARCHAR(9) NULL,
  cargo VARCHAR(45) NULL,
  situacao VARCHAR(10) NULL,
  fkAgencia INT NOT NULL,
  fkEmpresa INT NOT NULL,
  fkFuncionario INT NULL,
  CONSTRAINT fkAgencia
    FOREIGN KEY (fkAgencia)
    REFERENCES Agencia (idAgencia),
  CONSTRAINT fkEmpresa
    FOREIGN KEY (fkEmpresa)
    REFERENCES Empresa (idEmpresa),
  CONSTRAINT fkFuncionario
    FOREIGN KEY (fkFuncionario)
    REFERENCES Funcionario (idFuncionario)
);

CREATE TABLE Maquina (
  idMaquina INT AUTO_INCREMENT PRIMARY KEY,
  marca VARCHAR(45) NULL,
  modelo VARCHAR(45) NULL,
  situacao VARCHAR(10) NULL,
  sistemaOperacional VARCHAR(15) NULL,
  fkFuncionario INT NOT NULL,
  fkAgencia INT NOT NULL,
  fkEmpresa INT NOT NULL,
  CONSTRAINT fkFuncionarioMaq
    FOREIGN KEY (fkFuncionario)
    REFERENCES Funcionario (idFuncionario),
  CONSTRAINT fkAgenciaMaq
    FOREIGN KEY (fkAgencia)
    REFERENCES Agencia (idAgencia),
  CONSTRAINT fkEmpresaMaq
    FOREIGN KEY (fkEmpresa)
    REFERENCES Empresa (idEmpresa)
);

CREATE TABLE Componente (
  idComponente INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(45) NULL,
  modelo VARCHAR(45) NULL,
  capacidadeMax DOUBLE NULL,
  montagem VARCHAR(45) NULL,
  fkMaquina INT NOT NULL,
  CONSTRAINT fkMaquinaComponente
    FOREIGN KEY (fkMaquina)
    REFERENCES Maquina (idMaquina)
);

CREATE TABLE Alerta (
  idAlerta INT AUTO_INCREMENT PRIMARY KEY,
  causa VARCHAR(60) NOT NULL,
  gravidade VARCHAR(45) NOT NULL
);

CREATE TABLE Registro (
  idRegistro INT AUTO_INCREMENT PRIMARY KEY,
  enderecoIPV4 VARCHAR(500) NOT NULL,
  usoAtual DOUBLE NOT NULL,
  dataHora DATETIME NOT NULL,
  fkAlerta INT NOT NULL,
  fkComponente INT NOT NULL,
  fkMaquina INT NOT NULL,
  CONSTRAINT fkAlertaRegistro
    FOREIGN KEY (fkAlerta)
    REFERENCES Alerta (idAlerta),
  CONSTRAINT fkComponenteRegistro
    FOREIGN KEY (fkComponente)
    REFERENCES Componente (idComponente),
  CONSTRAINT fkMaquinaRegistro
    FOREIGN KEY (fkMaquina)
    REFERENCES Maquina (idMaquina)
);

-- Inserindo dados na tabela Endereco
INSERT INTO Endereco (cep, logradouro, bairro, localidade, uf, complemento)
VALUES
  ('12345678', 'Rua Principal 1', 'Centro', 'Cidade 1', 'SP', 'Apto 101'),
  ('98765432', 'Avenida Secundária 2', 'Subúrbio', 'Cidade 2', 'RJ', 'Casa 2'),
  ('55554444', 'Praça Central 3', 'Centro', 'Cidade 3', 'MG', 'Sala 3A'),
  ('11112222', 'Avenida Principal 4', 'Bairro A', 'Cidade 4', 'RS', 'Bloco 4'),
  ('44443333', 'Rua Secundária 5', 'Bairro B', 'Cidade 5', 'SC', 'Casa 5B'),
  ('77776666', 'Travessa Central 6', 'Centro', 'Cidade 6', 'PR', 'Apartamento 6C'),
  ('22221111', 'Avenida Principal 7', 'Bairro C', 'Cidade 7', 'GO', 'Casa 7C');

-- Inserindo dados na tabela Empresa
INSERT INTO Empresa (nomeEmpresa, CNPJ, digito, descricao, ispb, situacao)
VALUES
  ('Empresa A', '12345678901234', '123', 'Descrição Empresa A', 'ISPB1234', 1),
  ('Empresa B', '98765432109876', '789', 'Descrição Empresa B', 'ISPB5678', 1),
  ('Empresa C', '55554444333322', '222', 'Descrição Empresa C', 'ISPB4321', 0),
  ('Empresa D', '11112222333344', '333', 'Descrição Empresa D', 'ISPB2468', 1),
  ('Empresa E', '44443333999988', '888', 'Descrição Empresa E', 'ISPB8642', 1),
  ('Empresa F', '77776666555544', '444', 'Descrição Empresa F', 'ISPB3142', 0),
  ('Empresa G', '22221111777755', '555', 'Descrição Empresa G', 'ISPB5798', 1);

-- Inserindo dados na tabela Agencia
INSERT INTO Agencia (numero, digitoAgencia, ddd, telefone, email, fkEmpresa, fkEndereco)
VALUES
  ('12345', '1', '11', '987654321', 'agencia1@email.com', 1, 1),
  ('54321', '2', '22', '876543210', 'agencia2@email.com', 2, 2),
  ('11111', '3', '33', '765432109', 'agencia3@email.com', 3, 3),
  ('22222', '4', '44', '654321098', 'agencia4@email.com', 4, 4),
  ('33333', '5', '55', '543210987', 'agencia5@email.com', 5, 5),
  ('44444', '6', '66', '432109876', 'agencia6@email.com', 6, 6),
  ('55555', '7', '77', '321098765', 'agencia7@email.com', 7, 7);

-- Inserindo dados na tabela Funcionario
INSERT INTO Funcionario (nome, sobrenome, emailCorporativo, ddd, telefone, cargo, situacao, fkAgencia, fkEmpresa, fkFuncionario)
VALUES
  ('João', 'Silva', 'joao@empresa.com', '11', '123456789', 'Gerente', 'Ativo', 1, 1, NULL),
  ('Maria', 'Santos', 'maria@empresa.com', '11', '987654321', 'Analista', 'Ativo', 2, 2, NULL),
  ('Pedro', 'Gomes', 'pedro@empresa.com', '22', '876543210', 'Supervisor', 'Inativo', 3, 3, NULL),
  ('Ana', 'Ferreira', 'ana@empresa.com', '33', '765432109', 'Assistente', 'Ativo', 4, 4, NULL),
  ('Luiz', 'Carvalho', 'luiz@empresa.com', '44', '654321098', 'Coordenador', 'Ativo', 5, 5, NULL),
  ('Camila', 'Oliveira', 'camila@empresa.com', '55', '543210987', 'Gerente', 'Inativo', 6, 6, NULL),
  ('Lucas', 'Rocha', 'lucas@empresa.com', '66', '432109876', 'Analista', 'Ativo', 7, 7, NULL);

-- Inserindo dados na tabela Maquina
INSERT INTO Maquina (marca, modelo, situacao, sistemaOperacional, fkFuncionario, fkAgencia, fkEmpresa)
VALUES
  ('Dell', 'Latitude', 'Ativa', 'Windows 10', 1, 1, 1),
  ('HP', 'EliteBook', 'Inativa', 'Windows 11', 2, 2, 2),
  ('Lenovo', 'ThinkPad', 'Ativa', 'Ubuntu 20.04', 3, 3, 3),
  ('Apple', 'MacBook Pro', 'Ativa', 'macOS Big Sur', 4, 4, 4),
  ('Acer', 'Aspire', 'Inativa', 'Windows 10', 5, 5, 5),
  ('Asus', 'ZenBook', 'Ativa', 'Windows 11', 6, 6, 6),
  ('Sony', 'VAIO', 'Inativa', 'Windows 10', 7, 7, 7);

-- Inserindo dados na tabela Componente
INSERT INTO Componente (nome, modelo, capacidadeMax, montagem, fkMaquina)
VALUES
  ('Memória RAM', 'DDR4-2400', 16.0, 'Slot 1', 1),
  ('Disco Rígido', 'SSD-512GB', 512.0, 'Slot 2', 2),
  ('Placa de Vídeo', 'Nvidia GTX 1660', 6.0, 'Slot 1', 3),
  ('Processador', 'Intel Core i7', NULL, 'Socket 1151', 4),
  ('Placa-Mãe', 'ASUS Prime B450M', NULL, NULL, 5),
  ('Monitor', 'Dell 27"', NULL, NULL, 6),
  ('Teclado', 'Logitech K480', NULL, NULL, 7);

-- Inserindo dados na tabela Alerta
INSERT INTO Alerta (causa, gravidade)
VALUES
  ('Sobrecarga de CPU', 'Alta'),
  ('Problema na Rede', 'Média'),
  ('Disco Rígido Cheio', 'Alta'),
  ('Bateria Fraca', 'Baixa'),
  ('Falha no Sistema', 'Alta'),
  ('Superaquecimento', 'Média'),
  ('Ataque de Segurança', 'Alta');

-- Inserindo dados na tabela Registro
INSERT INTO Registro (enderecoIPV4, usoAtual, dataHora, fkAlerta, fkComponente, fkMaquina)
VALUES
  ('192.168.0.1', 80.5, '2023-10-15 10:00:00', 1, 1, 1),
  ('192.168.0.2', 95.2, '2023-10-15 10:30:00', 2, 2, 2),
  ('192.168.0.3', 75.8, '2023-10-15 11:00:00', 3, 3, 3),
  ('192.168.0.4', 55.3, '2023-10-15 11:30:00', 4, 4, 4),
  ('192.168.0.5', 70.1, '2023-10-15 12:00:00', 5, 5, 5),
  ('192.168.0.6', 82.4, '2023-10-15 12:30:00', 6, 6, 6),
  ('192.168.0.7', 65.9, '2023-10-15 13:00:00', 7, 7, 7);


SELECT 
    F.nome,
    F.situacao,
    M.modelo,
    M.marca,
    M.sistemaOperacional,
    M.situacao,
    C.nome,
    A.causa,
    R.enderecoIPV4,
    R.usoAtual,
    R.dataHora
FROM Funcionario AS F
JOIN Maquina AS M ON F.idFuncionario = M.fkFuncionario
JOIN Componente AS C ON M.idMaquina = C.fkMaquina
JOIN Alerta AS A ON 1 = 1  -- Faz um "CROSS JOIN" para todos os alertas
JOIN Registro AS R ON C.idComponente = R.fkComponente;
