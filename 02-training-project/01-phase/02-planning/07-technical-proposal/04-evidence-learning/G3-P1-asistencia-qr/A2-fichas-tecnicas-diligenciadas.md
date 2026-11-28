# A2 · Fichas Técnicas Diligenciadas (4 Fichas con Características Medibles)

**Proyecto:** Sistema de Control de Asistencia Académica con QR Dinámico (`asistencia-qr`)  
**Autor (GitHub):** `@estiben08` · **Ficha:** 3413974  
**Variante del escenario aplicada:** **Variante B** (120 usuarios totales, 30 usuarios concurrentes pico, 2 sedes, disponibilidad objetivo 99,5 % mensual, tope primer año \$70.000.000 COP).  
**RAP asociado:** 593060 (01) · Diligencia formatos de fichas técnicas de acuerdo con estándares (Criterio C2).

> **Cumplimiento estricto del Criterio C2 (`Rubricas_G3.md`):**
> - Se entregan **4 fichas técnicas** utilizando los **14 campos** del formato propio [`A1-formato-ficha-tecnica.md`](./A1-formato-ficha-tecnica.md): **2 de software/servicio** (`FT-SW-01` software propio y `FT-SW-02` stack de base de datos y servidor de aplicación) y **2 de hardware/infraestructura** (`FT-HW-01` servidor VPS Cloud y `FT-HW-02` puntos de acceso inalámbricos WiFi 6 para las 2 sedes).
> - Cada ficha cuenta con **7 características técnicas medibles** (superando el mínimo de 6), con **valor numérico, unidad de medida y método de verificación**.
> - **Neutralidad tecnológica:** Ninguna ficha exige una marca o modelo comercial como requisito.

---

## 1. Ficha Técnica 1 (Software Propio) · `FT-SW-01`

- **01. Código e Identificación:** `FT-SW-01` · Versión `1.0` · Fecha: `2026-11-24`
- **02. Denominación genérica:** Aplicación Web de Control de Asistencia Académica con Código QR Dinámico y Validación de Subred (`asistencia-qr v1.0`)
- **03. Categoría TI:** Software Propio / Aplicación de Gestión Académica Orientada a Servicios Web
- **04. Variante y Nodo:** **Variante B** (120 usuarios totales, 30 concurrentes pico, 2 sedes, 99,5 %) · Alojada en **`Nodo 3: Servidor de Aplicación`** y consumida desde `Nodo 1` y `Nodo 2`
- **05. Descripción funcional:** Sistema web en arquitectura de 3 capas que permite autenticar usuarios por rol (`ADMIN`, `INSTRUCTOR`, `APRENDIZ`), administrar fichas y ambientes de 2 sedes, proyectar códigos QR dinámicos firmados con `HMAC-SHA256`, validar la asistencia móvil verificando pertenencia a la subred local del aula, registrar contingencias auditadas, emitir alertas tempranas de deserción y exportar reportes históricos en CSV y Excel.
- **06. Cantidad y unidad de medida:** `1` · `Licencia corporativa multi-sede desplegada para 2 sedes y hasta 150 usuarios activos (cubre los 120 usuarios de la Variante B con margen del 25 %)`

### 07. Características Técnicas Medibles (`FT-SW-01` · 7 Características)

| # | Característica / Atributo Técnico | Valor Exigido | Unidad de Medida | Método de Verificación Objetiva |
|---|---|---|---|---|
| **7.1** | **Tiempo de respuesta en validación de escaneo QR (percentil 95)** | `<= 1,5` (`<= 1500`) | `segundos` (`ms`) | Prueba de carga automatizada con 30 peticiones concurrentes de escaneo QR en ventana de 30 s midiendo latencia `p95` en el endpoint de registro. |
| **7.2** | **Intervalo de rotación automática del token QR en pantalla** | `30` | `segundos` | Inspección con cronómetro y log de `token_qr_sesion`: verificar que cada 30 s se emite una nueva secuencia y la anterior pasa a `vigente = 0`. |
| **7.3** | **Longitud de firma criptográfica del código QR (`HMAC-SHA256`)** | `256` (`64`) | `bits` (`caracteres hex`) | Prueba unitaria de seguridad: alterar 1 carácter del `token_payload` y comprobar rechazo HTTP `403` con registro en `auditoria_seguridad`. |
| **7.4** | **Factor de costo de hash de contraseñas con sal (`bcrypt`)** | `>= 12` | `rondas logarítmicas (2^12 iteraciones)` | Consulta directa a la columna `usuario.password_hash` en base de datos comprobando el prefijo `$2b$12$` y longitud de `60 caracteres`. |
| **7.5** | **Capacidad de concurrencia simultánea en ráfaga de aula** | `>= 30` | `usuarios concurrentes / segundo` | Ejecución de prueba de estrés concurrente (30 hilos simultáneos para 2 aulas en paralelo de las 2 sedes) con tasa de error HTTP `5xx = 0 %`. |
| **7.6** | **Ancho mínimo de pantalla soportado en interfaz móvil del aprendiz** | `>= 360` | `píxeles (px) de ancho CSS` | Emulación de dispositivo móvil (`360 x 640 px`) en navegador verificando ausencia de desbordamiento horizontal y visibilidad del lector QR. |
| **7.7** | **Umbral configurable de disparo de alerta temprana de deserción** | `3` | `inasistencias acumuladas por ficha` | Prueba funcional de cierre de sesión (`CU-08`/`CU-10`): registrar la 3.ª inasistencia de un aprendiz y verificar creación de fila en `alerta_inasistencia`. |

- **08. Compatibilidad e interoperabilidad:** Compatible en cliente con navegadores estándar HTML5/ES6 (Chrome `>= 115`, Edge `>= 115`, Safari iOS `>= 16`, Firefox `>= 115`) sobre Windows, Android e iOS; en servidor con Linux 64-bit y motor relacional SQL ANSI (`MySQL 8.0`); exportación en formatos `CSV (UTF-8)` y `XLSX (OpenXML)`.
- **09. Normatividad y estándares que cumple:** Ley 1581 de 2012 y Decreto 1074 de 2015 (protección de datos personales), Ley 23 de 1982 y Decisión Andina 351 de 1993 (derecho de autor de software), ISO/IEC 25010:2011, ISO/IEC 27001:2022 y WCAG 2.2 Nivel AA.
- **10. Licenciamiento y propiedad intelectual:** Software desarrollado a medida; derechos morales del autor (`@estiben08`) y licencia de uso institucional sin costo recurrente por usuario adicional para las 2 sedes de la entidad contratante.
- **11. Condiciones de operación y ANS:** Disponibilidad mensual `>= 99,5 %` en horario académico (`06:00` a `22:00`, lunes a sábado), `RPO <= 24 horas` y `RTO <= 2 horas`.
- **12. Garantía y soporte técnico:** `12 meses` de garantía sobre defectos de codificación (corrección sin costo adicional) y soporte evolutivo/preventivo durante los `36 meses` de operación proyectada.
- **13. Entregables y criterios de aceptación:** Código fuente en repositorio Git, paquete desplegable, script SQL de las 11 tablas (`B5`), diccionario de datos (`B4`), manual de operación y acta de pruebas funcionales firmada.
- **14. Observaciones y restricciones:** No requiere instalación de aplicaciones móviles nativas (`.apk` / `.ipa`) en los teléfonos de los aprendices.

---

## 2. Ficha Técnica 2 (Software Base / Plataforma de Servidor) · `FT-SW-02`

- **01. Código e Identificación:** `FT-SW-02` · Versión `1.0` · Fecha: `2026-11-24`
- **02. Denominación genérica:** Plataforma de Software Base: Sistema Operativo Servidor Linux LTS, Servidor Web Proxy Inverso, Servidor WSGI y Motor de Base de Datos Relacional Transaccional
- **03. Categoría TI:** Software Base / Entorno de Ejecución y Motor de Base de Datos Relacional
- **04. Variante y Nodo:** **Variante B** (120 usuarios totales, 30 concurrentes pico, 2 sedes) · Alojado en **`Nodo 3: Servidor de Aplicación`** y **`Nodo 4: Servidor de Datos`**
- **05. Descripción funcional:** Conjunto integrado de software de infraestructura que provee el sistema operativo de servidor, la terminación criptográfica `HTTPS/TLS`, la ejecución concurrente de procesos Python mediante trabajadores WSGI y el almacenamiento relacional ACID de las 11 tablas del sistema con piscina de conexiones y respaldos automatizados.
- **06. Cantidad y unidad de medida:** `1` · `Stack de software base de código abierto instalado sobre la infraestructura central que atiende las 2 sedes`

### 07. Características Técnicas Medibles (`FT-SW-02` · 7 Características)

| # | Característica / Atributo Técnico | Valor Exigido | Unidad de Medida | Método de Verificación Objetiva |
|---|---|---|---|---|
| **7.1** | **Soporte de ciclo de vida del Sistema Operativo Servidor (LTS)** | `>= 5` | `años de soporte de seguridad activo` | Ejecución de comando `lsb_release -a` verificando versión LTS de 64 bits con parches vigentes hasta al menos `2029`. |
| **7.2** | **Versión mínima del protocolo criptográfico de transporte web** | `1.3` (`>= 1.2`) | `versión de estándar TLS (RFC 8446)` | Escaneo de configuración del puerto `443` comprobando negociación efectiva de `TLSv1.3` y rechazo de `SSLv3 / TLSv1.0 / TLSv1.1`. |
| **7.3** | **Tamaño de la piscina de conexiones pre-abiertas a Base de Datos** | `20` | `conexiones TCP persistentes en pool` | Inspección de parámetros de inicialización de `MySQLConnectionPool(pool_size=20)` y consulta `SHOW STATUS LIKE 'Threads_connected'`. |
| **7.4** | **Procesos trabajadores (*workers*) WSGI concurrentes activos** | `>= 4` | `procesos worker en ejecución` | Verificación de procesos del servidor de aplicación (`ps aux | grep gunicorn`) comprobando 1 proceso maestro y `>= 4` workers activos. |
| **7.5** | **Nivel de aislamiento transaccional del motor relacional** | `100` | `% cumplimiento ACID (REPEATABLE READ)` | Ejecución de consulta `SELECT @@transaction_isolation;` y prueba de inserción duplicada concurrente sobre `uk_registro_sesion_aprendiz`. |
| **7.6** | **Frecuencia de ejecución automática de copia de seguridad cifrada** | `1` (`cada 24`) | `respaldo diario` (`horas`) | Revisión del programador `cron` y verificación del archivo `.sql.gz.enc` generado diariamente con cifrado `AES-256`. |
| **7.7** | **Capacidad de conexiones simultáneas soportadas por el motor BD** | `>= 150` | `conexiones concurrentes máximas` | Consulta de variable del motor `SHOW VARIABLES LIKE 'max_connections';` comprobando valor `>= 150` (5 veces el pico de la Variante B). |

- **08. Compatibilidad e interoperabilidad:** Compatible con arquitectura `x86_64` / `ARM64`, estándar SQL ANSI-99/2003, interfaz `PEP 3333 (WSGI)`, contenedores OCI/Docker y certificados X.509 (`Let's Encrypt` / ACME).
- **09. Normatividad y estándares que cumple:** ISO/IEC 27001:2022 (controles criptográficos y copias de seguridad), RFC 8446 (TLS 1.3), Ley 1581 de 2012 (seguridad en almacenamiento de datos personales).
- **10. Licenciamiento y propiedad intelectual:** Licencias de código abierto (`GPLv2` para el sistema operativo Linux y motor MySQL Community, `BSD-2-Clause` para el proxy inverso, `PSF/MIT` para Python/Gunicorn), con costo de adquisición de licencia igual a `$0 COP` y cumplimiento de avisos de atribución.
- **11. Condiciones de operación y ANS:** Operación continua `24/7` con disponibilidad `>= 99,5 %` mensual, reinicio automático de demonios (`systemd` / Docker `restart: unless-stopped`) en `< 10 segundos`.
- **12. Garantía y soporte técnico:** Actualizaciones oficiales de seguridad de los repositorios LTS durante `36 meses` y soporte de administración incluido en el servicio de operación.
- **13. Entregables y criterios de aceptación:** Archivo de aprovisionamiento automatizado, evidencia de ejecución de `B5-script-creacion.sql` sin errores y acta de prueba de restauración del respaldo.
- **14. Observaciones y restricciones:** El puerto `3306` del motor de base de datos debe permanecer bloqueado en el cortafuegos externo, aceptando tráfico únicamente desde la interfaz privada del servidor de aplicación.

---

## 3. Ficha Técnica 3 (Hardware / Infraestructura Cloud) · `FT-HW-01`

- **01. Código e Identificación:** `FT-HW-01` · Versión `1.0` · Fecha: `2026-11-24`
- **02. Denominación genérica:** Servidor Virtual Privado en la Nube (VPS Cloud Administrado) con Almacenamiento SSD NVMe, IP Pública Fija y Respaldo Automatizado
- **03. Categoría TI:** Hardware e Infraestructura Cloud (IaaS — Cómputo, Almacenamiento y Red)
- **04. Variante y Nodo:** **Variante B** (120 usuarios totales, 30 concurrentes pico, 2 sedes, disponibilidad 99,5 %) · Aloja físicamente los nodos lógicos **`Nodo 3: Servidor de Aplicación`** y **`Nodo 4: Servidor de Datos`**
- **05. Descripción funcional:** Infraestructura de servidor virtual dedicado en centro de datos certificado que aloja la aplicación web `asistencia-qr` y su base de datos relacional para atender de forma centralizada las **2 sedes** de formación (120 usuarios totales, 30 concurrentes pico), garantizando la disponibilidad mensual del `99,5 %` exigida por la Variante B.
- **06. Cantidad y unidad de medida:** `1` · `Instancia de servidor virtual cloud en operación continua durante 12 meses (36 meses en horizonte TCO) con servicio de snapshots automáticos`

### 07. Características Técnicas Medibles (`FT-HW-01` · 7 Características)

| # | Característica / Atributo Técnico | Valor Exigido | Unidad de Medida | Método de Verificación Objetiva |
|---|---|---|---|---|
| **7.1** | **Núcleos de procesamiento dedicados o vCPU de alta frecuencia** | `>= 2` (`>= 2,4`) | `vCPU` (`GHz`) | Ejecución de comando `lscpu` o `nproc` en la instancia aprovisionada verificando conteo de procesadores `>= 2`. |
| **7.2** | **Memoria RAM principal dedicada (ECC)** | `>= 4` (`>= 4096`) | `GB` (`MB`) | Ejecución de comando `free -m` en el servidor comprobando memoria física disponible `>= 3900 MB`. |
| **7.3** | **Almacenamiento primario en estado sólido NVMe / SSD** | `>= 80` (`>= 3000`) | `GB` (`IOPS lectura/escritura`) | Ejecución de `df -h` y prueba de lectura `fio` verificando capacidad `>= 80 GB` (supera en más de 10x el volumen de 36 meses calculado en `A5`). |
| **7.4** | **Transferencia de datos mensual / Ancho de banda de red** | `>= 2` (`>= 1`) | `TB / mes` (`Gbps de puerto`) | Revisión del panel de telemetría de la instancia y prueba de caudal de red verificando cuota mensual `>= 2000 GB`. |
| **7.5** | **Acuerdo de Nivel de Servicio (SLA) de disponibilidad del centro de datos** | `>= 99,5` | `% de disponibilidad mensual` | Verificación del contrato/SLA público del proveedor cloud y monitoreo externo con *healthcheck* HTTP cada 60 segundos. |
| **7.6** | **Retención de instantáneas (*Snapshots* / Backups de volumen)** | `>= 4` (`>= 7`) | `puntos de restauración` (`días`) | Inspección de la política de respaldos en la consola del proveedor comprobando copias automáticas verificables. |
| **7.7** | **Latencia de red promedio desde Colombia hacia la región del servidor** | `<= 95` | `milisegundos (ms) RTT` | Prueba de `ping` y `traceroute` desde las 2 sedes del centro de formación hacia la IP pública del servidor (región `us-east` o Bogotá). |

- **08. Compatibilidad e interoperabilidad:** Soporte completo para imágenes Linux Ubuntu 24.04 LTS (64-bit), cortafuegos de red configurable por puertos (`TCP 443`, `TCP 22` restringido), soporte IPv4 + IPv6 y acceso por clave SSH `Ed25519`/`RSA-4096`.
- **09. Normatividad y estándares que cumple:** Centro de datos del proveedor con certificaciones internacionales **ISO/IEC 27001**, **SOC 2 Tipo II** y cumplimiento de seguridad física y ambiental.
- **10. Licenciamiento y propiedad intelectual:** Modalidad de suscripción mensual/anual por uso de infraestructura (IaaS); no exige compra de licencias de virtualización propietarias adicionales.
- **11. Condiciones de operación y ANS:** Disponibilidad garantizada `>= 99,5 %` mensual (cubre exactamente la meta de la Variante B); tiempo de aprovisionamiento o reemplazo de instancia `< 15 minutos` (`RTO <= 2 h`).
- **12. Garantía y soporte técnico:** Garantía de reemplazo inmediato de hardware subyacente ante falla física a cargo del proveedor cloud y soporte técnico `24/7` en infraestructura durante toda la vigencia de la suscripción.
- **13. Entregables y criterios de aceptación:** Credenciales de administración y acceso SSH por llave pública, dirección IPv4 estática asignada, reglas de firewall activas y prueba de conectividad HTTPS desde las 2 sedes.
- **14. Observaciones y restricciones:** No se exige ningún proveedor de nube específico; en el análisis comparativo (`B1`) se evalúan al menos 3 proveedores reales del mercado que cumplen o superan estas 7 características.

---

## 4. Ficha Técnica 4 (Hardware / Infraestructura de Red de Aula) · `FT-HW-02`

- **01. Código e Identificación:** `FT-HW-02` · Versión `1.0` · Fecha: `2026-11-24`
- **02. Denominación genérica:** Punto de Acceso Inalámbrico Empresarial (*Access Point* WiFi 6 Dual-Band PoE) con Soporte de VLAN y Subred Dedicada por Ambiente de Formación
- **03. Categoría TI:** Hardware de Red e Infraestructura Física de Conectividad en Aula
- **04. Variante y Nodo:** **Variante B** (120 usuarios totales, 30 concurrentes pico, **2 sedes**) · Provee la conectividad de red local para **`Nodo 1: PC Aula Instructor`** y **`Nodo 2: Smartphone Aprendiz`**
- **05. Descripción funcional:** Equipos de red inalámbrica empresarial instalados en los ambientes de formación de las **2 sedes** del proyecto para garantizar que los **30 usuarios concurrentes en hora pico** puedan conectarse simultáneamente sin saturación de canal y reciban una dirección IP dentro de la subred local del aula (`192.168.X.0/24`) requerida por el validador antifraude Zero-Trust (`RF-08`).
- **06. Cantidad y unidad de medida:** `4` · `Unidades físicas instaladas (2 Puntos de Acceso por cada una de las 2 sedes de la Variante B, incluyendo inyector PoE y herrajes de montaje)`

### 07. Características Técnicas Medibles (`FT-HW-02` · 7 Características)

| # | Característica / Atributo Técnico | Valor Exigido | Unidad de Medida | Método de Verificación Objetiva |
|---|---|---|---|---|
| **7.1** | **Estándar inalámbrico y velocidad agregada de radio (Dual-Band)** | `>= 1800` (`WiFi 6 / 802.11ax`) | `Mbps agregados (2,4 GHz + 5 GHz)` | Verificación de hoja de datos técnica del fabricante y prueba de enlace `802.11ax` con `OFDMA` y `MU-MIMO` activos. |
| **7.2** | **Capacidad de dispositivos clientes conectados simultáneamente por AP** | `>= 150` | `clientes WiFi concurrentes por unidad` | Prueba de estrés en aula con `>= 30` teléfonos móviles asociados al mismo SSID enviando peticiones HTTPS simultáneas sin desconexión. |
| **7.3** | **Velocidad de interfaz de red cableada (*Uplink* Ethernet)** | `1` (`1000`) | `Gbps` (`Mbps Full-Duplex RJ-45`) | Verificación del enlace físico en el switch del centro comprobando negociación a `1000BASE-T` con alimentación `PoE 802.3af/at`. |
| **7.4** | **Cantidad de SSID y mapeo a redes virtuales (`VLAN 802.1Q`)** | `>= 8` | `SSID independientes con VLAN Tag` | Inspección de la consola del controlador de red verificando que el SSID de formación asigna la VLAN y subred CIDR del ambiente (`RF-08`). |
| **7.5** | **Protocolo de cifrado y seguridad inalámbrica soportado** | `WPA2 / WPA3` | `estándar criptográfico IEEE 802.11i` | Verificación con analizador WiFi comprobando autenticación `WPA2/WPA3-PSK` o `Enterprise` con cifrado `AES-CCMP`. |
| **7.6** | **Ganancia de antena omnidireccional integrada y cobertura por aula** | `>= 4` (`>= 120`) | `dBi en 5 GHz` (`m² de cobertura`) | Medición de nivel de señal recibida (`RSSI >= -65 dBm`) en las cuatro esquinas del ambiente de formación con aplicación de diagnóstico. |
| **7.7** | **Consumo energético máximo por unidad sobre PoE** | `<= 15` | `Vatios (W)` | Medición en puerto PoE o especificación eléctrica verificando compatibilidad con estándar `IEEE 802.3af/at`. |

- **08. Compatibilidad e interoperabilidad:** Totalmente compatible con dispositivos móviles Android/iOS (estándares `802.11a/b/g/n/ac/ax`), switches Ethernet `IEEE 802.3af/at`, direccionamiento `DHCP IPv4/IPv6` y gestión centralizada por controlador web o en local sin licencia anual obligatoria.
- **09. Normatividad y estándares que cumple:** Estándares internacionales `IEEE 802.11ax (WiFi 6)`, `IEEE 802.1Q (VLAN)`, `IEEE 802.3af/at (PoE)` y homologación/certificación radioeléctrica `FCC / CE / RoHS`.
- **10. Licenciamiento y propiedad intelectual:** Firmware e interfaz de gestión incluidos de por vida con la compra del hardware, **sin cobro de licencias anuales por equipo** para mantener operativa la red inalámbrica.
- **11. Condiciones de operación y ANS:** Tiempo medio entre fallos (`MTBF`) `>= 100.000 horas`, operación continua en temperatura ambiente de `0 °C a 40 °C`.
- **12. Garantía y soporte técnico:** Garantía comercial mínima de `12 meses` por defectos de fábrica con reemplazo de unidad en Colombia.
- **13. Entregables y criterios de aceptación:** 4 unidades físicas nuevas en caja sellada con accesorios de montaje, factura legal con IVA discriminado, configuración de subredes por sede y acta de prueba de cobertura WiFi en las 2 sedes.
- **14. Observaciones y restricciones:** Ninguna marca específica es obligatoria; en el análisis comparativo (`B1`) se evalúan 3 alternativas reales de distintos fabricantes disponibles en el mercado colombiano.
