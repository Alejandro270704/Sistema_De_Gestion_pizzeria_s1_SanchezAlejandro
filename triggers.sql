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

delimiter //
create trigger auditoría_historial_precios
before update on pizza 
    for each row 
    begin 
    if old.precio_base != new.precio_base then 
    insert into historial_precios (id_pizza,nombre,tamano,precio_anterior,
    precio_nuevo,tipo) values (
        old.id,
        old.nombre,
        old.tamano,
        old.precio_base,
        new.precio_base,
        old.tipo
    );
    end if ;
end; //
delimiter ;
update pizza set precio_base=1000 where id=1;
--Trigger para marcar repartidor como “disponible” 
--nuevamente cuando termina un domicilio.
delimiter //
create trigger calcular_disponibilidad_repartidor
after insert on domicilio 
for each row  
begin
if new.hora_entregada is not null then 
update repartidor
set estado='disponible'
where id = new.id_repartidor;
else
update repartidor
set estado='no disponible'
where id = new.id_repartidor;
end if ;
end; //
delimiter ;
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

    update pedido
    set total = suma_subtotales + iva_total 
    where id = NEW.id_pedido;
end //

delimiter ;

-- triger para calcular costo de envio

delimiter //

create trigger calcular_costo_envio
before insert on domicilio
for each row
begin
    declare v_precio_metro int ;

    select z.precio_metro
    into 
    v_precio_metro
    from repartidor r
    left join zona z on r.id_zona = z.id
    where r.id = new.id_repartidor;

    set new.costo_envio = v_precio_metro * new.distancia_recorrida_metros;
end //

delimiter ;