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