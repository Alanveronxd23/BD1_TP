/*Creacion de la Base de datos*/

CREATE DATABASE IF NOT EXISTS telecomunicaciones;
USE telecomunicaciones;

/*Creacion de cada tabla de la base de datos y sus referencias empezando con una
sin Datos dependientes de alguna otra y yendo a la que sigue, siguiendo este sistema de ingreso*/

CREATE TABLE Provincias (
    id INT PRIMARY KEY,
    provincia VARCHAR(255)
);

CREATE TABLE Localidades (
    id INT PRIMARY KEY,
    localidad VARCHAR(255),
    idProvincia INT,
    FOREIGN KEY (idProvincia) REFERENCES Provincias(id)
);

CREATE TABLE personas (
    id INT PRIMARY KEY,
    tipDocumento INT,
    nroDocumento VARCHAR(255),
    razon_social VARCHAR(255),
    fecNacimiento DATE,
    telefono VARCHAR(20),
    email VARCHAR(255),
    direccion VARCHAR(255),
    idLocalidad INT,
    FOREIGN KEY (idLocalidad) REFERENCES Localidades(id)
);
CREATE TABLE Empleados (
    id INT PRIMARY KEY,
    legajo VARCHAR(50),
    fecContratacion DATE,
    idSupervisor INT,
    FOREIGN KEY (idSupervisor) REFERENCES Empleados(id)
);
CREATE TABLE Sucursales (
    id INT PRIMARY KEY,
    descFantasia VARCHAR(255),
    direccion VARCHAR(255),
    idLocalidad INT,
    idGerenteVta INT,
    FOREIGN KEY (idLocalidad) REFERENCES Localidades(id),
    FOREIGN KEY (idGerenteVta) REFERENCES Empleados(id)
);

CREATE TABLE Servicios (
    id INT PRIMARY KEY,
    servicio VARCHAR(255)
);

CREATE TABLE Paquetes (
    id INT PRIMARY KEY,
    idServicio INT,
    descPack VARCHAR(255),
    inicioVigencia DATE,
    fechaCadu DATE,
    FOREIGN KEY (idServicio) REFERENCES Servicios(id)
);
CREATE TABLE PaquetesTelMovil (
    idPaquete INT PRIMARY KEY,
    cantGB INT,
    cantGBFreeWh INT,
    minFreeCall INT,
    cantFreeSMS INT,
    FOREIGN KEY (idPaquete) REFERENCES Paquetes(id)
);
CREATE TABLE PaquetesHogar (
    idPaquete INT PRIMARY KEY,
    anchoBanda INT,
    limiteGb INT,
    FOREIGN KEY (idPaquete) REFERENCES Paquetes(id)
);
CREATE TABLE PaquetesTelFija (
    idPaquete INT PRIMARY KEY,
    minFree INT,
    cobertura VARCHAR(255),
    FOREIGN KEY (idPaquete) REFERENCES Paquetes(id)
);

CREATE TABLE PaquetesTV (
    idPaquete INT PRIMARY KEY,
    cantCanales INT,
    cantCanalesHD INT,
    FOREIGN KEY (idPaquete) REFERENCES Paquetes(id)
);

CREATE TABLE PacksPremium (
    id INT PRIMARY KEY,
    descripcion VARCHAR(255)
);

CREATE TABLE PaquetesTVPremium (
    idPaqueteTV INT,
    idPackPremium INT,
    PRIMARY KEY (idPaqueteTV, idPackPremium),
    FOREIGN KEY (idPaqueteTV) REFERENCES PaquetesTV(idPaquete),
    FOREIGN KEY (idPackPremium) REFERENCES PacksPremium(id)
);

CREATE TABLE Precios (
    idPaquete INT,
    fecDesde DATE,
    precio DECIMAL(10,2),
    PRIMARY KEY (idPaquete, fecDesde),
    FOREIGN KEY (idPaquete) REFERENCES Paquetes(id)
);

CREATE TABLE Contratos (
    id INT PRIMARY KEY,
    idCliente INT,
    idSucursal INT,
    idVendedor INT,
    diaFacturacion INT,
    diaRenCido INT,
    FOREIGN KEY (idCliente) REFERENCES personas(id),
    FOREIGN KEY (idSucursal) REFERENCES Sucursales(id),
    FOREIGN KEY (idVendedor) REFERENCES Empleados(id)
);

CREATE TABLE detContratos (
    idContrato INT,
    idPaquete INT,
    domInstalacion INT,   
    telContratado VARCHAR(255),
    PRIMARY KEY (idContrato, idPaquete),
    FOREIGN KEY (idContrato) REFERENCES Contratos(id),
    FOREIGN KEY (idPaquete) REFERENCES Paquetes(id)
);


/*Ingresando datos a las tablas para probar cosas*/


INSERT INTO Provincias (id, provincia) VALUES (1, 'Buenos Aires'),(2, 'Córdoba'),(3, 'Santa Fe');
INSERT INTO Localidades (id, localidad, idProvincia) VALUES (1, 'La Plata', 1),(2, 'Córdoba Capital', 2),(3, 'Rosario', 3);
INSERT INTO personas (id, tipDocumento, nroDocumento, razon_social, fecNacimiento, telefono, email, direccion, idLocalidad) VALUES (1, 1, '30111222', 'Juan Perez', '1985-06-15', '2211234567', 'juan@mail.com', 'Calle Falsa 123', 1),(2, 1, '28456789', 'Maria Gomez', '1990-08-23', '3517654321', 'maria@mail.com', 'Av Siempre Viva 742', 2);
INSERT INTO Empleados (id, legajo, fecContratacion, idSupervisor) VALUES (1, 'E001', '2020-01-10', NULL),(2, 'E002', '2021-03-15', 1);
INSERT INTO Sucursales (id, descFantasia, direccion, idLocalidad, idGerenteVta) VALUES (1, 'Sucursal Central', 'Av Libertador 1000', 1, 1),(2, 'Sucursal Córdoba', 'Bv San Juan 500', 2, 2);
INSERT INTO Servicios (id, servicio) VALUES (1, 'Internet'),(2, 'Telefonía Móvil'),(3, 'Telefonía Fija'),(4, 'Televisión');
INSERT INTO Paquetes (id, idServicio, descPack, inicioVigencia, fechaCadu) VALUES (1, 1, 'Internet 100Mb', '2023-01-01', '2025-12-31'),(2, 2, 'Movil 10GB', '2023-01-01', '2025-12-31'),(3, 4, 'TV Básico', '2023-01-01', '2025-12-31');
INSERT INTO PaquetesTelMovil (idPaquete, cantGB, cantGBFreeWh, minFreeCall, cantFreeSMS) VALUES (2, 10, 5, 200, 100);
INSERT INTO PaquetesHogar (idPaquete, anchoBanda, limiteGb) VALUES (1, 100, 500);
INSERT INTO PaquetesTV (idPaquete, cantCanales, cantCanalesHD) VALUES (3, 80, 30);
INSERT INTO Precios (idPaquete, fecDesde, precio) VALUES (1, '2023-01-01', 2500.00),(2, '2023-01-01', 2000.00),(3, '2023-01-01', 1800.00);
INSERT INTO Contratos (id, idCliente, idSucursal, idVendedor, diaFacturacion, diaRenCido) VALUES (1, 1, 1, 2, 10, 10),(2, 2, 2, 2, 15, 15);
INSERT INTO detContratos (idContrato, idPaquete, domInstalacion, telContratado) VALUES (1, 1, 123, NULL),(1, 2, 123, '2217654321'),(2, 3, 456, NULL);
INSERT INTO PacksPremium (id, descripcion) VALUES (1, 'Pack Cine'),(2, 'Pack Deportes');
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