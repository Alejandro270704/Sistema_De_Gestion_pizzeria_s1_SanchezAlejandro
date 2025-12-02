-- documento para triggers SQL 

-- Trigger de actualización automática de 
-- stock de ingredientes cuando se realiza un pedido.


delimiter //

create trigger actuaizar_stock_ingrediente
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