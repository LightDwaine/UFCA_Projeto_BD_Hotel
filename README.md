# Projeto Hotel - Banco de Dados | UFCA
Projeto acadêmico desenvolvido para uma tarefa da disciplina de Projeto de Banco de Dados do curso de Análise e Desenvolvimento de Sistemas (ADS) da UFCA (Universidade Federal do Cariri).

Este repositório contém a modelagem, implementação e integração de um banco de dados relacional projetado para simular o funcionamento de um hotel, desde a infraestrutura física até o faturamento de estadias.

# Tecnologias e Ferramentas utilizadas
SGBD: PostgreSQL 

Linguagem: Python 3 

ORM: SQLAlchemy 2.0.48 

Driver: psycopg2 2.9.11

env: dotenv 1.2.2

# PASSO A PASSO DE COMO EXECUTAR O PROJETO
**PASSO 1: Clonar o repositório e preparar o banco de dados**
 - Clone este repositório para o seu ambiente local:
    - Caso tenha o Githubd Desktop instalado na sua maquina, clique nessa opção:<img width="504" height="426" alt="image" src="https://github.com/user-attachments/assets/a862f7c1-bb5c-4758-90b0-66e8bb22daf1" />
    - Caso não tenha, no git bash digite esses comandos: <br/>
      ```
      git clone [URL do meu repositório]
      cd UFCA_Projeto_BD_Hotel
      ```
- Crie um banco de dados vazio no PostgreSQL.
- Copie, cole e execute o SQL do arquivo `bd_tema_oito_schema.sql` e depois o do arquivo `bd_tema_oito_INSERTS.sql` nessa ordem.

**PASSO 2: Configurar variáveis de ambiente**
Por motivo de segurança, credenciais não serão públicas. Você deve criar um arquivo de configuração local:
- Na raiz do projeto, crie um arquivo chamado exatamente `.env`.
- Insira as credenciais referentes ao seu banco de dados, seguindo a estrutura abaixo:<br/>
```
DB_USER=postgres
DB_PASS=sua_senha_aqui
DB_HOST=localhost
DB_PORT=5432
DB_NAME=nome_do_seu_banco_aqui
```

**PASSO 3: Configurar o ambiente virtual**
Para evitar conflitos de dependências, utilize um ambiente virtual Python:
- Crie o ambiente, no terminal do VSCode ou uma IDE com terminal:
 ```
python -m venv venv
 ```

- Ative o ambiente virtual:
  - **Windows:** `venv\Scripts\activate`
  - **Linux:** `source venv/bin/activate`

**PASSO 4: Instalar dependências**
Com o ambiente ativado (venv), instale as bibliotecas necessárias para esse projeto:
- No terminal digite:
  ```
  pip install -r requirements.txt
  ```
  
**PASSO 5: Executar o projeto** <br/>
- No terminal digite:
  ```
  python main.py
  ```

# Evidências
