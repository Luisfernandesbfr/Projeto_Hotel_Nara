CREATE DATABASE Projeto;

USE Projeto;
CREATE TABLE canal(
canal_id INT primary key,
canal_nome VARCHAR(100),
canal_grupo VARCHAR(100));


SET GLOBAL local_infile = 1;

LOAD DATA INFILE "C:/Users/namisi.oliveira/Desktop/d_canal.csv"
INTO TABLE canal
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(canal_id,canal_nome,canal_grupo); # nome das colunas 


CREATE TABLE data_hospedagem(
data_id INT primary key,
data_hospedagem date,
ano INT,
mes VARCHAR(100),
nome_mes INT,
trimestre INT,
dia_semana INT,
fim_de_semana_flag INT,
feriado_flag INT,
alta_temporada_flag INT);


LOAD DATA INFILE "C:/Users/namisi.oliveira/Desktop/d_data.csv"
INTO TABLE data_hospedagem
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(data_id,data_hospedagem,ano,mes,nome_mes,trimestre,dia_semana,fim_de_semana_flag,feriado_flag,alta_temporada_flag); # nome das colunas 



CREATE TABLE hospede(
hospede_id INT primary key,
pais VARCHAR(100),
uf VARCHAR(100),
cidade VARCHAR(100),
faixa_etaria VARCHAR(100),
segmento VARCHAR(100));


LOAD DATA INFILE "C:/Users/namisi.oliveira/Desktop/d_hospede.csv"
INTO TABLE Hospede
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(hospede_id,pais,uf,cidade,faixa_etaria,segmento); # nome das colunas 


CREATE TABLE hotel(
hotel_id INT primary key,
nome VARCHAR(100),
cidade VARCHAR(100),
uf VARCHAR(100),
categoria_estrelas INT,
possui_spa_flag INT);



LOAD DATA INFILE "C:/Users/namisi.oliveira/Desktop/d_hotel.csv"
INTO TABLE hotel
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(hotel_id,nome,cidade,uf,categoria_estrelas,possui_spa_flag); # nome das colunas 



CREATE TABLE motivos_cancelamento(
motivo_id INT primary key,
categoria VARCHAR(100),
descricao VARCHAR(100));



LOAD DATA INFILE "C:/Users/namisi.oliveira/Desktop/d_motivo_cancelamento.csv"
INTO TABLE motivos_cancelamento
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(motivo_id,categoria,descricao); # nome das colunas 



CREATE TABLE plano_tarifario(
rate_plan_id INT primary key,
nome_plano VARCHAR(100),
reembolsavel_flag INT,
cafe_incluso_flag INT,
politica_cancelamento VARCHAR(150));



LOAD DATA INFILE "C:/Users/namisi.oliveira/Desktop/d_plano_tarifario.csv"
INTO TABLE plano_tarifario
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(rate_plan_id,nome_plano,reembolsavel_flag,cafe_incluso_flag,politica_cancelamento); # nome das colunas



CREATE TABLE tipo_quarto(
tipo_quarto_id INT primary key,
tipo_quarto VARCHAR(100),
capacidade INT);



LOAD DATA INFILE "C:/Users/namisi.oliveira/Desktop/d_tipo_quarto.csv"
INTO TABLE tipo_quarto
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(tipo_quarto_id,tipo_quarto,capacidade); # nome das colunas



CREATE TABLE agencia(
agencia_id INT primary key,
nome VARCHAR(100),
tipo VARCHAR(100),
comissao_pct DECIMAL(3,2));



LOAD DATA INFILE  "C:/Users/namisi.oliveira/Desktop/d_agencia.csv"
INTO TABLE agencia
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(agencia_id,nome,tipo,comissao_pct); # nome das colunas



CREATE TABLE reservas(
reserva_id INT primary key,
data_reserva_id INT,
data_cancelamento_id INT ,
motivo_cancelamento_id INT,
checkin_id INT,
checkout_id INT,
hotel_id INT,
hospede_id INT,
canal_id INT,
agencia_id INT,
rate_plan_id INT,
tipo_quarto VARCHAR(100),
status_reserva VARCHAR(100),
adultos INT,
criancas INT,
valor_previsto DECIMAL(10,2),
desconto DECIMAL(10,2),
moeda VARCHAR(100),
FOREIGN KEY (motivo_cancelamento_id) REFERENCES motivos_cancelamento(motivo_id),
FOREIGN KEY (hotel_id) REFERENCES hotel(hotel_id),
FOREIGN KEY (hospede_id) REFERENCES hospede(hospede_id),
FOREIGN KEY (canal_id) REFERENCES canal(canal_id),
FOREIGN KEY (agencia_id) REFERENCES agencia(agencia_id),
FOREIGN KEY (rate_plan_id) REFERENCES plano_tarifario(rate_plan_id));



LOAD DATA INFILE  "C:/Users/namisi.oliveira/Desktop/f_reservas_sem_duplicadas.csv"
INTO TABLE reservas
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(reserva_id,data_reserva_id,data_cancelamento_id,motivo_cancelamento_id,checkin_id,checkout_id,hotel_id,hospede_id,canal_id,agencia_id,rate_plan_id,tipo_quarto,status_reserva,adultos,criancas,valor_previsto,desconto,moeda); # nome das colunas



CREATE TABLE pagamentos(
pagamento_id INT primary key,
reserva_id INT,
data_pagamento_id INT,
forma_pagamento VARCHAR(100),
valor_pago DECIMAL(10,2),
status_pagamento VARCHAR(100),
taxa_gateway DECIMAL(10,2),
FOREIGN KEY (reserva_id) REFERENCES reservas(reserva_id));

LOAD DATA INFILE "C:/Users/namisi.oliveira/Desktop/f_pagamentos.csv"   
INTO TABLE pagamentos
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(pagamento_id,reserva_id,data_pagamento_id,forma_pagamento,valor_pago,status_pagamento,taxa_gateway); # nome das colunas


CREATE TABLE reviews(
review_id INT primary key,
reserva_id INT,
data_review_id INT,
nota DECIMAL(10,2),
limpeza DECIMAL(10,2),
localizacao DECIMAL(10,2),
atendimento DECIMAL(10,2),
comentario_flag INT,
FOREIGN KEY (reserva_id) REFERENCES reservas(reserva_id));

LOAD DATA INFILE  "C:/Users/namisi.oliveira/Desktop/f_reviews_limpo.csv" 
INTO TABLE reviews
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(review_id,reserva_id,data_review_id,nota,limpeza,localizacao,atendimento,comentario_flag); # nome das colunas



CREATE TABLE diarias_e_inventarios(
hotel_id INT, 
data_id INT, 
tipo_quarto VARCHAR(100), 
quartos_vendidos INT, 
adr_estimado DECIMAL(10,2), 
receita_diarias DECIMAL(10,2), 
quartos_total INT, 
quartos_manutencao INT, 
quartos_disponiveis INT);

LOAD DATA INFILE "C:/Users/namisi.oliveira/Desktop/f_diarias_inventario_sem_negativos.csv"
INTO TABLE diarias_e_inventarios
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(hotel_id,data_id,tipo_quarto,quartos_vendidos,adr_estimado,receita_diarias,quartos_total,quartos_manutencao,quartos_disponiveis); # nome das colunas



CREATE TABLE overbooking(
hotel_id INT,
data_id INT,
tipo_quarto VARCHAR(100),
quartos_vendidos INT,
adr_estimado DECIMAL(10,2),
receita_diarias DECIMAL(10,2),
quartos_total INT, 
quartos_manutencao INT,
quartos_disponiveis INT);

LOAD DATA INFILE "C:/Users/namisi.oliveira/Desktop/Overbooking.csv"
INTO TABLE overbooking
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(hotel_id,data_id,tipo_quarto,quartos_vendidos,adr_estimado,receita_diarias,quartos_total,quartos_manutencao,quartos_disponiveis); # nome das colunas

SELECT* FROM overbooking;