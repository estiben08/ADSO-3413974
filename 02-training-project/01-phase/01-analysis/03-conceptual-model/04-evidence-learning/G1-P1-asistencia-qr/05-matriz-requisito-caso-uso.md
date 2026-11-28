# 05 · Interpretación del Informe de Requisitos y Matriz Requisito → Caso de Uso

**Proyecto:** Sistema de Control de Asistencia Académica con QR Dinámico (`asistencia-qr`)  
**Autor (GitHub):** `@estiben08`  
**RAP asociado:** 592373 · Interpreta el informe de requisitos para modelar las funciones del software (Criterio C3).

---

## 1. Distinción entre Requisitos Funcionales (RF), No Funcionales (RNF) y Reglas de Negocio (RN)

A partir de los insumos de requisitos del repositorio (`03-execute/16-week/02-optional-activity/asistenciaSENA.txt`, `03-execute/17-week/02-optional-activity/documento_unificado_proyecto (1).md` y `03-execute/19-week/02-optional-activity/SRC.docx`), se depuró y normalizó el catálogo separando estrictamente **comportamientos observables del sistema (RF)** de **atributos de calidad y restricciones (RNF)**:

- **Requisitos Funcionales (RF-01 a RF-13):** Definen *qué hace* el sistema ante los estímulos de los actores (`Instructor`, `Aprendiz`, `Administrador`, `Temporizador`). Cada RF se modela mediante uno o más casos de uso.
- **Requisitos No Funcionales (RNF-01 a RNF-05):** Definen *cómo o bajo qué cualidades y restricciones* opera el sistema (rendimiento, seguridad criptográfica, adaptabilidad móvil, disponibilidad y mantenibilidad). No son casos de uso independientes, sino restricciones transversales que condicionan los flujos y la arquitectura.

---

## 2. Matriz de Trazabilidad Requisito Funcional → Caso de Uso (100 % de Cobertura)

| ID Requisito | Descripción del Requisito Funcional (SRS consolidado) | Prioridad MoSCoW | Caso(s) de Uso que lo Atiende(n) | Actor(es) Involucrado(s) | Estado de Cobertura |
|---|---|---|---|---|---|
| **RF-01** | El sistema debe autenticar a los usuarios registrados (administradores, instructores y aprendices) validando su documento de identidad, contraseña y estado activo, redirigiéndolos a las funciones autorizadas para su rol. | *Must Have* | `CU-01 Autenticar usuario` | `Administrador`, `Instructor`, `Aprendiz` | **Cubierto (100 %)** |
| **RF-02** | El sistema debe permitir al administrador registrar, consultar, actualizar e inactivar usuarios (instructores y aprendices), ambientes de formación y fichas académicas con su programa y jornada. | *Must Have* | `CU-02 Gestionar catálogo académico y usuarios` | `Administrador` | **Cubierto (100 %)** |
| **RF-03** | El sistema debe permitir asociar o importar masivamente aprendices a una ficha de formación a partir de su número de documento, evitando duplicar personas ya registradas en el centro. | *Should Have* | `CU-02 Gestionar catálogo académico y usuarios` | `Administrador` | **Cubierto (100 %)** |
| **RF-04** | El sistema debe permitir al instructor seleccionar una ficha asignada y un ambiente de formación para aperturar una sesión de asistencia activa, capturando automáticamente la dirección IP de la red del aula. | *Must Have* | `CU-03 Aperturar sesión de asistencia` | `Instructor` | **Cubierto (100 %)** |
| **RF-05** | El sistema debe generar un token QR único por sesión que incorpore el identificador de sesión, ventana temporal de validez y una firma criptográfica (`HMAC-SHA256`) contra falsificación. | *Must Have* | `CU-04 Generar token QR dinámico firmado` *(incluido por `CU-03`)* | `Instructor`, `Temporizador` | **Cubierto (100 %)** |
| **RF-06** | El sistema debe rotar y refrescar automáticamente en pantalla el código QR de una sesión activa cada 30 segundos, invalidando de inmediato los códigos proyectados en ventanas anteriores. | *Must Have* | `CU-04 Generar token QR dinámico firmado` *(iniciado por `Temporizador`)* | `Temporizador`, `Instructor` | **Cubierto (100 %)** |
| **RF-07** | El sistema debe permitir al aprendiz autenticado escanear el código QR proyectado en el aula desde su dispositivo móvil para enviar su solicitud de registro de asistencia. | *Must Have* | `CU-05 Registrar asistencia por escaneo QR` | `Aprendiz` | **Cubierto (100 %)** |
| **RF-08** | El sistema debe validar al recibir un escaneo que la sesión esté activa, que el token QR sea vigente y su firma HMAC sea auténtica, y que la dirección IP del aprendiz pertenezca a la misma subred local del aula. | *Must Have* | `CU-06 Validar subred IP y firma del código QR` *(incluido por `CU-05`)* | `Aprendiz` | **Cubierto (100 %)** |
| **RF-09** | El sistema debe impedir que un mismo aprendiz registre más de una asistencia exitosa en la misma sesión académica, registrando en auditoría cualquier intento rechazado con su causal. | *Must Have* | `CU-06 Validar subred IP y firma del código QR` *(incluido por `CU-05`)* | `Aprendiz` | **Cubierto (100 %)** |
| **RF-10** | El sistema debe permitir al instructor registrar o ajustar manualmente la asistencia o excusa de un aprendiz presente en el aula cuando este carezca de teléfono móvil o falle su cámara, exigiendo registrar la observación de justificación. | *Should Have* | `CU-07 Registrar asistencia manual por contingencia` *(extiende a `CU-08`)* | `Instructor` | **Cubierto (100 %)** |
| **RF-11** | El sistema debe mostrar al instructor en tiempo real los contadores y listados de aprendices presentes, ausentes e intentos rechazados, y permitir cerrar la sesión marcando automáticamente como inasistentes a los no registrados. | *Must Have* | `CU-08 Monitorear asistencia y cerrar sesión` | `Instructor` | **Cubierto (100 %)** |
| **RF-12** | El sistema debe permitir al instructor y al administrador consultar el historial de asistencia filtrando por ficha, aprendiz y rango de fechas, y exportar el consolidado en formato CSV/Excel. | *Should Have* | `CU-09 Exportar reporte histórico de asistencia` | `Instructor`, `Administrador` | **Cubierto (100 %)** |
| **RF-13** | El sistema debe generar automáticamente una alerta temprana de riesgo de deserción cuando, al cierre de una sesión, un aprendiz acumule 3 o más inasistencias en la ficha. | *Could Have* | `CU-10 Generar alerta temprana de inasistencia` *(extiende a `CU-08`)* | `Instructor` | **Cubierto (100 %)** |

### Resumen de Cobertura Funcional
- **Total de Requisitos Funcionales en el SRS:** 13 (`RF-01` a `RF-13`).
- **Requisitos Funcionales cubiertos por Casos de Uso:** 13 de 13 (**100 % de cobertura**, superando el mínimo exigible del 90 %).
- **Requisitos Funcionales no cubiertos:** 0 (ninguno).

---

## 3. Catálogo de Requisitos No Funcionales (RNF) y su Relación con los Casos de Uso

Los Requisitos No Funcionales no se modelan como óvalos de casos de uso (pues no son objetivos de negocio iniciados por un actor), sino como restricciones de calidad verificables aplicadas sobre los casos de uso correspondientes:

| ID RNF | Categoría (ISO/IEC 25010) | Descripción y Métrica Verificable | Casos de Uso a los que Condiciona |
|---|---|---|---|
| **RNF-01** | **Eficiencia de desempeño** | La validación de un escaneo QR (`CU-05`/`CU-06`) y la confirmación en pantalla deben responder en un tiempo menor o igual a **1,5 segundos** en el percentil 95 (`p95 <= 1,5 s`) bajo una carga concurrente de **35 aprendices** escaneando en la misma ventana de 30 segundos. | `CU-04`, `CU-05`, `CU-06`, `CU-08` |
| **RNF-02** | **Seguridad (Confidencialidad e Integridad)** | Las contraseñas deben almacenarse exclusivamente mediante hash irreversible con sal criptográfica (`bcrypt` / `Argon2id`), los tokens QR deben firmarse con `HMAC-SHA256` y todo el tráfico entre navegador y servidor debe viajar cifrado sobre `HTTPS (TLS 1.3)`. | `CU-01`, `CU-04`, `CU-05`, `CU-06` |
| **RNF-03** | **Usabilidad y Compatibilidad Móvil** | La interfaz de escaneo y marcación del aprendiz debe ser 100 % responsiva (*Mobile-First*, desde `360px` de ancho) y operar directamente en navegadores móviles estándar (Chrome Android / Safari iOS) sin instalar aplicaciones nativas. | `CU-01`, `CU-05`, `CU-08` |
| **RNF-04** | **Fiabilidad y Disponibilidad** | El sistema debe garantizar una disponibilidad operativa mínima del **99,5 % mensual** durante las jornadas académicas (lunes a sábado, 6:00 a. m. a 10:00 p. m.) y mantener integridad transaccional para evitar pérdida o duplicidad de registros. | `CU-03`, `CU-05`, `CU-08`, `CU-09` |
| **RNF-05** | **Mantenibilidad (Modularidad)** | El software debe estructurarse separando estrictamente las capas de presentación, lógica de negocio/validación y persistencia de datos, permitiendo incorporar nuevas reglas de validación de asistencia sin modificar los controladores existentes. | Todos (`CU-01` a `CU-10`) |
