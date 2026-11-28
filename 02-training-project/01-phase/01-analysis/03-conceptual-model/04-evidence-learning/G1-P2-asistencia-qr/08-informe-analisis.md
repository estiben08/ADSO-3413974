# 08 · Informe de Análisis del Software (Anexo E)

**Proyecto:** Sistema de Control de Asistencia Académica con QR Dinámico (`asistencia-qr`)  
**Autor (GitHub):** `@estiben08` · **Ficha:** 3413974 · Análisis y Desarrollo de Software (ADSO)  
**Competencia:** 220501093 · Evaluar requisitos de la solución de software de acuerdo con metodologías de análisis y estándares  
**RAP asociado:** 592373 · Documenta las actividades de análisis a través de un informe (Criterio C8).

---

## 1. Requisitos Interpretados (Funcionales, No Funcionales y Reglas de Negocio)

El análisis del proyecto **Sistema de Control de Asistencia Académica con QR Dinámico (`asistencia-qr`)** parte de la necesidad operativa identificada en los ambientes de formación presencial del SENA: sustituir el llamado a lista manual en papel y los formularios estáticos vulnerables a suplantación por un mecanismo ágil y verificable en aula. A partir de los insumos levantados en las semanas 16 a 19 (`asistenciaSENA.txt`, `documento_unificado_proyecto (1).md` y `SRC.docx`), se depuró y formalizó la especificación de requisitos en tres bloques:

### 1.1 Requisitos Funcionales (`RF-01` a `RF-13`)
- **Acceso y administración académica (`RF-01` a `RF-03`):** Autenticación diferenciada por rol (`Administrador`, `Instructor`, `Aprendiz`), gestión del catálogo maestro de usuarios, ambientes y fichas de formación, e inscripción/importación masiva de aprendices por ficha sin duplicidad de registros.
- **Apertura de sesión y código QR dinámico (`RF-04` a `RF-06`):** Apertura de sesión de asistencia por ficha y ambiente capturando la subred IP del aula, generación de token QR firmado criptográficamente (`HMAC-SHA256`) y rotación automática del código en pantalla cada 30 segundos.
- **Marcación móvil y validación Zero-Trust (`RF-07` a `RF-09`):** Escaneo del código QR desde el navegador móvil del aprendiz, verificación simultánea de vigencia temporal, autenticidad de firma, pertenencia a la misma subred local del aula e inexistencia de asistencia duplicada en la misma sesión, con auditoría de rechazos.
- **Contingencia, monitoreo, reportes y alertas (`RF-10` a `RF-13`):** Registro manual auditado para aprendices presentes sin dispositivo funcional, monitoreo en vivo de presentes/pendientes/rechazos con cierre consolidado de inasistencias, exportación histórica en CSV/Excel por filtros de fecha y ficha, y generación automática de alertas tempranas de deserción al acumular 3 o más fallas (`RN-06`).

### 1.2 Requisitos No Funcionales (`RNF-01` a `RNF-05`)
- **`RNF-01` (Desempeño):** Tiempo de respuesta en validación de escaneo QR `<= 1,5 segundos` (`p95`) con 35 aprendices concurrentes en una ventana de 30 segundos.
- **`RNF-02` (Seguridad):** Hash de contraseñas con sal (`bcrypt`/`Argon2id`), firma `HMAC-SHA256` en tokens QR y cifrado de canal `HTTPS / TLS 1.3`.
- **`RNF-03` (Usabilidad Móvil):** Interfaz web *Mobile-First* (`>= 360px`) operable desde cualquier navegador móvil estándar sin instalación de apps nativas.
- **`RNF-04` (Disponibilidad e Integridad):** Disponibilidad del `99,5 % mensual` en horario académico e integridad transaccional de registros únicos por sesión.
- **`RNF-05` (Mantenibilidad):** Separación modular entre presentación, reglas de negocio/validación y persistencia de datos.

---

## 2. Síntesis y Enlaces a los Modelos de Análisis Elaborados

Siguiendo la metodología **Scrum** seleccionada y justificada en el Producto 1, se construyeron y verificaron los siguientes modelos coherentes entre sí:

| Modelo / Artefacto de Análisis | Ubicación Relativa | Alcance y Elementos Modelados |
|---|---|---|
| **Caracterización, Metodología Scrum y Plan de Análisis** | [`../G1-P1-asistencia-qr/01-caracterizacion-solucion.md`](../G1-P1-asistencia-qr/01-caracterizacion-solucion.md) · [`02-comparacion-seleccion-metodologia.md`](../G1-P1-asistencia-qr/02-comparacion-seleccion-metodologia.md) · [`03-plan-actividades-analisis.md`](../G1-P1-asistencia-qr/03-plan-actividades-analisis.md) | Caracterización en 4 dimensiones, comparación de RUP, Scrum, XP y RAD (puntaje Scrum: `4,89/5,0`) y plan de 8 actividades en 2 Sprints con *Definition of Done*. |
| **Diagrama de Casos de Uso UML y Matriz RF → CU** | [`../G1-P1-asistencia-qr/04-diagrama-casos-uso.svg`](../G1-P1-asistencia-qr/04-diagrama-casos-uso.svg) · [`04-especificacion-casos-uso-relaciones.md`](../G1-P1-asistencia-qr/04-especificacion-casos-uso-relaciones.md) · [`05-matriz-requisito-caso-uso.md`](../G1-P1-asistencia-qr/05-matriz-requisito-caso-uso.md) | **10 casos de uso** (Verbo + Objeto), 3 actores primarios (`Instructor`, `Aprendiz`, `Administrador`) y 1 secundario (`Temporizador`), 2 relaciones `«include»`, 2 `«extend»` y cobertura del 100 % de los 13 RF. |
| **Diagramas de Actividades UML (3 casos críticos)** | [`./01-diagramas-actividades.md`](./01-diagramas-actividades.md) · [`01-actividad-cu03-apertura-sesion.svg`](./01-actividad-cu03-apertura-sesion.svg) · [`01-actividad-cu05-registro-asistencia-qr.svg`](./01-actividad-cu05-registro-asistencia-qr.svg) · [`01-actividad-cu08-monitoreo-cierre.svg`](./01-actividad-cu08-monitoreo-cierre.svg) | **3 diagramas de actividades** (`CU-03`, `CU-05`, `CU-08`) con calles por actor/sistema, decisiones con guardas entre corchetes `[...]` y barras de concurrencia `Fork/Join`. |
| **Plantillas Extendidas de Casos de Uso (Anexo A)** | [`./02-plantillas-casos-uso-extendidos.md`](./02-plantillas-casos-uso-extendidos.md) | **4 plantillas extendidas** (`CU-03`, `CU-05`, `CU-08`, `CU-09`) con 7–8 pasos principales, 2 flujos alternos y 2 excepciones cada una, sin detalles de implementación. |
| **Modelo de Dominio Conceptual** | [`./03-modelo-dominio.md`](./03-modelo-dominio.md) · [`03-modelo-dominio.svg`](./03-modelo-dominio.svg) · [`03-modelo-dominio.drawio`](./03-modelo-dominio.drawio) | **11 clases conceptuales** con 3 a 5 atributos de negocio cada una, sin métodos ni FK, generalización `Persona` y clase de asociación `MatriculaFicha`. |
| **Modelo Entidad-Relación (MER)** | [`./04-modelo-entidad-relacion.md`](./04-modelo-entidad-relacion.md) · [`04-modelo-entidad-relacion.svg`](./04-modelo-entidad-relacion.svg) · [`04-modelo-entidad-relacion.drawio`](./04-modelo-entidad-relacion.drawio) | **8 entidades** en notación Pata de Gallo con cardinalidad `(mín, máx)` y participación, relación `N:M` resuelta en `MATRICULA_FICHA`, entidad débil `TOKEN_QR_SESION` y relación recursiva en `USUARIO`. |
| **Prototipo Inicial (Mockups Rotulados)** | [`./05-prototipo-inicial-mockups.md`](./05-prototipo-inicial-mockups.md) · `05-pantalla-1..4.svg` y `.png` | **4 pantallas visuales** rotuladas explícitamente con los casos de uso `CU-03/CU-04`, `CU-05/CU-06`, `CU-07/CU-08` y `CU-09/CU-10`. |
| **Matriz de Trazabilidad Total (Anexo C)** | [`./09-matriz-trazabilidad.md`](./09-matriz-trazabilidad.md) | Trazabilidad horizontal del **100 % de los 13 requisitos funcionales** a través de todos los artefactos de análisis. |

---

## 3. Resultado de la Verificación (Criterios que Cumplen y Hallazgos Detectados)

Se diseñó y aplicó el instrumento [`06-lista-chequeo-validacion.md`](./06-lista-chequeo-validacion.md) compuesto por **18 criterios verificables** (incluyendo 5 criterios de cobertura y trazabilidad):

- **En la Primera Verificación (sobre los insumos originales del año):** Cumplieron **12 de 18 criterios (66,7 %)** y se detectaron **6 incumplimientos (`No`)** en los criterios `#1` (cobertura de requisitos y casos implícitos), `#5` (cantidad y nombrado de casos de uso), `#6` (relaciones `«include»` y `«extend»`), `#10` (lenguaje técnico de implementación dentro de flujos de casos de uso), `#12` (métodos y llaves foráneas dentro del esquema de clases conceptual) y `#13` (MER incompleto sin entidad débil ni relación recursiva).
- **En la Segunda Verificación (tras aplicar las correcciones):** Cumplen **18 de 18 criterios (100 %)** con evidencia verificable en cada archivo.

---

## 4. Resumen de Ajustes Realizados y Conclusión de Preparación para Diseño

Los **6 hallazgos** fueron corregidos y documentados con su estado *Antes* y *Después* en [`07-registro-ajustes-segunda-verificacion.md`](./07-registro-ajustes-segunda-verificacion.md):
1. Se amplió el SRS de 5 a **13 Requisitos Funcionales** y **5 No Funcionales**, eliminando casos implícitos y logrando 100 % de cobertura.
2. Se reestructuró el diagrama de casos de uso a **10 casos** con sintaxis «Verbo + Objeto» y agrupación justificada del CRUD maestro en `CU-02`.
3. Se formalizaron las relaciones `«include»` (`CU-03 -> CU-04`, `CU-05 -> CU-06`) y `«extend»` (`CU-07 -> CU-08`, `CU-10 -> CU-08`) respetando la dirección de flecha UML.
4. Se eliminaron todas las referencias a tecnologías (`Flask`, `SQL`, nombres de tablas) de las 4 plantillas extendidas y se alinearon todas sus ramas con los 3 diagramas de actividades.
5. Se depuró el Modelo de Dominio a **11 clases conceptuales** sin métodos ni claves foráneas, añadiendo la jerarquía `Persona` y la clase de asociación `MatriculaFicha`.
6. Se completó el MER con **8 entidades**, resolviendo la relación `N:M` en `MATRICULA_FICHA`, modelando la entidad débil `TOKEN_QR_SESION` y la relación recursiva `id_vocero_orientador`.

**Conclusión:** El modelo conceptual del proyecto `asistencia-qr` es completo, internamente consistente y 100 % trazable a los requisitos del cliente, quedando listo como línea base de entrada para la **Guía 2 (Diseño de la Solución y Arquitectura)**.
