# Priorización de Requerimientos (MoSCoW): Sistema de Tiquetes Aéreos

### M - Must Have (Requisitos Obligatorios)
* **Seguridad y Control de Acceso:** El sistema debe contar con un módulo de inicio de sesión exclusivo para el agente de la aerolínea, garantizando que solo el personal autorizado pueda gestionar las operaciones, utilizando contraseñas seguras.
* **Gestión de Pasajeros y Reservas:** Debe existir la capacidad completa de crear y consultar el registro de pasajeros (documento, nombre, fecha de nacimiento) y gestionar sus solicitudes previas de vuelo (reservas).
* **Gestión de Vuelos y Aeropuertos:** El sistema debe permitir la creación de itinerarios detallados, vinculando una aeronave específica y estableciendo claramente el aeropuerto de origen y el de destino para cada vuelo.
* **Emisión de Tiquetes:** Es obligatorio que el sistema pueda transformar una reserva confirmada en un tiquete oficial, asignando una clase de servicio.
* **Asignación de Asientos Inequívoca:** Se requiere un mecanismo de asignación de asientos que impida, bajo cualquier circunstancia, que el mismo asiento de un avión sea asignado a dos pasajeros diferentes en el mismo vuelo.
* **Registro de Servicios Adicionales (Equipaje y Pagos):** El sistema debe permitir al agente registrar las piezas de equipaje y el pago asociado al tiquete, cumpliendo con el flujo operativo completo, incluso si el pasajero viaja sin equipaje.
* **Control de Abordaje:** Es indispensable registrar el momento exacto y la puerta por la cual el pasajero ingresa al avión.
* **Reporte Operativo de Ausencias (No-Show):** El sistema debe generar un informe preciso que cruce la información de los tiquetes emitidos con los registros de abordaje, para identificar a los pasajeros que compraron su tiquete pero no viajaron.
* **Rendimiento Exigido:** Todas las operaciones de consulta deben ejecutarse en un tiempo máximo de medio segundo, soportando hasta diez mil registros sin interrupciones.

### S - Should Have (Requisitos Altamente Recomendables)
* **Localización y Formato:** Toda la interfaz y los mensajes de error deben presentarse en un lenguaje claro en español. Asimismo, las fechas, horas y valores monetarios deben respetar los formatos locales para evitar confusiones operativas.

### C - Could Have (Requisitos Opcionales o Deseables)
* **Herramientas de Búsqueda Avanzada:** Implementación de filtros para que el agente localice rápidamente la información de un pasajero o una reserva específica utilizando el número de documento de identidad.
* **Selección Gráfica de Asientos:** Incorporación de un mapa interactivo de la aeronave que facilite al agente la visualización y selección de los asientos disponibles durante el proceso de asignación.
* **Notificaciones Automatizadas:** Capacidad del sistema para enviar confirmaciones por correo electrónico al pasajero una vez que se emite el tiquete o se realiza el pago.
* **Impresión de Documentos:** Funcionalidad integrada para imprimir directamente el pase de abordar físico desde la estación de trabajo del agente.

### W - Won't Have (Requisitos Excluidos de esta Versión)
* **Plataforma de Autogestión (Portal de Pasajeros):** El alcance del proyecto se limita exclusivamente a las herramientas para el agente de la aerolínea; no se desarrollará un sitio web para ventas directas al público.
* **Procesamiento de Pagos Electrónicos:** El sistema registrará el pago mediante un número de referencia para control interno, pero no incluirá conexiones directas con pasarelas bancarias o procesamiento de tarjetas de crédito.
* **Programa de Viajero Frecuente:** No se contempla la acumulación de millas ni la gestión de beneficios o categorías de lealtad para los pasajeros en esta fase del proyecto.
