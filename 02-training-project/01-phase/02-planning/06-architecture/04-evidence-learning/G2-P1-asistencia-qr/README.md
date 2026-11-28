# README de entrega · Guía 2: Diseño de la solución (Producto 1)

## 1. Datos de la entrega

| Campo | Valor |
|---|---|
| Producto | P1 (artefactos de diseño) |
| Usuario de GitHub del autor | `@estiben08` |
| Ficha | 3413974 |
| Caso elegido (nombre del proyecto) | Sistema de Control de Asistencia Académica con QR Dinámico y Validación de Subred (`asistencia-qr`) |
| Enlace al informe de análisis o SRS del caso (ruta en tu fork) | [`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-asistencia-qr/08-informe-analisis.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-asistencia-qr/08-informe-analisis.md) y [`03-execute/19-week/02-optional-activity/SRC.docx`](../../../../../../03-execute/19-week/02-optional-activity/SRC.docx) |
| Cuenta de GitHub con la que haces los commits | `@estiben08` |

## 2. Origen del insumo y trabajo en equipo

| Pregunta | Respuesta |
|---|---|
| ¿El SRS / informe de análisis lo elaboró un equipo? ¿Cuántas personas? | El prototipo inicial de las semanas 16 a 18 se exploró en grupo de proyecto (3 aprendices), y el documento de ingeniería inversa `SRC.docx` (semana 19) junto con el Informe de Análisis de la Guía 1 (`G1-P1` y `G1-P2`) fueron consolidados y ajustados individualmente por `@estiben08`. |
| ¿Qué parte del SRS es tuya? | La estructuración completa de los 13 Requisitos Funcionales (`RF-01` a `RF-13`), los 5 Requisitos No Funcionales (`RNF-01` a `RNF-05`), las reglas de negocio Zero-Trust (rotación 30 s, firma HMAC y subred IP) y el modelo conceptual de la Guía 1. |
| ¿Los artefactos de esta entrega los hiciste tú solo? | **Sí.** La totalidad de los artefactos de diseño (`A1` a `A7`) de esta carpeta son de autoría individual de `@estiben08`. |
| ¿Otro aprendiz usó o te compartió archivos de esta entrega? | **No.** Ningún artefacto de diseño de esta carpeta fue copiado de otro aprendiz ni del material de ejemplo del instructor. |

## 3. Qué reutilicé, qué ajusté y qué hice nuevo

| Artefacto | Archivo en esta carpeta | Origen (ruta en mi fork o «nuevo») | Qué ajusté o agregué |
|---|---|---|---|
| **A1. Ficha de interpretación y plataforma** | [`A1-ficha-interpretacion-plataforma.md`](./A1-ficha-interpretacion-plataforma.md) | Reutilizado y ampliado desde `03-execute/19-week/02-optional-activity/SRC.docx` (§17, §18, §26) y `G1-P2-asistencia-qr/08-informe-analisis.md` | Seleccioné los 13 RF y 5 RNF con métricas cuantificables (`p95 <= 1,5 s`, `99,5 %`), y justifiqué el lenguaje POO (**Python 3.12**) y el motor **Relacional (MySQL 8.0)** con 4 condiciones concretas del caso cada uno. |
| **A2. Diagrama de clases de diseño** | [`A2-diagrama-clases.md`](./A2-diagrama-clases.md) · [`A2-diagrama-clases.drawio`](./A2-diagrama-clases.drawio) · [`A2-diagrama-clases.mmd`](./A2-diagrama-clases.mmd) · [`A2-diagrama-clases.svg`](./A2-diagrama-clases.svg) · [`A2-diagrama-clases.png`](./A2-diagrama-clases.png) | Reutilizado y rediseñado desde `03-execute/17-week/02-optional-activity/trabajo/architecture/architecture.md` (§101) y `G1-P2-asistencia-qr/03-modelo-dominio.md` | Pasé de un boceto de 3 clases a **18 elementos orientados a objetos (16 clases y 2 interfaces)** con atributos tipados, visibilidad, métodos con parámetros tipados, herencia (`Usuario`), composición (`SesionAsistencia *-- TokenQRSesion`), agregación (`FichaFormacion o-- MatriculaFicha`), polimorfismo y alta cohesión. |
| **A3. Patrones de diseño GoF** | [`A3-patrones-diseno.md`](./A3-patrones-diseno.md) | **Nuevo** (apoyado en el análisis de mejoras de `03-execute/19-week/02-optional-activity/SRC.docx` §25 y §46) | Apliqué y justifiqué **3 patrones GoF distintos de Singleton** sobre las clases del diagrama A2: **Estrategia** (`IReglaValidacionAsistencia` con 3 validadores), **Método Fábrica** (`FabricaExportadorReporte` + `IExportadorReporte`) y **Fachada** (`ServicioControlAsistencia`). |
| **A4. Arquitectura del software** | [`A4-arquitectura-software.md`](./A4-arquitectura-software.md) · [`A4-arquitectura.drawio`](./A4-arquitectura.drawio) · [`A4-arquitectura.svg`](./A4-arquitectura.svg) · [`A4-arquitectura.png`](./A4-arquitectura.png) | Reutilizado y ajustado desde `03-execute/19-week/02-optional-activity/SRC.docx` (§24, §29, §46) | Formalicé la **Arquitectura en 3 Capas estrictas** (Presentación MVC, Lógica/Dominio, Acceso a Datos con `MySQLConnectionPool`) sin saltos de capa, y construí la tabla de decisiones arquitectónicas para los **5 RNF** con alternativas descartadas y razones técnicas. |
| **A5. Vista de componentes** | [`A5-vista-componentes.md`](./A5-vista-componentes.md) · [`A5-vista-componentes.drawio`](./A5-vista-componentes.drawio) · [`A5-vista-componentes.svg`](./A5-vista-componentes.svg) · [`A5-vista-componentes.png`](./A5-vista-componentes.png) | **Nuevo** | Diseñé **7 componentes modulares** con sus interfaces provistas (`IAutenticacion`, `IGestionAcademica`, `ISesionQR`, `IRegistroAsistencia`, `IReportesAlertas`, `IRepositorioDatos`), interfaces requeridas, dirección de dependencias y mapeo a clases y requisitos. |
| **A6. Vista de despliegue** | [`A6-vista-despliegue.md`](./A6-vista-despliegue.md) · [`A6-vista-despliegue.drawio`](./A6-vista-despliegue.drawio) · [`A6-vista-despliegue.svg`](./A6-vista-despliegue.svg) · [`A6-vista-despliegue.png`](./A6-vista-despliegue.png) | Reutilizado y ajustado desde `03-execute/17-week/02-optional-activity/trabajo/architecture/architecture.md` (§3) | Modelé **4 nodos de despliegue** (PC Aula Instructor, Smartphone Aprendiz en WiFi Aula, Servidor App Linux Nginx + Gunicorn y Servidor MySQL 8.0 en red privada) con artefactos alojados, protocolos/puertos (`HTTPS 443 TLS 1.3`, `WSGI 8000`, `MySQL 3306`) y decisiones vinculadas a RNF. |
| **A7. Matriz de trazabilidad** | [`A7-matriz-trazabilidad.md`](./A7-matriz-trazabilidad.md) | **Nuevo** (evolución hacia diseño de `G1-P2-asistencia-qr/09-matriz-trazabilidad.md`) | Construí la matriz bidireccional completa que vincula el **100 % de los 13 RF y 5 RNF** con sus clases de diseño, tablas del modelo lógico, componentes y decisiones/patrones, sin clases ni tablas huérfanas. |

**Qué reutilicé (resumen en 3 a 5 líneas):**
Reutilicé el documento de especificación e ingeniería inversa `SRC.docx` de la semana 19 (donde definí la solución Python/Flask + MySQL con códigos QR firmados por HMAC y validación de subred IP), el esquema inicial de 3 clases y topología de la semana 17, y el Informe de Análisis completo de la Guía 1 (`G1-P1-asistencia-qr` y `G1-P2-asistencia-qr`).

**Qué ajusté para llevarlo al estándar de la rúbrica (resumen en 3 a 5 líneas):**
Corregí los problemas arquitectónicos detectados en `SRC.docx` (§46) incorporando una piscina de conexiones (`MySQLConnectionPool`) y exportación CSV en *streaming*, expandí el diagrama de clases a 16 clases y 2 interfaces con alta cohesión (separando dominio, validadores antifraude y exportadores), y eliminé cualquier salto entre la capa de presentación y la base de datos.

**Qué hice completamente nuevo (resumen en 3 a 5 líneas):**
Diseñé la aplicación formal de 3 patrones GoF (Estrategia en `IReglaValidacionAsistencia`, Método Fábrica en `FabricaExportadorReporte` y Fachada en `ServicioControlAsistencia`), la tabla de decisiones arquitectónicas con alternativas descartadas para los 5 RNF, la vista de 7 componentes con interfaces provistas/requeridas, la vista de despliegue de 4 nodos con protocolos y la matriz de trazabilidad bidireccional análisis → diseño.

## 4. Autoverificación de mínimos

**Si es P1:**
- [x] A1 Ficha de interpretación: ≥ 8 RF (13 RF) y ≥ 3 RNF (5 RNF) con ID; plataforma justificada con 4 condiciones
- [x] A2 Diagrama de clases: ≥ 8 clases (16 clases + 2 interfaces), tipos, métodos, multiplicidades, ≥ 1 composición/agregación y ≥ 1 herencia e interfaz (con 3 y 2 implementaciones)
- [x] A3 ≥ 2 patrones GoF distintos aplicados en el diagrama (3 patrones: Estrategia, Método Fábrica y Fachada; ninguno es Singleton)
- [x] A4 Arquitectura con diagrama y tabla de ≥ 3 RNF → decisión (5 RNF con alternativa descartada y razón)
- [x] A5 Vista de componentes: ≥ 5 componentes con interfaces (7 componentes con interfaces provistas y requeridas)
- [x] A6 Vista de despliegue: ≥ 3 nodos con artefactos y protocolos (4 nodos con artefactos, puertos y decisiones RNF)
- [x] A7 Matriz de trazabilidad análisis → diseño (100 % de los 13 RF y 5 RNF, sin clases ni tablas huérfanas)
- [x] Fuente editable (`.drawio` / `.mmd`) e imagen exportada (`.svg` y `.png`) de cada diagrama

## 5. Historial de commits

| Día | Qué avancé (mensaje del commit) |
|---|---|
| `2026-11-27` | Sincronización de guías G1-G3 y estructuración de artefactos de análisis y diseño del proyecto `asistencia-qr` |
| `2026-11-27` | Entrega completa y verificada de artefactos `A1` a `A7` de `G2-P1-asistencia-qr` con diagramas editables e imágenes |

## 6. Uso de inteligencia artificial (declaración obligatoria)

| Herramienta | Para qué la usé | Qué verifiqué o cambié después |
|---|---|---|
| Asistente de IA (Antigravity / Gemini) | Apoyo en la generación de los archivos vectoriales `.svg`/`.drawio` y maquetación Markdown de las tablas de decisiones arquitectónicas, componentes, despliegue y trazabilidad a partir de mi documento `SRC.docx` (semana 19). | Verifiqué que las 16 clases y 2 interfaces cumplieran la regla de alta cohesión (sin mezclar UI, lógica, persistencia ni reportes), comprobé las 3 implementaciones del patrón Estrategia (`ValidadorFirmaHMAC`, `ValidadorSubredIP`, `ValidadorUnicidadSesion`) y las 2 del Método Fábrica (`ExportadorCSV`, `ExportadorExcel`), y validé que las 11 tablas trazadas en `A7` coincidieran exactamente con el modelo lógico de `G2-P2`. |

## 7. Enlaces

- Informe de análisis / SRS del caso: [`../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-asistencia-qr/08-informe-analisis.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-asistencia-qr/08-informe-analisis.md)
- Carpeta de esta entrega en GitHub: `02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P1-asistencia-qr/`
- Producto 2 complementario (Modelo de datos y verificación): [`../G2-P2-asistencia-qr/`](../G2-P2-asistencia-qr/)

## 8. Declaración de autoría

Declaro que los artefactos de esta carpeta son de mi autoría, que lo que reutilicé de mi trabajo del año o de otras fuentes está indicado en la sección 3, que no entregué como propio material del instructor ni de otros aprendices, y que puedo explicar cada artefacto en la verificación oral.

Usuario de GitHub: `@estiben08`  Fecha: `2026-11-27`
