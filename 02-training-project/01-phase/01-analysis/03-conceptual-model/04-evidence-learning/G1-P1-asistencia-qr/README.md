# Plantilla de README de entrega · Guía 1 · Modelo conceptual (Producto 1)

Ruta de entrega en el fork:
`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-asistencia-qr/`

---

## 1. Datos de la entrega

- **Producto:** P1 plan de análisis y casos de uso
- **Usuario de GitHub del autor:** `@estiben08`
- **Caso de estudio:** Sistema de Control de Asistencia Académica con QR Dinámico y Validación de Subred (`asistencia-qr`)
- **Trabajo en equipo del año:** Sí (proyecto formativo trabajado durante las semanas 16 a 19 en `03-execute/`; la estructuración, ampliación de requisitos, selección metodológica, modelado UML y ajustes de esta carpeta son trabajo individual de `@estiben08`).

## 2. Qué reutilicé

| Artefacto | Ruta original en mi fork (semana) | ¿Lo hice solo o en equipo? |
|---|---|---|
| Diagnóstico del problema, técnicas de levantamiento y exigencias funcionales iniciales (`EF-01` a `EF-06`) | `03-execute/16-week/02-optional-activity/asistenciaSENA.txt` | Individual (`@estiben08`) |
| Especificación unificada del flujo de registro por QR dinámico, importación de aprendices y control antifraude por IP | `03-execute/17-week/02-optional-activity/documento_unificado_proyecto (1).md` | En equipo / consolidado en mi fork |
| Descripción general, objetivos y alcance del Sistema de Control de Asistencia QR Zero-Trust (rotación 30 s y HMAC) | `03-execute/19-week/02-optional-activity/01_Descripcion_Proyecto.txt`, `02_Objetivos.txt` y `03_Alcance.txt` | Individual (`@estiben08`) |
| Documento SRS e ingeniería inversa del proyecto (`RF-01` a `RF-05`, `RNF-01` a `RNF-03`, reglas `RN01`–`RN04` y casos `CU-01`, `CU-02`) | `03-execute/19-week/02-optional-activity/SRC.docx` | Individual (`@estiben08`) |

## 3. Qué ajusté

| # | Artefacto | Qué cambié y por qué | Enlace al commit |
|---|---|---|---|
| 1 | Catálogo de Requisitos Funcionales y No Funcionales (`05-matriz-requisito-caso-uso.md`) | En `SRC.docx` solo existían 5 RF generales (`RF01`–`RF05`) y 3 RNF sin métricas. Los amplié y normalicé a **13 Requisitos Funcionales (`RF-01` a `RF-13`)** con prioridad MoSCoW y **5 Requisitos No Funcionales (`RNF-01` a `RNF-05`)** con métricas verificables (p95 <= 1,5 s, disponibilidad 99,5 %, TLS 1.3), mejorando el **Criterio C3** de `Rubricas_G1.md`. | [Ver historial de commits de la carpeta](https://github.com/estiben08/ADSO-3413974/commits/main/02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-asistencia-qr) |
| 2 | Diagrama de Casos de Uso UML (`04-diagrama-casos-uso.drawio` / `.svg`) | En la semana 17 y 19 solo había 2 a 4 casos de uso en texto plano sin relaciones `«include»` ni `«extend»`. Construí el diagrama UML completo con **10 casos de uso** (nombres Verbo + Objeto, agrupando el CRUD administrativo en `CU-02` según regla de arbitraje #1), **3 actores primarios** (`Instructor`, `Aprendiz`, `Administrador`) y **1 actor secundario** (`Temporizador`), frontera del sistema, **2 relaciones `«include»`** (`CU-03 -> CU-04` y `CU-05 -> CU-06`) y **2 relaciones `«extend»`** (`CU-07 -> CU-08` y `CU-10 -> CU-08`) con puntos de extensión y condiciones, mejorando el **Criterio C4**. | [Ver historial de commits de la carpeta](https://github.com/estiben08/ADSO-3413974/commits/main/02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-asistencia-qr) |
| 3 | Matriz Requisito → Caso de Uso (`05-matriz-requisito-caso-uso.md`) | En `SRC.docx` (§23) la matriz tenía solo 4 filas y dejaba `CU-Login` y `CU-04` como «implícitos». Ajusté la matriz para cubrir el **100 % de los 13 requisitos funcionales** de forma explícita y separé los 5 RNF en su propia tabla de restricciones transversales, cumpliendo el nivel 100 % del **Criterio C3**. | [Ver historial de commits de la carpeta](https://github.com/estiben08/ADSO-3413974/commits/main/02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-asistencia-qr) |
| 4 | Caracterización y Plan de Análisis Scrum (`01-caracterizacion-solucion.md` y `03-plan-actividades-analisis.md`) | Incorporé la caracterización formal en los 4 aspectos exigidos y organicé el plan de 8 actividades de análisis en 2 Sprints con responsables, fechas, esfuerzo, entregables y *Definition of Done*, cumpliendo los **Criterios C1 y C2**. | [Ver historial de commits de la carpeta](https://github.com/estiben08/ADSO-3413974/commits/main/02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-asistencia-qr) |

## 4. Qué construí nuevo

- **Caracterización estructurada de la solución (`01-caracterizacion-solucion.md`)** evaluando tipo de proyecto, tamaño del equipo, estabilidad de requisitos y disponibilidad del cliente en el SENA.
- **Comparación multicriterio de las 4 metodologías (`02-comparacion-seleccion-metodologia.md`)**: análisis de RUP, Scrum, XP y RAD frente a las características del proyecto, matriz ponderada y justificación de **Scrum**.
- **Plan de 8 actividades de análisis con cronograma por Sprints (`03-plan-actividades-analisis.md`)**: coherente con eventos Scrum, prioridades MoSCoW y *Definition of Done*.
- **Diagrama de casos de uso UML en fuente editable e imágenes (`04-diagrama-casos-uso.drawio`, `.mmd`, `.svg`, `.png`)** junto con la tabla de justificación de cada relación `«include»` y `«extend»` (`04-especificacion-casos-uso-relaciones.md`).

## 5. Artefactos entregados

**Producto 1**

- [x] Caracterización de la solución: [01-caracterizacion-solucion.md](./01-caracterizacion-solucion.md)
- [x] Comparación de metodologías y selección justificada: [02-comparacion-seleccion-metodologia.md](./02-comparacion-seleccion-metodologia.md)
- [x] Plan de actividades, cronograma y entregables: [03-plan-actividades-analisis.md](./03-plan-actividades-analisis.md)
- [x] Diagrama de casos de uso (fuente editable Draw.io y Mermaid): [04-diagrama-casos-uso.drawio](./04-diagrama-casos-uso.drawio) · [04-diagrama-casos-uso.mmd](./04-diagrama-casos-uso.mmd) · [04-especificacion-casos-uso-relaciones.md](./04-especificacion-casos-uso-relaciones.md)
- [x] Diagrama de casos de uso (imagen SVG y PNG): [04-diagrama-casos-uso.svg](./04-diagrama-casos-uso.svg) · [04-diagrama-casos-uso.png](./04-diagrama-casos-uso.png)
- [x] Matriz requisito → caso de uso: [05-matriz-requisito-caso-uso.md](./05-matriz-requisito-caso-uso.md)

## 6. Declaración de autoría

- [x] Declaro que el ajuste y lo construido nuevo en esta carpeta es **mi trabajo individual**.
- [x] Declaro que lo que tomé de mi equipo o de otra fuente está identificado en la sección 2.
- [x] Entiendo que el sábado 28 de noviembre de 2026 el instructor me hará **3 preguntas orales** sobre mis productos (una del producto 1, una del producto 2 y una tercera a su elección) y que, si respondo bien menos de 2, el producto sobre el que fallé queda con tope de 50.

Firma (usuario de GitHub y fecha): `@estiben08` · `2026-11-27`

## 7. Uso de inteligencia artificial

| Herramienta | Para qué la usé | Qué verifiqué o corregí yo |
|---|---|---|
| Asistente de IA (Antigravity / Gemini) | Apoyo en la estructuración de tablas Markdown, generación del código fuente vectorial `.drawio`/`.svg` del diagrama de casos de uso a partir de mis insumos de las semanas 16 a 19 (`SRC.docx`) y revisión ortográfica. | Verifiqué que los 13 requisitos funcionales y 10 casos de uso correspondan fielmente a mi proyecto de Control de Asistencia QR SENA, comprobé la dirección correcta de las flechas `«include»` (caso base → incluido) y `«extend»` (caso extensor → base) conforme a la sección 7 de `Rubricas_G1.md`, y validé que el CRUD administrativo quedara agrupado en `CU-02`. |

## 8. Autocontrol antes del push

- [x] Hice commits propios en la ventana de trabajo de la guía.
- [x] No subí el marco documental del instructor, plantillas sin diligenciar ni archivos de otras personas.
- [x] Hice `push` y comprobé en GitHub que la carpeta está publicada.
