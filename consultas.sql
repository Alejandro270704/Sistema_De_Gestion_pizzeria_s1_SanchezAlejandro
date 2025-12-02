-- documento para consultas SQL 

--Clientes con pedidos entre dos fechas (BETWEEN).
delimiter //
create procedure pedidos_por_fecha (in v_fecha1 varchar(200),v_fecha2 varchar(200))
begin 
select 
p.id,
p.id_cliente,
p.id_vededor,
p.fecha_pedido,
p.metodo_pago,
p.estado_pedido, 
p.tipo_pedido,p.total
from pedido p where fecha_pedido between v_fecha1 and  v_fecha2 ;
end; //
delimiter ;
call pedidos_por_fecha(' 2025-01-01',' 2025-01-09');

--Pizzas más vendidas (GROUP BY y COUNT).
delimiter //
create procedure pizza_mas_vendidas()
begin 
select 
p.nombre,
sum(dp.cantidad_pizza) as total_vendido
from detalle_pedido dp
left join  pizza p on dp.id_pizza=p.id
group by dp.id_pizza
order by total_vendido desc; 
end; // 
delimiter ;
call pizza_mas_vendidas(); 

--Pedidos por repartidor (JOIN).
delimiter //
create procedure pedido_repartidor()
begin 
select 
d.id,
p.nombre
from domicilio d 
left join repartidor r on d.id_repartidor=r.id
left join persona p on p.id=r.id ; 

end; // 
delimiter ;
call pedido_repartidor(); 
--Promedio de entrega por zona (AVG y JOIN).
--Clientes que gastaron más de un monto (HAVING).
--Búsqueda por coincidencia parcial de nombre de pizza (LIKE).
--Subconsulta para obtener los clientes frecuentes (más de 5 pedidos mensuales).