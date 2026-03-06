from sqlalchemy import Column, Integer, String, Numeric, Date, DateTime, ForeignKey
from sqlalchemy.orm import declarative_base, relationship

Base = declarative_base()

# ==========================================
# TABELAS INDEPENDENTES
# ==========================================
class Hospede(Base):
    __tablename__ = 'hospede'
    id_hospede = Column(Integer, primary_key=True, autoincrement=True)
    nome = Column(String(100), nullable=False)
    cpf = Column(String(20), unique=True, nullable=False)
    email = Column(String(100))
    telefone = Column(String(20))
    
    # Relacionamento 1-N (Um hóspede tem várias reservas)
    reservas = relationship("Reserva", back_populates="hospede")

class Quarto(Base):
    __tablename__ = 'quarto'
    id_quarto = Column(Integer, primary_key=True, autoincrement=True)
    numero = Column(String(10), unique=True, nullable=False)
    tipo = Column(String(20), nullable=False)
    capacidade = Column(Integer, nullable=False)
    tarifa_base = Column(Numeric(10, 2), nullable=False)
    status = Column(String(20), default='DISPONIVEL')

    # Relacionamentos 1-N
    reservas = relationship("Reserva", back_populates="quarto")
    manutencoes = relationship("Manutencao", back_populates="quarto")

class Temporada(Base):
    __tablename__ = 'temporada'
    id_temporada = Column(Integer, primary_key=True, autoincrement=True)
    nome = Column(String(50), nullable=False)
    data_inicio = Column(Date, nullable=False)
    data_fim = Column(Date, nullable=False)
    multiplicador = Column(Numeric(4, 2), nullable=False)

# ==========================================
# TABELAS DEPENDENTES (Com Foreign Keys)
# ==========================================
class Reserva(Base):
    __tablename__ = 'reserva'
    id_reserva = Column(Integer, primary_key=True, autoincrement=True)
    id_hospede = Column(Integer, ForeignKey('hospede.id_hospede'), nullable=False)
    id_quarto = Column(Integer, ForeignKey('quarto.id_quarto'), nullable=False)
    data_entrada = Column(Date, nullable=False)
    data_saida = Column(Date, nullable=False)
    qtd_hospedes = Column(Integer, nullable=False)
    origem = Column(String(50))
    status = Column(String(20), default='PENDENTE')
    valor_total = Column(Numeric(10, 2), nullable=False)

    # Relacionamentos N-1 (Muitas reservas para 1 hóspede/quarto)
    hospede = relationship("Hospede", back_populates="reservas")
    quarto = relationship("Quarto", back_populates="reservas")
    
    # Relacionamentos 1-N (Uma reserva tem muitos adicionais/pagamentos)
    adicionais = relationship("Adicional", back_populates="reserva")
    pagamentos = relationship("Pagamento", back_populates="reserva")

class Manutencao(Base):
    __tablename__ = 'manutencao'
    id_manutencao = Column(Integer, primary_key=True, autoincrement=True)
    id_quarto = Column(Integer, ForeignKey('quarto.id_quarto'), nullable=False)
    data_inicio = Column(DateTime, nullable=False)
    data_fim = Column(DateTime)
    motivo = Column(String(255), nullable=False)

    quarto = relationship("Quarto", back_populates="manutencoes")

class Adicional(Base):
    __tablename__ = 'adicional'
    id_adicional = Column(Integer, primary_key=True, autoincrement=True)
    id_reserva = Column(Integer, ForeignKey('reserva.id_reserva'), nullable=False)
    descricao = Column(String(100), nullable=False)
    valor = Column(Numeric(10, 2), nullable=False)
    data_lancamento = Column(DateTime, nullable=False)

    reserva = relationship("Reserva", back_populates="adicionais")

class Pagamento(Base):
    __tablename__ = 'pagamento'
    id_pagamento = Column(Integer, primary_key=True, autoincrement=True)
    id_reserva = Column(Integer, ForeignKey('reserva.id_reserva'), nullable=False)
    data_pagamento = Column(DateTime, nullable=False)
    forma_pagamento = Column(String(50), nullable=False)
    valor = Column(Numeric(10, 2), nullable=False)

    reserva = relationship("Reserva", back_populates="pagamentos")