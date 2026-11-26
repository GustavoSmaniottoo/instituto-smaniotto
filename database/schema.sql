-- Instituto Smaniotto · schema.sql
SET NAMES utf8mb4;
DROP DATABASE IF EXISTS instituto_smaniotto;
CREATE DATABASE instituto_smaniotto CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE instituto_smaniotto;

-- Cadastro de doadores (LGPD: apenas dados necessários para contato e recibo, sem CPF ou endereço)
CREATE TABLE doador (
  id_doador INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(150) NOT NULL,
  email VARCHAR(100) UNIQUE,
  telefone VARCHAR(20),
  data_cadastro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Campanhas de arrecadação da ONG
CREATE TABLE campanha (
  id_campanha INT AUTO_INCREMENT PRIMARY KEY,
  titulo VARCHAR(120) NOT NULL,
  descricao VARCHAR(255),
  meta_valor DECIMAL(10, 2) NOT NULL CHECK (meta_valor > 0),
  data_inicio DATE NOT NULL,
  data_fim DATE,
  status VARCHAR(20) NOT NULL DEFAULT 'ativa' CHECK (status IN ('ativa', 'encerrada'))
);

-- Categorias dos itens doados (ex.: Alimentos, Roupas, Higiene)
CREATE TABLE categoria (
  id_categoria INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(80) NOT NULL UNIQUE
);

-- Catálogo de itens que a ONG recebe
CREATE TABLE item (
  id_item INT AUTO_INCREMENT PRIMARY KEY,
  id_categoria INT NOT NULL,
  nome VARCHAR(120) NOT NULL,
  unidade_medida VARCHAR(20) NOT NULL DEFAULT 'unidade',
  valor_estimado DECIMAL(10, 2) NOT NULL DEFAULT 0.00 CHECK (valor_estimado >= 0),
  FOREIGN KEY (id_categoria) REFERENCES categoria (id_categoria)
);

-- Registro de cada doação realizada
CREATE TABLE doacao (
  id_doacao INT AUTO_INCREMENT PRIMARY KEY,
  id_doador INT NOT NULL,
  id_campanha INT,
  data_doacao DATE NOT NULL,
  observacao VARCHAR(255),
  FOREIGN KEY (id_doador) REFERENCES doador (id_doador),
  FOREIGN KEY (id_campanha) REFERENCES campanha (id_campanha)
);

-- Tabela associativa N:N entre doacao e item (itens e quantidades de cada doação)
CREATE TABLE doacao_item (
  id_doacao INT NOT NULL,
  id_item INT NOT NULL,
  quantidade INT NOT NULL CHECK (quantidade > 0),
  PRIMARY KEY (id_doacao, id_item),
  FOREIGN KEY (id_doacao) REFERENCES doacao (id_doacao) ON DELETE CASCADE,
  FOREIGN KEY (id_item) REFERENCES item (id_item)
);
