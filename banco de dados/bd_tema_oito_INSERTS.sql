-- ===============================
-- ETAPA 3 - PROJETO FINAL
-- Carga de dados (INSERTs)
-- ===============================

-- Os dados são inseridos primeiro nas tabelas independentes
-- Para que seus IDs existam antes de os inserir nas tabelas dependentes

-- Tabelas independentes
INSERT INTO temporada (nome, data_inicio, data_fim, multiplicador) 
VALUES  ('Carnaval 2026', '2026-02-09', '2026-02-14', 1.70),
		('Dia dos Namorados 2026', '2026-06-10', '2026-06-13', 1.30),
		('São João 2026', '2026-06-20', '2026-06-25', 1.40),
		('Férias Escolares 2026', '2026-07-01', '2026-07-31', 1.30),
		('Baixa Temporada', '2026-03-01', '2026-06-09', 0.85),
		('Natal 2026', '2026-12-15', '2027-01-05', 1.50);

INSERT INTO quarto (numero, tipo, capacidade, tarifa_base, status) 
VALUES  ('101', 'SIMPLES', 1, 150.00, 'DISPONIVEL'),
		('102', 'SIMPLES', 1, 150.00, 'MANUTENCAO'), 
		('201', 'DUPLO', 2, 250.00, 'OCUPADO'),
		('202', 'DUPLO', 2, 250.00, 'MANUTENCAO'),
		('301', 'DUPLO', 4, 500.00, 'DISPONIVEL'),
		('302', 'LUXO', 4, 500.00, 'DISPONIVEL'),
		('401', 'LUXO', 3, 750.00, 'DISPONIVEL'),
		('402', 'LUXO', 3, 750.00, 'DISPONIVEL'),
		('501', 'LUXO', 4, 1000.00, 'DISPONIVEL');

INSERT INTO hospede (nome, cpf, email, telefone) 
VALUES  ('Ana Maria Silva', '123.456.789-00', 'AnaMar.silva@email.com', '(85) 900001111'),
		('Carlos Douglas Souza', '98765432100', 'carlosD.souza@email.com', '(21) 912348765'),
		('Mariana Lima Albuquerque', '111.222.333-44', 'mari.lima@email.com', '(11) 998761234'),
		('Roberto Dias Lima', '55566677788', 'beto.dias@email.com', '(66) 956565656'), 
		('Dio Brando', '204.696.803-00', 'dio.brando@email.com', '(11) 984939393'),
		('João Pedro Vasconcelos', '000.111.222-33', 'joao.pedro@email.com', '(86) 909548732'),
		('Elena Rodriguez', '121.232.343-45', 'elena.rodriguez@email.com', '(11) 998749251'),
		('Maria José Magalhães', '098.123.765.34', 'maria.jose@email.com', '(66) 924178494');

-- Tabelas dependentes
INSERT INTO manutencao (id_quarto, data_inicio, data_fim, motivo) 
VALUES  (2, '2026-02-01 10:00:00', '2026-02-05 18:00:00', 'Pintura de paredes'),
		(1, '2026-01-10 08:00:00', '2026-01-11 12:00:00', 'Reparo no ar condicionado'),
		(4, '2026-02-03 07:00:00', NULL, 'Vazamento na encanação da cozinha - Interditado');

INSERT INTO reserva (id_hospede, id_quarto, data_entrada, data_saida, qtd_hospedes, origem, status, valor_total) 
VALUES  (1, 1, '2025-02-10', '2025-02-15', 1, 'SITE', 'CHECKOUT', 750.00),
		(2, 3, '2026-01-10', '2026-01-19', 2, 'BALCAO', 'CHECKIN', 2250.00),
		(3, 5, '2026-12-20', '2026-12-25', 4, 'TELEFONE', 'CONFIRMADA', 3750.00),
		(4, 4, '2025-12-07', '2026-02-02', 2, 'SITE', 'NO_SHOW', 0.00),
		(5, 5, '2026-01-05', '2026-01-10', 4, 'SITE', 'CONFIRMADA', 3750.00),
		(6, 2, '2026-02-15', '2026-02-20', 1, 'TELEFONE', 'CANCELADA', 0.00),
		(7, 1, '2026-03-01', '2026-03-05', 1, 'BALCAO', 'PENDENTE', 750.00),
		(8, 3, '2026-04-10', '2026-04-15', 2, 'SITE', 'PENDENTE', 2250.00);

INSERT INTO adicional (id_reserva, descricao, valor, data_lancamento) 
VALUES  (1, 'Frigobar - Água s/ Gás 500ml', 6.00, '2025-02-11 14:00:00'),
		(1, 'Frigobar - Chocolate Barra', 12.00, '2025-02-11 22:30:00'),
		(1, 'Serviço de Lavanderia - Express', 50.00, '2025-02-12 09:00:00'),
		(2, 'Diária Estacionamento', 25.00, '2026-01-11 08:00:00'),
		(2, 'Diária Estacionamento', 25.00, '2026-01-12 08:00:00'),
		(2, 'Room Service - Jantar Executivo', 85.90, '2026-01-11 20:15:00'),
		(2, 'Taxa de Serviço (10%)', 8.59, '2026-01-11 20:15:00'),
		(3, 'Reposição - Toalha Rasgada', 45.00, '2026-12-24 10:00:00');

INSERT INTO pagamento (id_reserva, data_pagamento, forma_pagamento, valor) 
VALUES  (1, '2025-02-15 10:00:00', 'CREDITO', 818.00), 
		(2, '2026-01-10 14:00:00', 'PIX', 1000.00),
		(2, '2026-01-15 16:00:00', 'PIX', 1250.00), 
		(3, '2026-12-20 09:00:00', 'DEBITO', 3750.00), 
		(5, '2026-01-05 10:00:00', 'CREDITO', 3750.00);
