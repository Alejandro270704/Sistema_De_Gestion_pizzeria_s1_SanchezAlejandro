-- documento para creacion de la base de datos SQL 

create table persona (
    id int primary key,
    nombre varchar(200),
    telefono int,
    direccion varchar(200),
    correo_electronico varchar(200)
);

create table cliente (
    id int primary key,
    foreign key (id) references persona(id)
);

create table vendedor (
    id int primary key,
    foreign key (id) references persona(id)
);

create table zona (
    id int primary key,
    nombre varchar(200),
    precio_metro double
);

create table repartidor (
    id int primary key,
    id_zona int,
    estado enum('disponible','no disponible'),
    foreign key (id) references persona(id),
    foreign key (id_zona) references zona(id)
);

create table pizza (
    id int primary key,
    nombre varchar(200),
    tamano enum('personal','mediana','familiar'),
    precio_base double,
    tipo enum('vegetariana','especial','clásica')
);

create table ingrediente (
    id int primary key,
    nombre varchar(200),
    stock int,
    unidad enum('g','kg','ml','l'),
    nivel_stock int
);

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

create table pizza_ingredientes (
    id int primary key,
    id_ingredientes int,
    id_pizza int,
    foreign key (id_ingredientes) references ingrediente(id),
    foreign key (id_pizza) references pizza(id)
);
