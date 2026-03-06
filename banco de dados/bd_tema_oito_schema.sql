CREATE TABLE hospede (
    id_hospede INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(20) NOT NULL UNIQUE, 
    email VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NOT NULL
);

CREATE TABLE quarto (
    id_quarto INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    numero VARCHAR(10) NOT NULL UNIQUE,
    tipo VARCHAR(20) NOT NULL CHECK (tipo IN ('SIMPLES', 'DUPLO', 'LUXO')),
    capacidade INT NOT NULL CHECK (capacidade > 0),
    tarifa_base DECIMAL(10, 2) NOT NULL CHECK (tarifa_base > 0),
    status VARCHAR(20) NOT NULL DEFAULT 'DISPONIVEL' CHECK (status IN ('DISPONIVEL', 'OCUPADO', 'MANUTENCAO', 'BLOQUEADO'))
);

CREATE TABLE temporada (
    id_temporada INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    multiplicador DECIMAL(4, 2) NOT NULL CHECK (multiplicador > 0), 
    CONSTRAINT chk_datas_temporada CHECK (data_inicio <= data_fim)
);

CREATE TABLE manutencao (
    id_manutencao INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_quarto INT NOT NULL,
    data_inicio TIMESTAMP NOT NULL,
    data_fim TIMESTAMP, 
    motivo TEXT NOT NULL,
    
    CONSTRAINT fk_manutencao_quarto 
        FOREIGN KEY (id_quarto) REFERENCES quarto(id_quarto)
        ON DELETE RESTRICT, 
        
    CONSTRAINT chk_datas_manutencao CHECK (data_fim IS NULL OR data_inicio <= data_fim)
);

CREATE TABLE reserva (
    id_reserva INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_hospede INT NOT NULL,
    id_quarto INT NOT NULL,
    data_entrada DATE NOT NULL,
    data_saida DATE NOT NULL,
    qtd_hospedes INT NOT NULL CHECK (qtd_hospedes > 0),
    origem VARCHAR(20) NOT NULL CHECK (origem IN ('SITE', 'TELEFONE', 'BALCAO')),
    status VARCHAR(20) NOT NULL DEFAULT 'PENDENTE' CHECK (status IN ('PENDENTE', 'CONFIRMADA', 'CHECKIN', 'CHECKOUT', 'CANCELADA', 'NO_SHOW')),
    valor_total DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    data_real_checkin TIMESTAMP,
    data_real_checkout TIMESTAMP,

    CONSTRAINT fk_reserva_hospede 
        FOREIGN KEY (id_hospede) REFERENCES hospede(id_hospede)
        ON DELETE RESTRICT, 

    CONSTRAINT fk_reserva_quarto 
        FOREIGN KEY (id_quarto) REFERENCES quarto(id_quarto)
        ON DELETE RESTRICT, 

    CONSTRAINT chk_datas_reserva CHECK (data_entrada < data_saida) 
);

CREATE TABLE adicional (
    id_adicional INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_reserva INT NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    valor DECIMAL(10, 2) NOT NULL CHECK (valor >= 0),
    data_lancamento TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, 

    CONSTRAINT fk_adicional_reserva 
        FOREIGN KEY (id_reserva) REFERENCES reserva(id_reserva)
        ON DELETE CASCADE 
);

CREATE TABLE pagamento (
    id_pagamento INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_reserva INT NOT NULL,
    data_pagamento TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    forma_pagamento VARCHAR(50) NOT NULL, 
    valor DECIMAL(10, 2) NOT NULL CHECK (valor > 0),

    CONSTRAINT fk_pagamento_reserva 
        FOREIGN KEY (id_reserva) REFERENCES reserva(id_reserva)
        ON DELETE RESTRICT 
);