show tables;
select * From pagamentos;


-- Total de reservas por status
SELECT status_reserva,COUNT(*) AS total_reservas
FROM reservas
GROUP BY status_reserva;


-- Quantidade de reservas por canal

SELECT canal.canal_nome,COUNT(reservas.reserva_id) AS total_reservas
FROM reservas
JOIN canal canal ON reservas.canal_id = canal.canal_id
GROUP BY canal.canal_nome
ORDER BY total_reservas DESC;

-- Motivos Cancelamentos
SELECT motivos_cancelamento.descricao,COUNT(*) AS total_cancelamentos
FROM reservas
JOIN motivos_cancelamento ON reservas.motivo_cancelamento_id = motivos_cancelamento.motivo_id
WHERE reservas.status_reserva = 'Cancelada'
GROUP BY motivos_cancelamento.descricao
ORDER BY total_cancelamentos DESC;

-- Pagamentos concluidos

SELECT SUM(valor_pago) AS receita_realizada
FROM pagamentos
WHERE status_pagamento = 'Aprovado';


-- Reservas por tipo de quarto 
SELECT tipo_quarto,COUNT(*) AS total_reservas
FROM reservas
GROUP BY tipo_quarto
ORDER BY total_reservas DESC;


-- Forma de pagamento mais utilizada 
SELECT forma_pagamento,COUNT(*) AS qtd_pagamentos
FROM pagamentos
GROUP BY forma_pagamento
ORDER BY qtd_pagamentos DESC;

-- Receita liquida
SELECT SUM(valor_pago - taxa_gateway) AS receita_liquida
FROM pagamentos
WHERE status_pagamento = 'Aprovado';

-- Reservas por faixa etaria
SELECT hospede.faixa_etaria,COUNT(*) AS total_reservas FROM reservas
JOIN hospede ON reservas.hospede_id = hospede.hospede_id
GROUP BY hospede.faixa_etaria
ORDER BY total_reservas DESC;

-- Quantidade de reviews por Hotel
SELECT hotel.nome AS hotel,COUNT(reviews.review_id) AS total_reviews
FROM reviews 
JOIN reservas  ON reviews.reserva_id = reservas.reserva_id
JOIN hotel  ON reservas.hotel_id = hotel.hotel_id
GROUP BY hotel.nome
ORDER BY total_reviews DESC;


-- Valor medio das reservas

SELECT ROUND(AVG(valor_previsto),2) AS valor_medio
FROM reservas;




