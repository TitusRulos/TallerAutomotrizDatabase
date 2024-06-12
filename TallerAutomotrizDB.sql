create database taller_automotriz;
use taller_automotriz;

create table cliente(
	id int primary key auto_increment,
	nombre varchar(25),
	apellido varchar(25),
	pais varchar(50),
	ciudad varchar(50),
	codigo_postal varchar(25),
	direccion varchar(50),
	email varchar(100)
);

create table proveedor(
	id int primary key auto_increment,
	nombre varchar(25),
	descripcion text
);

create table cargo(
	id int primary key auto_increment,
	nombre varchar(25),
	descripcion text
);

create table servicio(
	id int primary key auto_increment,
	nombre varchar(25),
	descripcion text,
	costo decimal (10,2)
);

create table tipo_telefono(
	id int primary key auto_increment,
	tipo varchar(25)
);

create table ubicacion(
	id int primary key auto_increment,
	pais varchar(50),
	ciudad varchar(50),
	codigo_postal varchar(50),
	direccion varchar(50)
);

create table pieza(
	id int primary key auto_increment,
	nombre varchar(50),
	descripcion text,
	precio decimal(10,2),
	proveedor_id int,
	foreign key (proveedor_id) references proveedor(id)
);

create table contacto(
	id int primary key auto_increment,
	nombre varchar(25),
	proveedor_id int,
	foreign key (proveedor_id) references proveedor(id)
);

create table empleado(
	id int primary key auto_increment,
	nombre varchar(25),
	apellido varchar(25),
	cargo_id int,
	foreign key (cargo_id) references cargo(id)
);

create table vehiculo(
	id int primary key auto_increment,
	placa varchar(25),
	marca varchar(25),
	modelo varchar(25),
	año int,
	cliente_id int,
	foreign key (cliente_id) references cliente(id)
);

create table factura(
	id int primary key auto_increment,
	fecha date,
	total decimal(10,2),
	cliente_id int,
	foreign key (cliente_id) references cliente(id)
);

CREATE TABLE inventario (
	nombre varchar(50),
    ubicacion_id INT,
    pieza_id INT,
    cantidad INT,
    PRIMARY KEY (ubicacion_id, pieza_id),
    FOREIGN KEY (ubicacion_id) REFERENCES ubicacion(id),
    FOREIGN KEY (pieza_id) REFERENCES pieza(id)
);

create table orden_compra(
	id int primary key auto_increment,
	fecha date,
	proveedor_id int,
	foreign key (proveedor_id) references proveedor(id),
	empleado_id int,
	foreign key (empleado_id) references empleado(id),
	total decimal(10,2)
);

create table telefono(
    id int primary key auto_increment,
    num varchar(25),
    tipo_entidad enum('c','e','p'),
    cliente_id int,
    empleado_id int,
    contacto_id int,
    tipo_telefono int,
    foreign key (cliente_id) references cliente(id),
    foreign key (empleado_id) references empleado(id),
    foreign key (contacto_id) references contacto(id),
    foreign key (tipo_telefono) references tipo_telefono(id)  
);

create table cita(
	id int primary key auto_increment,
	fecha_hora datetime,
	vehiculo_id int,
	foreign key (vehiculo_id) references vehiculo(id),
	servicio_id int,
	foreign key (servicio_id) references servicio(id)
);

create table reparacion(
	id int primary key auto_increment,
	fecha_hora datetime,
	vehiculo_id int,
	foreign key (vehiculo_id) references vehiculo(id),
	empleado_id int,
	foreign key (empleado_id) references empleado(id),
	servicio_id int,
	foreign key (servicio_id) references servicio(id),
	costo_total decimal(10,2),
	duracion tinyint(3),
	descripcion text
);

create table orden_detalles(
	orden_compra_id int,
	pieza_id int,
	cantidad int,
	precio decimal (10,2),
	primary key (orden_compra_id, pieza_id),
	foreign key (pieza_id) references pieza(id),
	foreign key (orden_compra_id) references orden_compra(id)
);

create table reparacion_pieza(
	reparacion_id int,
	pieza_id int,
	cantidad int,
	primary key (reparacion_id, pieza_id),
	foreign key (pieza_id) references pieza(id),
	foreign key (reparacion_id) references reparacion(id)
);

create table factura_detalles(
    factura_id INT,
    reparacion_id INT,
    pieza_id INT,
    cantidad INT,
    precio DECIMAL(10,2),
    primary key (factura_id, reparacion_id, pieza_id),
    foreign key (reparacion_id, pieza_id) references reparacion_pieza(reparacion_id, pieza_id),
    foreign key (factura_id) references factura(id)    
);

/**------------------------------------------INSERCIONES------------------------------------**/

INSERT INTO cliente (nombre, apellido, pais, ciudad, codigo_postal, direccion, email) VALUES
('Juan', 'Pérez', 'España', 'Madrid', '28001', 'Calle Mayor 1', 'juan.perez@example.com'),
('María', 'Gómez', 'México', 'Ciudad de México', '01234', 'Avenida Reforma 200', 'maria.gomez@example.com'),
('Luis', 'Martínez', 'Argentina', 'Buenos Aires', '1000', 'Calle Florida 123', 'luis.martinez@example.com'),
('Ana', 'Fernández', 'Colombia', 'Bogotá', '110111', 'Carrera 7 89', 'ana.fernandez@example.com'),
('Carlos', 'Rodríguez', 'Chile', 'Santiago', '750056', 'Avenida Providencia 456', 'carlos.rodriguez@example.com'),
('Elena', 'Sánchez', 'Perú', 'Lima', '15001', 'Avenida Larco 789', 'elena.sanchez@example.com');

INSERT INTO proveedor (nombre, descripcion) VALUES
('Proveedor A', 'Proveedor de piezas automotrices A'),
('Proveedor B', 'Proveedor de piezas automotrices B'),
('Proveedor C', 'Proveedor de lubricantes y aceites'),
('Proveedor D', 'Proveedor de neumáticos'),
('Proveedor E', 'Proveedor de baterías y componentes eléctricos'),
('Proveedor F', 'Proveedor de accesorios para vehículos');

INSERT INTO cargo (nombre, descripcion) VALUES
('Mecánico', 'Responsable de reparaciones y mantenimiento'),
('Administrador', 'Gestión de la oficina y coordinación de servicios'),
('Recepcionista', 'Atención al cliente y manejo de citas'),
('Supervisor', 'Supervisión de trabajos y calidad de servicio'),
('Jefe de Taller', 'Coordinación general del taller'),
('Auxiliar', 'Apoyo en tareas varias del taller');

INSERT INTO servicio (nombre, descripcion, costo) VALUES
('Cambio de aceite', 'Cambio de aceite del motor', 50.00),
('Alineación', 'Alineación de las ruedas', 40.00),
('Balanceo', 'Balanceo de las ruedas', 30.00),
('Revisión de frenos', 'Chequeo y ajuste de frenos', 60.00),
('Cambio de batería', 'Reemplazo de la batería del vehículo', 100.00),
('Inspección general', 'Inspección completa del vehículo', 150.00);

INSERT INTO tipo_telefono (tipo) VALUES
('Móvil'),
('Fijo'),
('Fax'),
('Oficina'),
('Residencial'),
('Emergencia');

INSERT INTO ubicacion (pais, ciudad, codigo_postal, direccion) VALUES
('España', 'Madrid', '28001', 'Calle Principal 123'),
('México', 'Ciudad de México', '01234', 'Avenida Central 456'),
('Argentina', 'Buenos Aires', '1000', 'Calle Central 789'),
('Colombia', 'Bogotá', '110111', 'Carrera 7 890'),
('Chile', 'Santiago', '750056', 'Avenida Central 987'),
('Perú', 'Lima', '15001', 'Avenida Principal 654');


INSERT INTO pieza (nombre, descripcion, precio, proveedor_id) VALUES
('Filtro de aceite', 'Filtro de aceite para motor', 10.00, 1),
('Neumático', 'Neumático para vehículos', 50.00, 4),
('Batería', 'Batería de 12V', 70.00, 5),
('Lubricante', 'Lubricante para motor', 20.00, 3),
('Pastillas de freno', 'Juego de pastillas de freno', 30.00, 1),
('Aceite de motor', 'Aceite sintético para motor', 25.00, 3);

INSERT INTO contacto (nombre, proveedor_id) VALUES
('Contacto A', 1),
('Contacto B', 2),
('Contacto C', 3),
('Contacto D', 4),
('Contacto E', 5),
('Contacto F', 6);

INSERT INTO empleado (nombre, apellido, cargo_id) VALUES
('Pedro', 'López', 1),
('Lucía', 'Ramírez', 2),
('Miguel', 'Torres', 3),
('Laura', 'Hernández', 4),
('José', 'García', 5),
('Sara', 'Martínez', 6);

INSERT INTO vehiculo (placa, marca, modelo, año, cliente_id) VALUES
('ENP123', 'Toyota', 'Corolla', 2018, 1),
('JHK456', 'Ford', 'Focus', 2019, 2),
('PLM789', 'Honda', 'Civic', 2017, 3),
('QWE234', 'Chevrolet', 'Cruze', 2020, 4),
('ASD567', 'Mazda', '3', 2021, 5),
('ZXC890', 'Volkswagen', 'Golf', 2016, 6);

INSERT INTO factura (fecha, total, cliente_id) VALUES
('2023-01-15', 150.00, 1),
('2023-02-20', 200.00, 2),
('2023-03-10', 175.00, 3),
('2023-04-05', 225.00, 4),
('2023-05-12', 300.00, 5),
('2023-06-01', 250.00, 6);

INSERT INTO inventario (nombre, ubicacion_id, pieza_id, cantidad) VALUES
('Inventario 1', 1, 1, 100),
('Inventario 1', 1, 2, 50),
('Inventario 3', 2, 3, 80),
('Inventario 4', 2, 4, 30),
('Inventario 5', 3, 5, 40),
('Inventario 6', 3, 6, 60);

INSERT INTO orden_compra (fecha, proveedor_id, empleado_id, total) VALUES
('2023-01-10', 1, 1, 500.00),
('2023-02-15', 2, 2, 750.00),
('2023-03-20', 3, 3, 600.00),
('2023-04-25', 4, 4, 800.00),
('2023-05-30', 5, 5, 700.00),
('2023-06-05', 6, 6, 650.00);

INSERT INTO telefono (num, tipo_entidad, cliente_id, empleado_id, contacto_id, tipo_telefono) VALUES
('123456789', 'c', 1, NULL, NULL, 1),
('987654321', 'e', NULL, 2, NULL, 2),
('555666777', 'p', NULL, NULL, 3, 3),
('111222333', 'c', 2, NULL, NULL, 4),
('444555666', 'e', NULL, 3, NULL, 5),
('777888999', 'p', NULL, NULL, 4, 6);

INSERT INTO cita (fecha_hora, vehiculo_id, servicio_id) VALUES
('2023-01-20 10:00:00', 1, 1),
('2023-02-25 11:00:00', 2, 2),
('2023-03-15 09:00:00', 3, 3),
('2023-04-10 08:00:00', 4, 4),
('2023-05-05 13:00:00', 5, 5),
('2023-06-01 14:00:00', 6, 6);

INSERT INTO reparacion (fecha_hora, vehiculo_id, empleado_id, servicio_id, costo_total, duracion, descripcion) VALUES
('2023-01-21 10:00:00', 1, 1, 1, 150.00, 2, 'Cambio de aceite y filtro'),
('2023-02-26 11:00:00', 2, 2, 2, 200.00, 3, 'Alineación y balanceo'),
('2023-03-16 09:00:00', 3, 3, 3, 175.00, 2, 'Balanceo y revisión de frenos'),
('2023-04-11 08:00:00', 4, 4, 4, 225.00, 4, 'Revisión de frenos y cambio de batería'),
('2023-05-06 13:00:00', 5, 5, 5, 300.00, 3, 'Cambio de batería y aceite'),
('2023-06-02 14:00:00', 6, 6, 6, 250.00, 5, 'Inspección general y cambio de neumáticos');

INSERT INTO orden_detalles (orden_compra_id, pieza_id, cantidad, precio) VALUES
(1, 1, 10, 10.00),
(2, 2, 20, 50.00),
(3, 3, 15, 70.00),
(4, 4, 25, 20.00),
(5, 5, 30, 30.00),
(6, 6, 40, 25.00);

INSERT INTO reparacion_pieza (reparacion_id, pieza_id, cantidad) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 1),
(4, 4, 1),
(5, 5, 1),
(6, 6, 1);

INSERT INTO factura_detalles (factura_id, reparacion_id, pieza_id, cantidad, precio) VALUES
(1, 1, 1, 1, 10.00),
(2, 2, 2, 2, 100.00),
(3, 3, 3, 1, 70.00),
(4, 4, 4, 1, 20.00),
(5, 5, 5, 1, 30.00),
(6, 6, 6, 1, 25.00);



	