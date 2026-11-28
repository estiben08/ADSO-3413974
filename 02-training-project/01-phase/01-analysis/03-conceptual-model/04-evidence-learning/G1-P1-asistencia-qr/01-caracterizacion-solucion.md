# 01 · Caracterización de la Solución de Software

**Proyecto:** Sistema de Control de Asistencia Académica con QR Dinámico y Validación de Subred (`asistencia-qr`)  
**Autor (GitHub):** `@estiben08`  
**Ficha:** 3413974 · Análisis y Desarrollo de Software (ADSO)  
**Insumos reutilizados del repositorio:**
- `03-execute/16-week/02-optional-activity/asistenciaSENA.txt`
- `03-execute/17-week/02-optional-activity/documento_unificado_proyecto (1).md`
- `03-execute/19-week/02-optional-activity/01_Descripcion_Proyecto.txt`
- `03-execute/19-week/02-optional-activity/02_Objetivos.txt`
- `03-execute/19-week/02-optional-activity/03_Alcance.txt`
- `03-execute/19-week/02-optional-activity/SRC.docx`

---

## 1. Contexto y Problema de Negocio

En los ambientes de formación presencial del SENA, el registro tradicional de asistencia mediante planillas en papel o llamado verbal consume entre 10 y 15 minutos por sesión académica, genera errores de transcripción y dificulta la consolidación oportuna de alertas de inasistencia. Por otro lado, los formularios web estáticos (como enlaces fijos compartidos en mensajería) permiten la suplantación remota: un aprendiz ausente recibe el enlace o una captura estática por WhatsApp y registra su asistencia desde fuera del centro de formación.

La solución **Sistema de Control de Asistencia QR (`asistencia-qr`)** resuelve ambos problemas mediante una aplicación web responsiva con enfoque *Zero-Trust* en aula:
1. El **Instructor** abre la sesión de formación desde el computador del ambiente y proyecta un código QR dinámico que rota automáticamente cada 30 segundos y lleva una firma criptográfica `HMAC-SHA256`.
2. El **Aprendiz** escanea el código QR desde el navegador de su teléfono móvil conectado a la red WiFi institucional.
3. El sistema verifica en tiempo real cuatro reglas: (a) que la sesión esté activa, (b) que el token QR sea vigente y su firma HMAC sea auténtica, (c) que la dirección IP de origen del móvil coincida en subred local con la IP de la sesión del aula, y (d) que no exista un registro previo del mismo aprendiz en esa sesión.

---

## 2. Caracterización bajo los 4 Aspectos Obligatorios (Criterio C1 · RAP 592375)

Para seleccionar de manera objetiva la metodología de desarrollo y planear las actividades de análisis, se caracteriza el proyecto en las cuatro dimensiones exigidas por la guía:

| # | Aspecto de Caracterización | Valor / Perfil en el Proyecto `asistencia-qr` | Evidencia e Implicación para la Fase de Análisis |
|---|---|---|---|
| **1** | **Tipo de proyecto y criticidad** | **Aplicación web institucional de gestión operativa con controles de seguridad antifraude en tiempo real** (monolito modular MVC con proyección asíncrona de QR, validación criptográfica HMAC, verificación de subred IP y reportes CSV). Alcance de tamaño mediano-pequeño (MVP académico operativo) con alta exigencia en integridad de datos y tiempos de respuesta en ráfagas de escaneo (30–40 aprendices escaneando en una ventana de 30 segundos). | Requiere modelar con precisión las reglas de negocio antifraude (`RN-01` a `RN-06`), los flujos de excepción en el escaneo QR y la estructura relacional que impida registros duplicados. |
| **2** | **Tamaño y perfil del equipo** | **Equipo pequeño (1 a 3 aprendices desarrolladores en formación ADSO, con ajuste y consolidación individual por `@estiben08`)**, roles multifuncionales (analista, diseñador, desarrollador full-stack Python/MySQL y verificador QA) y dedicación parcial de 12 a 18 horas semanales combinadas con sesiones formativas. | Un equipo pequeño con roles compartidos no puede sostener una burocracia documental pesada; necesita artefactos visuales claros (UML, prototipos navegables y listas de chequeo verificables) que guíen directamente la construcción. |
| **3** | **Estabilidad de los requisitos** | **Estabilidad media-alta en el núcleo funcional, con evolución iterativa en mecanismos antifraude y reportes.** El objetivo nuclear (gestionar fichas, abrir sesión, proyectar QR, escanear y exportar asistencia) está bien definido en el SRS (`SRC.docx`), pero las reglas operativas de aula (tiempo de rotación del QR de 30 s vs. 5 min, registro manual por contingencia cuando un aprendiz no tiene celular, y umbrales de alerta temprana de deserción) evolucionaron a partir de pruebas en ambiente real. | Exige una metodología que permita congelar el alcance de cada iteración corta pero aceptar refinamientos en los criterios de aceptación entre iteraciones tras validar con usuarios reales. |
| **4** | **Disponibilidad del cliente / usuarios** | **Alta y periódica (retroalimentación semanal en ambiente de formación).** Los actores reales del dominio (instructores técnicos del centro CIES y aprendices de la ficha 3413974) están disponibles en las sesiones presenciales de cada semana para revisar prototipos, probar el escaneo en la red del aula y validar reportes. | Favorece ciclos cortos de inspección y adaptación con demostraciones funcionales y validación temprana de mockups, en lugar de esperar hasta el final del semestre para validar el sistema. |

---

## 3. Resumen de Componentes Funcionales y Restricciones del Caso

- **Actores identificados:**
  - **Primarios:** `Instructor` (gestiona sesiones QR, monitorea asistencia en vivo, registra contingencias y exporta reportes), `Aprendiz` (autentica su identidad y registra asistencia escaneando el QR vigente desde la red del aula), `Administrador` (administra usuarios, centros, ambientes, fichas y matrículas).
  - **Secundario / Iniciador temporal:** `Temporizador del Sistema (Reloj)` (dispara la rotación automática del token QR cada 30 segundos y la evaluación de alertas tempranas al cierre de sesión).
- **Restricciones operativas y técnicas:**
  - Operación desde navegador web móvil y de escritorio sin exigir instalación de aplicaciones nativas en tiendas (`App Store` / `Play Store`).
  - Sin integración directa por API privada con SofíaPlus (la interoperabilidad se realiza mediante importación/exportación estructurada en CSV/Excel).
  - Tiempo de validación por escaneo inferior a 1,5 segundos bajo concurrencia de aula (35 aprendices simultáneos).
