delimiter //
create trigger atualizar_total_ingressos
after insert on ingresso_compra
for each row
begin
    declare v_id_evento int;

select fk_id_evento
into v_id_evento
from ingresso
where id_ingresso = new.fk_id_ingresso;

      -- Verificar se o evento já existe na tabela de resumo
    if exists (
        select * from resumo_evento where id_evento = v_id_evento
    ) then
        -- Atualiza o total de ingressos
        update resumo_evento
        set total_ingressos = total_ingressos + new.quantidade
        where id_evento = v_id_evento;
    else
        -- Insere novo registro no resumo
        insert into resumo_evento (id_evento, total_ingressos)
        values (v_id_evento, new.quantidade);
    end if;
end; //

delimiter ;