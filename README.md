# TallerAutomotrizDatabase

Este proyecto define una base de datos para la gestión de un taller automotriz. La base de datos incluye información sobre clientes, proveedores, empleados, vehículos, inventario de piezas, servicios y más.

## Entidades y sus Descripciones

### Cliente
- **Campos:**
  - id (INT, PK, AUTO_INCREMENT)
  - nombre (VARCHAR(25))
  - apellido (VARCHAR(25))
  - pais (VARCHAR(50))
  - ciudad (VARCHAR(50))
  - codigo_postal (VARCHAR(25))
  - direccion (VARCHAR(50))
  - email (VARCHAR(100))
- **Funcionalidad:**
  - Almacena información personal de los clientes del taller.
- **Relaciones:**
  - Relacionado con la tabla vehiculo (cliente_id)
  - Relacionado con la tabla factura (cliente_id)
  - Relacionado con la tabla telefono (cliente_id)

### Proveedor
- **Campos:**
  - id (INT, PK, AUTO_INCREMENT)
  - nombre (VARCHAR(25))
  - descripcion (TEXT)
- **Funcionalidad:**
  - Almacena información sobre los proveedores del taller.
- **Relaciones:**
  - Relacionado con la tabla pieza (proveedor_id)
  - Relacionado con la tabla contacto (proveedor_id)
  - Relacionado con la tabla orden_compra (proveedor_id)

### Cargo
- **Campos:**
  - id (INT, PK, AUTO_INCREMENT)
  - nombre (VARCHAR(25))
  - descripcion (TEXT)
- **Funcionalidad:**
  - Almacena información sobre los distintos cargos de los empleados.
- **Relaciones:**
  - Relacionado con la tabla empleado (cargo_id)

### Servicio
- **Campos:**
  - id (INT, PK, AUTO_INCREMENT)
  - nombre (VARCHAR(25))
  - descripcion (TEXT)
  - costo (DECIMAL(10,2))
- **Funcionalidad:**
  - Almacena información sobre los servicios que ofrece el taller.
- **Relaciones:**
  - Relacionado con la tabla cita (servicio_id)
  - Relacionado con la tabla reparacion (servicio_id)

### Tipo_Telefono
- **Campos:**
  - id (INT, PK, AUTO_INCREMENT)
  - tipo (VARCHAR(25))
- **Funcionalidad:**
  - Almacena información sobre los tipos de teléfono.
- **Relaciones:**
  - Relacionado con la tabla telefono (tipo_telefono)

### Ubicacion
- **Campos:**
  - id (INT, PK, AUTO_INCREMENT)
  - pais (VARCHAR(50))
  - ciudad (VARCHAR(50))
  - codigo_postal (VARCHAR(50))
  - direccion (VARCHAR(50))
- **Funcionalidad:**
  - Almacena información sobre las ubicaciones del taller.
- **Relaciones:**
  - Relacionado con la tabla inventario (ubicacion_id)

### Pieza
- **Campos:**
  - id (INT, PK, AUTO_INCREMENT)
  - nombre (VARCHAR(50))
  - descripcion (TEXT)
  - precio (DECIMAL(10,2))
  - proveedor_id (INT, FK)
- **Funcionalidad:**
  - Almacena información sobre las piezas disponibles en el taller.
- **Relaciones:**
  - Relacionado con la tabla proveedor (proveedor_id)
  - Relacionado con la tabla inventario (pieza_id)
  - Relacionado con la tabla orden_detalles (pieza_id)
  - Relacionado con la tabla reparacion_pieza (pieza_id)

### Contacto
- **Campos:**
  - id (INT, PK, AUTO_INCREMENT)
  - nombre (VARCHAR(25))
  - proveedor_id (INT, FK)
- **Funcionalidad:**
  - Almacena información de los contactos de los proveedores.
- **Relaciones:**
  - Relacionado con la tabla proveedor (proveedor_id)
  - Relacionado con la tabla telefono (contacto_id)

### Empleado
- **Campos:**
  - id (INT, PK, AUTO_INCREMENT)
  - nombre (VARCHAR(25))
  - apellido (VARCHAR(25))
  - cargo_id (INT, FK)
- **Funcionalidad:**
  - Almacena información de los empleados del taller.
- **Relaciones:**
  - Relacionado con la tabla cargo (cargo_id)
  - Relacionado con la tabla telefono (empleado_id)
  - Relacionado con la tabla orden_compra (empleado_id)
  - Relacionado con la tabla reparacion (empleado_id)

### Vehiculo
- **Campos:**
  - id (INT, PK, AUTO_INCREMENT)
  - placa (VARCHAR(25))
  - marca (VARCHAR(25))
  - modelo (VARCHAR(25))
  - año (INT)
  - cliente_id (INT, FK)
- **Funcionalidad:**
  - Almacena información sobre los vehículos de los clientes.
- **Relaciones:**
  - Relacionado con la tabla cliente (cliente_id)
  - Relacionado con la tabla cita (vehiculo_id)
  - Relacionado con la tabla reparacion (vehiculo_id)

### Factura
- **Campos:**
  - id (INT, PK, AUTO_INCREMENT)
  - fecha (DATE)
  - total (DECIMAL(10,2))
  - cliente_id (INT, FK)
- **Funcionalidad:**
  - Almacena información sobre las facturas emitidas a los clientes.
- **Relaciones:**
  - Relacionado con la tabla cliente (cliente_id)
  - Relacionado con la tabla factura_detalles (factura_id)

### Inventario
- **Campos:**
  - nombre (VARCHAR(50))
  - ubicacion_id (INT, FK)
  - pieza_id (INT, FK)
  - cantidad (INT)
- **Funcionalidad:**
  - Almacena información sobre las piezas en inventario y su ubicación.
- **Relaciones:**
  - Relacionado con la tabla ubicacion (ubicacion_id)
  - Relacionado con la tabla pieza (pieza_id)

### Orden_Compra
- **Campos:**
  - id (INT, PK, AUTO_INCREMENT)
  - fecha (DATE)
  - proveedor_id (INT, FK)
  - empleado_id (INT, FK)
  - total (DECIMAL(10,2))
- **Funcionalidad:**
  - Almacena información sobre las órdenes de compra realizadas por el taller.
- **Relaciones:**
  - Relacionado con la tabla proveedor (proveedor_id)
  - Relacionado con la tabla empleado (empleado_id)
  - Relacionado con la tabla orden_detalles (orden_compra_id)
 
### Telefono
- **Campos:**
  - id (INT, PK, AUTO_INCREMENT)
  - num (VARCHAR(25))
  - tipo_entidad (ENUM('c', 'e', 'p'))
  - cliente_id (INT, FK)
  - empleado_id (INT, FK)
  - contacto_id (INT, FK)
  - tipo_telefono (INT, FK)
- **Funcionalidad:**
  - Almacena información sobre los teléfonos de clientes, empleados y contactos.
- **Relaciones:**
  - Relacionado con la tabla cliente (cliente_id)
  - Relacionado con la tabla empleado (empleado_id)
  - Relacionado con la tabla contacto (contacto_id)
  - Relacionado con la tabla tipo_telefono (tipo_telefono)

### Cita
- **Campos:**
  - id (INT, PK, AUTO_INCREMENT)
  - fecha_hora (DATETIME)
  - vehiculo_id (INT, FK)
  - servicio_id (INT, FK)
- **Funcionalidad:**
  - Almacena información sobre las citas programadas en el taller.
- **Relaciones:**
  - Relacionado con la tabla vehiculo (vehiculo_id)
  - Relacionado con la tabla servicio (servicio_id)

### Reparacion
- **Campos:**
  - id (INT, PK, AUTO_INCREMENT)
  - fecha_hora (DATETIME)
  - vehiculo_id (INT, FK)
  - empleado_id (INT, FK)
  - servicio_id (INT, FK)
  - costo_total (DECIMAL(10,2))
  - duracion (TINYINT(3))
  - descripcion (TEXT)
- **Funcionalidad:**
  - Almacena información sobre las reparaciones realizadas en el taller.
- **Relaciones:**
  - Relacionado con la tabla vehiculo (vehiculo_id)
  - Relacionado con la tabla empleado (empleado_id)
  - Relacionado con la tabla servicio (servicio_id)
  - Relacionado con la tabla reparacion_pieza (reparacion_id)

### Orden_Detalles
- **Campos:**
  - orden_compra_id (INT, FK)
  - pieza_id (INT, FK)
  - cantidad (INT)
  - precio (DECIMAL(10,2))
- **Funcionalidad:**
  - Almacena los detalles de cada orden de compra.
- **Relaciones:**
  - Relacionado con la tabla orden_compra (orden_compra_id)
  - Relacionado con la tabla pieza (pieza_id)

### Reparacion_Pieza
- **Campos:**
  - reparacion_id (INT, FK)
  - pieza_id (INT, FK)
  - cantidad (INT)
- **Funcionalidad:**
  - Almacena las piezas utilizadas en cada reparación.
- **Relaciones:**
  - Relacionado con la tabla reparacion (reparacion_id)
  - Relacionado con la tabla pieza (pieza_id)

### Factura_Detalles
- **Campos:**
  - factura_id (INT, FK)
  - reparacion_id (INT, FK)
  - pieza_id (INT, FK)
  - cantidad (INT)
  - precio (DECIMAL(10,2))
- **Funcionalidad:**
  - Almacena los detalles de cada factura emitida.
- **Relaciones:**
  - Relacionado con la tabla factura (factura_id)
  - Relacionado con la tabla reparacion_pieza (reparacion_id, pieza_id)
