-- Instituto Smaniotto · seed.sql
-- Dados de exemplo. Rode depois do schema.sql.
SET NAMES utf8mb4;
USE instituto_smaniotto;

INSERT INTO campanha (titulo, descricao, meta_valor, data_inicio, data_fim) VALUES
  ('Inverno Solidário', 'Arrecadação de agasalhos e cobertores para famílias atendidas', 5000.00, '2026-05-01', '2026-08-31'),
  ('Cesta Básica Mensal', 'Montagem de cestas de alimentos e itens de higiene', 8000.00, '2026-01-01', NULL);

INSERT INTO categoria (nome) VALUES
  ('Alimento'),
  ('Higiene'),
  ('Vestuário');

INSERT INTO item (id_categoria, nome, unidade, valor_estimado) VALUES
  (1, 'Arroz 5 kg', 'pacote', 28.00),
  (1, 'Feijão 1 kg', 'pacote', 8.50),
  (1, 'Óleo de soja 900 ml', 'garrafa', 7.90),
  (1, 'Leite em pó 400 g', 'lata', 16.00),
  (2, 'Sabonete', 'unidade', 3.50),
  (2, 'Creme dental', 'unidade', 5.00),
  (2, 'Fralda infantil', 'pacote', 32.00),
  (3, 'Agasalho', 'peça', 45.00),
  (3, 'Cobertor', 'unidade', 55.00);

INSERT INTO doador (nome, email, telefone) VALUES
  ('Mercado Bom Preço', 'contato@bompreco.exemplo.com', '(11) 3333-1000'),
  ('Ana Souza', 'ana.souza@exemplo.com', '(11) 98888-1001'),
  ('Carlos Lima', NULL, '(11) 97777-1002'),
  ('Paróquia São José', 'secretaria@psaojose.exemplo.com', NULL);

INSERT INTO doacao (id_doador, id_campanha, data_doacao, observacao) VALUES
  (1, 2, '2026-10-05', 'Entrega feita pelo próprio mercado'),
  (2, 2, '2026-10-12', NULL),
  (4, 1, '2026-10-18', 'Campanha do agasalho');

INSERT INTO doacao_item (id_doacao, id_item, quantidade) VALUES
  (1, 1, 10),
  (1, 2, 15),
  (1, 3, 8),
  (2, 5, 12),
  (2, 6, 12),
  (3, 8, 20),
  (3, 9, 6);
