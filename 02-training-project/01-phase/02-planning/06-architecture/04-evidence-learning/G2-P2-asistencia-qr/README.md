# README de entrega · Guía 2: Diseño de la solución (Producto 2)

## 1. Datos de la entrega

| Campo | Valor |
|---|---|
| Producto | P2 (modelo de datos y verificación) |
| Usuario de GitHub del autor | `@estiben08` |
| Ficha | 3413974 |
| Caso elegido (nombre del proyecto) | Sistema de Control de Asistencia Académica con QR Dinámico y Validación de Subred (`asistencia-qr`) |
| Enlace al informe de análisis o SRS del caso (ruta en tu fork) | [`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-asistencia-qr/08-informe-analisis.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-asistencia-qr/08-informe-analisis.md) y [`03-execute/19-week/02-optional-activity/SRC.docx`](../../../../../../03-execute/19-week/02-optional-activity/SRC.docx) |
| Cuenta de GitHub con la que haces los commits | `@estiben08` |

## 2. Origen del insumo y trabajo en equipo

| Pregunta | Respuesta |
|---|---|
| ¿El SRS / informe de análisis lo elaboró un equipo? ¿Cuántas personas? | El prototipo inicial de las semanas 16 a 18 se trabajó en equipo de proyecto (3 aprendices), mientras que el documento `SRC.docx` (semana 19) y el Informe de Análisis de la Guía 1 (`G1-P2-asistencia-qr`) fueron elaborados y ajustados individualmente por `@estiben08`. |
| ¿Qué parte del SRS es tuya? | El catálogo depurado de 13 Requisitos Funcionales, 5 Requisitos No Funcionales, reglas de negocio antifraude (`RN-01` a `RN-06`) y el MER de análisis. |
| ¿Los artefactos de esta entrega los hiciste tú solo? | **Sí.** Todos los artefactos de datos, normalización, diccionario, script SQL, políticas de seguridad y lista de chequeo (`B1` a `B7`) de esta carpeta son trabajo individual de `@estiben08`. |
| ¿Otro aprendiz usó o te compartió archivos de esta entrega? | **No.** Ningún archivo de esta entrega fue copiado de otro aprendiz ni de los ejemplos del instructor. |

## 3. Qué reutilicé, qué ajusté y qué hice nuevo

| Artefacto | Archivo en esta carpeta | Origen (ruta en mi fork o «nuevo») | Qué ajusté o agregué |
|---|---|---|---|
| **B1. Modelo conceptual de datos** | [`B1-modelo-conceptual-datos.md`](./B1-modelo-conceptual-datos.md) · [`B1-modelo-conceptual.drawio`](./B1-modelo-conceptual.drawio) · [`B1-modelo-conceptual.svg`](./B1-modelo-conceptual.svg) · [`B1-modelo-conceptual.png`](./B1-modelo-conceptual.png) | Reutilizado y ajustado desde `03-execute/19-week/02-optional-activity/SRC.docx` (§32–§36) y `G1-P2-asistencia-qr/04-modelo-entidad-relacion.md` | Ajusté el modelo al diseño relacional incorporando `CENTRO_FORMACION` y `AUDITORIA_SEGURIDAD` (9 entidades en total), declarando explícitamente el atributo multivaluado `{telefonos_contacto}`, la relación `N:M`, la entidad débil `TOKEN_QR_SESION`, la relación recursiva y las cardinalidades `(mín, máx)`. |
| **B2. Modelo lógico relacional** | [`B2-modelo-logico-relacional.md`](./B2-modelo-logico-relacional.md) · [`B2-modelo-logico.drawio`](./B2-modelo-logico.drawio) · [`B2-modelo-logico.svg`](./B2-modelo-logico.svg) · [`B2-modelo-logico.png`](./B2-modelo-logico.png) | Reutilizado y ampliado desde `03-execute/19-week/02-optional-activity/SRC.docx` (§33–§35) | Pasé de las 5 tablas incompletas de `SRC.docx` a **11 tablas relacionales en 3FN** con todas sus `PK`, `FK` y `UK`, y construí el cuadro completo de **6 reglas de transformación aplicadas** (`N:M`, `1:N`, entidad débil, atributo multivaluado, relación recursiva y herencia). |
| **B3. Evidencia de normalización** | [`B3-evidencia-normalizacion.md`](./B3-evidencia-normalizacion.md) | **Nuevo** | Desarrollé la normalización paso a paso (`0FN → 1FN → 2FN → 3FN`) de **2 tablas complejas del caso**: `planilla_sesion_asistencia_0fn` (con llave compuesta `(id_sesion, id_aprendiz)` y dependencias parciales) y `ficha_ambiente_centro_0fn` (con dependencias transitivas encadenadas), escribiendo todas las dependencias funcionales (`DF`). |
| **B4. Diccionario de datos** | [`B4-diccionario-datos.md`](./B4-diccionario-datos.md) | Reutilizado y completado desde `03-execute/19-week/02-optional-activity/SRC.docx` (§34) | En `SRC.docx` solo estaban 2 tablas parciales con tipos vacíos (`—`). Completé el **100 % de las 11 tablas y sus 76 columnas** con tipo, tamaño, restricciones y dominio, garantizando coincidencia exacta 1:1 con `B2` y `B5`. |
| **B5. Script SQL y evidencia de ejecución** | [`B5-script-creacion.sql`](./B5-script-creacion.sql) · [`B5-evidencia-ejecucion-sql.md`](./B5-evidencia-ejecucion-sql.md) · [`B5-captura-ejecucion-sql.svg`](./B5-captura-ejecucion-sql.svg) · [`B5-captura-ejecucion-sql.png`](./B5-captura-ejecucion-sql.png) | **Nuevo** | Escribí y ejecuté el script DDL/DML que crea el **100 % de las 11 tablas** con `PK`, **14 `FK` con `ON DELETE RESTRICT/CASCADE/SET NULL`**, `NOT NULL`, `UNIQUE` y **18 restricciones `CHECK`**, adjuntando el log y captura real de ejecución con 0 errores. |
| **B6. Políticas de seguridad y matriz de roles** | [`B6-politicas-seguridad-roles.md`](./B6-politicas-seguridad-roles.md) | Reutilizado y ampliado desde `03-execute/19-week/02-optional-activity/SRC.docx` (§13, §37, §38) | Formulé **9 políticas concretas** (3 de Integridad, 3 de Confidencialidad, 3 de Disponibilidad) especificando hash con sal (`bcrypt`/`Argon2id`), `TLS 1.3`, Ley 1581 de 2012, backup diario y acta mensual de restauración, más la matriz RBAC de **4 roles contra las 11 tablas**. |
| **B7. Lista de chequeo diligenciada** | [`B7-lista-chequeo-verificacion-diseno.md`](./B7-lista-chequeo-verificacion-diseno.md) | **Nuevo** | Construí y apliqué la lista de chequeo de **24 criterios medibles** agrupados por los 8 artefactos de `G2-P1` y `G2-P2` con severidad y evidencia, más el registro de **4 hallazgos de diseño corregidos**. |

**Qué reutilicé (resumen en 3 a 5 líneas):**
Reutilicé el modelo relacional preliminar de `SRC.docx` de la semana 19 (`usuarios`, `fichas`, `ficha_aprendiz`, `sesiones`, `asistencias`), las reglas de validación HMAC y subred IP documentadas en las semanas 17 a 19, y el MER elaborado en la Guía 1 (`G1-P2-asistencia-qr/04-modelo-entidad-relacion.md`).

**Qué ajusté para llevarlo al estándar de la rúbrica (resumen en 3 a 5 líneas):**
Completé todos los tipos de datos faltantes (`—`) del diccionario original de `SRC.docx`, expandí el esquema a 11 tablas normalizadas en 3FN (incorporando `centro_formacion`, `telefono_usuario`, `ambiente_formacion`, `token_qr_sesion`, `alerta_inasistencia` y `auditoria_seguridad`), y añadí restricciones declarativas `CHECK` y acciones referenciales `ON DELETE` en todas las llaves foráneas.

**Qué hice completamente nuevo (resumen en 3 a 5 líneas):**
Elaboré el cuadro formal de reglas de transformación conceptual → lógico, la demostración paso a paso de normalización `0FN → 1FN → 2FN → 3FN` de dos tablas propias con sus dependencias funcionales escritas, el script SQL ejecutable verificado con 0 errores en motor SQL, las 9 políticas CIA con cumplimiento de Ley 1581 de 2012, la matriz de 4 roles × 11 tablas y la lista de chequeo de 24 criterios aplicada a `G2-P1` y `G2-P2`.

## 4. Autoverificación de mínimos

**Si es P2:**
- [x] B1 Modelo conceptual: ≥ 6 entidades (9 entidades), cardinalidades `(mín, máx)`, ≥ 1 N:M y ≥ 1 1:N
- [x] B2 Modelo lógico: ≥ 8 tablas (11 tablas) con PK/FK y cuadro de reglas de transformación
- [x] B3 Normalización: ≥ 2 tablas de 0FN a 3FN con dependencias funcionales (Caso 1 con llave compuesta y dependencia parcial; Caso 2 con dependencias transitivas)
- [x] B4 Diccionario de datos completo (100 % de las 11 tablas y 76 columnas, idéntico a B2 y B5)
- [x] B5 Script SQL ejecutado sin errores (evidencia adjunta) y `ON DELETE` en ≥ 3 FK (14 FK con `ON DELETE` y 18 `CHECK`)
- [x] B6 ≥ 6 políticas de seguridad (9 políticas, con hash y sal en contraseñas y TLS 1.3) y matriz de ≥ 3 roles (4 roles × 11 tablas)
- [x] B7 Lista de chequeo de ≥ 20 criterios (24 criterios), diligenciada sobre P1 y P2, con severidad, evidencia y 4 hallazgos corregidos

## 5. Historial de commits

| Día | Qué avancé (mensaje del commit) |
|---|---|
| `2026-11-27` | Estructuración del modelo lógico de 11 tablas en 3FN, normalización y diccionario de datos de `asistencia-qr` |
| `2026-11-27` | Ejecución y validación del script SQL `B5`, políticas de seguridad `B6` y lista de chequeo `B7` de `G2-P2-asistencia-qr` |

## 6. Uso de inteligencia artificial (declaración obligatoria)

| Herramienta | Para qué la usé | Qué verifiqué o cambié después |
|---|---|---|
| Asistente de IA (Antigravity / Gemini) | Apoyo en el formateo Markdown del diccionario de 76 columnas (`B4`), generación de los diagramas `.svg`/`.drawio` (`B1`, `B2`) y estructuración de las tablas de normalización (`B3`). | Ejecuté personalmente el script `B5-script-creacion.sql` sobre el motor SQL verificando que las 11 tablas, las 14 llaves foráneas y los 18 `CHECK` crearan e insertaran datos con 0 errores, comprobé la coincidencia exacta de nombres y tipos entre `B2`, `B4` y `B5`, y verifiqué las dependencias funcionales de `B3`. |

## 7. Enlaces

- Informe de análisis / SRS del caso: [`../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-asistencia-qr/08-informe-analisis.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-asistencia-qr/08-informe-analisis.md)
- Carpeta del Producto 1 (Artefactos de diseño): [`../G2-P1-asistencia-qr/`](../G2-P1-asistencia-qr/)
- Carpeta de esta entrega en GitHub: `02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P2-asistencia-qr/`

## 8. Declaración de autoría

Declaro que los artefactos de esta carpeta son de mi autoría, que lo que reutilicé de mi trabajo del año o de otras fuentes está indicado en la sección 3, que no entregué como propio material del instructor ni de otros aprendices, y que puedo explicar cada artefacto en la verificación oral.

Usuario de GitHub: `@estiben08`  Fecha: `2026-11-27`
