-- documento para funciones SQL 

-- Función para calcular el total de un pedido 
--(sumando precios de pizzas + costo de envío + IVA).
delimiter //
create function calcular_total( id_pedido int)
returns double
deterministic
begin 

declare total_final double ;

select
sum(p.precio_base * dp.cantidad_pizza) +
sum(p.precio_base * dp.cantidad_pizza * (dp.iva/100)) +
max(d.costo_envio)
into total_final
from detalle_pedido dp
left join pizza p on dp.id_pizza = p.id
left join domicilio d on d.id_pedido = dp.id_pedido
where dp.id_pedido = id_pedido;
return total_final;
end; //
delimiter ;


select calcular_total(5);

--Función para calcular la ganancia neta diaria 
--(ventas - costos de ingredientes).
delimiter //
create function calcular_ganancia(v_fecha date)
returns double
deterministic
begin 
declare ganancia_neta double;
select 
sum(pg.cantidad_pagada-pzi.cantidad_usada) sum(pzi.cantidad_usada*)into ganancia_neta
from pago_pedido pg
left join detalle_pedido dp on pg.id_pedido=dp.id_pedido
left join pizza pz on pz.id=pg.id_pizza
left join pizza_ingredientes pzi pzi.id_pizza=pz.id
left join ingrediente i on pzi.id_ingredientes=i.id 

return ganancia_neta ;
end; //
delimiter ;
--Procedimiento para cambiar automáticamente el estado
-- del pedido a “entregado” cuando se registre la hora de entrega.


-- procedimiento para insersiones

delimiter //
create procedure insertar_persona (
    in p_nombre varchar(200),
    in p_telefono varchar(200),
    in p_direccion varchar(200),
    in p_correo varchar(200)
)
begin 
    insert into persona (nombre, telefono, direccion, correo_electronico)
    values (p_nombre, p_telefono, p_direccion, p_correo);
end //
delimiter ;


delimiter //

create procedure insertar_cliente(
    in p_id_persona int
)
begin
    insert into cliente(id)
    values (p_id_persona);
end //

delimiter ;


delimiter //

create procedure insertar_vendedor(
    in p_id_persona int
)
begin
    insert into vendedor(id)
    values (p_id_persona);
end //

delimiter ;

delimiter //

create procedure insertar_zona(
    in p_nombre varchar(200),
    in p_precio_metro double
)
begin
    insert into zona(nombre, precio_metro)
    values (p_nombre, p_precio_metro);
end //

delimiter ;

delimiter //

create procedure insertar_repartidor(
    in p_id_persona int,
    in p_id_zona int
)
begin
    insert into repartidor(id, id_zona)
    values (p_id_persona, p_id_zona);
end //

delimiter ;


delimiter //

create procedure insertar_pizza(
    in p_nombre varchar(200),
    in p_tamano enum('personal','mediana','familiar'),
    in p_precio_base double,
    in p_tipo enum('vegetariana','especial','clásica')
)
begin
    insert into pizza(nombre, tamano, precio_base, tipo)
    values (p_nombre, p_tamano, p_precio_base, p_tipo);
end //

delimiter ;


delimiter //

create procedure insertar_ingrediente(
    in p_nombre varchar(200),
    in p_stock int,
    in p_precio int,
    in p_unidad enum('g','kg','ml','l'),
    in p_nivel_stock int
)
begin
    insert into ingrediente(nombre, stock, precio, unidad, nivel_stock)
    values (p_nombre, p_stock, p_precio, p_unidad, p_nivel_stock);
end //

delimiter ;


delimiter //

create procedure insertar_pedido(
    in p_id_cliente int,
    in p_id_vendedor int,
    in p_fecha date,
    in p_metodo_pago enum('efectivo','tarjeta','app'),
    in p_estado enum('pendiente','en preparación','entregado','cancelado'),
    in p_tipo enum('domicilio','local')
)
begin
    insert into pedido(id_cliente, id_vededor, fecha_pedido, metodo_pago, estado_pedido, tipo_pedido)
    values (p_id_cliente, p_id_vendedor, p_fecha, p_metodo_pago, p_estado, p_tipo);
end //

delimiter ;


delimiter //

create procedure insertar_pago_pedido(
    in p_id_pedido int,
    in p_cantidad double,
    in p_fecha date
)
begin
    insert into pago_pedido(id_pedido, cantidad_pagada, fecha_pago)
    values (p_id_pedido, p_cantidad, p_fecha);
end //

delimiter ;


delimiter //

create procedure insertar_detalle_pedido(
    in p_id_pedido int,
    in p_id_pizza int,
    in p_cantidad int,
    in p_iva int,
    in p_subtotal double
)
begin
    insert into detalle_pedido(id_pedido, id_pizza, cantidad_pizza, iva, subtotal)
    values (p_id_pedido, p_id_pizza, p_cantidad, p_iva, p_subtotal);
end //

delimiter ;


delimiter //

create procedure insertar_domicilio(
    in p_id_pedido int,
    in p_id_repartidor int,
    in p_salida datetime,
    in p_entrega datetime,
    in p_distancia int,
    in p_costo double
)
begin
    insert into domicilio(id_pedido, id_repartidor, hora_salida, hora_entregada, distancia_recorrida_metros, costo_envio)
    values (p_id_pedido, p_id_repartidor, p_salida, p_entrega, p_distancia, p_costo);
end //

delimiter ;


delimiter //

create procedure insertar_pizza_ingredientes(
    in p_id_ingrediente int,
    in p_cantidad int,
    in p_unidad enum('g','kg','ml','l'),
    in p_id_pizza int
)
begin
    insert into pizza_ingredientes(id_ingredientes, cantidad_usada, unidad, id_pizza)
    values (p_id_ingrediente, p_cantidad, p_unidad, p_id_pizza);
end //

delimiter ;




