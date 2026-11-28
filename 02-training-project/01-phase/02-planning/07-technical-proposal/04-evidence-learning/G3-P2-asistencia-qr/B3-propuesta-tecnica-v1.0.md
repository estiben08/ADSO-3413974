# B3 · Propuesta Técnica de Servicios de Tecnología de la Información (Versión 1.0)

**Título de la Oferta:** Diseño, Desarrollo, Despliegue y Soporte del Sistema Web de Control de Asistencia Académica con Código QR Dinámico y Validación Zero-Trust de Subred (`asistencia-qr`) para Dos Sedes de Formación  
**Versión:** `1.0` (Oferta Base Inicial) · **Fecha de emisión:** `2026-11-25`  
**Proponente (Autor GitHub):** `@estiben08` · **Ficha:** 3413974 · Programa ADSO  
**Contraparte / Cliente Objetivo:** Coordinación Académica y de Infraestructura TI (`@coordinacion-academica-cies`)  
**Variante del Escenario Aplicada:** **Variante B** (`120` usuarios totales, `30` usuarios concurrentes en hora pico, `2` sedes operativas, disponibilidad mensual objetivo `99,5 %`, tope presupuestal primer año `$70.000.000 COP`, TRM `$4.000 COP/USD`, IVA `19 %`).  
**RAP asociado:** 593062 (02) · Documenta la propuesta técnica según las especificaciones de la solución de software (Criterio C3).

---

## Tabla de Contenido (Las 12 Secciones Obligatorias)

1. [Resumen Ejecutivo](#1-resumen-ejecutivo)
2. [Entendimiento de la Necesidad y Planteamiento del Problema](#2-entendimiento-de-la-necesidad-y-planteamiento-del-problema)
3. [Alcance de la Solución: Inclusiones, Exclusiones y Supuestos](#3-alcance-de-la-solución-inclusiones-exclusiones-y-supuestos)
4. [Solución Propuesta y Arquitectura con Diagrama Integrado](#4-solución-propuesta-y-arquitectura-con-diagrama-integrado)
5. [Especificaciones Técnicas y Referentes Normativos](#5-especificaciones-técnicas-y-referentes-normativos)
6. [Metodología de Desarrollo, EDT de 12 Tareas y Ruta Crítica (CPM)](#6-metodología-de-desarrollo-edt-de-12-tareas-y-ruta-crítica-cpm)
7. [Equipo de Trabajo, Perfiles y Responsabilidades](#7-equipo-de-trabajo-perfiles-y-responsabilidades)
8. [Presupuesto, Condiciones Económicas y Flujo a 36 Meses](#8-presupuesto-condiciones-económicas-y-flujo-a-36-meses)
9. [Matriz de Gestión de Riesgos y Reserva de Contingencia](#9-matriz-de-gestión-de-riesgos-y-reserva-de-contingencia)
10. [Garantías, Mantenimiento, Capacitación y Soporte Técnico](#10-garantías-mantenimiento-capacitación-y-soporte-técnico)
11. [Condiciones Comerciales, Licenciamiento y Propiedad Intelectual](#11-condiciones-comerciales-licenciamiento-y-propiedad-intelectual)
12. [Vigencia de la Oferta y Anexos Técnicos](#12-vigencia-de-la-oferta-y-anexos-técnicos)

---

## 1. Resumen Ejecutivo

La presente Propuesta Técnica (`v1.0`) ofrece una solución integral llave en mano —compuesta por software propio a medida (`FT-SW-01`), plataforma de servidor Linux/MySQL optimizada (`FT-SW-02`), infraestructura cloud de alta disponibilidad (`FT-HW-01`) y equipamiento inalámbrico WiFi 6 empresarial para **2 sedes** (`FT-HW-02`)— diseñada para automatizar y blindar contra fraude la toma de asistencia académica de **120 usuarios totales y hasta 30 usuarios concurrentes en hora pico** (**Variante B**).

El sistema **`asistencia-qr`** reduce el tiempo de llamado a lista de 12–15 minutos por sesión a **menos de 90 segundos**, eliminando tanto las planillas en papel como la suplantación remota por enlaces compartidos en mensajería. Esto se logra combinando **códigos QR dinámicos que rotan cada 30 segundos firmados criptográficamente con `HMAC-SHA256`**, **verificación en tiempo real de pertenencia a la misma subred IP del aula**, **panel de monitoreo en vivo con registro auditado de contingencias** y **alertas tempranas automáticas de riesgo de deserción** al acumular 3 o más inasistencias.

- **Plazo de ejecución e implantación:** **45 días hábiles (9 semanas / 4 Sprints Scrum)** hasta la puesta en producción en las 2 sedes, más acompañamiento y soporte continuo.
- **Inversión Total Oferta `v1.0` (Primer Año, con Contingencia, Margen del 15 % e IVA del 19 % incluidos):** **`$41.019.860 COP`** (frente al tope de `$70.000.000 COP` de la Variante B, generando un **ahorro presupuestal inmediato de `$28.980.140 COP`, equivalente al `41,4 %`** del presupuesto máximo del cliente).
- **Costo Total de Operación y Propiedad a 36 Meses (con IVA):** **`$58.072.630 COP`** (`$41.019.860` en el Año 1 y `$8.526.385/año` en los Años 2 y 3).

---

## 2. Entendimiento de la Necesidad y Planteamiento del Problema

A partir del diagnóstico de campo realizado en los ambientes de formación (`03-execute/16-week` a `19-week`), la institución enfrenta tres dolores operativos críticos en sus **2 sedes**:
1. **Pérdida de tiempo efectivo de formación:** En una jornada con `8 sesiones diarias` entre las 2 sedes (`1.920 sesiones/año`), invertir 12 minutos por clase pasando lista en papel consume **`384 horas de formación al año`**.
2. **Suplantación remota en formularios digitales simples:** Cuando se utilizan enlaces fijos o códigos QR estáticos, los aprendices en aula envían una captura por WhatsApp a compañeros ausentes, quienes registran asistencia desde sus hogares o desde redes móviles externas.
3. **Detección tardía del riesgo de deserción estudiantil:** La consolidación manual de planillas al final del mes retrasa la identificación de aprendices que acumulan 3 o más fallas consecutivas, impidiendo la intervención preventiva oportuna de Bienestar al Aprendiz.

**Beneficio cuantificable de la solución:** Reducción del `88 %` en el tiempo de toma de asistencia (de 12 min a `< 1,5 min`), bloqueo del `100 %` de los intentos de registro desde redes externas a las 2 sedes (`RF-08`) y emisión instantánea (`0 días de retraso`) de alertas de deserción al cerrar cada sesión (`RF-13`).

---

## 3. Alcance de la Solución: Inclusiones, Exclusiones y Supuestos

### 3.1 Qué Incluye la Propuesta (Dentro del Alcance)
1. **Software propio `asistencia-qr v1.0` (`FT-SW-01`):** Cubre el 100 % de los **13 Requisitos Funcionales (`RF-01` a `RF-13`)** y **5 Requisitos No Funcionales (`RNF-01` a `RNF-05`)**:
   - Autenticación RBAC (`ADMIN`, `INSTRUCTOR`, `APRENDIZ`) con hash `bcrypt` (costo 12) + sal y cumplimiento de Ley 1581 de 2012 (`CU-01`).
   - Administración de centros, ambientes con subred CIDR, fichas e importación masiva de los 120 usuarios (`CU-02`).
   - Apertura de sesión por ambiente y proyección de código QR dinámico firmado con `HMAC-SHA256` que rota cada 30 s (`CU-03`, `CU-04`).
   - Escaneo móvil en navegador (*Mobile-First* `>= 360px`) con validación polimórfica de firma HMAC, subred IP local y unicidad por sesión (`CU-05`, `CU-06`).
   - Registro manual por contingencia en aula con justificación obligatoria (`CU-07`), monitoreo en vivo y cierre con marcación automática de inasistentes (`CU-08`).
   - Exportación histórica en *streaming* a `CSV` y `Excel (.xlsx)` (`CU-09`) y alertas tempranas automáticas al acumular `>= 3` inasistencias (`CU-10`).
2. **Infraestructura Cloud y Base de Datos (`FT-SW-02` y `FT-HW-01`):** Aprovisionamiento de servidor VPS Cloud DigitalOcean Droplet Premium (`2 vCPU`, `4 GB RAM`, `80 GB NVMe`, backups automáticos y bucket S3 cifrado `AES-256`) con Ubuntu 24.04 LTS, Nginx 1.26 (`TLS 1.3`), Gunicorn (4 workers) y MySQL 8.0 (11 tablas en 3FN con `MySQLConnectionPool` de 20 conexiones).
3. **Equipamiento de Red Inalámbrica para las 2 Sedes (`FT-HW-02`):** Suministro, instalación y configuración de **4 Puntos de Acceso WiFi 6 Empresariales TP-Link Omada EAP650** (2 por sede) y **2 Switches Gigabit PoE** con configuración de VLANs y subredes CIDR por aula.
4. **Capacitación, Documentación y Soporte:** 2 talleres de transferencia (uno por sede), manuales técnico y de usuario, 12 meses de garantía y bolsa de soporte técnico mensual (`6 horas/mes`) con simulacro mensual de restauración de backups.

### 3.2 Qué No Incluye la Propuesta (Exclusiones Justificadas)
- **Computadores de escritorio/proyectores de aula (`Nodo 1`) y teléfonos móviles de aprendices (`Nodo 2`):** Se utilizan los equipos de aula ya existentes en las 2 sedes y los smartphones personales de los aprendices (*BYOD*).
- **Integración automática por API privada con SofíaPlus:** SofíaPlus no expone una API pública de escritura para terceros; la integración se realiza mediante importación de listados y exportación homologada en CSV/Excel (`RF-03`, `RF-12`).
- **Obras civiles o licencias propietarias de Windows/Oracle:** El stack opera 100 % sobre Linux y MySQL Community con costo `$0` en licencias de motor.

### 3.3 Supuestos del Ejercicio (Variante B · Anexo A)
- Parámetros base: **120 usuarios totales**, **30 usuarios concurrentes pico**, **2 sedes**, **disponibilidad mensual objetivo del `99,5 %`**, **tope presupuestal de `$70.000.000 COP` en el primer año**, **TRM de `$4.000 COP/USD`** e **IVA del `19 %`**.

---

## 4. Solución Propuesta y Arquitectura con Diagrama Integrado

La solución implementa una **Arquitectura Cliente-Servidor en Tres Capas Lógicas** sin saltos de capa (`Capa 1: Presentación Web MVC` → `Capa 2: Lógica de Negocio y Dominio con Patrones Estrategia, Método Fábrica y Fachada` → `Capa 3: Persistencia SQL con Piscina de 20 Conexiones`), desplegada sobre **4 nodos físicos/virtuales** que conectan las **2 sedes** con el servidor central por `HTTPS sobre TCP/443 (TLS 1.3)` y aíslan el motor MySQL 8.0 en red privada (`TCP/3306`).

- **Fuente editable Draw.io:** [`B3-diagrama-arquitectura-despliegue.drawio`](./B3-diagrama-arquitectura-despliegue.drawio)
- **Imagen vectorial SVG:** [`B3-diagrama-arquitectura-despliegue.svg`](./B3-diagrama-arquitectura-despliegue.svg)
- **Imagen PNG:** [`B3-diagrama-arquitectura-despliegue.png`](./B3-diagrama-arquitectura-despliegue.png)

![Diagrama Integrado de Arquitectura y Despliegue B3](./B3-diagrama-arquitectura-despliegue.svg)

*(Nota: Los diagramas de casos de uso, actividades, dominio, clases y modelo lógico relacional se anexan y referencian desde las entregas `G1-P1`, `G1-P2`, `G2-P1` y `G2-P2`).*

---

## 5. Especificaciones Técnicas y Referentes Normativos

La totalidad de las especificaciones técnicas medibles, el dimensionamiento de licencias y los cálculos de capacidad que rigen esta propuesta se encuentran detallados en el **Producto 1 (`G3-P1-asistencia-qr`)**, con el cual esta oferta guarda coherencia del 100 %:
- **Formato y 4 Fichas Técnicas (`FT-SW-01`, `FT-SW-02`, `FT-HW-01`, `FT-HW-02`):** [`../G3-P1-asistencia-qr/A1-formato-ficha-tecnica.md`](../G3-P1-asistencia-qr/A1-formato-ficha-tecnica.md) y [`../G3-P1-asistencia-qr/A2-fichas-tecnicas-diligenciadas.md`](../G3-P1-asistencia-qr/A2-fichas-tecnicas-diligenciadas.md).
- **Cumplimiento Normativo Legal y Técnico (Ley 1581 de 2012, Decreto 1074 de 2015, Ley 23 de 1982, Decisión Andina 351 de 1993, Ley 1273 de 2009, ISO/IEC 25010, ISO/IEC 27001:2022 y WCAG 2.2):** [`../G3-P1-asistencia-qr/A3-referente-tecnico-normatividad.md`](../G3-P1-asistencia-qr/A3-referente-tecnico-normatividad.md).
- **Dimensionamiento de Licencias (7 componentes y 6 dependencias con reemplazo a `PyMySQL` MIT):** [`../G3-P1-asistencia-qr/A4-dimensionamiento-licencias.md`](../G3-P1-asistencia-qr/A4-dimensionamiento-licencias.md).
- **Condiciones Técnicas de Capacidad (7 parámetros calculados para 120 usuarios, 30 concurrentes y 2 sedes):** [`../G3-P1-asistencia-qr/A5-estimacion-condiciones-tecnicas.md`](../G3-P1-asistencia-qr/A5-estimacion-condiciones-tecnicas.md).

---

## 6. Metodología de Desarrollo, EDT de 12 Tareas y Ruta Crítica (CPM)

El proyecto se ejecuta bajo el marco ágil **Scrum** organizado en **4 Sprints de 2 semanas (45 días hábiles en total)**, combinando entregas incrementales con control de ruta crítica (**Método de la Ruta Crítica — CPM**).

### 6.1 Estructura de Desglose del Trabajo (EDT / WBS de 12 Tareas con Predecesoras, Holgura y Ruta Crítica)

Se definen **12 tareas** (superando el mínimo exigible de 10), indicando duración en días hábiles (`D`), tareas predecesoras, Inicio Temprano (`ES`), Fin Temprano (`EF`), Inicio Tardío (`LS`), Fin Tardío (`LF`), **Holgura Total (`H = LS - ES`)** y pertenencia a la **Ruta Crítica (`H = 0`)**:

| ID Tarea | Sprint / Fase | Nombre de la Tarea (EDT) | Duración (`D` días) | Predecesora(s) | `ES` (Día) | `EF` (Día) | `LS` (Día) | `LF` (Día) | Holgura (`H = LS - ES`) | ¿En Ruta Crítica? | Entregable / Hito |
|---|---|---|---|---|---|---|---|---|---|---|---|
| **T-01** | Sprint 1 | Refinamiento de SRS, modelo conceptual UML y MER definitivo | **4 d** | — *(Inicio)* | 0 | 4 | 0 | 4 | **0 días** | **SÍ (Crítica)** | **Hito 1 (Día 4):** Línea base de Análisis aprobada |
| **T-02** | Sprint 1 | Diseño de arquitectura 3 capas, patrones GoF y DDL SQL 3FN (11 tablas) | **5 d** | `T-01` | 4 | 9 | 4 | 9 | **0 días** | **SÍ (Crítica)** | Script `B5-script-creacion.sql` y DAS |
| **T-03** | Sprint 1 | Adquisición e instalación física de 4 APs WiFi 6 y 2 Switches en las 2 sedes | **6 d** | `T-01` | 4 | 10 | 14 | 20 | **10 días** | No (Paralela) | Red WiFi 6 instalada en Sede 1 y Sede 2 |
| **T-04** | Sprint 2 | Aprovisionamiento VPS Cloud DigitalOcean, Ubuntu 24.04, MySQL 8.0 y Pool `PyMySQL` | **4 d** | `T-02` | 9 | 13 | 9 | 13 | **0 días** | **SÍ (Crítica)** | **Hito 2 (Día 13):** Entorno Cloud y BD activos |
| **T-05** | Sprint 2 | Codificación `ComponenteAutenticacionSeguridad` (`bcrypt`, RBAC, Ley 1581) y `Catalogo` | **6 d** | `T-04` | 13 | 19 | 13 | 19 | **0 días** | **SÍ (Crítica)** | Módulos `CU-01` y `CU-02` verificados |
| **T-06** | Sprint 2 | Configuración de VLANs, subredes CIDR por ambiente y pruebas de cobertura en 2 sedes | **4 d** | `T-03`, `T-04` | 13 | 17 | 20 | 24 | **7 días** | No (Paralela) | Subredes `192.168.10.0/24` y `20.0/24` listas |
| **T-07** | Sprint 3 | Codificación `ComponenteSesionQR` (rotación 30 s y firma `HMAC-SHA256`) | **6 d** | `T-05` | 19 | 25 | 19 | 25 | **0 días** | **SÍ (Crítica)** | Motor QR dinámico (`CU-03`, `CU-04`) |
| **T-08** | Sprint 3 | Codificación `ComponenteValidacionAsistencia` (3 Estrategias: HMAC, Subred IP, Unicidad + Contingencia) | **7 d** | `T-06`, `T-07` | 25 | 32 | 25 | 32 | **0 días** | **SÍ (Crítica)** | **Hito 3 (Día 32):** Validador Zero-Trust (`CU-05` a `CU-08`) |
| **T-09** | Sprint 3 | Desarrollo de Vistas Responsivas *Mobile-First* (`>=360px`) y Tablero AJAX en vivo | **5 d** | `T-07` | 25 | 30 | 27 | 32 | **2 días** | No (Paralela) | Interfaces web móvil y de aula integradas |
| **T-10** | Sprint 4 | Codificación `ComponenteReportesAlertas` (Fábrica CSV/Excel streaming y Alertas `>=3` fallas) | **5 d** | `T-08`, `T-09` | 32 | 37 | 32 | 37 | **0 días** | **SÍ (Crítica)** | Módulos `CU-09` y `CU-10` operativos |
| **T-11** | Sprint 4 | Configuración Nginx `TLS 1.3`, script de backup cifrado `AES-256` y pruebas de carga (30 conc.) | **5 d** | `T-10` | 37 | 42 | 37 | 42 | **0 días** | **SÍ (Crítica)** | Acta de pruebas de estrés (`p95 <= 1,5 s`) y backup |
| **T-12** | Sprint 4 | Capacitación en las 2 sedes, despliegue final a producción y firma de Acta de Entrega | **3 d** | `T-11` | 42 | 45 | 42 | 45 | **0 días** | **SÍ (Crítica)** | **Hito 4 (Día 45):** Salida a Producción en 2 Sedes |

### 6.2 Cálculo de la Ruta Crítica (CPM)
- **Secuencia de la Ruta Crítica (`Holgura H = 0`):**
  `T-01 (4 d) → T-02 (5 d) → T-04 (4 d) → T-05 (6 d) → T-07 (6 d) → T-08 (7 d) → T-10 (5 d) → T-11 (5 d) → T-12 (3 d)`
- **Duración Total de la Ruta Crítica:** `4 + 5 + 4 + 6 + 6 + 7 + 5 + 5 + 3 = 45 días hábiles (9 semanas)`.
- **Tareas con holgura (no críticas):** `T-03` (instalación física de APs WiFi 6, con `H = 10 días`), `T-06` (configuración de VLANs en las 2 sedes, con `H = 7 días`) y `T-09` (maquetación de vistas responsivas, con `H = 2 días`). Cualquier retraso en las 9 tareas críticas retrasa la fecha final del proyecto; las 3 tareas con holgura pueden absorber demoras de proveedor de hardware de hasta 10 días sin afectar la salida en vivo.

---

## 7. Equipo de Trabajo, Perfiles y Responsabilidades

| Rol en el Proyecto | Responsable / Perfil | Dedicación (Horas PERT) | Responsabilidades Principales en la Ejecución |
|---|---|---|---|
| **Líder Técnico, Arquitecto y Desarrollador Backend Senior** | `@estiben08` (Tecnólogo ADSO) | `180 horas` | Diseño arquitectónico en 3 capas, modelo de datos 3FN, implementación de patrones Estrategia/Fábrica/Fachada, motor QR `HMAC-SHA256`, validador de subred IP y pruebas unitarias. |
| **Desarrollador Frontend Web e Ingeniero DevOps / Redes** | Especialista de Apoyo ADSO (`1 perfil`) | `90 horas` | Maquetación *Mobile-First* (`>=360px`), tablero AJAX del instructor, aprovisionamiento VPS Linux/Nginx/Gunicorn `TLS 1.3`, configuración de los 4 APs WiFi 6 en las 2 sedes y pruebas de carga. |
| **Total Esfuerzo de Ingeniería** | **Equipo de 2 profesionales** | **`270 horas PERT`** | Cobertura del 100 % de las 12 tareas de la EDT (`T-01` a `T-12`). |

---

## 8. Presupuesto, Condiciones Económicas y Flujo a 36 Meses

El detalle completo con fórmulas vivas se entrega en [`B2-presupuesto-software-hardware.xlsx`](./B2-presupuesto-software-hardware.xlsx) y [`B2-presupuesto-software-hardware.md`](./B2-presupuesto-software-hardware.md). A continuación se presenta el resumen ejecutivo de la oferta `v1.0`:

| Concepto Financiero | Valor Año 1 (12 Meses · COP) | Valor Horizonte 36 Meses (COP) | Referencia en Hoja de Cálculo `B2` |
|---|---|---|---|
| **Subtotal Software y Servicios (Categorías 1, 2, 4 parcial y 5)** | `$20.992.500` | `$29.552.500` | Hoja `4_Presupuesto_v1.0` Celda `J17` / `K17` |
| **Subtotal Hardware e Infraestructura (Categorías 3 y 4 VPS Cloud)** | `$5.862.400` | `$8.627.200` | Hoja `4_Presupuesto_v1.0` Celda `J18` / `K18` |
| **SUBTOTAL COSTOS DIRECTOS E INDIRECTOS** | **`$26.854.900`** | **`$38.179.700`** | Hoja `4_Presupuesto_v1.0` Celda `J19` / `K19` |
| **6. Reserva de Contingencia (`=SUM(Valores Esperados Riesgos)` = `9,10 %`)** | **`$2.445.000`** | **`$3.300.750`** | Hoja `3_Matriz_Riesgos` Celda `I11` → `J20` |
| **COSTO TOTAL CON CONTINGENCIA** | **`$29.299.900`** | **`$41.480.450`** | Hoja `4_Presupuesto_v1.0` Celda `J22` / `K22` |
| **Margen Comercial (`15 %` Margen sobre Precio: `Precio = Costo / 0,85`)** | `$5.170.571` | `$7.320.079` | Hoja `4_Presupuesto_v1.0` Celda `J23` / `K23` |
| **PRECIO DE VENTA ANTES DE IVA** | **`$34.470.471`** | **`$48.800.529`** | Hoja `4_Presupuesto_v1.0` Celda `J24` / `K24` |
| **IVA (`19 %` aplicado al final sobre Precio con Contingencia)** | `$6.549.389` | `$9.272.101` | Hoja `4_Presupuesto_v1.0` Celda `J25` / `K25` |
| **PRECIO TOTAL DE VENTA CON IVA INCLUIDO (OFERTA v1.0)** | **`$41.019.860`** | **`$58.072.630`** | Hoja `4_Presupuesto_v1.0` Celda `J26` / `K26` |

---

## 9. Matriz de Gestión de Riesgos y Reserva de Contingencia

Siguiendo la plantilla del Anexo B (`Rubricas_G3.md`), se identifican y cuantifican **7 riesgos del proyecto** (superando el mínimo exigible de 6). La suma de los valores esperados (`Probabilidad × Impacto`) de los riesgos cubiertos determina exactamente la **Reserva de Contingencia de `$2.445.000 COP`** (`9,10 %` del subtotal):

| N.º | Riesgo | Causa | Probabilidad (%) | Impacto ($ COP) | Valor Esperado ($) `=Prob × Imp` | Respuesta (Evitar, Mitigar, Transferir, Aceptar) | Responsable |
|---|---|---|---|---|---|---|---|
| **R1** | Separación de subredes VLAN entre PC del aula (Ethernet) y WiFi de aprendices en alguna de las 2 sedes | Configuración previa de routers del centro que aísla la LAN cableada respecto de la WLAN | `25,0 %` | `$2.400.000` | **`$600.000`** | **Mitigar:** Configurar tabla de subredes CIDR autorizadas por ambiente en BD y mapeo VLAN 802.1Q en los 4 APs TP-Link EAP650 (`T-06`). | `@estiben08` (Redes) |
| **R2** | Saturación de canal WiFi o demora `> 1,5 s` cuando 30 aprendices escanean en la misma ventana de 30 s | Interferencia en banda 2,4 GHz o apertura repetida de conexiones TCP a MySQL | `20,0 %` | `$2.200.000` | **`$440.000`** | **Mitigar:** Usar banda 5 GHz WiFi 6 (`OFDMA`), `MySQLConnectionPool` de 20 conexiones pre-abiertas y validación HMAC en memoria (`T-08`, `T-11`). | `@estiben08` (Backend) |
| **R3** | Incompatibilidad legal GPLv2 del conector MySQL frente a cláusulas contractuales de propiedad intelectual | Uso del paquete `mysql-connector-python` (GPLv2) sin excepción FOSS aplicable | `15,0 %` | `$1.600.000` | **`$240.000`** | **Evitar / Mitigar:** Reemplazar por el conector `PyMySQL` + `DBUtils` bajo licencia permisiva **MIT** (`PR-03`, 4 horas). | `@estiben08` (Arquitectura) |
| **R4** | Caída temporal o falla de disco en el nodo VPS Cloud durante jornada académica (comprometiendo el `99,5 %`) | Incidente físico en el centro de datos cloud o corrupción de volumen | `15,0 %` | `$2.500.000` | **`$375.000`** | **Transferir / Mitigar:** SLA `99,99 %` de DigitalOcean + backup diario cifrado `AES-256` en S3 externo + simulacro mensual (`RTO <= 2 h`). | `@estiben08` (DevOps) |
| **R5** | Intento de fraude fotografiando el QR en el aula y enviándolo por mensajería a aprendices externos | Colaboración indebida entre un aprendiz dentro del salón y otro fuera de la sede | `30,0 %` | `$1.800.000` | **`$540.000`** | **Mitigar:** Triple candado Zero-Trust: rotación cada 30 s + firma `HMAC-SHA256` + validación obligatoria de IP en la misma subred del aula (`CU-06`). | `@estiben08` (Seguridad) |
| **R6** | Retraso en la entrega de listados oficiales de fichas y aprendices de las 2 sedes para poblar el sistema | Demoras operativas en la descarga de reportes planos desde SofíaPlus | `15,0 %` | `$200.000` | **`$30.000`** | **Mitigar:** Incluir importador masivo por copiado/pegado de documentos (`RF-03`) que permite a cada instructor cargar su ficha en 30 segundos. | `@estiben08` (Analista) |
| **R7** | Subida de la TRM por encima de `$4.000 COP/USD` en la facturación mensual de nube | Volatilidad cambiaria USD/COP durante el año de operación | `20,0 %` | `$1.100.000` | **`$220.000`** | **Aceptar con reserva:** Cubrir diferencial cambiario con la reserva de contingencia financiera. | `@estiben08` (Finanzas) |
| | **TOTAL RESERVA DE CONTINGENCIA (Suma de Valores Esperados cubiertos con reserva)** | | | | **`$2.445.000 COP`** | **Equivale al `9,10 %` del subtotal de costos (`$26.854.900`), dentro del rango `5 % a 15 %` del Anexo D.** | |

*(Nota: En la hoja `3_Matriz_Riesgos` del archivo `.xlsx`, los 7 riesgos tienen la fórmula exacta `=D*E` cuya suma directa es `$2.445.000 COP`).*

---

## 10. Garantías, Mantenimiento, Capacitación y Soporte Técnico

- **Garantía de Calidad de Software (`12 meses`):** Corrección sin costo adicional para el cliente de cualquier defecto de codificación (*bug*), error de cálculo en reportes o incumplimiento de los 13 requisitos funcionales detectado durante los primeros 12 meses tras el acta de recibo a satisfacción.
- **Garantía de Hardware de Red (`12 meses`):** Los 4 Puntos de Acceso WiFi 6 TP-Link Omada EAP650 y los 2 Switches PoE cuentan con garantía comercial de fábrica de 12 meses con reemplazo en Colombia.
- **Mantenimiento Preventivo y Soporte Técnico (`6 horas/mes` incluidas durante los 36 meses):** Incluye aplicación mensual de parches de seguridad de Ubuntu LTS y paquetes Python, monitoreo de espacio en disco NVMe, revisión de certificados TLS Let's Encrypt y ejecución del **simulacro mensual de restauración de copias de seguridad con acta firmada** (`P-08`).
- **Capacitación y Transferencia de Conocimiento:** 2 sesiones prácticas (una en cada sede) dirigidas a los instructores y administradores, entrega de manual de usuario, manual de administración/despliegue (`runbook`) y videos cortos de operación.

---

## 11. Condiciones Comerciales, Licenciamiento y Propiedad Intelectual

### 11.1 Forma e Hitos de Pago
- **Pago 1 (`30 %` a la firma del contrato e Hito 1 — Día 4):** Contra entrega y aprobación de las especificaciones técnicas definitivas y orden de compra del equipamiento WiFi 6 de las 2 sedes (`$12.305.958 COP` con IVA).
- **Pago 2 (`40 %` al Hito 3 — Día 32):** Contra entrega de la infraestructura Cloud/WiFi 6 instalada y demostración funcional del motor QR dinámico y validador Zero-Trust (`$16.407.944 COP` con IVA).
- **Pago 3 (`30 %` al Hito 4 — Día 45):** Contra salida a producción en las 2 sedes, pruebas de carga superadas (`p95 <= 1,5 s` con 30 usuarios concurrentes), capacitación realizada y firma del Acta de Entrega y Aceptación Final (`$12.305.958 COP` con IVA).

### 11.2 Propiedad Intelectual y Licenciamiento (Ley 23 de 1982, Ley 1450 de 2011 Art. 28 y Decisión Andina 351 de 1993)
- **Derechos Morales:** En virtud del Artículo 30 de la Ley 23 de 1982 y el Artículo 11 de la Decisión Andina 351 de 1993, los derechos morales de paternidad e integridad sobre la arquitectura y el código fuente corresponden de manera perpetua e irrenunciable a su autor (`@estiben08`).
- **Derechos Patrimoniales y Licencia Institucional:** Se otorga a la entidad contratante una **Licencia de Uso Institucional Perpetua, No Exclusiva y Libre de Regalías por Usuario**, con entrega completa del código fuente documentado, scripts SQL (`B5`) y manuales, facultándola para ejecutar, respaldar (Art. 25 Decisión Andina 351) y desplegar el sistema en las **2 sedes** contratadas sin costos adicionales de licenciamiento por usuario.
- **Cumplimiento de Licencias de Terceros:** Todas las librerías incluidas (`Flask`, `Werkzeug`, `qrcode`, `Pillow`, `bcrypt`, `PyMySQL`) cuentan con licencias abiertas permisivas (`BSD-3`, `MIT`, `Apache-2.0`) verificadas en `A4`, libres de restricciones copyleft sobre el software entregado.

---

## 12. Vigencia de la Oferta y Anexos Técnicos

- **Vigencia de la oferta comercial:** **Treinta (30) días calendario** contados a partir de su fecha de presentación (`2026-11-25` a `2026-12-25`).
- **Anexos que integran esta Propuesta Técnica:**
  - **Anexo 1:** Formato y 4 Fichas Técnicas Diligenciadas ([`../G3-P1-asistencia-qr/A2-fichas-tecnicas-diligenciadas.md`](../G3-P1-asistencia-qr/A2-fichas-tecnicas-diligenciadas.md)).
  - **Anexo 2:** Matriz de Referentes Legales y Técnicos ([`../G3-P1-asistencia-qr/A3-referente-tecnico-normatividad.md`](../G3-P1-asistencia-qr/A3-referente-tecnico-normatividad.md)).
  - **Anexo 3:** Dimensionamiento de Licencias e Inventario de Dependencias ([`../G3-P1-asistencia-qr/A4-dimensionamiento-licencias.md`](../G3-P1-asistencia-qr/A4-dimensionamiento-licencias.md)).
  - **Anexo 4:** Estimación de Condiciones Técnicas de Capacidad ([`../G3-P1-asistencia-qr/A5-estimacion-condiciones-tecnicas.md`](../G3-P1-asistencia-qr/A5-estimacion-condiciones-tecnicas.md)).
  - **Anexo 5:** Análisis Comparativo de Proveedores y TCO a 36 Meses ([`./B1-analisis-comparativo-proveedores.md`](./B1-analisis-comparativo-proveedores.md)).
  - **Anexo 6:** Libro de Presupuesto y Flujo de Caja con Fórmulas Vivas ([`./B2-presupuesto-software-hardware.xlsx`](./B2-presupuesto-software-hardware.xlsx)).
  - **Anexo 7:** Lista de Verificación para Contrato, Matriz TdR y Acuerdo de Nivel de Servicio ANS ([`./B6-verificacion-contrato-tdr-ans.md`](./B6-verificacion-contrato-tdr-ans.md)).
