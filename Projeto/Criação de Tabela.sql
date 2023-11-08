-- Criação do Banco de Dados

CREATE DATABASE IF NOT EXISTS VENDAS_SUCOS_TREINAMENTO
DEFAULT CHARACTER SET UTF8; -- Não necessário, ele identifica o Conjunto na Maquina.. Preciso colocar somente se for outro diferente da minha máquina

CREATE TABLE IF NOT EXISTS PRODUTOS(
    CODIGO VARCHAR (10) NOT NULL PRIMARY KEY,
    DESCRITOR VARCHAR (100) NULL,
    SABOR VARCHAR (50) NULL,
    TAMANHO VARCHAR (50) NULL,
    EMBALAGEM VARCHAR(50) NULL,
    PRECO_LISTA FLOAT NULL
);


CREATE TABLE IF NOT EXISTS VENDEDORES (
    MATRICULA VARCHAR (5) NOT NULL,
    NOME VARCHAR (100) NULL, 
    BAIRRO VARCHAR (50) NULL,
    COMISSAO FLOAT NULL,
    DATA_ADMISSAOo DATE NULL,
    FERIAS BIT(1),
PRIMARY KEY(MATRICULA)
);

-- tab clientes foi feita com o Assistente

/* Digitei errado a Coluna Data_Admissão, se ela fosse uma PK teriamos problemas para alterar, seria melhor até derrubar a Tabela..
mas como é uma coluna normal nós podemos alterar com o código abaixo

Sobre a PF eu creio que seja por causa da ligações dela*/

ALTER TABLE VENDEDORES RENAME COLUMN DATA_ADMISSAOo TO DATA_ADMISSAO;



CREATE TABLE IF NOT EXISTS TABELA_DE_VENDAS(
     NUMERO VARCHAR (5) NOT NULL PRIMARY KEY,
     DATA_VENDA DATE NULL,
     CPF VARCHAR(11) NOT NULL, -- Por esse campo que vai ser ligado pela FK com o CPF da Tab Cliente, é bom colocar Not NULL
     MATRICULA VARCHAR(5) NOT NULL,
     IMPOSTO FLOAT NULL
); -- Crio sem o FK

-- Alterar a tabela, adicionando um novo relacionamento
ALTER TABLE TABELA_DE_VENDAS ADD CONSTRAINT 
FK_CLIENTE FOREIGN KEY (CPF) REFERENCES CLIENTE (CPF);

ALTER TABLE TABELA_DE_VENDAS ADD CONSTRAINT
FK_VENDEDORES FOREIGN KEY (MATRICULA) REFERENCES VENDEDORES (MATRICULA);

-- Todas essas ligações nós os chamamos de Constraint, seria restrições/ relacionamento


-- Troca o nome da tabela por Notas, que faz mais sentido

ALTER TABLE tabela_de_vendas RENAME Notas;

CREATE TABLE IF NOT EXISTS ITENS_NOTAS(
     NUMERO VARCHAR (5) NOT NULL, 
     CODIGO VARCHAR (10) NOT NULL,
     QUANTIDADE INT ,
	 PRECO FLOAT,
PRIMARY KEY (NUMERO, CODIGO) -- Dá outra maneira dava Multipla Primary Key definidas
);

-- Essa tabela trata-se de um Chave Primária Composta, onde há duas PKs
/*uma nota fiscal pode ter vários itens, então se eu colocar somente número 
como PK, vai dar problema, porque aí não vou conseguir ter mais de um item,
mas o que diferencia cada item de uma nota fiscal? É o código do produto. */


ALTER TABLE ITENS_NOTAS ADD CONSTRAINT FK_NOTAS 
FOREIGN KEY (NUMERO) 
REFERENCES NOTAS (NUMERO);

ALTER TABLE ITENS_NOTAS ADD CONSTRAINT FK_PRDUTOS
FOREIGN KEY (CODIGO)
REFERENCES PRODUTOS (CODIGO);