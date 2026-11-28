# Plantilla de README de entrega · Guía 1 · Modelo conceptual (Producto 2)

Ruta de entrega en el fork:
`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-asistencia-qr/`

---

## 1. Datos de la entrega

- **Producto:** P2 modelo de análisis y verificación
- **Usuario de GitHub del autor:** `@estiben08`
- **Caso de estudio:** Sistema de Control de Asistencia Académica con QR Dinámico y Validación de Subred (`asistencia-qr`)
- **Trabajo en equipo del año:** Sí (insumos iniciales de semanas 16 a 19 trabajados durante el año en `03-execute/`; el modelado de actividades, las 4 plantillas extendidas, el modelo de dominio conceptual, el MER en Pata de Gallo, los mockups rotulados, la lista de chequeo de 18 criterios, los 6 ajustes y el informe de análisis de esta carpeta son trabajo individual de `@estiben08`).

## 2. Qué reutilicé

| Artefacto | Ruta original en mi fork (semana) | ¿Lo hice solo o en equipo? |
|---|---|---|
| Flujos narrativos de registro de asistencia por instructor y aprendiz, importación y consulta | `03-execute/17-week/02-optional-activity/documento_unificado_proyecto (1).md` | En equipo / consolidado en mi fork |
| Esquema preliminar de 3 clases (`Formador`, `Session`, `Registro`) y casos de uso básicos | `03-execute/17-week/02-optional-activity/trabajo/architecture/architecture.md` y `db/data-model.md` | En equipo / consolidado en mi fork |
| Mockup HTML e interfaz preliminar de asistencia QR | `03-execute/17-week/02-optional-activity/asistencia_qr_mockup (1).html` y `16-week/02-optional-activity/SENA_Control_Asistencia_Mockup.pptx` | Individual (`@estiben08`) |
| Documentación SRS, diccionario preliminar de 5 tablas y relaciones en texto plano | `03-execute/19-week/02-optional-activity/SRC.docx` | Individual (`@estiben08`) |

## 3. Qué ajusté

| # | Artefacto | Qué cambié y por qué | Enlace al commit |
|---|---|---|---|
| 1 | Plantillas extendidas de casos de uso (`02-plantillas-casos-uso-extendidos.md`) | En `SRC.docx` (§21) solo había 2 casos de uso de 5 líneas que mezclaban detalles técnicos (`Flask`, `tabla asistencias`, `HMAC`). Construí **4 plantillas extendidas** (`CU-03`, `CU-05`, `CU-08`, `CU-09`) con el formato del Anexo A, 7 a 8 pasos en lenguaje puro de intención actor-sistema (cero tecnología), 2 flujos alternos y 2 excepciones cada una, mejorando el **Criterio C2** de `Rubricas_G1.md`. | [Ver historial de commits de la carpeta](https://github.com/estiben08/ADSO-3413974/commits/main/02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-asistencia-qr) |
| 2 | Modelo de Dominio Conceptual (`03-modelo-dominio.md` y `.svg`) | En la semana 17 el esquema tenía solo 3 clases y mezclaba métodos (`+iniciarSesion()`) y claves foráneas (`unitId`). Lo transformé en un **Modelo de Dominio conceptual de 11 clases** con 3 a 5 atributos de negocio por clase, **sin métodos ni llaves foráneas** (Regla de Arbitraje #5 y #10), añadiendo la generalización `Persona` (`Instructor`, `Aprendiz`, `Administrador`) y la clase de asociación `MatriculaFicha`, cumpliendo el 100 % del **Criterio C3**. | [Ver historial de commits de la carpeta](https://github.com/estiben08/ADSO-3413974/commits/main/02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-asistencia-qr) |
| 3 | Modelo Entidad-Relación MER (`04-modelo-entidad-relacion.md` y `.svg`) | En `SRC.docx` (§34–§36) el modelo tenía 5 tablas en texto con tipos faltantes (`—`), sin entidad débil ni relación recursiva. Diseñé el **MER en notación Pata de Gallo con 8 entidades**, cardinalidades `(mín, máx)` y participación, relación `N:M` resuelta en `MATRICULA_FICHA` con atributos propios, entidad débil `TOKEN_QR_SESION` y relación recursiva `id_vocero_orientador` en `USUARIO`, cumpliendo el 100 % del **Criterio C4**. | [Ver historial de commits de la carpeta](https://github.com/estiben08/ADSO-3413974/commits/main/02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-asistencia-qr) |
| 4 | Prototipo Inicial Rotulado (`05-prototipo-inicial-mockups.md` y `05-pantalla-1..4.svg`) | Ajusté los mockups de las semanas 16 y 17 en **4 pantallas completas**, añadiendo en cada una el rótulo visible de trazabilidad con el código y nombre del caso de uso (`CU-03/CU-04`, `CU-05/CU-06`, `CU-07/CU-08`, `CU-09/CU-10`) y cubriendo el caso de contingencia manual y las alertas de deserción, cumpliendo el 100 % del **Criterio C5**. | [Ver historial de commits de la carpeta](https://github.com/estiben08/ADSO-3413974/commits/main/02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-asistencia-qr) |

## 4. Qué construí nuevo

- **3 Diagramas de actividades UML (`01-diagramas-actividades.md`, `.drawio`, `.svg`, `.png`)** para los casos críticos `CU-03`, `CU-05` y `CU-08`, con calles por actor/sistema, decisiones con guardas completas entre corchetes `[...]` y barras de concurrencia `Fork/Join`.
- **Lista de chequeo de validación de 18 criterios verificables (`06-lista-chequeo-validacion.md` — Anexo B)** con 5 criterios de cobertura/trazabilidad, evidencia puntual y hallazgos.
- **Registro de 6 ajustes con Antes, Después y acta de segunda verificación (`07-registro-ajustes-segunda-verificacion.md` — Anexo D)**.
- **Informe de análisis (`08-informe-analisis.md` — Anexo E)** y **Matriz de trazabilidad extremo a extremo (`09-matriz-trazabilidad.md` — Anexo C)** con 100 % de cobertura de los 13 requisitos funcionales.

## 5. Artefactos entregados

**Producto 2**

- [x] Diagramas de actividades (3 diagramas: `CU-03`, `CU-05`, `CU-08`): [01-diagramas-actividades.md](./01-diagramas-actividades.md) · [01-actividad-cu03-apertura-sesion.svg](./01-actividad-cu03-apertura-sesion.svg) · [01-actividad-cu05-registro-asistencia-qr.svg](./01-actividad-cu05-registro-asistencia-qr.svg) · [01-actividad-cu08-monitoreo-cierre.svg](./01-actividad-cu08-monitoreo-cierre.svg)
- [x] Plantillas extendidas de casos de uso (4 plantillas: `CU-03`, `CU-05`, `CU-08`, `CU-09`): [02-plantillas-casos-uso-extendidos.md](./02-plantillas-casos-uso-extendidos.md)
- [x] Modelo de dominio (11 clases conceptuales): [03-modelo-dominio.md](./03-modelo-dominio.md) · [03-modelo-dominio.drawio](./03-modelo-dominio.drawio) · [03-modelo-dominio.svg](./03-modelo-dominio.svg) · [03-modelo-dominio.png](./03-modelo-dominio.png)
- [x] Modelo entidad-relación (8 entidades en Pata de Gallo): [04-modelo-entidad-relacion.md](./04-modelo-entidad-relacion.md) · [04-modelo-entidad-relacion.drawio](./04-modelo-entidad-relacion.drawio) · [04-modelo-entidad-relacion.svg](./04-modelo-entidad-relacion.svg) · [04-modelo-entidad-relacion.png](./04-modelo-entidad-relacion.png)
- [x] Prototipo inicial (4 pantallas rotuladas por caso de uso): [05-prototipo-inicial-mockups.md](./05-prototipo-inicial-mockups.md) · [05-pantalla-1-apertura-qr.svg](./05-pantalla-1-apertura-qr.svg) · [05-pantalla-2-escaneo-aprendiz.svg](./05-pantalla-2-escaneo-aprendiz.svg) · [05-pantalla-3-monitoreo-cierre.svg](./05-pantalla-3-monitoreo-cierre.svg) · [05-pantalla-4-reportes-alertas.svg](./05-pantalla-4-reportes-alertas.svg)
- [x] Lista de chequeo diligenciada (18 criterios verificables): [06-lista-chequeo-validacion.md](./06-lista-chequeo-validacion.md)
- [x] Registro de ajustes y segunda verificación (6 hallazgos corregidos): [07-registro-ajustes-segunda-verificacion.md](./07-registro-ajustes-segunda-verificacion.md)
- [x] Informe de análisis (Anexo E): [08-informe-analisis.md](./08-informe-analisis.md)
- [x] Matriz de trazabilidad (Anexo C · 100 % de los 13 RF): [09-matriz-trazabilidad.md](./09-matriz-trazabilidad.md)

## 6. Declaración de autoría

- [x] Declaro que el ajuste y lo construido nuevo en esta carpeta es **mi trabajo individual**.
- [x] Declaro que lo que tomé de mi equipo o de otra fuente está identificado en la sección 2.
- [x] Entiendo que el sábado 28 de noviembre de 2026 el instructor me hará **3 preguntas orales** sobre mis productos (una del producto 1, una del producto 2 y una tercera a su elección) y que, si respondo bien menos de 2, el producto sobre el que fallé queda con tope de 50.

Firma (usuario de GitHub y fecha): `@estiben08` · `2026-11-27`

## 7. Uso de inteligencia artificial

| Herramienta | Para qué la usé | Qué verifiqué o corregí yo |
|---|---|---|
| Asistente de IA (Antigravity / Gemini) | Apoyo en el formateo de las tablas de los Anexos A, B, C, D y E, y generación del código vectorial `.svg`/`.drawio` de los diagramas de actividades, modelo de dominio, MER y mockups a partir de mi proyecto `asistencia-qr`. | Verifiqué que las 4 plantillas extendidas no tuvieran detalles de implementación técnica (regla de arbitraje #10), que cada rama de los 3 diagramas de actividades coincidiera con los flujos alternos y excepciones de las plantillas, que el modelo de dominio no tuviera métodos ni llaves foráneas, y que el MER incluyera la relación N:M resuelta (`MATRICULA_FICHA`), la entidad débil (`TOKEN_QR_SESION`) y la relación recursiva (`id_vocero_orientador`). |

## 8. Autocontrol antes del push

- [x] Hice commits propios en la ventana de trabajo de la guía.
- [x] No subí el marco documental del instructor, plantillas sin diligenciar ni archivos de otras personas.
- [x] Hice `push` y comprobé en GitHub que la carpeta está publicada.
