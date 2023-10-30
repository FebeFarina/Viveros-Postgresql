create database viveros
\c viveros

create table vivero (
id_vivero serial NOT NULL,
longitud real CHECK (longitud BETWEEN -180 AND 180) NOT NULL,
latitud real CHECK (latitud BETWEEN -90 AND 90 ) NOT NULL,
 PRIMARY KEY(id_vivero)
);

INSERT INTO vivero (id_vivero, longitud, latitud) VALUES (7, 28.6167721, -17.8881046);
INSERT INTO vivero (id_vivero, longitud, latitud) VALUES (2, 29.6238863, -17.8971276);
INSERT INTO vivero (id_vivero, longitud, latitud) VALUES (3, 28.6485041, -17.9003433);
INSERT INTO vivero (id_vivero, longitud, latitud) VALUES (4, 26.9977721, -18.0236046);
INSERT INTO vivero (id_vivero, longitud, latitud) VALUES (1, 22.5443547, -15.5543256);

create table zona (
id_zona serial NOT NULL,
id_vivero serial NOT NULL,
tipo VARCHAR(20) NOT NULL,
longitud real CHECK (longitud BETWEEN -180 AND 180) NOT NULL,
latitud real CHECK (latitud BETWEEN -90 AND 90 ) NOT NULL,
PRIMARY KEY(id_zona),
CONSTRAINT FK_VIVERO
FOREIGN KEY(id_vivero) REFERENCES vivero(id_vivero) ON DELETE CASCADE
);

INSERT INTO zona (id_zona, id_vivero, tipo, longitud, latitud) VALUES (2, 7, 'ALMACEN', 28.6167721, -17.8881046);
INSERT INTO zona (id_zona, id_vivero, tipo, longitud, latitud) VALUES (1, 7, 'ABIERTO', 28.6167689, -17.8881023);
INSERT INTO zona (id_zona, id_vivero, tipo, longitud, latitud) VALUES (3, 7, 'ARBOLEDA', 28.6167697, -17.8881037);
INSERT INTO zona (id_zona, id_vivero, tipo, longitud, latitud) VALUES (4, 1, 'MACETAS', 29.6238863, -17.8971276);
INSERT INTO zona (id_zona, id_vivero, tipo, longitud, latitud) VALUES (5, 2, 'ALMACEN', 22.5443542, -15.5543255);

create table producto (
id_producto serial NOT NULL,
id_zona serial NOT NULL,
tipo VARCHAR(20) NOT NULL,
stock int CHECK (stock >= 0) NOT NULL,
PRIMARY KEY (id_producto),
CONSTRAINT FK_ZONA
FOREIGN KEY(id_zona) REFERENCES zona(id_zona)
);

INSERT INTO producto (id_producto, id_zona, tipo, stock) VALUES (4, 2, 'ABONO', 45);
INSERT INTO producto (id_producto, id_zona, tipo, stock) VALUES (3, 2, 'GIRASOLES', 78);
INSERT INTO producto (id_producto, id_zona, tipo, stock) VALUES (1, 2, 'REGADERAS', 76);
INSERT INTO producto (id_producto, id_zona, tipo, stock) VALUES (2, 2, 'KIT DE SEMILLAS', 100);
INSERT INTO producto (id_producto, id_zona, tipo, stock) VALUES (5, 2, 'MACETAS XL', 10);

create table empleado (
id_empleado serial NOT NULL,
nombre VARCHAR(20),
PRIMARY KEY (id_empleado)
);

INSERT INTO empleado (id_empleado,nombre) VALUES (1, 'Manuel');
INSERT INTO empleado (id_empleado,nombre) VALUES (2, 'Febe');
INSERT INTO empleado (id_empleado,nombre) VALUES (3, 'Aday');
INSERT INTO empleado (id_empleado,nombre) VALUES (4, 'Facundo');
INSERT INTO empleado (id_empleado,nombre) VALUES (5, 'Brayan');

create table clienteplus (
id_cliente serial NOT NULL,
fecha_ingreso DATE NOT NULL,
PRIMARY KEY(id_cliente),
CONSTRAINT FECHA_INGRESO_VALIDA
CHECK (fecha_ingreso <= CURRENT_DATE)
);

INSERT INTO clienteplus (id_cliente, fecha_ingreso) VALUES (1, '2002-12-10');
INSERT INTO clienteplus (id_cliente, fecha_ingreso) VALUES (2, '2010-07-11');
INSERT INTO clienteplus (id_cliente, fecha_ingreso) VALUES (3, '2016-04-23');
INSERT INTO clienteplus (id_cliente, fecha_ingreso) VALUES (4, '2018-03-03');
INSERT INTO clienteplus (id_cliente, fecha_ingreso) VALUES (5, '2007-11-11');

create table trabaja (
fecha_inicio TIMESTAMP NOT NULL,
fecha_fin TIMESTAMP,
id_empleado serial NOT NULL,
id_zona serial NOT NULL,
PRIMARY KEY(fecha_inicio, id_empelado),
CONSTRAINT FK_EMPLEADO
FOREIGN KEY(id_empleado) REFERENCES empleado(id_empleado) ON DELETE CASCADE,
CONSTRAINT FK_ZONA
FOREIGN KEY(id_zona) REFERENCES zona(id_zona) ON DELETE CASCADE,
CONSTRAINT FECHA_VALIDA
CHECK (fecha_fin > fecha_inicio)
);

INSERT INTO trabaja (fecha_inicio, fecha_fin, id_empleado, id_zona) VALUES ('2000-10-30 12:00:00', '2000-10-31 20:00:00', 1, 2);
INSERT INTO trabaja (fecha_inicio, fecha_fin, id_empleado, id_zona) VALUES ('2010-01-01 08:00:00', '2010-03-31 20:00:00', 1, 3);
INSERT INTO trabaja (fecha_inicio, fecha_fin, id_empleado, id_zona) VALUES ('2006-10-30 08:00:00', '2007-10-30 20:00:00', 1, 1);
INSERT INTO trabaja (fecha_inicio, fecha_fin, id_empleado, id_zona) VALUES ('2020-07-23 16:00:00', '2020-07-30 20:00:00', 1, 5);
INSERT INTO trabaja (fecha_inicio, fecha_fin, id_empleado, id_zona) VALUES ('2023-08-28 16:00:00', '2023-08-30 16:00:00', 1, 1);

create table compra (
fecha_compra TIMESTAMP NOT NULL,
id_producto serial NOT NULL,
id_cliente serial NOT NULL,
cantidad int CHECK (cantidad >= 0) NOT NULL,
id_empleado serial NOT NULL,
PRIMARY KEY(fecha_compra, id_producto, id_cliente),
CONSTRAINT FK_PRODUCTO
FOREIGN KEY(id_producto) REFERENCES producto(id_producto) ON DELETE CASCADE,
CONSTRAINT FK_CLIENTE
FOREIGN KEY (id_cliente) REFERENCES clienteplus(id_cliente) ON DELETE CASCADE,
CONSTRAINT FK_EMPLEADO
FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado) ON DELETE CASCADE
);

INSERT INTO compra (fecha_comrpa, id_producto, id_cliente, cantidad, id_empleado) VALUES ('2023-08-28 16:00:00', 1, 1, 7, 1);
INSERT INTO compra (fecha_comrpa, id_producto, id_cliente, cantidad, id_empleado) VALUES ('2023-08-28 16:20:00', 1, 3, 3, 2);
INSERT INTO compra (fecha_comrpa, id_producto, id_cliente, cantidad, id_empleado) VALUES ('2023-08-28 16:25:00', 1, 2, 5, 2);
INSERT INTO compra (fecha_comrpa, id_producto, id_cliente, cantidad, id_empleado) VALUES ('2023-08-28 16:30:00', 1, 3, 2, 4);
INSERT INTO compra (fecha_comrpa, id_producto, id_cliente, cantidad, id_empleado) VALUES ('2023-08-28 16:50:00', 1, 4, 10, 3);


CREATE OR REPLACE VIEW empleado_ventas AS
SELECT e.id_empleado, COUNT(*) AS ventas
FROM empleado e
INNER JOIN compra c ON e.id_empleado = c.id_empleado
GROUP BY e.id_empleado;


CREATE OR REPLACE VIEW clienteplus_compras AS
SELECT cp.id_cliente, COUNT(*) AS compras
FROM clienteplus cp
INNER JOIN compra c ON cp.id_cliente = c.id_cliente
GROUP BY cp.id_cliente;


CREATE OR REPLACE FUNCTION check_compra_cantidad() RETURNS TRIGGER AS $$
BEGIN
    IF (NEW.cantidad > (SELECT stock FROM producto WHERE id_producto = NEW.id_producto)) THEN
        RAISE EXCEPTION 'Insufficient stock for this product';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_insert_update_compra
BEFORE INSERT OR UPDATE ON compra
FOR EACH ROW
EXECUTE FUNCTION check_compra_cantidad();
