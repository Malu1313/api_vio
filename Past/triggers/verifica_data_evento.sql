delimiter //

create trigger verifica_data_evento
before insert on ingresso_compra
for each row
begin
    declare data_evento datetime;

    
    -- Obtem a data do evento
select e.data_hora into v_data_evento
from ingresso i
join evento e on i.fk_id_evento = e.id_evento
where i.id_ingresso = p_id_ingresso;

-- Verificarse a data do evento é menor que a atual
if date(v_data_evento) < curdate() then
signal sqlstate '45000'
set message_text= 'ERRO_PROCEDURE - Não é possível comprar ingressos para eventos passados!';
end if;
-- Criar registro na tabela 'compra'
insert into compra (data_compra, fk_id_usuario)
values (now(), p_id_usuario);

-- Obter o ID da compra recém-criada
set v_id_compra = last_insert_id();

-- Registrar os ingressos comprados
insert into ingresso_compra (fk_id_compra, fk_id_ingresso, quantidade)
values (v_id_compra, p_id_ingresso, p_quantidade);
end


insert into evento (nome, data_hora, local, descricao, fk_id_organizador)
values ('Feira cultural de inverno', '2025-07-20 18:00:00', 'Parque Municipal', 'Evento cultural com música e gastronomia.', 1);

-- confirmar criação do evento
select * from evento;




insert into ingresso (preco, tipo, fk_id_evento)
values
(120.00, 'vip', 4),
(60.00, 'pista', 4);