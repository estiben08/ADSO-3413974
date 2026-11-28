# B6 · Políticas de Seguridad de los Datos y Matriz de Permisos por Rol

**Proyecto:** Sistema de Control de Asistencia Académica con QR Dinámico (`asistencia-qr`)  
**Autor (GitHub):** `@estiben08` · **Ficha:** 3413974  
**RAP asociado:** 593101 (02) · Define políticas de seguridad para garantizar integridad, confidencialidad y disponibilidad de los datos (Criterio 5).

---

## 1. Políticas de Seguridad de los Datos sobre el Caso `asistencia-qr` (9 Políticas · 3 por Principio)

Siguiendo la sección 11 de `Plantillas_G2.md` y el nivel 100 del Criterio 5 (`Rubricas_G2.md`), se definen **9 políticas concretas vinculadas a las tablas y columnas reales del modelo** (3 de Integridad, 3 de Confidencialidad y 3 de Disponibilidad):

| # | Principio (CIA) | Política y Medida Técnica Concreta sobre las Tablas del Caso | Tabla(s) / Columna(s) Afectadas | Requisito / Norma Asociada |
|---|---|---|---|---|
| **P-01** | **Integridad** | **Integridad referencial y de dominio declarativa en base de datos:** Todas las relaciones utilizan `FOREIGN KEY` con `ON DELETE RESTRICT` en tablas históricas (`sesion_asistencia`, `registro_asistencia`, `ficha_formacion`) para impedir el borrado accidental de fichas o sesiones con asistencias registradas, junto con `CHECK (hora_cierre >= hora_apertura)` y `UNIQUE (id_sesion, id_aprendiz)` para impedir doble marcación. | `sesion_asistencia`, `registro_asistencia`, `matricula_ficha` | `RF-09`, `RNF-04` |
| **P-02** | **Integridad** | **Firma criptográfica inalterable en códigos QR dinámicos (`HMAC-SHA256`):** Cada fila de `token_qr_sesion` almacena en `firma_hmac_sha256` el código de autenticación de mensaje calculado con la clave secreta del servidor sobre `(id_sesion + numero_secuencia + fecha_hora_expiracion)`. Cualquier alteración de un solo carácter del QR invalida la firma. | `token_qr_sesion.token_payload`, `token_qr_sesion.firma_hmac_sha256` | `RF-05`, `RF-08`, `RNF-02` |
| **P-03** | **Integridad** | **Bitácora inmutable (*Append-Only*) de ajustes manuales y rechazos:** Todo registro manual por contingencia (`modalidad_registro = 'MANUAL_INSTRUCTOR'`) exige poblar `motivo_contingencia` y dispara una inserción en `auditoria_seguridad` con el `id_usuario` del instructor, `ip_origen` y `fecha_hora_evento`. Ningún rol tiene permiso `DELETE` ni `UPDATE` sobre `auditoria_seguridad`. | `registro_asistencia.motivo_contingencia`, `auditoria_seguridad` | `RF-09`, `RF-10`, `RN-05` |
| **P-04** | **Confidencialidad** | **Almacenamiento de contraseñas mediante Hash irreversible con Sal criptográfica (nunca cifradas ni en texto plano):** La columna `usuario.password_hash` almacena únicamente el resumen generado con **`bcrypt` (factor de costo 12) o `Argon2id`** con sal aleatoria de 128 bits única por usuario. Se prohíbe el cifrado simétrico reversible de contraseñas. | `usuario.password_hash` | `RF-01`, `RNF-02`, ISO/IEC 27001 |
| **P-05** | **Confidencialidad** | **Cifrado de datos en tránsito (`TLS 1.3`) y protección de datos personales en reposo:** Todo el tráfico entre los navegadores (PC del aula y celulares de aprendices) y el servidor Nginx viaja cifrado por **`HTTPS sobre TLS 1.3 (puerto 443)`**. Los campos sensibles de contacto (`usuario.numero_documento`, `usuario.correo_institucional` y `telefono_usuario.numero_telefono`) se almacenan en volumen cifrado (`AES-256`) y en los reportes visuales se enmascaran parcialmente (`***8215`). | `usuario.numero_documento`, `telefono_usuario.numero_telefono` | `RNF-02`, Ley 1581 de 2012 |
| **P-06** | **Confidencialidad** | **Tratamiento de Datos Personales conforme a la Ley 1581 de 2012 y Decreto 1074 de 2015:**(1) **Finalidad informada y limitada:** Los datos personales (`nombre_completo`, `numero_documento`, `correo_institucional`, `numero_telefono`, `ip_origen_aprendiz`) se recolectan exclusivamente para la gestión académica y verificación de asistencia institucional del SENA.<br>(2) **Autorización previa del titular:** En el primer inicio de sesión (`CU-01`), el usuario acepta el aviso de privacidad y autorización de tratamiento.<br>(3) **Derechos de Habeas Data (Conocer, Actualizar, Rectificar):** El titular consulta sus propios datos y solicita corrección a través del administrador. | `usuario`, `telefono_usuario`, `registro_asistencia.ip_origen_aprendiz` | Ley 1581 de 2012, Decreto 1074 de 2015 |
| **P-07** | **Disponibilidad** | **Estrategia de Respaldo Automatizado (*Backup* 3-2-1) con `RPO <= 24 horas`:** Un trabajo programado (`cron`) ejecuta diariamente a las `23:30` un volcado transaccional completo (`mysqldump --single-transaction`) de las 11 tablas, lo comprime, lo cifra con `AES-256` y almacena una copia local en el Nodo 4 y una réplica en almacenamiento externo aislado. | Las 11 tablas del esquema `asistencia_qr` | `RNF-04` |
| **P-08** | **Disponibilidad** | **Prueba mensual de restauración con Acta de Verificación y `RTO <= 2 horas`:** El primer sábado de cada mes se ejecuta un simulacro de restauración del backup cifrado sobre un contenedor limpio de verificación, comprobando conteo de filas e integridad de llaves foráneas y firmando el acta técnica de recuperación. | Esquema completo `asistencia_qr` y `auditoria_seguridad` | `RNF-04`, ISO/IEC 27001 |
| **P-09** | **Disponibilidad** | **Control de agotamiento de recursos mediante Pool de Conexiones y Streaming CSV:** El acceso a MySQL se limita y reutiliza mediante `MySQLConnectionPool` (20 conexiones pre-abiertas) y la descarga de reportes históricos (`RF-12`) se procesa por lotes en *streaming*, evitando bloqueos por agotamiento de sockets o memoria RAM durante ráfagas de 35 escaneos simultáneos. | `registro_asistencia`, `token_qr_sesion`, `sesion_asistencia` | `RNF-01`, `RNF-04` |

---

## 2. Matriz de Control de Acceso Basado en Roles (RBAC · 4 Roles contra las 11 Tablas)

Se aplica el **Principio de Mínimo Privilegio** sobre los **4 roles del sistema** (`Administrador`, `Instructor`, `Aprendiz` y `AuditorConsulta`, superando el mínimo exigible de 3 roles) frente a las **11 tablas del modelo lógico**:

| Tabla del Modelo Lógico | Rol 1: `Administrador` (`ADMIN`) | Rol 2: `Instructor` (`INSTRUCTOR`) | Rol 3: `Aprendiz` (`APRENDIZ`) | Rol 4: `AuditorConsulta` *(Coordinación / Bienestar)* |
|---|---|---|---|---|
| `centro_formacion` | `SELECT`, `INSERT`, `UPDATE` | `SELECT` | `SELECT` | `SELECT` |
| `usuario` | `SELECT`, `INSERT`, `UPDATE` *(inactivar, nunca `DELETE` físico)* | `SELECT` *(solo aprendices de sus fichas y su propio perfil)*, `UPDATE` *(solo su contraseña)* | `SELECT` *(solo su propia fila)*, `UPDATE` *(solo su contraseña)* | `SELECT` *(sin columna `password_hash`)* |
| `telefono_usuario` | `SELECT`, `INSERT`, `UPDATE`, `DELETE` | `SELECT` *(solo aprendices de sus fichas)* | `SELECT`, `INSERT`, `UPDATE` *(solo sus propios teléfonos)* | `SELECT` |
| `ambiente_formacion` | `SELECT`, `INSERT`, `UPDATE` | `SELECT` | `SELECT` *(solo ambiente de su sesión activa)* | `SELECT` |
| `ficha_formacion` | `SELECT`, `INSERT`, `UPDATE` | `SELECT` *(solo fichas asignadas a su cargo)* | `SELECT` *(solo fichas donde está matriculado)* | `SELECT` |
| `matricula_ficha` | `SELECT`, `INSERT`, `UPDATE` | `SELECT` *(solo matrículas de sus fichas)* | `SELECT` *(solo su propia matrícula)* | `SELECT` |
| `sesion_asistencia` | `SELECT` | `SELECT`, `INSERT`, `UPDATE` *(abrir y cerrar sesiones de sus fichas)* | `SELECT` *(solo verificar si la sesión de su ficha está `ACTIVA`)* | `SELECT` |
| `token_qr_sesion` | `SELECT` | `SELECT`, `INSERT`, `UPDATE` *(generar e invalidar QR de su sesión)* | `SELECT` *(solo validación de token en `CU-06`)* | Sin acceso (`NONE`) |
| `registro_asistencia` | `SELECT` | `SELECT`, `INSERT`, `UPDATE` *(asentar contingencia con motivo obligatorio `RN-05`)* | `SELECT` *(solo sus propias asistencias)*, `INSERT` *(solo su propia fila vía validación QR `CU-05`)* | `SELECT` |
| `alerta_inasistencia` | `SELECT`, `UPDATE` *(gestión institucional)* | `SELECT`, `INSERT`, `UPDATE` *(registrar nota de seguimiento en sus fichas)* | `SELECT` *(solo sus propias alertas preventivas)* | `SELECT`, `UPDATE` *(registrar seguimiento de Bienestar)* |
| `auditoria_seguridad` | `SELECT`, `INSERT` *(bitácora inmutable: nadie tiene `UPDATE` ni `DELETE`)* | `INSERT` *(automático por el servicio)*, `SELECT` *(rechazos de su sesión)* | `INSERT` *(automático al intentar escaneo)* | `SELECT` *(auditoría completa)* |
