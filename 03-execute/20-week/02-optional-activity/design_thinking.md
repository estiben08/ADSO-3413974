# Metodología de Resolución (Design Thinking): Sistema de Tiquetes Aéreos

### Fase 1: Empatizar (Comprensión del Usuario)
El análisis se centra en el único actor del sistema para esta fase: el agente de la aerolínea. Este usuario opera en un entorno de atención al cliente que demanda inmediatez y precisión. El agente necesita gestionar múltiples tareas consecutivas —desde registrar datos personales hasta confirmar abordajes— mientras atiende directamente al pasajero. Las principales frustraciones en este rol surgen cuando los sistemas son lentos, cuando la información de los vuelos es confusa, o cuando la plataforma permite errores graves, como la sobreventa o la duplicación de asientos, lo cual genera conflictos directos en el aeropuerto.

### Fase 2: Definir (Planteamiento del Problema)
El objetivo fundamental es diseñar y construir una plataforma de gestión centralizada que garantice la integridad absoluta de las operaciones de la aerolínea. El problema central a resolver es la orquestación de un flujo de trabajo que vincule a un pasajero, un vuelo específico (definido por origen y destino), un tiquete y un asiento, asegurando que ninguna asignación se duplique. Adicionalmente, el sistema debe resolver la necesidad administrativa de identificar de forma inmediata y precisa a los pasajeros denominados "No-Show" (aquellos que adquirieron un tiquete pero no registraron su ingreso a la aeronave), manteniendo tiempos de respuesta inferiores a medio segundo.

### Fase 3: Idear (Estructuración de la Solución)
Para cumplir con los estrictos requerimientos de integridad y rendimiento, se estructura la siguiente solución tecnológica:
* **Procesamiento Central (Motor del Sistema):** Se utilizará el lenguaje de programación Go. Esta decisión técnica responde directamente a la necesidad de garantizar tiempos de respuesta ultra rápidos (menores a 500 milisegundos) y a su capacidad para manejar múltiples transacciones simultáneas sin degradar el rendimiento del sistema.
* **Interfaz de Usuario (Panel del Agente):** Se implementará utilizando Angular. Esto permitirá construir una herramienta de trabajo fluida y estructurada, donde el agente pueda llenar formularios de reserva y asignación de asientos con validaciones inmediatas, sin experimentar tiempos de carga prolongados.
* **Gestión y Almacenamiento de Datos:** Se empleará el sistema PostgreSQL. Esta base de datos es la solución idónea para garantizar las complejas reglas de negocio del proyecto, como asegurar que un aeropuerto pueda ser tanto origen como destino, que los asientos dependan de una aeronave específica, y, lo más crítico, que la conexión entre el pasajero, el vuelo y el asiento sea completamente única y a prueba de errores.

### Fase 4: Prototipar (Diseño Visual y de Interacción)
El diseño inicial contemplará las siguientes interfaces estructuradas, priorizando la facilidad de uso para el agente:
1. **Acceso Seguro:** Pantalla de validación de credenciales.
2. **Panel de Control (Dashboard):** Vista general que permita consultar rápidamente los itinerarios y los vuelos programados.
3. **Módulo de Gestión de Pasajeros y Reservas:** Formularios ágiles para el ingreso de datos personales y la creación de solicitudes de viaje.
4. **Módulo de Operación de Vuelo:** Interfaz central para convertir reservas en tiquetes, registrar el pago, ingresar la información del equipaje y realizar la asignación del asiento en la aeronave.
5. **Módulo de Abordaje y Auditoría:** Pantalla para registrar el ingreso final del pasajero al avión y una sección dedicada exclusivamente a generar el reporte de los pasajeros ausentes (No-Show).

### Fase 5: Evaluar (Validación y Pruebas)
La validación del sistema se realizará asegurando el cumplimiento íntegro de los criterios de aceptación:
* **Simulación Operativa:** Un agente realizará el ciclo de vida completo de una venta en un entorno de pruebas, verificando que los procesos fluyan sin interrupciones desde la creación del pasajero hasta el registro del abordaje.
* **Verificación de Reglas de Negocio:** Se ejecutarán pruebas exhaustivas y automatizadas diseñadas específicamente para intentar vulnerar el sistema (por ejemplo, intentando asignar un mismo asiento a dos personas), comprobando así la solidez de las restricciones de la base de datos.
* **Auditoría de Reportes:** Se crearán escenarios simulados donde ciertos pasajeros con tiquete no completen el paso de abordaje, validando que el reporte final identifique con total precisión a los pasajeros ausentes.
* **Despliegue Unificado:** Se verificará que toda la infraestructura de la aplicación pueda encenderse y operar correctamente utilizando las herramientas de empaquetado automatizadas exigidas en el requerimiento.
