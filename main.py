import os
from dotenv import load_dotenv
from sqlalchemy import create_engine, func, desc
from sqlalchemy.orm import sessionmaker
from models import Hospede, Quarto, Reserva, Adicional, Pagamento

# Configuração de conexão com o banco de dados
load_dotenv()
DB_USER = os.getenv("DB_USER")
DB_PASS = os.getenv("DB_PASS")
DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_NAME = os.getenv("DB_NAME")

# Monta a URL de conexão do PostgreSQL
DATABASE_URL = f"postgresql+psycopg2://{DB_USER}:{DB_PASS}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
engine = create_engine(DATABASE_URL, echo=False)
Session = sessionmaker(bind=engine)
session = Session()

print("Conectado ao banco de dados com sucesso!\n")

print("--- EXECUTANDO CRUD ---")

# CREATE: Inserir pelo menos 3 registros
novo_hospede1 = Hospede(nome="Lucas Python", cpf="123123123", email="lucas@python.com", telefone="1199999999")
novo_hospede2 = Hospede(nome="Maria Silva", cpf="456456456", email="maria@sql.com", telefone="2188888888")
novo_hospede3 = Hospede(nome="João Delete", cpf="789789789", email="joao@delete.com", telefone="3177777777")

session.add_all([novo_hospede1, novo_hospede2, novo_hospede3])
session.commit()
print("➕ CREATE: 3 Hóspedes inseridos com sucesso!")

# READ: Listar registros com ordenação
quartos = session.query(Quarto).order_by(Quarto.tarifa_base.desc()).all()
print("\n📖 READ: Lista de Quartos ordenados por tarifa (do mais caro pro mais barato):")
for q in quartos:
    print(f"Quarto {q.numero} - {q.tipo} - R$ {q.tarifa_base}")

# UPDATE: Atualizar 1 registro
quarto_para_atualizar = session.query(Quarto).filter_by(numero='101').first()
if quarto_para_atualizar:
    quarto_para_atualizar.status = 'MANUTENCAO'
    session.commit()
    print(f"\n✏️ UPDATE: Status do quarto {quarto_para_atualizar.numero} alterado para {quarto_para_atualizar.status}.")

# DELETE: Remover 1 registro (Respeitando integridade, apagamos o hóspede sem reservas)
hospede_deletar = session.query(Hospede).filter_by(nome="João Delete").first()
if hospede_deletar:
    session.delete(hospede_deletar)
    session.commit()
    print(f"\n🗑️ DELETE: Hóspede '{hospede_deletar.nome}' removido com sucesso!")


# ==========================================
# PARTE 4: CONSULTAS COM RELACIONAMENTO
# ==========================================
print("\n--- EXECUTANDO CONSULTAS ORM ---")

# Consulta 1 (JOIN): Listar entidades A trazendo dados de B
# Objetivo: Ver quais hóspedes estão com reserva em status de CHECKIN
print("\n🔍 Consulta 1 (JOIN): Hóspedes atualmente no hotel (CHECKIN)")
hospedes_checkin = session.query(Hospede, Reserva).join(Reserva).filter(Reserva.status == 'CHECKIN').all()
for hospede, reserva in hospedes_checkin:
    print(f"Hóspede: {hospede.nome} | Entrada: {reserva.data_entrada}")

# Consulta 2 (JOIN + Agregação):
# Objetivo: Total pago por cada reserva usando relacionamento
print("\n🔍 Consulta 2 (Agregação + JOIN): Total recebido por reserva")
total_pagamentos = session.query(
    Reserva.id_reserva, 
    func.sum(Pagamento.valor).label('total_pago')
).join(Pagamento).group_by(Reserva.id_reserva).all()

for reserva_id, total in total_pagamentos:
    print(f"Reserva ID: {reserva_id} | Total Pago: R$ {total}")

# Consulta 3 (Filtro + Ordenação):
# Objetivo: Top 3 itens adicionais mais caros já consumidos
print("\n🔍 Consulta 3 (Filtro + Ordenação): Top 3 consumos mais caros")
top_adicionais = session.query(Adicional).filter(Adicional.valor > 10).order_by(desc(Adicional.valor)).limit(3).all()
for ad in top_adicionais:
    print(f"Item: {ad.descricao} | Valor: R$ {ad.valor}")

session.close()