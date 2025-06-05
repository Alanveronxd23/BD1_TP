/*Creacion de la Base de datos*/

CREATE DATABASE IF NOT EXISTS telecomunicaciones;
USE telecomunicaciones;

DROP TABLE IF EXISTS detContratos;
DROP TABLE IF EXISTS Contratos;
DROP TABLE IF EXISTS Precios;
DROP TABLE IF EXISTS PaquetesTVPremium;
DROP TABLE IF EXISTS PacksPremium;
DROP TABLE IF EXISTS PaquetesTV;
DROP TABLE IF EXISTS PaquetesTelFija;
DROP TABLE IF EXISTS PaquetesHogar;
DROP TABLE IF EXISTS PaquetesTelMovil;
DROP TABLE IF EXISTS Paquetes;
DROP TABLE IF EXISTS Servicios;
DROP TABLE IF EXISTS Sucursales;
DROP TABLE IF EXISTS Empleados;
DROP TABLE IF EXISTS personas;
DROP TABLE IF EXISTS Localidades;
DROP TABLE IF EXISTS Provincias;

/*Creacion de cada tabla de la base de datos y sus referencias empezando con una
sin Datos dependientes de alguna otra y yendo a la que sigue, siguiendo este sistema de ingreso*/

CREATE TABLE Provincias 
(
    id_cliente INT PRIMARY KEY,
    provincia VARCHAR(255)
);

CREATE TABLE Localidades 
(
    id_cliente INT PRIMARY KEY,
    localidad VARCHAR(255),
    idProvincia INT,
    FOREIGN KEY (idProvincia) REFERENCES Provincias(id_cliente)
);

CREATE TABLE personas 
(
    id_cliente INT PRIMARY KEY,
    tipDocumento INT,
    nroDocumento VARCHAR(255),
    razon_social VARCHAR(255),
    fecNacimiento DATE,
    telefono VARCHAR(20),
    email VARCHAR(255),
    direccion VARCHAR(255),
    idLocalidad INT,
    FOREIGN KEY (idLocalidad) REFERENCES Localidades(id_cliente)
);
CREATE TABLE Empleados 
(
    id_cliente INT PRIMARY KEY,
    legajo VARCHAR(50),
    fecContratacion DATE,
    idSupervisor INT,
    FOREIGN KEY (id_cliente) REFERENCES personas(id_cliente),
    FOREIGN KEY (idSupervisor) REFERENCES Empleados(id_cliente)
);
CREATE TABLE Sucursales 
(
    id_cliente INT PRIMARY KEY,
    descFantasia VARCHAR(255),
    direccion VARCHAR(255),
    idLocalidad INT,
    idGerenteVta INT,
    FOREIGN KEY (idLocalidad) REFERENCES Localidades(id_cliente),
    FOREIGN KEY (idGerenteVta) REFERENCES Empleados(id_cliente)
);

CREATE TABLE Servicios 
(
    id_cliente INT PRIMARY KEY,
    servicio VARCHAR(255)
);

CREATE TABLE Paquetes (
    id_cliente INT PRIMARY KEY,
    idServicio INT,
    descPack VARCHAR(255),
    inicioVigencia DATE,
    fechaCaducacion DATE,
    FOREIGN KEY (idServicio) REFERENCES Servicios(id_cliente)
);
CREATE TABLE PaquetesTelMovil 
(
    idPaquete INT PRIMARY KEY,
    cantGB INT,
    cantGBFreeWh INT,
    minFreeCall INT,
    cantFreeSMS INT,
    FOREIGN KEY (idPaquete) REFERENCES Paquetes(id_cliente)
);
CREATE TABLE PaquetesHogar 
(
    idPaquete INT PRIMARY KEY,
    anchoBanda INT,
    limiteGb INT,
    FOREIGN KEY (idPaquete) REFERENCES Paquetes(id_cliente)
);
CREATE TABLE PaquetesTelFija 
(
    idPaquete INT PRIMARY KEY,
    minFree INT,
    cobertura VARCHAR(255),
    FOREIGN KEY (idPaquete) REFERENCES Paquetes(id_cliente)
);

CREATE TABLE PaquetesTV 
(
    idPaquete INT PRIMARY KEY,
    cantCanales INT,
    cantCanalesHD INT,
    FOREIGN KEY (idPaquete) REFERENCES Paquetes(id_cliente)
);

CREATE TABLE PacksPremium 
(
    id_cliente INT PRIMARY KEY,
    descripcion VARCHAR(255)
);

CREATE TABLE PaquetesTVPremium 
(
    idPaqueteTV INT,
    idPackPremium INT,
    PRIMARY KEY (idPaqueteTV, idPackPremium),
    FOREIGN KEY (idPaqueteTV) REFERENCES PaquetesTV(idPaquete),
    FOREIGN KEY (idPackPremium) REFERENCES PacksPremium(id_cliente)
);

CREATE TABLE Precios 
(
    idPaquete INT,
    fecDesde DATE,
    precio DECIMAL(10,2),
    PRIMARY KEY (idPaquete, fecDesde),
    FOREIGN KEY (idPaquete) REFERENCES Paquetes(id_cliente)
);

CREATE TABLE Contratos 
(
    id_cliente INT PRIMARY KEY,
    idCliente INT,
    idSucursal INT,
    idVendedor INT,
    diaFacturacion INT,
    diaRenCido INT,
    FOREIGN KEY (idCliente) REFERENCES personas(id_cliente),
    FOREIGN KEY (idSucursal) REFERENCES Sucursales(id_cliente),
    FOREIGN KEY (idVendedor) REFERENCES Empleados(id_cliente)
);

CREATE TABLE detContratos 
(
    idContrato INT,
    idPaquete INT,
    domInstalacion INT,   
    telContratado VARCHAR(255),
    PRIMARY KEY (idContrato, idPaquete),
    FOREIGN KEY (idContrato) REFERENCES Contratos(id_cliente),
    FOREIGN KEY (idPaquete) REFERENCES Paquetes(id_cliente)
);


/*Ingresando datos a las tablas para probar cosas*/


INSERT INTO Provincias (id_cliente, provincia) VALUES (1, 'Buenos Aires'),(2, 'Córdoba'),(3, 'Santa Fe');
INSERT INTO Localidades (id_cliente, localidad, idProvincia) VALUES (1, 'La Plata', 1),(2, 'Córdoba Capital', 2),(3, 'Rosario', 3);
INSERT INTO personas (id_cliente, tipDocumento, nroDocumento, razon_social, fecNacimiento, telefono, email, direccion, idLocalidad) VALUES (1, 1, '30111222', 'Juan Perez', '1985-06-15', '2211234567', 'juan@mail.com', 'Calle Falsa 123', 1),(2, 1, '28456789', 'Maria Gomez', '1990-08-23', '3517654321', 'maria@mail.com', 'Av Siempre Viva 742', 2);
INSERT INTO Empleados (id_cliente, legajo, fecContratacion, idSupervisor) VALUES (1, 'E001', '2020-01-10', NULL),(2, 'E002', '2021-03-15', 1);
INSERT INTO Sucursales (id_cliente, descFantasia, direccion, idLocalidad, idGerenteVta) VALUES (1, 'Sucursal Central', 'Av Libertador 1000', 1, 1),(2, 'Sucursal Córdoba', 'Bv San Juan 500', 2, 2);
INSERT INTO Servicios (id_cliente, servicio) VALUES (1, 'Internet'),(2, 'Telefonía Móvil'),(3, 'Telefonía Fija'),(4, 'Televisión');
INSERT INTO Paquetes (id_cliente, idServicio, descPack, inicioVigencia, fechaCaducacion) VALUES (1, 1, 'Internet 100Mb', '2023-01-01', '2025-12-31'),(2, 2, 'Movil 10GB', '2023-01-01', '2025-12-31'),(3, 4, 'TV Básico', '2023-01-01', '2025-12-31');
INSERT INTO PaquetesTelMovil (idPaquete, cantGB, cantGBFreeWh, minFreeCall, cantFreeSMS) VALUES (2, 10, 5, 200, 100);
INSERT INTO PaquetesHogar (idPaquete, anchoBanda, limiteGb) VALUES (1, 100, 500);
INSERT INTO PaquetesTV (idPaquete, cantCanales, cantCanalesHD) VALUES (3, 80, 30);
INSERT INTO Precios (idPaquete, fecDesde, precio) VALUES (1, '2023-01-01', 2500.00),(2, '2023-01-01', 2000.00),(3, '2023-01-01', 1800.00);
INSERT INTO Contratos (id_cliente, idCliente, idSucursal, idVendedor, diaFacturacion, diaRenCido) VALUES (1, 1, 1, 2, 10, 10),(2, 2, 2, 2, 15, 15);
INSERT INTO detContratos (idContrato, idPaquete, domInstalacion, telContratado) VALUES (1, 1, 123, NULL),(1, 2, 123, '2217654321'),(2, 3, 456, NULL);
INSERT INTO PacksPremium (id_cliente, descripcion) VALUES (1, 'Pack Cine'),(2, 'Pack Deportes');
INSERT INTO PaquetesTVPremium (idPaqueteTV, idPackPremium) VALUES (3, 1),(3, 2);

/*Mostrar todas las tablas una por una*/


SELECT * FROM Provincias;
SELECT * FROM Localidades;
SELECT * FROM personas;
SELECT * FROM Empleados;
SELECT * FROM Sucursales;
SELECT * FROM Servicios;
SELECT * FROM Paquetes;
SELECT * FROM PaquetesTelMovil;
SELECT * FROM PaquetesHogar;
SELECT * FROM PaquetesTV;
SELECT * FROM Precios;
SELECT * FROM Contratos;
SELECT * FROM detContratos;
SELECT * FROM PacksPremium;
SELECT * FROM PaquetesTVPremium;


SELECT provincia FROM Provincias;

/*Describiendo las tablas y como es la estructura de cada una*/


DESCRIBE Provincias;
DESCRIBE Localidades;
DESCRIBE personas;
DESCRIBE Empleados;
DESCRIBE Sucursales;
DESCRIBE Servicios;
DESCRIBE Paquetes;
DESCRIBE PaquetesTelMovil;
DESCRIBE PaquetesHogar;
DESCRIBE Precios;
DESCRIBE Contratos;
DESCRIBE detContratos;
DESCRIBE PacksPremium;
DESCRIBE PaquetesTVPremium;

-- consultas y analisis de datos

-- 1)  Clientes con más de un paquete contratado

SELECT c.idCliente 'id cliente', p.razon_social 'nombre y apellido', COUNT(*) 'cantidad de paquetes'
FROM Contratos c
INNER JOIN detContratos dc ON c.id_cliente = dc.idContrato
INNER JOIN personas p ON c.idCliente = p.id_cliente
GROUP BY c.idCliente, p.razon_social
HAVING COUNT(*) > 1;

/*seleccionamos para mostrar el id del cliente, el nombre y apellido y la cantidad de paquetes
hacemos inner join de contratos con det contratos y personas, para ver solo las personas que tienen contratos
agrupamos por id del cliente y nombre del cliente y hacemos el having para ponerle la condicion que sea mayor a 1.
utilizamos count, inner join, group by y having*/

-- 2) mostrar el paquete mas caro y su fecha

SELECT idPaquete 'paquete', fecDesde 'fecha desde', precio
FROM Precios
WHERE precio = (SELECT MAX(precio) FROM Precios);
     
-- seleccionamos el paquete, la fecha y el precio. hacemos una subconsulta y utilizamos la funcion max/

-- 3) total facturado por cada contrato

SELECT c.id 'id del contrato', SUM(pre.precio) 'total facturado'
FROM Contratos c
INNER JOIN detContratos dc ON c.id = dc.idContrato
INNER JOIN Precios pre ON dc.idPaquete = pre.idPaquete
GROUP BY c.id_cliente;

/*seleccionamos los id de los contratos, creamos una columna para sumar el total del precio de cada contrato
hacemos inner join con detcontratos y los precios conectado desde los id y precios
y agrupamos por el id de cada contrato.
utilizamos la funcion SUM y tambien group by*/

-- 4) cliente que contrato el precio mas alto

SET @precioMax = (SELECT MAX(precio) FROM Precios);

SELECT p.razon_social 'nombre y apellido', c.id 'contrato', pre.precio 'precio'
FROM personas p
INNER JOIN Contratos c ON p.id = c.idCliente
INNER JOIN detContratos dc ON c.id = dc.idContrato
INNER JOIN Precios pre ON dc.idPaquete = pre.idPaquete
WHERE pre.precio = @precioMax;

/*seleccionamos la razon social, id del contrato y el precio
hacemos inner join con contratos, detcontratos y precios
indexando los clientes que tienen contratos con los paquetes y precios de paquetes
y ponemos la condicion de que muestre la persona que pago el precio maximo
utilizamos lo antes visto y una variable*/
