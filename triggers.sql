-- documento para triggers SQL 

-- Trigger de actualización automática de 
-- stock de ingredientes cuando se realiza un pedido.


delimiter //

create trigger actualizar_stock_ingrediente
before insert on detalle_pedido
    FOR EACH ROW
BEGIN
update ingrediente i 
left join pizza_ingredientes pi on i.id=pi.id_ingredientes 
set 
i.stock =i.stock -(pi.cantidad_usada * new.cantidad_pizza) 
where
    pi.id_pizza = new.id_pizza;
END //

delimiter ;
--Trigger de auditoría que registre en una tabla historial_precios
-- cada vez que se modifique el precio de una pizza.


--Trigger para marcar repartidor como “disponible” 
--nuevamente cuando termina un domicilio.

--trigger para calcular el total en detalle_pedido y pedido
delimiter //

create trigger calcular_subtotal_detalle
before insert on detalle_pedido
for each row
begin
    declare precio double;
    select precio_base into precio
    from pizza
    where id = NEW.id_pizza;

    set NEW.subtotal = precio * NEW.cantidad_pizza;
end //

delimiter ;



delimiter //

create trigger actualizar_total_pedido
after insert on detalle_pedido
for each row
begin
    declare suma_subtotales double default 0;
    declare iva_total double default 0;
    declare costo_envio double default 0;
    declare tipo varchar(20);

    select sum(subtotal)
    into suma_subtotales
    from detalle_pedido
    where id_pedido = NEW.id_pedido;

    select sum(subtotal * (iva/100))
    into iva_total
    from detalle_pedido
    where id_pedido = NEW.id_pedido;

    select tipo_pedido
    into tipo
    from pedido
    where id = NEW.id_pedido;

    if tipo = 'domicilio' then
        select ifnull(costo_envio,0)
        into costo_envio
        from domicilio
        where id_pedido = NEW.id_pedido
        limit 1;  -- ver a futuro si es necesario o si se deja de implementar
    end if;

    update pedido
    set total = suma_subtotales + iva_total + costo_envio
    where id = NEW.id_pedido;
end //

delimiter ;