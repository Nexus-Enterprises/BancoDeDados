CREATE DATABASE NEXUS;
USE NEXUS;

CREATE TABLE Endereco (
  idEndereco INT PRIMARY KEY auto_increment,
  cep CHAR(8)  NULL,
  logradouro VARCHAR(45) NOT NULL,
  bairro VARCHAR(45) NOT NULL,
  localidade VARCHAR(45) NOT NULL,
  uf CHAR(2) NOT NULL,
  complemento VARCHAR(45) NULL
  );

CREATE TABLE Empresa (
  idEmpresa INT PRIMARY KEY auto_increment,
  nomeEmpresa VARCHAR(45) NOT NULL,
  CNPJ VARCHAR(14) NOT NULL,
  digito CHAR(3) NOT NULL,
  descricao VARCHAR(45) NULL,
  ispb CHAR(8) NOT NULL,
  situacao TINYINT NULL
  );

CREATE TABLE Agencia (
  idAgencia INT auto_increment,
  numero CHAR(5) NULL,
  digitoAgencia CHAR(1) NULL,
  ddd CHAR(2) NULL,
  telefone VARCHAR(9) NULL,
  email VARCHAR(45) NULL,
  fkEmpresa INT NOT NULL,
  fkEndereco INT NOT NULL,
  PRIMARY KEY (idAgencia, fkEmpresa),
  CONSTRAINT fkEndereco
    FOREIGN KEY (fkEndereco)
    REFERENCES Endereco (idEndereco),
  CONSTRAINT fkEmpresa
    FOREIGN KEY (fkEmpresa)
    REFERENCES Empresa (idEmpresa)
   );

CREATE TABLE Funcionario (
  idFuncionario INT auto_increment,
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
  PRIMARY KEY (idFuncionario, fkAgencia, fkEmpresa),
  CONSTRAINT fkAgencia
    FOREIGN KEY (fkAgencia, fkEmpresa)
    REFERENCES Agencia (idAgencia , fkEmpresa),
  CONSTRAINT fkFuncionario
    FOREIGN KEY (fkFuncionario)
    REFERENCES Funcionario (idFuncionario)
   );

CREATE TABLE Maquina (
  idMaquina INT primary key auto_increment,
  marca VARCHAR(45) NULL,
  modelo VARCHAR(45) NULL,
  situacao VARCHAR(10) NULL,
  sistemaOperacional VARCHAR(15) NULL,
  fkFuncionario INT NOT NULL,
  fkAgencia INT NOT NULL,
  fkEmpresa INT NOT NULL,
  CONSTRAINT fkFuncionarioMaq
    FOREIGN KEY (fkFuncionario , fkAgencia , fkEmpresa)
    REFERENCES Funcionario (idFuncionario , fkAgencia , fkEmpresa)
  );

CREATE TABLE Componente (
  idComponente INT primary key auto_increment,
  nome VARCHAR(45) NULL,
  modelo VARCHAR(45) NULL,
  capacidadeMax DOUBLE NULL
  );


CREATE TABLE Alerta (
  idAlerta INT primary key auto_increment,
  causa VARCHAR(60) not null,
  gravidade VARCHAR(45) not null
  );

CREATE TABLE  CompMaquina (
  idCompMaquina INT NOT NULL,
  fkComponente INT NOT NULL,
  fkMaquina INT NOT NULL,
  PRIMARY KEY (idCompMaquina, fkComponente, fkMaquina),
  CONSTRAINT fkComponente
    FOREIGN KEY (fkComponente)
    REFERENCES Componente (idComponente),
  CONSTRAINT fkMaquina
    FOREIGN KEY (fkMaquina)
    REFERENCES Maquina (idMaquina)
);

CREATE TABLE  Registro (
  idRegistro INT NOT NULL auto_increment,
  enderecoIPV4 VARCHAR(500) not NULL,
  usoAtual DOUBLE not NULL,
  dataHora DATETIME not NULL,
  fkAlerta INT NOT NULL,
  fkCompMaquina INT NOT NULL,
  fkComponente INT NOT NULL,
  fkMaquina INT NOT NULL,
  PRIMARY KEY (idRegistro, fkAlerta, fkCompMaquina, fkComponente, fkMaquina),
  CONSTRAINT fkAlerta
    FOREIGN KEY (fkAlerta)
    REFERENCES Alerta (idAlerta),
  CONSTRAINT fkCompMaquina
    FOREIGN KEY (fkCompMaquina , fkComponente , fkMaquina)
    REFERENCES CompMaquina (idCompMaquina , fkComponente , fkMaquina)
 );
 

