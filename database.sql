-- documento para creacion de la base de datos SQL 

--creacion de la tabla persona 
create table persona (
    id int primary key,
    nombre varchar(200),
    telefono int,
    direccion varchar(200),
    correo_electronico varchar(200)
);
--creacion de la tabla cliente que hereda persona
create table cliente (
    id int primary key,
    foreign key (id) references persona(id)
);
--creacion de la tabla vendedor que hereda persona
create table vendedor (
    id int primary key,
    foreign key (id) references persona(id)
);
--creacion de la tabla zona
create table zona (
    id int primary key,
    nombre varchar(200),
    precio_metro double
);
--creacion de la tabla repartidor que hereda persona
create table repartidor (
    id int primary key,
    id_zona int,
    estado enum('disponible','no disponible'),
    foreign key (id) references persona(id),
    foreign key (id_zona) references zona(id)
);
--creacion de la tabla pizza
create table pizza (
    id int primary key,
    nombre varchar(200),
    tamano enum('personal','mediana','familiar'),
    precio_base double,
    tipo enum('vegetariana','especial','clásica')
);
--creacion de la tabla ingrediente
create table ingrediente (
    id int primary key,
    nombre varchar(200),
    stock int,
    unidad enum('g','kg','ml','l'),
    nivel_stock int
);
--creacion de la tabla pedido
create table pedido (
    id int primary key,
    id_cliente int,
    id_vededor int,
    fecha_pedido date,
    metodo_pago enum('efectivo','tarjeta','app'),
    estado_pedido enum('pendiente','en preparación','entregado','cancelado'),
    foreign key (id_cliente) references cliente(id),
    foreign key (id_vededor) references vendedor(id)
);
--creacion de la tabla detalle_pedido 
create table detalle_pedido (
    id int primary key,
    id_pedido int,
    id_pizza int,
    cantidad_pizza int,
    iva int,
    total double,
    foreign key (id_pedido) references pedido(id),
    foreign key (id_pizza) references pizza(id)
);
--creacion de la tabla domicilio 
create table domicilio (
    id int primary key,
    id_pedido int,
    id_repartidor int,
    hora_salida date,
    hora_entregada date,
    distancia_recorrida int,
    costo_envio double,
    total_final double,
    foreign key (id_pedido) references pedido(id),
    foreign key (id_repartidor) references repartidor(id)
);
--creacion de la tabla pizza_ingredientes 
create table pizza_ingredientes (
    id int primary key,
    id_ingredientes int,
    id_pizza int,
    foreign key (id_ingredientes) references ingrediente(id),
    foreign key (id_pizza) references pizza(id)
);


-- organizacion de la data 

--data persona
insert into persona values
(1,'Carlos López',3101111111,'Calle 1','carlos@mail.com'),
(2,'María Pérez',3102222222,'Calle 2','maria@mail.com'),
(3,'Juan Gómez',3103333333,'Calle 3','juan@mail.com'),
(4,'Laura Ríos',3104444444,'Calle 4','laura@mail.com'),
(5,'Andrés Ruiz',3105555555,'Calle 5','andres@mail.com'),
(6,'Sofía Castro',3106666666,'Calle 6','sofia@mail.com'),
(7,'Luis Torres',3107777777,'Calle 7','luis@mail.com'),
(8,'Ana López',3108888888,'Calle 8','ana@mail.com'),
(9,'Miguel Díaz',3109999999,'Calle 9','miguel@mail.com'),
(10,'Sara Mendoza',3101212121,'Calle 10','sara@mail.com'),
(11,'Pedro Martínez',3101313131,'Calle 11','pedro@mail.com'),
(12,'Diego Romero',3101414141,'Calle 12','diego@mail.com'),
(13,'Daniela Navas',3101515151,'Calle 13','daniela@mail.com'),
(14,'Hugo Silva',3101616161,'Calle 14','hugo@mail.com'),
(15,'Valentina López',3101717171,'Calle 15','valentina@mail.com'),
(16,'Camilo Ortiz',3101818181,'Calle 16','camilo@mail.com'),
(17,'Paula Castaño',3101919191,'Calle 17','paula@mail.com'),
(18,'Felipe Herrera',3102020202,'Calle 18','felipe@mail.com'),
(19,'Juliana Mora',3102121212,'Calle 19','juliana@mail.com'),
(20,'Ricardo Pardo',3102222333,'Calle 20','ricardo@mail.com');

-- data cliente
insert into cliente values
(1),(2),(3),(4),(5),(6),(7),(8),(9),(10),
(11),(12),(13),(14),(15),(16),(17),(18),(19),(20);
-- data vendedor 
insert into vendedor values
(1),(2),(3),(4),(5),(6),(7),(8),(9),(10),
(11),(12),(13),(14),(15),(16),(17),(18),(19),(20);

--data zona
insert into zona values
(1,'Norte',1200),
(2,'Sur',1500),
(3,'Centro',1000),
(4,'Occidente',1800),
(5,'Oriente',1100),
(6,'Altavista',1300),
(7,'San Mateo',1600),
(8,'Los Alpes',1250),
(9,'Santa Rosa',1400),
(10,'San José',1700),
(11,'El Edén',1350),
(12,'Villa Luz',1450),
(13,'La Pradera',1500),
(14,'San Luis',1750),
(15,'San Marcos',1600),
(16,'La Cima',1550),
(17,'El Bosque',1650),
(18,'Villa Nueva',1480),
(19,'El Dorado',1800),
(20,'La Riviera',1900);
-- data repartidor 
insert into repartidor values
(1,1,'disponible'),
(2,2,'no disponible'),
(3,3,'disponible'),
(4,4,'disponible'),
(5,5,'no disponible'),
(6,6,'disponible'),
(7,7,'disponible'),
(8,8,'no disponible'),
(9,9,'disponible'),
(10,10,'disponible'),
(11,11,'no disponible'),
(12,12,'disponible'),
(13,13,'disponible'),
(14,14,'no disponible'),
(15,15,'disponible'),
(16,16,'disponible'),
(17,17,'no disponible'),
(18,18,'disponible'),
(19,19,'disponible'),
(20,20,'no disponible');

--data pizza 

insert into pizza values
(1,'Margarita','personal',12000,'clásica'),
(2,'Hawaiana','mediana',25000,'especial'),
(3,'Peperoni','familiar',38000,'clásica'),
(4,'Mexicana','personal',15000,'especial'),
(5,'Vegetariana','mediana',26000,'vegetariana'),
(6,'Cuatro Quesos','familiar',40000,'especial'),
(7,'Pollo Champiñón','mediana',27000,'clásica'),
(8,'BBQ','personal',16000,'especial'),
(9,'Carnes','familiar',42000,'especial'),
(10,'Napolitana','personal',13000,'clásica'),
(11,'Toscana','mediana',28000,'especial'),
(12,'Campesina','familiar',36000,'clásica'),
(13,'Ranchera','mediana',29000,'especial'),
(14,'Criolla','personal',15000,'especial'),
(15,'Vegana','mediana',30000,'vegetariana'),
(16,'Deluxe','familiar',45000,'especial'),
(17,'Pollo BBQ','mediana',27000,'clásica'),
(18,'Pepperoni Extra','personal',14000,'clásica'),
(19,'Champiñón','mediana',25000,'vegetariana'),
(20,'Carne y Tocino','familiar',44000,'especial');

--data ingrediente
insert into ingrediente values
(1,'Queso',3000,'g',500),
(2,'Jamón',2000,'g',400),
(3,'Piña',1500,'g',300),
(4,'Peperoni',2500,'g',500),
(5,'Champiñones',1800,'g',300),
(6,'Pollo',2500,'g',400),
(7,'Cebolla',1200,'g',250),
(8,'Tomate',2000,'g',500),
(9,'Carne',3000,'g',400),
(10,'Tocino',2200,'g',300),
(11,'Aceitunas',1500,'g',200),
(12,'Maíz',1800,'g',250),
(13,'Pimentón',1600,'g',200),
(14,'Salsa BBQ',2000,'ml',500),
(15,'Salsa Tomate',3000,'ml',600),
(16,'Orégano',500,'g',100),
(17,'Ajo',600,'g',150),
(18,'Queso Vegano',1500,'g',300),
(19,'Tofu',1200,'g',200),
(20,'Espinaca',1400,'g',250);
-- data pedido
insert into pedido values
(1,1,1,'2025-01-01','efectivo','pendiente'),
(2,2,2,'2025-01-02','tarjeta','en preparación'),
(3,3,3,'2025-01-03','app','entregado'),
(4,4,4,'2025-01-04','efectivo','pendiente'),
(5,5,5,'2025-01-05','app','entregado'),
(6,6,6,'2025-01-06','tarjeta','cancelado'),
(7,7,7,'2025-01-07','efectivo','en preparación'),
(8,8,8,'2025-01-08','tarjeta','entregado'),
(9,9,9,'2025-01-09','app','pendiente'),
(10,10,10,'2025-01-10','efectivo','entregado'),
(11,11,11,'2025-01-11','app','pendiente'),
(12,12,12,'2025-01-12','tarjeta','entregado'),
(13,13,13,'2025-01-13','efectivo','en preparación'),
(14,14,14,'2025-01-14','app','cancelado'),
(15,15,15,'2025-01-15','tarjeta','pendiente'),
(16,16,16,'2025-01-16','efectivo','entregado'),
(17,17,17,'2025-01-17','app','en preparación'),
(18,18,18,'2025-01-18','tarjeta','entregado'),
(19,19,19,'2025-01-19','efectivo','pendiente'),
(20,20,20,'2025-01-20','tarjeta','entregado');
-- data detalle_pedido
insert into detalle_pedido values
(1,1,1,2,19,24000),
(2,2,3,1,21,38000),
(3,3,5,3,19,78000),
(4,4,4,1,20,15000),
(5,5,2,2,19,50000),
(6,6,7,1,22,27000),
(7,7,8,2,19,32000),
(8,8,9,1,19,42000),
(9,9,10,3,19,39000),
(10,10,11,1,21,28000),
(11,11,12,2,19,72000),
(12,12,13,1,22,29000),
(13,13,14,1,20,15000),
(14,14,15,1,22,30000),
(15,15,16,1,19,45000),
(16,16,17,2,21,54000),
(17,17,18,3,19,42000),
(18,18,19,1,19,25000),
(19,19,20,1,21,44000),
(20,20,6,2,22,80000);
-- data domicilio 

insert into domicilio values
(1,1,1,'2025-01-01','2025-01-01',3,5000,29000),
(2,2,2,'2025-01-02','2025-01-02',4,6000,44000),
(3,3,3,'2025-01-03','2025-01-03',2,4000,82000),
(4,4,4,'2025-01-04','2025-01-04',5,7000,22000),
(5,5,5,'2025-01-05','2025-01-05',3,5000,55000),
(6,6,6,'2025-01-06','2025-01-06',4,6000,31000),
(7,7,7,'2025-01-07','2025-01-07',1,3000,35000),
(8,8,8,'2025-01-08','2025-01-08',2,4000,46000),
(9,9,9,'2025-01-09','2025-01-09',3,5000,44000),
(10,10,10,'2025-01-10','2025-01-10',4,6000,34000),
(11,11,11,'2025-01-11','2025-01-11',5,7000,79000),
(12,12,12,'2025-01-12','2025-01-12',2,4000,33000),
(13,13,13,'2025-01-13','2025-01-13',3,5000,34000),
(14,14,14,'2025-01-14','2025-01-14',4,6000,36000),
(15,15,15,'2025-01-15','2025-01-15',3,5000,50000),
(16,16,16,'2025-01-16','2025-01-16',1,3000,57000),
(17,17,17,'2025-01-17','2025-01-17',4,6000,48000),
(18,18,18,'2025-01-18','2025-01-18',5,7000,29000),
(19,19,19,'2025-01-19','2025-01-19',2,4000,25000),
(20,20,20,'2025-01-20','2025-01-20',3,5000,85000);

-- data pizza_ingrediente
insert into pizza_ingredientes values
(1,1,1),
(2,2,2),
(3,3,2),
(4,4,3),
(5,5,4),
(6,6,7),
(7,7,5),
(8,8,9),
(9,9,9),
(10,10,20),
(11,11,11),
(12,12,12),
(13,13,14),
(14,14,8),
(15,15,10),
(16,16,13),
(17,17,6),
(18,18,15),
(19,19,18),
(20,20,19);
