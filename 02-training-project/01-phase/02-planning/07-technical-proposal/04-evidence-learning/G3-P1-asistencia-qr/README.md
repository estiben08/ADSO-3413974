# G3 · Propuesta técnica · README de entrega (Producto 1)

## 1. Identificación

| Campo | Valor |
|---|---|
| Producto | P1 Especificaciones técnicas |
| Usuario de GitHub del autor | `@estiben08` |
| Ficha | 3413974 |
| Variante del escenario asignada (A, B, C o D) | **Variante B** (120 usuarios totales, 30 usuarios concurrentes pico, 2 sedes, disponibilidad objetivo 99,5 % mensual, tope primer año `$70.000.000 COP`) |
| Caso de estudio (nombre del proyecto de mi fork) | Sistema de Control de Asistencia Académica con QR Dinámico y Validación de Subred (`asistencia-qr`) |
| Fecha de la última actualización | `2026-11-27` |
| Plazo de entrega | A más tardar el sábado 5 de diciembre de 2026 a las 6:00 a. m. |

## 2. Qué reutilicé de mi trabajo del año

| Artefacto de este producto | Archivo de origen en mi fork (ruta) | Cómo lo reutilicé |
|---|---|---|
| Fichas técnicas (`A2`) y condiciones técnicas (`A5`) | `03-execute/19-week/02-optional-activity/SRC.docx` (§17, §18, §26–§28, §46) y `02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P1-asistencia-qr/A1-ficha-interpretacion-plataforma.md` | Tomé el stack técnico de mi proyecto (Python 3.12 + Flask + MySQL 8.0 + Nginx) y las metas de rendimiento (`p95 <= 1,5 s`, disponibilidad `99,5 %`, rotación QR `30 s`) y las transformé en 4 fichas técnicas formales con 7 características medibles cada una y 7 parámetros de capacidad calculados con fórmula para la Variante B. |
| Referente técnico (`A3`) | `03-execute/13-week/02-optional-activity/document-normativa.docx`, `14-week/02-optional-activity/CoffeeCol_Normativa.docx` y `19-week/02-optional-activity/SRC.docx` (§20, §38) | Separé las reglas operativas internas de mi proyecto («Normativa Interna») respecto de la normatividad legal colombiana y supranacional (Ley 1581 de 2012, Ley 23 de 1982, Decisión Andina 351 de 1993, Ley 1273 de 2009 e ISO/IEC 25010 / 27001 / WCAG 2.2). |
| Dimensionamiento de licencias (`A4`) | `03-execute/19-week/02-optional-activity/SRC.docx` (§27, §28: `Flask`, `Werkzeug`, `mysql-connector-python`, `qrcode`, `hashlib`, `hmac`) | Audité las librerías reales de mi proyecto, dimensioné 7 componentes con fórmulas desde la Variante B y detecté la alerta de compatibilidad GPLv2 de `mysql-connector-python`, calculando su reemplazo por `PyMySQL` (MIT). |
| Estimación económica (`A6`) | `02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-asistencia-qr/03-plan-actividades-analisis.md` y módulos de `SRC.docx` (§14) | Descompuse los módulos y casos de uso (`CU-01` a `CU-10`) de mi sistema en 10 paquetes de esfuerzo estimados con Tres Puntos PERT y construí el libro Excel con fórmulas vivas a 12 y 36 meses. |

## 3. Qué ajusté o construí desde cero

| Artefacto | Qué cambié o construí | Por qué (necesidad del caso o criterio de la rúbrica) |
|---|---|---|
| `A1-formato-ficha-tecnica.md` | Construí desde cero un formato propio de **14 campos** basado en ISO/IEC 25010, IEEE 29148 y Colombia Compra Eficiente. | Cumplir el nivel 100 del **Criterio C1** (mínimo 12 campos con valor, unidad, método de verificación, normas, garantía y compatibilidad). |
| `A2-fichas-tecnicas-diligenciadas.md` | Diligencié **4 fichas técnicas** (`FT-SW-01`, `FT-SW-02`, `FT-HW-01`, `FT-HW-02`), cada una con **7 características medibles** y cero marcas comerciales. | Cumplir el nivel 100 del **Criterio C2** (2 de software, incluyendo el software propio, y 2 de hardware/infraestructura para las 2 sedes de la Variante B). |
| `A3-referente-tecnico-normatividad.md` | Construí la matriz con **5 referentes legales y técnicos vigentes** verificados en fuentes oficiales y separé en sección aparte la normativa interna del proyecto. | Cumplir el nivel 100 del **Criterio C3** (Ley 1581/2012 + Dec. 1074/2015, Ley 23/1982, Decisión Andina 351/1993, estándares ISO 25010/27001/WCAG 2.2 y Ley 1273/2009). |
| `A4-dimensionamiento-licencias.md` | Dimensioné **7 componentes** con fórmulas desde la Variante B, inventarié **6 dependencias del código** con alerta GPLv2 y definí la licencia del software propio. | Cumplir el nivel 100 del **Criterio C4** y la convención del Anexo D sobre costo de reemplazo de librería (`4 h × $55.000 = $220.000 COP`). |
| `A5-estimacion-condiciones-tecnicas.md` | Calculé **7 parámetros técnicos** (concurrencia RPS, almacenamiento a 36 meses, ancho de banda, disponibilidad, latencia p95, RPO/RTO y RAM/CPU) con fórmulas matemáticas. | Cumplir el nivel 100 del **Criterio C5** con coherencia total frente a las 4 fichas de `A2`. |
| `A6-estimacion-condiciones-economicas.xlsx` y `.md` | Construí el libro Excel con **3 hojas y fórmulas vivas** (`PERT`, costos a 12 y 36 meses, directos/indirectos, únicos/recurrentes, contingencia e IVA del 19 %). | Cumplir el nivel 100 del **Criterio C6** respetando el tope de `$70.000.000 COP` de la Variante B (`$35.859.924 COP` con IVA en Año 1). |

## 4. Enlaces a los entregables

### Solo Producto 1

- [x] A1. Formato de ficha técnica (14 campos): [A1-formato-ficha-tecnica.md](./A1-formato-ficha-tecnica.md)
- [x] A2. Fichas técnicas diligenciadas (4 fichas con 7 características medibles cada una): [A2-fichas-tecnicas-diligenciadas.md](./A2-fichas-tecnicas-diligenciadas.md)
- [x] A3. Referente técnico (5 referentes verificados con fecha y enlace oficial): [A3-referente-tecnico-normatividad.md](./A3-referente-tecnico-normatividad.md)
- [x] A4. Dimensionamiento de licencias e inventario de dependencias (7 componentes y 6 dependencias): [A4-dimensionamiento-licencias.md](./A4-dimensionamiento-licencias.md)
- [x] A5. Estimación de condiciones técnicas (7 parámetros con fórmula): [A5-estimacion-condiciones-tecnicas.md](./A5-estimacion-condiciones-tecnicas.md)
- [x] A6. Estimación preliminar de condiciones económicas (hoja de cálculo `.xlsx` con fórmulas vivas + documento `.md`): [A6-estimacion-condiciones-economicas.xlsx](./A6-estimacion-condiciones-economicas.xlsx) · [A6-estimacion-condiciones-economicas.md](./A6-estimacion-condiciones-economicas.md)

## 5. Autoevaluación de mínimos (marca solo lo que verificaste)

| Mínimo | Mi conteo |
|---|---|
| [P1] Fichas diligenciadas / características medibles por ficha | `4 fichas` / `7 características medibles por ficha` |
| [P1] Referentes técnicos (4 o más) / incluyen Ley 1581 de 2012, Ley 23 de 1982, Decisión Andina 351 y un estándar | `5 referentes completos` / `sí` |
| [P1] Componentes de licencias / dependencias inventariadas | `7 componentes` / `6 dependencias` |
| Mis hojas de cálculo usan fórmulas | `sí` (fórmulas PERT, `SUM`, referencias entre hojas y cálculo de contingencia e IVA) |

## 6. Historial de trabajo

| Fecha | Qué hice ese día | Commits |
|---|---|---|
| `2026-11-27` | Diseño del formato de ficha `A1`, elaboración de las 4 fichas `A2`, matriz normativa `A3` y dimensionamiento de licencias `A4` | Ver historial de commits de la carpeta en GitHub |
| `2026-11-27` | Cálculo de los 7 parámetros técnicos `A5` y construcción del libro Excel `A6-estimacion-condiciones-economicas.xlsx` con fórmulas vivas | Ver historial de commits de la carpeta en GitHub |

## 7. Fuentes consultadas

| Fuente (nombre y enlace) | Fecha de consulta | Para qué la usé |
|---|---|---|
| SUIN-Juriscol — Ley Estatutaria 1581 de 2012 (`https://www.suin-juriscol.gov.co/viewDocument.asp?ruta=Leyes/1683819`) y Decreto 1074 de 2015 (`https://www.suin-juriscol.gov.co/viewDocument.asp?ruta=Decretos/30019935`) | `2026-11-24` | Verificar las obligaciones legales de tratamiento de datos personales y Habeas Data en `A3`. |
| SUIN-Juriscol / DNDA — Ley 23 de 1982 (`https://www.suin-juriscol.gov.co/viewDocument.asp?ruta=Leyes/1579084`) y Ley 1450 de 2011 Art. 28 | `2026-11-24` | Verificar el régimen de derechos morales y patrimoniales de autor de software en `A3` y `A4`. |
| Comunidad Andina — Decisión Andina 351 de 1993 (`https://www.comunidadandina.org/StaticFiles/DocOf/DEC351.pdf`) | `2026-11-24` | Verificar los artículos 11 y 23 a 27 sobre protección de programas de ordenador y copias de respaldo en `A3` y `A4`. |
| SUIN-Juriscol — Ley 1273 de 2009 (`https://www.suin-juriscol.gov.co/viewDocument.asp?ruta=Leyes/1676892`) y Ley 527 de 1999 | `2026-11-24` | Sustentar el 5.º referente normativo sobre protección de datos, delitos informáticos y validez probatoria de firmas HMAC en `A3`. |
| ISO/IEC 25010:2011 (`https://www.iso.org/standard/35733.html`), ISO/IEC 27001:2022 y W3C WCAG 2.2 (`https://www.w3.org/TR/WCAG22/`) | `2026-11-24` | Estructurar el formato de ficha técnica `A1` y los referentes técnicos de calidad, seguridad y accesibilidad en `A3`. |
| DigitalOcean Pricing (`https://www.digitalocean.com/pricing/droplets`) y AWS Lightsail Pricing (`https://aws.amazon.com/lightsail/pricing/`) | `2026-11-25` | Consultar precios públicos de referencia para el servidor VPS Cloud (`FT-HW-01`) en `A4` y `A6`. |

## 8. Uso de herramientas de IA (declaración)

| Herramienta | Para qué la usé | Qué parte del producto | Cómo verifiqué el resultado |
|---|---|---|---|
| Asistente de IA (Antigravity / Gemini) | Apoyo en la estructuración de las tablas Markdown de los artefactos `A1` a `A6` y generación del libro Excel `A6-estimacion-condiciones-economicas.xlsx` con `openpyxl`. | Formato de tablas en `A1`–`A6` y fórmulas en `.xlsx`. | Verifiqué en fuentes oficiales (SUIN-Juriscol, CAN, ISO, W3C) la vigencia y artículos exactos de las 5 normas citadas en `A3`, comprobé que cada fórmula matemática de `A4` y `A5` partiera de los números de la Variante B (120 usuarios, 30 concurrentes, 2 sedes, 99,5 %), y revisé que todas las celdas de totales, PERT, contingencia e IVA en el archivo `.xlsx` contuvieran fórmulas vivas y no valores pegados. |

## 9. Declaración de autoría

Declaro que este producto es de mi autoría, que lo elaboré reutilizando y ajustando el trabajo que realicé durante el año en mi fork, que las fuentes están citadas, que los usos de IA están declarados arriba y que puedo explicar cada decisión y cada cálculo en la verificación oral del sábado 5 de diciembre de 2026. Si trabajé con compañeros de equipo, lo indico aquí: el caso base `asistencia-qr` nació en las semanas 16 a 19, pero la totalidad de las especificaciones, fichas, cálculos de la Variante B y hojas de cálculo de esta carpeta fueron elaboradas individualmente por `@estiben08`.

Declaro además que no incluí datos personales reales ni documentos reales de terceros en este repositorio público.

Usuario de GitHub: `@estiben08` · Fecha: `2026-11-27`
