# B5 · Acta de Reunión de Validación de la Propuesta Técnica con la Contraparte

**Proyecto:** Sistema de Control de Asistencia Académica con QR Dinámico (`asistencia-qr`)  
**Código del Acta:** `ACTA-VAL-G3-3413974-01`  
**Fecha de la reunión de validación:** `2026-11-26` *(Anterior a la fecha límite de entrega)*  
**Hora y Medio:** `16:00 a 16:45 (Hora de Colombia)` · Sesión sincrónica con revisión de pantalla y repositorio GitHub  
**Variante del escenario:** **Variante B** (120 usuarios totales, 30 concurrentes pico, 2 sedes, disponibilidad `99,5 %`, tope `$70.000.000 COP`)  
**RAP asociados:** 593061 (03) · Documenta las sugerencias del cliente según la necesidad del negocio (Criterio C5) y Ajusta los parámetros técnicos de acuerdo con los resultados de la negociación (Criterio C6).

---

## 1. Participantes de la Sesión de Validación (Sin Datos Personales Reales)

| Rol en la Negociación | Identificación Pública (Usuario / Rol Institucional) | Dependencia / Representación |
|---|---|---|
| **Proponente Técnico (Autor)** | `@estiben08` · Aprendiz Tecnólogo ADSO (Ficha 3413974) | Equipo de Ingeniería de Software — Proyecto `asistencia-qr` |
| **Contraparte (Cliente Evaluador)** | `@coordinacion-academica-cies` · Coordinador Académico y Líder de Infraestructura TI (Rol Cliente) | Coordinación Académica de Ambientes de Formación (2 Sedes) |

---

## 2. Orden del Día Desarrollado

1. Presentación ejecutiva de la Propuesta Técnica `v1.0` (`B3`) y soporte de presentación (`B4`) en 10 minutos.
2. Revisión de las 4 fichas técnicas (`A2`), el comparativo de proveedores (`B1`) y el libro de presupuesto con fórmulas vivas (`B2`).
3. Formulación de sugerencias, observaciones y objeciones por parte de la contraparte.
4. Negociación técnica y económica, clasificación de sugerencias y acuerdo de ajustes para la versión `v1.1` (`B7`).

---

## 3. Sugerencias y Objeciones del Cliente Convertidas en Requisitos Verificables y Clasificadas (5 Sugerencias · Mínimo Exigible: 4)

Cada observación formulada por la contraparte durante la sesión fue traducida a un **requisito verificable**, clasificada (`Aceptada`, `Negociada` o `Rechazada`), justificada técnicamente y evaluada en su impacto sobre **costo y plazo**:

| ID | Sugerencia u Objeción Original de la Contraparte | Requisito Verificable Derivado | Clasificación | Prioridad | Justificación Técnica y Acuerdo de Negociación | Efecto en Costo Directo (Año 1) | Efecto en Plazo (EDT) |
|---|---|---|---|---|---|---|---|
| **S-01** | *«Queremos que si el servidor falla a mitad del día no se pierda toda la asistencia de la jornada de la mañana; un solo backup nocturno de 24 horas nos parece riesgoso.»* | **REQ-VAL-01:** El sistema de respaldo automatizado del Nodo 4 debe ejecutar **2 copias de seguridad transaccionales cifradas (`AES-256`) cada día** (`12:30 p. m.` y `11:30 p. m.`) replicadas al almacenamiento externo S3, reduciendo el **`RPO` máximo de `24 horas` a `<= 12 horas`** y elevando el ANS de disponibilidad mensual de **`99,5 %` a `99,6 %`**. | **Aceptada** | **Alta** | Mejora sustancialmente la resiliencia del servicio para las 2 sedes con un esfuerzo mínimo de automatización (`4 horas` de script incremental) y `+3 USD/mes` de cuota S3, reduciendo además el valor esperado del riesgo `R4` en `-$150.000 COP`. | `+$364.000 COP` (`$220.000` script + `$144.000` S3/año) y `-$150.000` en reserva de riesgo `R4` | **`+0 días`** (se ejecuta dentro de `T-11`) |
| **S-02** | *«En todas las fichas hay 2 o 3 aprendices cuyo celular tiene la cámara rayada o dañada; si el instructor tiene que registrarlos manualmente en todas las clases se pierde tiempo.»* | **REQ-VAL-02:** La pantalla de proyección del aula (`CU-04`) debe mostrar junto al QR un **Código de Sala Rotativo (`CSR`) alfanumérico de 6 caracteres no ambiguos** que rote en la misma ventana y sea validado por una cuarta estrategia (`ValidadorCodigoSalaCSR` implementando `IReglaValidacionAsistencia`), exigiendo igualmente **conexión activa a la subred WiFi del aula (`RF-08`)**. | **Negociada** *(Aceptada con alcance acotado)* | **Alta** | La contraparte pedía inicialmente un PIN fijo por ficha; se negoció que el código sea **rotativo y sujeto a la misma validación de subred IP del aula** para no abrir una brecha de fraude por WhatsApp. Gracias al patrón **Estrategia (`A3`)**, solo requiere agregar la clase `ValidadorCodigoSalaCSR` (`12 horas` de desarrollo y pruebas). | `+$660.000 COP` (`12 h × $55.000/h`) | **`+2 días hábiles`** en `T-08` (plazo pasa de 45 a **47 días hábiles**) |
| **S-03** | *«En los cambios de clase de las 7:00 a. m. y 1:00 p. m., cuando los 30 aprendices entran al tiempo, quisiéramos que la validación responda aún más rápido que 1,5 segundos.»* | **REQ-VAL-03:** El componente `ComponenteSesionQR` debe precargar en caché de memoria RAM el padrón de aprendices matriculados de la ficha al momento de aperturar la sesión (`CU-03`), reduciendo el **tiempo de respuesta `p95` de validación en ráfaga de `<= 1,5 segundos` a `<= 1,2 segundos`**. | **Aceptada** | **Media-Alta** | Precargar en un diccionario en memoria los 30 `id_aprendiz` matriculados al abrir la sesión evita una consulta `JOIN` por cada escaneo y baja la latencia `p95` en ~200 ms. Requiere `6 horas` de optimización y pruebas en `T-07`/`T-11`. | `+$330.000 COP` (`6 h × $55.000/h`) | **`+0 días`** (absorbido en la holgura de `T-09`) |
| **S-04** | *«¿Podríamos permitir que los aprendices marquen asistencia usando sus datos móviles 4G/5G personales sin conectarse al WiFi del salón cuando tengan afán?»* | **REQ-VAL-04 (Descartado):** Desactivar la validación de subred IP local (`ValidadorSubredIP`) para conexiones desde redes celulares públicas 4G/5G. | **Rechazada** *(con argumento técnico aceptado por el cliente)* | **Crítica (Seguridad)** | **Argumento técnico de rechazo:** Las redes móviles 4G/5G asignan direcciones IP públicas dinámicas de operador (CGNAT) que no permiten distinguir si el aprendiz está dentro del salón o a 10 kilómetros de la sede. Desactivar `ValidadorSubredIP` anularía el objetivo central del proyecto (`RF-08` Zero-Trust), pues bastaría enviar una foto del QR o el código CSR por WhatsApp para suplantar asistencia. La contraparte comprendió el riesgo y aceptó mantener obligatoria la conexión al WiFi 6 del aula. | **`$0 COP`** (No se implementa) | **`0 días`** |
| **S-05** | *«Quisiéramos que el sistema envíe mensajes de texto SMS automáticos al celular de los padres de familia cada vez que un aprendiz falte a una clase.»* | **REQ-VAL-05 (Diferido a Fase 2):** Integrar pasarela de mensajería SMS comercial por evento de inasistencia diaria. | **Negociada** *(Excluida de v1.1 / Diferida a Fase 2)* | **Baja** | Una pasarela SMS comercial implica un costo recurrente por mensaje (`~$120 COP/SMS × 1.920 sesiones`) y requiere autorización legal expresa de tratamiento de datos de terceros (padres/acudientes) bajo Ley 1581 de 2012. Se acordó mantener en `v1.1` el panel visual y exportación Excel de **Alertas Tempranas (`CU-10`)** sin costo adicional por mensaje, dejando la pasarela SMS como módulo opcional futuro. | **`$0 COP`** en `v1.1` | **`0 días`** |

---

## 4. Tabla de Ajustes de Parámetros Técnicos (Criterio C6 · 3 Parámetros Modificados con Antes, Después e Impacto Cuantificado)

Los acuerdos de las sugerencias `S-01`, `S-02` y `S-03` modifican formalmente **3 parámetros técnicos** de la propuesta, cuyos efectos cuantificados se propagan a la **Propuesta Ajustada `v1.1` (`B7`)**, al **Presupuesto Ajustado `v1.1` (Hoja `6_Presupuesto_Ajustado_v1.1` de `B2-presupuesto-software-hardware.xlsx`)** y al **Acuerdo de Nivel de Servicio (`ANS` en `B6`)**:

| # | Parámetro Técnico Modificado |Artefacto(s) donde se Propaga | Valor Antes (`v1.0`) | Valor Después (`v1.1`) | Motivo del Ajuste (Origen en Acta) | Impacto Cuantificado en Costo (Año 1 / 36M) | Impacto en Plazo (Ruta Crítica) | Impacto en Riesgo (Matriz `B3`) |
|---|---|---|---|---|---|---|---|---|
| **P-AJ-01** | **Objetivo de Punto de Recuperación (`RPO`) y Disponibilidad Mensual del ANS** | - Ficha `FT-SW-01` (#11) y `FT-SW-02` (#7.6)<br>- ANS (`B6` Métricas #1 y #3)<br>- Propuesta `v1.1` (`B7` §8, §9, §10)<br>- Presupuesto Hoja `6` | - `RPO <= 24 horas` (1 backup diario a las 23:30)<br>- Disponibilidad mensual: **`99,5 %`** (máx. 124,8 min caída/mes académico) | - **`RPO <= 12 horas`** (2 backups diarios cifrados `AES-256`: `12:30` y `23:30`)<br>- Disponibilidad mensual: **`99,6 %`** (máx. 99,8 min caída/mes académico) | Atender la sugerencia `S-01` del cliente para proteger la asistencia tomada en la jornada de la mañana ante cualquier contingencia vespertina. | - Costo directo: **`+$364.000` (Año 1)** / **`+$652.000` (36M)**<br>- Reserva riesgo `R4`: **`-$150.000` (Año 1)** | **`0 días`** (se configura dentro de la tarea `T-11`) | **Reduce el Valor Esperado del Riesgo `R4`** de `$375.000` a **`$225.000 COP`** (baja probabilidad/impacto de pérdida de datos). |
| **P-AJ-02** | **Mecanismo Alterno de Marcación en Aula: Código de Sala Rotativo (`CSR`) bajo Subred IP** | - Ficha `FT-SW-01` (#05)<br>- Arquitectura (`ValidadorCodigoSalaCSR`)<br>- Propuesta `v1.1` (`B7` §3, §4, §6, §8)<br>- Presupuesto Hoja `6` | Solo escaneo óptico por cámara de código QR (`CU-05`) o registro manual por el instructor (`CU-07`). | **Escaneo óptico QR + Código de Sala Rotativo (`CSR`) de 6 caracteres** sincronizado con la ventana temporal y validado contra la misma subred IP del aula (`ValidadorCodigoSalaCSR`). | Atender la sugerencia negociada `S-02` para aprendices con cámara averiada sin sacrificar la validación Zero-Trust de ubicación en aula. | - Costo directo: **`+$660.000` (`12 h × $55.000/h`)** en Año 1 y 36M | **`+2 días hábiles`** en la tarea crítica `T-08` (la Ruta Crítica pasa de **45 a 47 días hábiles**). | **Reduce la fricción operativa en aula** y evita sobrecargar al instructor con registros manuales en `CU-07`. |
| **P-AJ-03** | **Tiempo de Respuesta en Validación de Asistencia en Hora Pico (`p95`)** | - Ficha `FT-SW-01` (#7.1)<br>- ANS (`B6` Métrica #2)<br>- Propuesta `v1.1` (`B7` §5, §8)<br>- Presupuesto Hoja `6` | Latencia `p95 <= 1,5 segundos` (`1.500 ms`) con 30 usuarios concurrentes. | **Latencia `p95 <= 1,2 segundos` (`1.200 ms`)** con 30 usuarios concurrentes mediante precarga en caché de memoria del padrón de matrícula activa al abrir la sesión. | Atender la sugerencia `S-03` para acelerar el ingreso en los cambios de turno de las 2 sedes. | - Costo directo: **`+$330.000` (`6 h × $55.000/h`)** en Año 1 y 36M | **`0 días`** (absorbido en la holgura de 2 días de `T-09`). | **Reduce la carga de lecturas `SELECT` sobre MySQL en un `35 %`** durante la ráfaga de 30 segundos (`Riesgo R2`). |

---

## 5. Consolidado Financiero del Impacto de la Negociación (`v1.0` → `v1.1`)

| Rubro Presupuestal | Oferta Inicial `v1.0` (Año 1) | Variación Acordada en Acta `B5` | Oferta Ajustada `v1.1` (Año 1) | Oferta Ajustada `v1.1` (36 Meses) |
|---|---|---|---|---|
| **Subtotal de Costos Directos e Indirectos** | `$26.854.900` | `+$1.354.000` (`S-01 + S-02 + S-03`) | **`$28.208.900`** | **`$39.821.700`** |
| **Reserva de Contingencia (Riesgos `R1`–`R7`)** | `$2.445.000` (`9,10 %`) | `-$150.000` (reducción riesgo `R4`) | **`$2.295.000`** (`8,14 %`) | **`$3.098.250`** |
| **Costo Total con Contingencia** | `$29.299.900` | `+$1.204.000` | **`$30.503.900`** | **`$42.919.950`** |
| **Precio de Venta antes de IVA (`Margen 15 %: Costo / 0,85`)** | `$34.470.471` | `+$1.416.471` | **`$35.886.941`** | **`$50.494.059`** |
| **IVA (`19 %`)** | `$6.549.389` | `+$269.130` | **`$6.818.519`** | **`$9.593.871`** |
| **PRECIO TOTAL DE VENTA CON IVA INCLUIDO (COP)** | **`$41.019.860`** | **`+$1.685.601` (`+4,11 %`)** | **`$42.705.460`** | **`$60.087.930`** |
| **Plazo Total de Ejecución (Ruta Crítica CPM)** | **45 días hábiles** | **`+2 días hábiles`** | **47 días hábiles** | — |
| **Holgura frente al Tope de `$70.000.000` (Variante B)** | `+$28.980.140` | `-$1.685.601` | **`+$27.294.540` bajo el tope (Cumple)** | — |

---

## 6. Confirmación Escrita y Firma de las Partes

> **Declaración de confirmación de la contraparte:**  
> *"En calidad de contraparte evaluadora (`@coordinacion-academica-cies`), confirmo por escrito que la propuesta técnica `asistencia-qr` me fue presentada formalmente el 26 de noviembre de 2026, que las 5 sugerencias discutidas (`S-01` a `S-05`) quedaron fielmente registradas y clasificadas en la sección 3 de esta acta, y que apruebo los 3 ajustes técnicos y el nuevo valor consolidado de la versión `v1.1` (`$42.705.460 COP` con IVA incluido para el primer año y plazo de 47 días hábiles)."*

- **Firmado por el Proponente Técnico:** `@estiben08` · Fecha: `2026-11-26`
- **Confirmado por la Contraparte Evaluadora:** `@coordinacion-academica-cies` (Rol Coordinación Académica / Cliente) · Fecha: `2026-11-26`
