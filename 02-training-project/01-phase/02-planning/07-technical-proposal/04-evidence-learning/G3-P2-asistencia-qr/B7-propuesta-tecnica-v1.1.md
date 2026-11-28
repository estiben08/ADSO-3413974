# B7 · Propuesta Técnica Ajustada (Versión 1.1) con Control Formal de Cambios

**Título de la Oferta:** Diseño, Desarrollo, Despliegue y Soporte del Sistema Web de Control de Asistencia Académica con Código QR Dinámico, Código de Sala Rotativo (`CSR`) y Validación Zero-Trust de Subred (`asistencia-qr`) para Dos Sedes de Formación  
**Versión:** `1.1` *(Versión Definitiva Ajustada tras Validación con la Contraparte)*  
**Fecha de emisión de la versión `1.1`:** `2026-11-27` *(Basada en el Acta de Validación `B5` del `2026-11-26`)*  
**Proponente (Autor GitHub):** `@estiben08` · **Ficha:** 3413974 · Programa ADSO  
**Contraparte / Cliente Evaluador:** `@coordinacion-academica-cies` (Coordinación Académica y de Infraestructura TI — 2 Sedes)  
**Variante del Escenario Aplicada:** **Variante B** (`120` usuarios totales, `30` concurrentes pico, `2` sedes, disponibilidad `99,6 % mensual`, tope primer año `$70.000.000 COP`, TRM `$4.000 COP/USD`, IVA `19 %`).  
**RAP asociado:** 593061 (03) · Ajusta los parámetros técnicos de acuerdo con los resultados de la negociación (Criterio C6).

---

## 0. Tabla Formal de Control de Cambios (`v1.0` → `v1.1`)

| Versión | Fecha | Autor | Origen del Cambio | Resumen de Cambios Propagados en Documento, Presupuesto y ANS |
|---|---|---|---|---|
| `1.0` | `2026-11-25` | `@estiben08` | Emisión inicial (`B3-propuesta-tecnica-v1.0.md`) | Oferta base para la Variante B: `$41.019.860 COP` con IVA (Año 1), 45 días hábiles, disponibilidad `99,5 %`, `RPO <= 24 h` y `p95 <= 1,5 s`. |
| **`1.1`** | **`2026-11-27`** | **`@estiben08`** | **Acta de Validación con la Contraparte (`B5-acta-validacion-sugerencias.md` del `2026-11-26`, sugerencias `S-01`, `S-02` y `S-03`)** | **Se propagan 3 ajustes técnicos cuantificados:**<br>1. **`P-AJ-01` (de `S-01`):** Se pasa de 1 a **2 respaldos cifrados diarios (`12:30` y `23:30`)**, reduciendo el **`RPO` de `24 h` a `<= 12 h`**, elevando la disponibilidad del ANS de **`99,5 %` a `99,6 %`** y bajando el riesgo `R4` en `-$150.000 COP` (`+$364.000` en costo directo Año 1).<br>2. **`P-AJ-02` (de `S-02`):** Se incorpora el **Código de Sala Rotativo (`CSR`) de 6 caracteres** (`ValidadorCodigoSalaCSR`) bajo validación obligatoria de subred IP del aula para aprendices con cámara averiada (`+$660.000` en costo directo y **`+2 días hábiles`** en `T-08`, pasando el plazo de **45 a 47 días hábiles**).<br>3. **`P-AJ-03` (de `S-03`):** Se incorpora **precarga en caché de memoria del padrón de matrícula activa** al abrir sesión, reduciendo el tiempo de respuesta en hora pico de **`p95 <= 1,5 s` a `p95 <= 1,2 s`** (`+$330.000` en costo directo, `0 días` adicionales).<br>**Nuevo Total Año 1 con IVA (`v1.1`):** **`$42.705.460 COP`** (mantiene **`$27.294.540 COP` de holgura** bajo el tope de `$70.000.000 COP`). |

---

## 1. Resumen Ejecutivo (Actualizado a `v1.1`)

La versión `1.1` de la Propuesta Técnica consolida la solución integral llave en mano del sistema **`asistencia-qr`** para las **2 sedes** de formación (**120 usuarios totales y 30 usuarios concurrentes pico — Variante B**), incorporando la totalidad de las mejoras acordadas con la contraparte en el Acta de Validación [`B5-acta-validacion-sugerencias.md`](./B5-acta-validacion-sugerencias.md):
- **Doble modalidad de marcación Zero-Trust en aula (`QR Dinámico + Código de Sala Rotativo CSR`):** Los aprendices con cámara funcional escanean el código QR que rota cada 30 segundos firmado con `HMAC-SHA256`, y quienes presenten avería en su cámara ingresan el código alfanumérico rotativo `CSR` de 6 caracteres proyectado en pantalla (`P-AJ-02`). En ambos canales, el servidor verifica obligatoriamente que la dirección IP del móvil pertenezca a la subred WiFi 6 del ambiente de formación (`RF-08`).
- **Mayor velocidad y resiliencia (`ANS mejorado`):** Gracias a la precarga en caché del padrón de matrícula (`P-AJ-03`) y al esquema de doble respaldo diario cifrado (`P-AJ-01`), se garantiza un tiempo de respuesta **`p95 <= 1,2 segundos`**, una disponibilidad mensual **`>= 99,6 %`** y un **`RPO <= 12 horas`** (`RTO <= 2 horas`).
- **Plazo total de ejecución (`v1.1`):** **47 días hábiles** (Ruta Crítica CPM actualizada).
- **Inversión Total Oferta Definitiva `v1.1` (Primer Año, con Contingencia, Margen del 15 % e IVA del 19 % incluidos):** **`$42.705.460 COP`** (`$27.294.540 COP` por debajo del tope de `$70.000.000 COP` de la Variante B).
- **Costo Total a 36 Meses (`v1.1` con IVA incluido):** **`$60.087.930 COP`**.

---

## 2. Entendimiento de la Necesidad y Planteamiento del Problema

Se conserva íntegramente el diagnóstico de la sección 2 de `B3-propuesta-tecnica-v1.0.md` (recuperación de `384 horas de clase/año` en las 2 sedes, bloqueo del 100 % de la suplantación remota por WhatsApp y detección inmediata de alertas de deserción), añadiendo la necesidad validada con el cliente en el Acta `B5` de ofrecer un canal de respaldo sin cámara (`CSR`) para no recargar al instructor con registros manuales cuando un aprendiz tiene la cámara del teléfono deteriorada.

---

## 3. Alcance de la Solución Ajustado (`v1.1`): Inclusiones, Exclusiones y Supuestos

### 3.1 Inclusiones Actualizadas en `v1.1`
1. **Los 13 Requisitos Funcionales (`RF-01` a `RF-13`) y 5 No Funcionales (`RNF-01` a `RNF-05`)** de la versión `1.0`, **más los 3 requisitos acordados en el Acta `B5`:**
   - **`REQ-VAL-01` (Doble respaldo diario `RPO <= 12 h`):** Ejecución automática del backup transaccional cifrado `AES-256` a las `12:30 p. m.` y `11:30 p. m.` con réplica en S3/Spaces.
   - **`REQ-VAL-02` (Código de Sala Rotativo `CSR` con validación de subred IP):** Generación y validación polimórfica mediante la cuarta estrategia `ValidadorCodigoSalaCSR` (`IReglaValidacionAsistencia`).
   - **`REQ-VAL-03` (Caché en memoria de matrícula activa para `p95 <= 1,2 s`):** Precarga del padrón de la ficha al ejecutar `CU-03`.
2. **Infraestructura Cloud (`FT-HW-01`) y Equipamiento WiFi 6 para 2 Sedes (`FT-HW-02`):** 1 servidor VPS DigitalOcean Droplet Premium (`2 vCPU`, `4 GB RAM`, `80 GB NVMe + Backups`), 4 Puntos de Acceso WiFi 6 TP-Link Omada EAP650 y 2 Switches Gigabit PoE.

### 3.2 Exclusiones Confirmadas en el Acta `B5`
- Se mantienen las exclusiones de `v1.0` (PCs de aula existentes y teléfonos *BYOD* de aprendices).
- **Exclusión confirmada `S-04`:** No se permite marcación desde redes móviles públicas 4G/5G fuera de la subred WiFi del aula (para preservar la seguridad Zero-Trust).
- **Exclusión confirmada `S-05`:** El envío de SMS comerciales a padres de familia queda diferido a una eventual Fase 2, manteniendo en `v1.1` el módulo completo de alertas visuales y exportables de deserción (`CU-10`).

---

## 4. Solución Propuesta y Arquitectura (`v1.1`)

La arquitectura en 3 capas y el diagrama de despliegue de 4 nodos ([`B3-diagrama-arquitectura-despliegue.svg`](./B3-diagrama-arquitectura-despliegue.svg)) se enriquecen en la Capa 2 (`ComponenteValidacionAsistencia`) demostrando la ventaja del **Patrón Estrategia (`A3`)**:
- Para incorporar el Código de Sala Rotativo (`REQ-VAL-02`), **no se modifica ninguna clase existente**: únicamente se adiciona la estrategia concreta `ValidadorCodigoSalaCSR` que implementa `IReglaValidacionAsistencia` y se registra en la lista de reglas de `ServicioControlAsistencia` junto a `ValidadorFirmaHMAC`, `ValidadorSubredIP` y `ValidadorUnicidadSesion`.

---

## 5. Especificaciones Técnicas Propagadas a `v1.1`

| Ficha / Parámetro | Valor en `v1.0` (`G3-P1/A2` y `A5`) | Valor Propagado en `v1.1` |
|---|---|---|
| **`FT-SW-01` #7.1 · Tiempo de respuesta en validación (`p95`)** | `<= 1,5 segundos` (`1.500 ms`) | **`<= 1,2 segundos` (`1.200 ms`)** |
| **`FT-SW-01` #05 · Modalidades de marcación en aula** | Escaneo QR (`CU-05`) + Contingencia manual (`CU-07`) | **Escaneo QR + Código de Sala Rotativo `CSR` 6 caracteres + Contingencia manual** |
| **`FT-SW-02` #7.6 · Frecuencia de copia de seguridad cifrada** | `1 respaldo diario` (cada 24 horas) | **`2 respaldos diarios`** (cada 12 horas: `12:30` y `23:30`) |
| **`FT-SW-01` #11 · Disponibilidad mensual y `RPO` / `RTO`** | Disponibilidad `>= 99,5 %` · `RPO <= 24 h` · `RTO <= 2 h` | **Disponibilidad `>= 99,6 %` · `RPO <= 12 h` · `RTO <= 2 h`** |

---

## 6. Metodología Scrum, EDT Ajustada (12 Tareas) y Nueva Ruta Crítica (`47 Días Hábiles`)

Al incorporar las `12 horas` de desarrollo del validador `CSR` (`P-AJ-02`) en la tarea crítica `T-08` (que pasa de `7` a `9 días hábiles`), y las `6 horas` de caché en memoria (`P-AJ-03`) en `T-07`/`T-09` junto con las `4 horas` de doble backup (`P-AJ-01`) en `T-11`:

| ID Tarea | Nombre de la Tarea (EDT `v1.1`) | Duración `v1.0` | Duración `v1.1` | Predecesora(s) | `ES` | `EF` | `LS` | `LF` | Holgura `H` | ¿Ruta Crítica? |
|---|---|---|---|---|---|---|---|---|---|---|
| **T-01** | Refinamiento de SRS, modelo conceptual UML y MER definitivo | 4 d | **4 d** | — | 0 | 4 | 0 | 4 | **0 d** | **SÍ** |
| **T-02** | Diseño arquitectura 3 capas, patrones GoF y DDL SQL 3FN (11 tablas) | 5 d | **5 d** | `T-01` | 4 | 9 | 4 | 9 | **0 d** | **SÍ** |
| **T-03** | Adquisición e instalación física de 4 APs WiFi 6 y 2 Switches en 2 sedes | 6 d | **6 d** | `T-01` | 4 | 10 | 14 | 20 | **10 d** | No |
| **T-04** | Aprovisionamiento VPS Cloud DigitalOcean, Ubuntu 24.04, MySQL 8.0 y `PyMySQL` | 4 d | **4 d** | `T-02` | 9 | 13 | 9 | 13 | **0 d** | **SÍ** |
| **T-05** | Codificación `ComponenteAutenticacionSeguridad` (`bcrypt`, RBAC, Ley 1581) y `Catalogo` | 6 d | **6 d** | `T-04` | 13 | 19 | 13 | 19 | **0 d** | **SÍ** |
| **T-06** | Configuración de VLANs, subredes CIDR por ambiente y pruebas en 2 sedes | 4 d | **4 d** | `T-03`, `T-04` | 13 | 17 | 20 | 24 | **7 d** | No |
| **T-07** | Codificación `ComponenteSesionQR` (QR 30 s + HMAC + **Caché de matrícula `P-AJ-03`**) | 6 d | **6 d** | `T-05` | 19 | 25 | 19 | 25 | **0 d** | **SÍ** |
| **T-08** | Codificación `ComponenteValidacionAsistencia` (HMAC, Subred IP, Unicidad + **`ValidadorCodigoSalaCSR` `P-AJ-02`**) | 7 d | **9 d (+2 d)** | `T-06`, `T-07` | 25 | 34 | 25 | 34 | **0 d** | **SÍ** |
| **T-09** | Desarrollo de Vistas Responsivas *Mobile-First* (Lector QR + Input CSR) y Tablero AJAX | 5 d | **6 d (+1 d)** | `T-07` | 25 | 31 | 28 | 34 | **3 d** | No |
| **T-10** | Codificación `ComponenteReportesAlertas` (Fábrica CSV/Excel streaming y Alertas `>=3`) | 5 d | **5 d** | `T-08`, `T-09` | 34 | 39 | 34 | 39 | **0 d** | **SÍ** |
| **T-11** | Configuración Nginx `TLS 1.3`, **Doble Backup 12 h (`P-AJ-01`)** y pruebas de carga (`p95 <= 1,2 s`) | 5 d | **5 d** | `T-10` | 39 | 44 | 39 | 44 | **0 d** | **SÍ** |
| **T-12** | Capacitación en las 2 sedes, despliegue final a producción y firma de Acta de Entrega | 3 d | **3 d** | `T-11` | 44 | 47 | 44 | 47 | **0 d** | **SÍ** |

- **Nueva Ruta Crítica Calculada (`v1.1`):** `T-01 → T-02 → T-04 → T-05 → T-07 → T-08 → T-10 → T-11 → T-12` = **`47 días hábiles`**.

---

## 7. Equipo de Trabajo (`v1.1`)

El esfuerzo total de ingeniería pasa de `270 horas` a **`292 horas PERT` (`+22 horas` por los 3 ajustes del Acta `B5`)**, distribuidas entre el Líder Técnico/Backend (`@estiben08`: `196 horas`) y el Especialista Frontend/DevOps (`96 horas`).

---

## 8. Presupuesto Definitivo Ajustado (`v1.1` · Hoja `6_Presupuesto_Ajustado_v1.1` de `B2-presupuesto-software-hardware.xlsx`)

| Concepto Presupuestal | Versión `v1.0` (Año 1) | Ajuste Acta `B5` | Versión Definitiva `v1.1` (Año 1) | Versión Definitiva `v1.1` (36 Meses) |
|---|---|---|---|---|
| **Subtotal de Costos Directos e Indirectos** | `$26.854.900` | `+$1.354.000` (`22 h × $55.000 + $144.000 S3`) | **`$28.208.900`** | **`$39.821.700`** |
| **Reserva de Contingencia (Suma EMV Riesgos `R1`–`R7` ajustada)** | `$2.445.000` (`9,10 %`) | `-$150.000` (menor riesgo `R4`) | **`$2.295.000`** (`8,14 %` del subtotal) | **`$3.098.250`** |
| **COSTO TOTAL CON CONTINGENCIA (`v1.1`)** | **`$29.299.900`** | **`+$1.204.000`** | **`$30.503.900`** | **`$42.919.950`** |
| **Margen Comercial (`15 %` sobre Precio: `=Precio - Costo`)** | `$5.170.571` | `+$212.471` | **`$5.383.041`** | **`$7.574.109`** |
| **PRECIO DE VENTA ANTES DE IVA (`=Costo / 0,85`)** | **`$34.470.471`** | **`+$1.416.471`** | **`$35.886.941`** | **`$50.494.059`** |
| **IVA (`19 %` sobre Precio con Contingencia)** | `$6.549.389` | `+$269.130` | **`$6.818.519`** | **`$9.593.871`** |
| **PRECIO TOTAL DE VENTA CON IVA INCLUIDO (`v1.1`)** | **`$41.019.860`** | **`+$1.685.601`** | **`$42.705.460`** | **`$60.087.930`** |
| **Tope Presupuesto Primer Año Variante B (`$70.000.000`)** | `+$28.980.140` holgura | `-$1.685.601` | **`+$27.294.540` bajo el tope (Cumple)** | — |

---

## 9. Matriz de Riesgos Actualizada en `v1.1`

Con la implementación del doble respaldo diario cifrado (`P-AJ-01`, cada 12 horas), la probabilidad del riesgo **`R4` (Pérdida o indisponibilidad prolongada ante falla en el nodo VPS)** se reduce del `15,0 %` al **`9,0 %`** sobre el impacto de `$2.500.000 COP`, disminuyendo su Valor Esperado de `$375.000` a **`$225.000 COP` (`-$150.000 COP`)**. En consecuencia, la Reserva Total de Contingencia en `v1.1` pasa de `$2.445.000` a **`$2.295.000 COP`** (`8,14 %` del nuevo subtotal de `$28.208.900 COP`, manteniéndose dentro del rango normativo del `5 % al 15 %` del Anexo D).

---

## 10. Garantías, Soporte y Acuerdo de Nivel de Servicio (`ANS v1.1`)

Se mantienen los **12 meses de garantía** en software y hardware y las **6 horas/mes de soporte preventivo/correctivo**, actualizando las métricas del ANS conforme al documento [`B6-verificacion-contrato-tdr-ans.md`](./B6-verificacion-contrato-tdr-ans.md) (§3):
- **`ANS-01` (Disponibilidad mensual):** **`>= 99,6 % mensual`** en horario académico.
- **`ANS-02` (Tiempo de respuesta en validación QR y CSR):** **`p95 <= 1,2 segundos` (`<= 1.200 ms`)** con 30 usuarios concurrentes.
- **`ANS-03` (`RPO`):** **`<= 12 horas`** (2 copias cifradas diarias a las `12:30` y `23:30`).
- **`ANS-04` (`RTO`):** **`<= 2,0 horas`** verificadas mensualmente con acta de restauración.
- **`ANS-05` (Atención de incidentes S1 Críticos):** Respuesta `<= 30 min`, solución `<= 2 horas`.

---

## 11. Condiciones Comerciales e Hitos de Pago Actualizados (`v1.1`)

- **Pago 1 (`30 %` a la firma e Hito 1 — Día 4):** **`$12.811.638 COP`** (IVA incluido).
- **Pago 2 (`40 %` al Hito 3 — Día 34):** **`$17.082.184 COP`** (IVA incluido).
- **Pago 3 (`30 %` al Hito 4 — Día 47, salida a producción en 2 sedes):** **`$12.811.638 COP`** (IVA incluido).
- **Total Contrato Año 1 (`v1.1`):** **`$42.705.460 COP`** (IVA incluido).
- Se mantienen inalteradas las condiciones de Propiedad Intelectual (derechos morales de `@estiben08` y Licencia Institucional Perpetua con código fuente y librerías permisivas `BSD-3`/`MIT`).

---

## 12. Vigencia de la Oferta Ajustada y Anexos

La presente oferta ajustada `v1.1` tiene vigencia de **30 días calendario** desde su emisión (`2026-11-27` a `2026-12-27`) e integra como anexos vinculantes los artefactos `A1` a `A6` de `G3-P1-asistencia-qr` y `B1` a `B6` de `G3-P2-asistencia-qr`.
