# B4 · Diccionario de Datos del Modelo Lógico Relacional

**Proyecto:** Sistema de Control de Asistencia Académica con QR Dinámico (`asistencia-qr`)  
**Autor (GitHub):** `@estiben08` · **Ficha:** 3413974  
**RAP asociado:** 593101 (02) · Crea el diccionario de datos de acuerdo con el modelo lógico (Criterio 4).

---

## 1. Estándar de Nombrado Declarado

- **Nombres de tablas:** Sustantivos en singular y formato `snake_case` en minúsculas (`centro_formacion`, `usuario`, `telefono_usuario`, `ambiente_formacion`, `ficha_formacion`, `matricula_ficha`, `sesion_asistencia`, `token_qr_sesion`, `registro_asistencia`, `alerta_inasistencia`, `auditoria_seguridad`).
- **Llaves primarias (`PK`):** Prefijo `id_<entidad>` (o llave compuesta `(id_ficha, id_aprendiz)` en `matricula_ficha`).
- **Llaves foráneas (`FK`):** Prefijo `id_<entidad_referenciada_o_rol>` con restricción explícita `fk_<tabla>_<destino>`.
- **Restricciones de unicidad y dominio:** Prefijos `uk_<tabla>_<columna>` y `ck_<tabla>_<regla>`.
- **Consistencia 1:1:** Los nombres de las 11 tablas, las 76 columnas, sus tipos de datos, tamaños y restricciones coinciden **exactamente** con el modelo lógico [`B2-modelo-logico-relacional.md`](./B2-modelo-logico-relacional.md) y el script ejecutable [`B5-script-creacion.sql`](./B5-script-creacion.sql).

---

## 2. Diccionario Completo de las 11 Tablas (100 % de Tablas y Columnas)

### Tabla 1: `centro_formacion`
Almacena las sedes o centros regionales del SENA donde operan los ambientes y las fichas.

| Tabla | Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de Negocio |
|---|---|---|---|---|---|
| `centro_formacion` | `id_centro` | `INTEGER` | n/a | `PRIMARY KEY`, autoincremental | Entero positivo identificador único del centro |
| `centro_formacion` | `codigo_centro` | `VARCHAR` | `15` | `NOT NULL`, `UNIQUE` (`uk_centro_codigo`) | Código institucional SENA del centro (ej. `'9527'`) |
| `centro_formacion` | `nombre_centro` | `VARCHAR` | `120` | `NOT NULL` | Denominación oficial del centro de formación |
| `centro_formacion` | `regional` | `VARCHAR` | `60` | `NOT NULL` | Regional SENA a la que pertenece (ej. `'41 - REGIONAL HUILA'`) |
| `centro_formacion` | `ciudad_sede` | `VARCHAR` | `60` | `NOT NULL` | Municipio sede del centro (ej. `'NEIVA'`) |
| `centro_formacion` | `estado_centro` | `VARCHAR` | `15` | `NOT NULL`, `DEFAULT 'ACTIVO'`, `CHECK (estado_centro IN ('ACTIVO', 'INACTIVO'))` | Estado operativo del centro |

### Tabla 2: `usuario`
Almacena las personas vinculadas al sistema (`ADMIN`, `INSTRUCTOR`, `APRENDIZ`) con soporte de relación recursiva de vocero orientador.

| Tabla | Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de Negocio |
|---|---|---|---|---|---|
| `usuario` | `id_usuario` | `INTEGER` | n/a | `PRIMARY KEY`, autoincremental | Entero positivo identificador único del usuario |
| `usuario` | `id_centro` | `INTEGER` | n/a | `NOT NULL`, `FK → centro_formacion(id_centro) ON DELETE RESTRICT` | Centro de formación al que está adscrito |
| `usuario` | `tipo_documento` | `VARCHAR` | `5` | `NOT NULL`, `CHECK (tipo_documento IN ('CC', 'TI', 'CE', 'PEP'))` | Tipo de documento de identidad válido en Colombia |
| `usuario` | `numero_documento` | `VARCHAR` | `20` | `NOT NULL`, `UNIQUE` (`uk_usuario_documento`) | Número de documento sin espacios ni puntos |
| `usuario` | `nombre_completo` | `VARCHAR` | `120` | `NOT NULL` | Nombres y apellidos completos de la persona |
| `usuario` | `correo_institucional` | `VARCHAR` | `120` | `NOT NULL`, `UNIQUE` (`uk_usuario_correo`) | Correo institucional o registrado para notificaciones |
| `usuario` | `password_hash` | `VARCHAR` | `255` | `NOT NULL` | Hash criptográfico con sal (`bcrypt` / `Argon2id`); nunca texto plano |
| `usuario` | `rol_sistema` | `VARCHAR` | `15` | `NOT NULL`, `CHECK (rol_sistema IN ('ADMIN', 'INSTRUCTOR', 'APRENDIZ'))` | Rol principal de autorización en el sistema |
| `usuario` | `especialidad_tecnica` | `VARCHAR` | `80` | `NULL` | Área técnica del instructor o programa del aprendiz |
| `usuario` | `es_vocero` | `INTEGER` | `1` | `NOT NULL`, `DEFAULT 0`, `CHECK (es_vocero IN (0, 1))` | Indicador booleano (`1` = vocero de ficha, `0` = no) |
| `usuario` | `id_vocero_orientador` | `INTEGER` | n/a | `NULL`, `FK → usuario(id_usuario) ON DELETE SET NULL` | Relación recursiva hacia el aprendiz vocero que lo orienta |
| `usuario` | `estado_usuario` | `VARCHAR` | `15` | `NOT NULL`, `DEFAULT 'ACTIVO'`, `CHECK (estado_usuario IN ('ACTIVO', 'INACTIVO', 'SUSPENDIDO'))` | Estado de habilitación de la cuenta (`RF-01`) |

### Tabla 3: `telefono_usuario`
Resuelve en 1FN el atributo multivaluado de teléfonos de contacto de un usuario.

| Tabla | Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de Negocio |
|---|---|---|---|---|---|
| `telefono_usuario` | `id_telefono` | `INTEGER` | n/a | `PRIMARY KEY`, autoincremental | Identificador único del teléfono registrado |
| `telefono_usuario` | `id_usuario` | `INTEGER` | n/a | `NOT NULL`, `FK → usuario(id_usuario) ON DELETE CASCADE` | Usuario titular de la línea telefónica |
| `telefono_usuario` | `numero_telefono` | `VARCHAR` | `20` | `NOT NULL`, `UNIQUE (id_usuario, numero_telefono)` | Número telefónico de contacto (solo dígitos/prefijo) |
| `telefono_usuario` | `tipo_telefono` | `VARCHAR` | `15` | `NOT NULL`, `DEFAULT 'MOVIL'`, `CHECK (tipo_telefono IN ('MOVIL', 'FIJO', 'EMERGENCIA'))` | Clasificación del número de contacto |
| `telefono_usuario` | `es_principal` | `INTEGER` | `1` | `NOT NULL`, `DEFAULT 1`, `CHECK (es_principal IN (0, 1))` | `1` si es el número principal, `0` si es secundario |

### Tabla 4: `ambiente_formacion`
Almacena las aulas o laboratorios físicos y su rango de subred IP local autorizada para validación Zero-Trust (`RF-08`).

| Tabla | Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de Negocio |
|---|---|---|---|---|---|
| `ambiente_formacion` | `id_ambiente` | `INTEGER` | n/a | `PRIMARY KEY`, autoincremental | Identificador único del ambiente de formación |
| `ambiente_formacion` | `id_centro` | `INTEGER` | n/a | `NOT NULL`, `FK → centro_formacion(id_centro) ON DELETE RESTRICT` | Centro de formación donde se ubica el ambiente |
| `ambiente_formacion` | `codigo_ambiente` | `VARCHAR` | `20` | `NOT NULL`, `UNIQUE` (`uk_ambiente_codigo`) | Código físico del salón o laboratorio (ej. `'AMB-302'`) |
| `ambiente_formacion` | `nombre_ambiente` | `VARCHAR` | `100` | `NOT NULL` | Nombre descriptivo del laboratorio o aula |
| `ambiente_formacion` | `capacidad_cupos` | `INTEGER` | n/a | `NOT NULL`, `CHECK (capacidad_cupos > 0 AND capacidad_cupos <= 120)` | Cupo máximo de aprendices permitido en el salón |
| `ambiente_formacion` | `subred_cidr_aula` | `VARCHAR` | `32` | `NOT NULL` | Subred IPv4 en notación CIDR del WiFi del aula (ej. `'192.168.10.0/24'`) |
| `ambiente_formacion` | `estado_ambiente` | `VARCHAR` | `15` | `NOT NULL`, `DEFAULT 'DISPONIBLE'`, `CHECK (estado_ambiente IN ('DISPONIBLE', 'MANTENIMIENTO', 'INACTIVO'))` | Disponibilidad operativa del ambiente |

### Tabla 5: `ficha_formacion`
Almacena los grupos o fichas académicas de formación titulada (`RF-02`).

| Tabla | Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de Negocio |
|---|---|---|---|---|---|
| `ficha_formacion` | `id_ficha` | `INTEGER` | n/a | `PRIMARY KEY`, autoincremental | Identificador interno de la ficha |
| `ficha_formacion` | `id_centro` | `INTEGER` | n/a | `NOT NULL`, `FK → centro_formacion(id_centro) ON DELETE RESTRICT` | Centro de formación que oferta la ficha |
| `ficha_formacion` | `id_instructor_lider` | `INTEGER` | n/a | `NOT NULL`, `FK → usuario(id_usuario) ON DELETE RESTRICT` | Instructor líder o vocero técnico asignado a la ficha |
| `ficha_formacion` | `numero_ficha` | `VARCHAR` | `15` | `NOT NULL`, `UNIQUE` (`uk_ficha_numero`) | Código oficial en SofíaPlus (ej. `'3413974'`) |
| `ficha_formacion` | `nombre_programa` | `VARCHAR` | `140` | `NOT NULL` | Nombre del programa (ej. `'ANALISIS Y DESARROLLO DE SOFTWARE'`) |
| `ficha_formacion` | `nivel_formacion` | `VARCHAR` | `30` | `NOT NULL`, `CHECK (nivel_formacion IN ('TECNOLOGO', 'TECNICO', 'OPERARIO', 'COMPLEMENTARIA'))` | Nivel de formación titulada o complementaria |
| `ficha_formacion` | `jornada` | `VARCHAR` | `20` | `NOT NULL`, `CHECK (jornada IN ('MANANA', 'TARDE', 'NOCHE', 'MIXTA', 'FINES_SEMANA'))` | Jornada académica programada |
| `ficha_formacion` | `fecha_inicio` | `DATE` | n/a | `NOT NULL` | Fecha de inicio de la etapa lectiva (`AAAA-MM-DD`) |
| `ficha_formacion` | `fecha_fin` | `DATE` | n/a | `NOT NULL`, `CHECK (fecha_fin >= fecha_inicio)` | Fecha de finalización prevista de la ficha |
| `ficha_formacion` | `estado_ficha` | `VARCHAR` | `15` | `NOT NULL`, `DEFAULT 'EN_EJECUCION'`, `CHECK (estado_ficha IN ('EN_EJECUCION', 'FINALIZADA', 'CANCELADA'))` | Estado académico del grupo |

### Tabla 6: `matricula_ficha`
Tabla intermedia asociativa que resuelve la relación `N:M` entre `ficha_formacion` y `usuario` (aprendiz) (`RF-03`).

| Tabla | Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de Negocio |
|---|---|---|---|---|---|
| `matricula_ficha` | `id_ficha` | `INTEGER` | n/a | `PRIMARY KEY (compuesta)`, `NOT NULL`, `FK → ficha_formacion(id_ficha) ON DELETE RESTRICT` | Ficha en la que se inscribe el aprendiz |
| `matricula_ficha` | `id_aprendiz` | `INTEGER` | n/a | `PRIMARY KEY (compuesta)`, `NOT NULL`, `FK → usuario(id_usuario) ON DELETE RESTRICT` | Aprendiz inscrito en la ficha |
| `matricula_ficha` | `fecha_vinculacion` | `DATE` | n/a | `NOT NULL` | Fecha oficial de matrícula del aprendiz en la ficha |
| `matricula_ficha` | `estado_matricula` | `VARCHAR` | `20` | `NOT NULL`, `DEFAULT 'EN_FORMACION'`, `CHECK (estado_matricula IN ('EN_FORMACION', 'RETIRO_VOLUNTARIO', 'CANCELADO', 'TRASLADADO'))` | Estado académico del aprendiz dentro de la ficha |
| `matricula_ficha` | `observacion_academica` | `VARCHAR` | `200` | `NULL` | Nota opcional sobre traslado o novedad de matrícula |

### Tabla 7: `sesion_asistencia`
Representa cada jornada de toma de asistencia abierta por un instructor en un ambiente para una ficha (`RF-04`, `RF-11`).

| Tabla | Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de Negocio |
|---|---|---|---|---|---|
| `sesion_asistencia` | `id_sesion` | `INTEGER` | n/a | `PRIMARY KEY`, autoincremental | Identificador único de la sesión de asistencia |
| `sesion_asistencia` | `id_ficha` | `INTEGER` | n/a | `NOT NULL`, `FK → ficha_formacion(id_ficha) ON DELETE RESTRICT` | Ficha académica convocada a la sesión |
| `sesion_asistencia` | `id_instructor` | `INTEGER` | n/a | `NOT NULL`, `FK → usuario(id_usuario) ON DELETE RESTRICT` | Instructor que apertura y dirige la sesión |
| `sesion_asistencia` | `id_ambiente` | `INTEGER` | n/a | `NOT NULL`, `FK → ambiente_formacion(id_ambiente) ON DELETE RESTRICT` | Ambiente físico donde se desarrolla la clase |
| `sesion_asistencia` | `fecha_sesion` | `DATE` | n/a | `NOT NULL` | Fecha calendario de la sesión (`AAAA-MM-DD`) |
| `sesion_asistencia` | `hora_apertura` | `TIME` | n/a | `NOT NULL` | Hora exacta en que el instructor activa la sesión (`HH:MM:SS`) |
| `sesion_asistencia` | `hora_cierre` | `TIME` | n/a | `NULL`, `CHECK (hora_cierre IS NULL OR hora_cierre >= hora_apertura)` | Hora de cierre de la ventana de asistencia |
| `sesion_asistencia` | `ip_subred_aula` | `VARCHAR` | `32` | `NOT NULL` | Prefijo o subred IP capturada al abrir la sesión (`RN-01`) |
| `sesion_asistencia` | `estado_sesion` | `VARCHAR` | `15` | `NOT NULL`, `DEFAULT 'ACTIVA'`, `CHECK (estado_sesion IN ('ACTIVA', 'CERRADA', 'EXPIRADA'))` | Estado operativo de la ventana de asistencia (`RN-03`) |

### Tabla 8: `token_qr_sesion`
Almacena las secuencias de códigos QR dinámicos firmados con `HMAC-SHA256` que rotan cada 30 segundos durante una sesión (`RF-05`, `RF-06`).

| Tabla | Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de Negocio |
|---|---|---|---|---|---|
| `token_qr_sesion` | `id_token_qr` | `INTEGER` | n/a | `PRIMARY KEY`, autoincremental | Identificador técnico del registro de token QR |
| `token_qr_sesion` | `id_sesion` | `INTEGER` | n/a | `NOT NULL`, `FK → sesion_asistencia(id_sesion) ON DELETE CASCADE` | Sesión propietaria del token (dependencia de entidad débil) |
| `token_qr_sesion` | `numero_secuencia` | `INTEGER` | n/a | `NOT NULL`, `CHECK (numero_secuencia >= 1)`, `UNIQUE (id_sesion, numero_secuencia)` | Consecutivo de rotación cada 30 segundos (`1, 2, 3...`) |
| `token_qr_sesion` | `token_payload` | `VARCHAR` | `160` | `NOT NULL`, `UNIQUE` (`uk_token_payload`) | Cadena codificada en el QR (`sesion + secuencia + timestamp`) |
| `token_qr_sesion` | `firma_hmac_sha256` | `VARCHAR` | `64` | `NOT NULL` | Firma hexadecimal de 64 caracteres `HMAC-SHA256` (`RNF-02`) |
| `token_qr_sesion` | `fecha_hora_emision` | `DATETIME` | n/a | `NOT NULL` | Marca temporal exacta de generación del código QR |
| `token_qr_sesion` | `fecha_hora_expiracion` | `DATETIME` | n/a | `NOT NULL`, `CHECK (fecha_hora_expiracion > fecha_hora_emision)` | Marca temporal de vencimiento (`emisión + 30 segundos`) |
| `token_qr_sesion` | `vigente` | `INTEGER` | `1` | `NOT NULL`, `DEFAULT 1`, `CHECK (vigente IN (0, 1))` | `1` si es el QR activo en pantalla; `0` si ya rotó o se cerró |

### Tabla 9: `registro_asistencia`
Almacena la asistencia individual de cada aprendiz por sesión, impidiendo duplicados (`RF-07`, `RF-08`, `RF-09`, `RF-10`, `RF-11`).

| Tabla | Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de Negocio |
|---|---|---|---|---|---|
| `registro_asistencia` | `id_registro` | `INTEGER` | n/a | `PRIMARY KEY`, autoincremental | Identificador único del asiento de asistencia |
| `registro_asistencia` | `id_sesion` | `INTEGER` | n/a | `NOT NULL`, `FK → sesion_asistencia(id_sesion) ON DELETE RESTRICT`, `UNIQUE (id_sesion, id_aprendiz)` | Sesión de asistencia a la que corresponde el registro |
| `registro_asistencia` | `id_aprendiz` | `INTEGER` | n/a | `NOT NULL`, `FK → usuario(id_usuario) ON DELETE RESTRICT`, `UNIQUE (id_sesion, id_aprendiz)` | Aprendiz evaluado (`RN-02`: máximo 1 registro por sesión) |
| `registro_asistencia` | `fecha_hora_marcacion` | `DATETIME` | n/a | `NOT NULL` | Fecha y hora exacta de marcación o consolidación |
| `registro_asistencia` | `estado_asistencia` | `VARCHAR` | `20` | `NOT NULL`, `CHECK (estado_asistencia IN ('PRESENTE', 'CONTINGENCIA', 'EXCUSA', 'INASISTENTE'))` | Estado final de asistencia en la jornada |
| `registro_asistencia` | `modalidad_registro` | `VARCHAR` | `20` | `NOT NULL`, `CHECK (modalidad_registro IN ('QR_MOVIL', 'MANUAL_INSTRUCTOR', 'CIERRE_AUTOMATICO'))` | Canal por el que se generó el registro |
| `registro_asistencia` | `ip_origen_aprendiz` | `VARCHAR` | `45` | `NOT NULL` | Dirección IP desde la cual se realizó la marcación |
| `registro_asistencia` | `motivo_contingencia` | `VARCHAR` | `200` | `NULL` | Justificación obligatoria cuando `modalidad_registro = 'MANUAL_INSTRUCTOR'` (`RN-05`) |

### Tabla 10: `alerta_inasistencia`
Almacena las alertas tempranas de riesgo de deserción generadas al acumular 3 o más inasistencias (`RF-13`, `RN-06`).

| Tabla | Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de Negocio |
|---|---|---|---|---|---|
| `alerta_inasistencia` | `id_alerta` | `INTEGER` | n/a | `PRIMARY KEY`, autoincremental | Identificador único de la alerta temprana |
| `alerta_inasistencia` | `id_ficha` | `INTEGER` | n/a | `NOT NULL`, `FK → ficha_formacion(id_ficha) ON DELETE RESTRICT` | Ficha en la que se acumularon las inasistencias |
| `alerta_inasistencia` | `id_aprendiz` | `INTEGER` | n/a | `NOT NULL`, `FK → usuario(id_usuario) ON DELETE RESTRICT` | Aprendiz en riesgo de deserción |
| `alerta_inasistencia` | `fecha_generacion` | `DATE` | n/a | `NOT NULL` | Fecha en que se alcanzó o superó el umbral |
| `alerta_inasistencia` | `total_inasistencias` | `INTEGER` | n/a | `NOT NULL`, `CHECK (total_inasistencias >= 3)` | Conteo de fallas acumuladas que disparó la alerta (`RN-06`) |
| `alerta_inasistencia` | `nivel_riesgo` | `VARCHAR` | `20` | `NOT NULL`, `CHECK (nivel_riesgo IN ('PREVENTIVO', 'ALTO', 'CRITICO'))` | Severidad de la alerta para Bienestar al Aprendiz |
| `alerta_inasistencia` | `observacion_seguimiento` | `VARCHAR` | `200` | `NOT NULL` | Detalle del hallazgo y acción de seguimiento recomendada |
| `alerta_inasistencia` | `estado_alerta` | `VARCHAR` | `15` | `NOT NULL`, `DEFAULT 'ABIERTA'`, `CHECK (estado_alerta IN ('ABIERTA', 'EN_GESTION', 'CERRADA'))` | Estado de gestión de la alerta |

### Tabla 11: `auditoria_seguridad`
Registra de manera inmutable los eventos de seguridad, intentos de escaneo rechazados (por IP externa, QR expirado o duplicado) y ajustes manuales (`RF-08`, `RF-09`, `RF-10`, `RNF-02`).

| Tabla | Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de Negocio |
|---|---|---|---|---|---|
| `auditoria_seguridad` | `id_auditoria` | `INTEGER` | n/a | `PRIMARY KEY`, autoincremental | Identificador secuencial del evento de auditoría |
| `auditoria_seguridad` | `id_usuario` | `INTEGER` | n/a | `NULL`, `FK → usuario(id_usuario) ON DELETE SET NULL` | Usuario involucrado (nulo si el intento fue anónimo/fallido) |
| `auditoria_seguridad` | `id_sesion` | `INTEGER` | n/a | `NULL`, `FK → sesion_asistencia(id_sesion) ON DELETE SET NULL` | Sesión asociada al evento (si aplica) |
| `auditoria_seguridad` | `fecha_hora_evento` | `DATETIME` | n/a | `NOT NULL` | Marca de tiempo exacta del evento |
| `auditoria_seguridad` | `tipo_evento` | `VARCHAR` | `40` | `NOT NULL` | Categoría (`'LOGIN_OK'`, `'RECHAZO_SUBRED_IP'`, `'RECHAZO_QR_EXPIRADO'`, `'AJUSTE_CONTINGENCIA'`) |
| `auditoria_seguridad` | `ip_origen` | `VARCHAR` | `45` | `NOT NULL` | Dirección IPv4/IPv6 de origen de la petición |
| `auditoria_seguridad` | `detalle_evento` | `VARCHAR` | `250` | `NOT NULL` | Descripción técnica o causal del evento registrado |
| `auditoria_seguridad` | `resultado_operacion` | `VARCHAR` | `15` | `NOT NULL`, `CHECK (resultado_operacion IN ('EXITOSO', 'RECHAZADO', 'ALERTA'))` | Resultado de control del evento |
