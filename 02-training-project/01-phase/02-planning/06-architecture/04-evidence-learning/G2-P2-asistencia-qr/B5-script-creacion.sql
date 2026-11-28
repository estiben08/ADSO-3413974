-- ============================================================================
-- B5 · SCRIPT SQL DE CREACIÓN Y VALIDACIÓN DEL MODELO DE DATOS (3FN)
-- Proyecto: Sistema de Control de Asistencia Académica con QR Dinámico (asistencia-qr)
-- Autor (GitHub): @estiben08 · Ficha: 3413974 · SENA CIES
-- Estándar: SQL ANSI compatible con SQLite 3 y MySQL 8.0
-- Tablas: 11 (100% del Diccionario de Datos B4 y Modelo Lógico B2)
-- ============================================================================

PRAGMA foreign_keys = ON;

-- 1. Tabla: centro_formacion
CREATE TABLE centro_formacion (
    id_centro       INTEGER      PRIMARY KEY,
    codigo_centro   VARCHAR(15)  NOT NULL,
    nombre_centro   VARCHAR(120) NOT NULL,
    regional        VARCHAR(60)  NOT NULL,
    ciudad_sede     VARCHAR(60)  NOT NULL,
    estado_centro   VARCHAR(15)  NOT NULL DEFAULT 'ACTIVO',
    CONSTRAINT uk_centro_codigo UNIQUE (codigo_centro),
    CONSTRAINT ck_centro_estado CHECK (estado_centro IN ('ACTIVO', 'INACTIVO'))
);

-- 2. Tabla: usuario (Incluye relación recursiva id_vocero_orientador)
CREATE TABLE usuario (
    id_usuario            INTEGER      PRIMARY KEY,
    id_centro             INTEGER      NOT NULL,
    tipo_documento        VARCHAR(5)   NOT NULL,
    numero_documento      VARCHAR(20)  NOT NULL,
    nombre_completo       VARCHAR(120) NOT NULL,
    correo_institucional  VARCHAR(120) NOT NULL,
    password_hash         VARCHAR(255) NOT NULL,
    rol_sistema           VARCHAR(15)  NOT NULL,
    especialidad_tecnica  VARCHAR(80)  NULL,
    es_vocero             INTEGER      NOT NULL DEFAULT 0,
    id_vocero_orientador  INTEGER      NULL,
    estado_usuario        VARCHAR(15)  NOT NULL DEFAULT 'ACTIVO',
    CONSTRAINT uk_usuario_documento UNIQUE (numero_documento),
    CONSTRAINT uk_usuario_correo UNIQUE (correo_institucional),
    CONSTRAINT fk_usuario_centro FOREIGN KEY (id_centro)
        REFERENCES centro_formacion (id_centro) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_usuario_vocero FOREIGN KEY (id_vocero_orientador)
        REFERENCES usuario (id_usuario) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT ck_usuario_tipo_doc CHECK (tipo_documento IN ('CC', 'TI', 'CE', 'PEP')),
    CONSTRAINT ck_usuario_rol CHECK (rol_sistema IN ('ADMIN', 'INSTRUCTOR', 'APRENDIZ')),
    CONSTRAINT ck_usuario_vocero CHECK (es_vocero IN (0, 1)),
    CONSTRAINT ck_usuario_estado CHECK (estado_usuario IN ('ACTIVO', 'INACTIVO', 'SUSPENDIDO'))
);

-- 3. Tabla: telefono_usuario (Resuelve atributo multivaluado en 1FN)
CREATE TABLE telefono_usuario (
    id_telefono      INTEGER     PRIMARY KEY,
    id_usuario       INTEGER     NOT NULL,
    numero_telefono  VARCHAR(20) NOT NULL,
    tipo_telefono    VARCHAR(15) NOT NULL DEFAULT 'MOVIL',
    es_principal     INTEGER     NOT NULL DEFAULT 1,
    CONSTRAINT uk_telefono_usuario_num UNIQUE (id_usuario, numero_telefono),
    CONSTRAINT fk_telefono_usuario FOREIGN KEY (id_usuario)
        REFERENCES usuario (id_usuario) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT ck_telefono_tipo CHECK (tipo_telefono IN ('MOVIL', 'FIJO', 'EMERGENCIA')),
    CONSTRAINT ck_telefono_principal CHECK (es_principal IN (0, 1))
);

-- 4. Tabla: ambiente_formacion
CREATE TABLE ambiente_formacion (
    id_ambiente      INTEGER      PRIMARY KEY,
    id_centro        INTEGER      NOT NULL,
    codigo_ambiente  VARCHAR(20)  NOT NULL,
    nombre_ambiente  VARCHAR(100) NOT NULL,
    capacidad_cupos  INTEGER      NOT NULL,
    subred_cidr_aula VARCHAR(32)  NOT NULL,
    estado_ambiente  VARCHAR(15)  NOT NULL DEFAULT 'DISPONIBLE',
    CONSTRAINT uk_ambiente_codigo UNIQUE (codigo_ambiente),
    CONSTRAINT fk_ambiente_centro FOREIGN KEY (id_centro)
        REFERENCES centro_formacion (id_centro) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT ck_ambiente_capacidad CHECK (capacidad_cupos > 0 AND capacidad_cupos <= 120),
    CONSTRAINT ck_ambiente_estado CHECK (estado_ambiente IN ('DISPONIBLE', 'MANTENIMIENTO', 'INACTIVO'))
);

-- 5. Tabla: ficha_formacion
CREATE TABLE ficha_formacion (
    id_ficha             INTEGER      PRIMARY KEY,
    id_centro            INTEGER      NOT NULL,
    id_instructor_lider  INTEGER      NOT NULL,
    numero_ficha         VARCHAR(15)  NOT NULL,
    nombre_programa      VARCHAR(140) NOT NULL,
    nivel_formacion      VARCHAR(30)  NOT NULL,
    jornada              VARCHAR(20)  NOT NULL,
    fecha_inicio         DATE         NOT NULL,
    fecha_fin            DATE         NOT NULL,
    estado_ficha         VARCHAR(15)  NOT NULL DEFAULT 'EN_EJECUCION',
    CONSTRAINT uk_ficha_numero UNIQUE (numero_ficha),
    CONSTRAINT fk_ficha_centro FOREIGN KEY (id_centro)
        REFERENCES centro_formacion (id_centro) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_ficha_instructor FOREIGN KEY (id_instructor_lider)
        REFERENCES usuario (id_usuario) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT ck_ficha_nivel CHECK (nivel_formacion IN ('TECNOLOGO', 'TECNICO', 'OPERARIO', 'COMPLEMENTARIA')),
    CONSTRAINT ck_ficha_jornada CHECK (jornada IN ('MANANA', 'TARDE', 'NOCHE', 'MIXTA', 'FINES_SEMANA')),
    CONSTRAINT ck_ficha_fechas CHECK (fecha_fin >= fecha_inicio),
    CONSTRAINT ck_ficha_estado CHECK (estado_ficha IN ('EN_EJECUCION', 'FINALIZADA', 'CANCELADA'))
);

-- 6. Tabla: matricula_ficha (Tabla intermedia N:M con llave primaria compuesta)
CREATE TABLE matricula_ficha (
    id_ficha               INTEGER      NOT NULL,
    id_aprendiz            INTEGER      NOT NULL,
    fecha_vinculacion      DATE         NOT NULL,
    estado_matricula       VARCHAR(20)  NOT NULL DEFAULT 'EN_FORMACION',
    observacion_academica  VARCHAR(200) NULL,
    CONSTRAINT pk_matricula_ficha PRIMARY KEY (id_ficha, id_aprendiz),
    CONSTRAINT fk_matricula_ficha FOREIGN KEY (id_ficha)
        REFERENCES ficha_formacion (id_ficha) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_matricula_aprendiz FOREIGN KEY (id_aprendiz)
        REFERENCES usuario (id_usuario) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT ck_matricula_estado CHECK (estado_matricula IN ('EN_FORMACION', 'RETIRO_VOLUNTARIO', 'CANCELADO', 'TRASLADADO'))
);

-- 7. Tabla: sesion_asistencia
CREATE TABLE sesion_asistencia (
    id_sesion       INTEGER     PRIMARY KEY,
    id_ficha        INTEGER     NOT NULL,
    id_instructor   INTEGER     NOT NULL,
    id_ambiente     INTEGER     NOT NULL,
    fecha_sesion    DATE        NOT NULL,
    hora_apertura   TIME        NOT NULL,
    hora_cierre     TIME        NULL,
    ip_subred_aula  VARCHAR(32) NOT NULL,
    estado_sesion   VARCHAR(15) NOT NULL DEFAULT 'ACTIVA',
    CONSTRAINT fk_sesion_ficha FOREIGN KEY (id_ficha)
        REFERENCES ficha_formacion (id_ficha) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_sesion_instructor FOREIGN KEY (id_instructor)
        REFERENCES usuario (id_usuario) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_sesion_ambiente FOREIGN KEY (id_ambiente)
        REFERENCES ambiente_formacion (id_ambiente) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT ck_sesion_horas CHECK (hora_cierre IS NULL OR hora_cierre >= hora_apertura),
    CONSTRAINT ck_sesion_estado CHECK (estado_sesion IN ('ACTIVA', 'CERRADA', 'EXPIRADA'))
);

-- 8. Tabla: token_qr_sesion (Entidad débil dependiente de sesion_asistencia)
CREATE TABLE token_qr_sesion (
    id_token_qr            INTEGER      PRIMARY KEY,
    id_sesion              INTEGER      NOT NULL,
    numero_secuencia       INTEGER      NOT NULL,
    token_payload          VARCHAR(160) NOT NULL,
    firma_hmac_sha256      VARCHAR(64)  NOT NULL,
    fecha_hora_emision     DATETIME     NOT NULL,
    fecha_hora_expiracion  DATETIME     NOT NULL,
    vigente                INTEGER      NOT NULL DEFAULT 1,
    CONSTRAINT uk_token_payload UNIQUE (token_payload),
    CONSTRAINT uk_token_sesion_secuencia UNIQUE (id_sesion, numero_secuencia),
    CONSTRAINT fk_token_sesion FOREIGN KEY (id_sesion)
        REFERENCES sesion_asistencia (id_sesion) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT ck_token_secuencia CHECK (numero_secuencia >= 1),
    CONSTRAINT ck_token_expiracion CHECK (fecha_hora_expiracion > fecha_hora_emision),
    CONSTRAINT ck_token_vigente CHECK (vigente IN (0, 1))
);

-- 9. Tabla: registro_asistencia
CREATE TABLE registro_asistencia (
    id_registro           INTEGER      PRIMARY KEY,
    id_sesion             INTEGER      NOT NULL,
    id_aprendiz           INTEGER      NOT NULL,
    fecha_hora_marcacion  DATETIME     NOT NULL,
    estado_asistencia     VARCHAR(20)  NOT NULL,
    modalidad_registro    VARCHAR(20)  NOT NULL,
    ip_origen_aprendiz    VARCHAR(45)  NOT NULL,
    motivo_contingencia   VARCHAR(200) NULL,
    CONSTRAINT uk_registro_sesion_aprendiz UNIQUE (id_sesion, id_aprendiz),
    CONSTRAINT fk_registro_sesion FOREIGN KEY (id_sesion)
        REFERENCES sesion_asistencia (id_sesion) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_registro_aprendiz FOREIGN KEY (id_aprendiz)
        REFERENCES usuario (id_usuario) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT ck_registro_estado CHECK (estado_asistencia IN ('PRESENTE', 'CONTINGENCIA', 'EXCUSA', 'INASISTENTE')),
    CONSTRAINT ck_registro_modalidad CHECK (modalidad_registro IN ('QR_MOVIL', 'MANUAL_INSTRUCTOR', 'CIERRE_AUTOMATICO'))
);

-- 10. Tabla: alerta_inasistencia
CREATE TABLE alerta_inasistencia (
    id_alerta                INTEGER      PRIMARY KEY,
    id_ficha                 INTEGER      NOT NULL,
    id_aprendiz              INTEGER      NOT NULL,
    fecha_generacion         DATE         NOT NULL,
    total_inasistencias      INTEGER      NOT NULL,
    nivel_riesgo             VARCHAR(20)  NOT NULL,
    observacion_seguimiento  VARCHAR(200) NOT NULL,
    estado_alerta            VARCHAR(15)  NOT NULL DEFAULT 'ABIERTA',
    CONSTRAINT fk_alerta_ficha FOREIGN KEY (id_ficha)
        REFERENCES ficha_formacion (id_ficha) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_alerta_aprendiz FOREIGN KEY (id_aprendiz)
        REFERENCES usuario (id_usuario) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT ck_alerta_umbral CHECK (total_inasistencias >= 3),
    CONSTRAINT ck_alerta_riesgo CHECK (nivel_riesgo IN ('PREVENTIVO', 'ALTO', 'CRITICO')),
    CONSTRAINT ck_alerta_estado CHECK (estado_alerta IN ('ABIERTA', 'EN_GESTION', 'CERRADA'))
);

-- 11. Tabla: auditoria_seguridad
CREATE TABLE auditoria_seguridad (
    id_auditoria         INTEGER      PRIMARY KEY,
    id_usuario           INTEGER      NULL,
    id_sesion            INTEGER      NULL,
    fecha_hora_evento    DATETIME     NOT NULL,
    tipo_evento          VARCHAR(40)  NOT NULL,
    ip_origen            VARCHAR(45)  NOT NULL,
    detalle_evento       VARCHAR(250) NOT NULL,
    resultado_operacion  VARCHAR(15)  NOT NULL,
    CONSTRAINT fk_auditoria_usuario FOREIGN KEY (id_usuario)
        REFERENCES usuario (id_usuario) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_auditoria_sesion FOREIGN KEY (id_sesion)
        REFERENCES sesion_asistencia (id_sesion) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT ck_auditoria_resultado CHECK (resultado_operacion IN ('EXITOSO', 'RECHAZADO', 'ALERTA'))
);

-- Índices de rendimiento para RNF-01 (p95 <= 1,5 s con 35 aprendices simultáneos)
CREATE INDEX idx_sesion_ficha_fecha ON sesion_asistencia (id_ficha, fecha_sesion);
CREATE INDEX idx_token_sesion_vigente ON token_qr_sesion (id_sesion, vigente);
CREATE INDEX idx_registro_aprendiz ON registro_asistencia (id_aprendiz, estado_asistencia);

-- ============================================================================
-- INSERCIÓN DE DATOS DE VERIFICACIÓN (PRUEBA FUNCIONAL DE LAS 11 TABLAS)
-- ============================================================================

INSERT INTO centro_formacion VALUES (1, '9527', 'CENTRO DE LA INDUSTRIA, LA EMPRESA Y LOS SERVICIOS - CIES', '41 - REGIONAL HUILA', 'NEIVA', 'ACTIVO');

INSERT INTO usuario VALUES
(1, 1, 'CC', '10000001', 'Coordinador Academico CIES', 'admin.cies@sena.edu.co', '$2b$12$SalHashSeguraAdmin952700000000000000000000000000', 'ADMIN', 'Administracion Educativa', 0, NULL, 'ACTIVO'),
(2, 1, 'CC', '10000002', 'Instructor Lider ADSO', 'instructor.adso@sena.edu.co', '$2b$12$SalHashSeguraInst9527000000000000000000000000000', 'INSTRUCTOR', 'Ingenieria de Software', 0, NULL, 'ACTIVO'),
(3, 1, 'TI', '10000003', 'Aprendiz Vocero Ficha', 'vocero.adso@soy.sena.edu.co', '$2b$12$SalHashSeguraApr19527000000000000000000000000000', 'APRENDIZ', 'ADSO', 1, NULL, 'ACTIVO'),
(4, 1, 'CC', '10000004', 'Aprendiz Integrante Dos', 'aprendiz2.adso@soy.sena.edu.co', '$2b$12$SalHashSeguraApr29527000000000000000000000000000', 'APRENDIZ', 'ADSO', 0, 3, 'ACTIVO');

INSERT INTO telefono_usuario VALUES
(1, 3, '3105550101', 'MOVIL', 1),
(2, 3, '6088750101', 'FIJO', 0),
(3, 4, '3158880202', 'MOVIL', 1);

INSERT INTO ambiente_formacion VALUES
(1, 1, 'AMB-302', 'Laboratorio de Desarrollo de Software 302', 35, '192.168.10.0/24', 'DISPONIBLE');

INSERT INTO ficha_formacion VALUES
(1, 1, 2, '3413974', 'ANALISIS Y DESARROLLO DE SOFTWARE', 'TECNOLOGO', 'MANANA', '2026-02-09', '2028-05-08', 'EN_EJECUCION');

INSERT INTO matricula_ficha VALUES
(1, 3, '2026-02-09', 'EN_FORMACION', 'Vocero principal de la ficha'),
(1, 4, '2026-02-09', 'EN_FORMACION', 'Orientado por vocero id_usuario=3');

INSERT INTO sesion_asistencia VALUES
(1, 1, 2, 1, '2026-11-27', '07:05:00', '09:00:00', '192.168.10.0/24', 'CERRADA');

INSERT INTO token_qr_sesion VALUES
(1, 1, 1, 'SES1-SEQ1-1764245100', 'a8f5f167f44f4964e6c998dee827110c8b7f4b2a9d1e0c3f5a6b7c8d9e0f1a2b', '2026-11-27 07:05:00', '2026-11-27 07:05:30', 0);

INSERT INTO registro_asistencia VALUES
(1, 1, 3, '2026-11-27 07:05:14', 'PRESENTE', 'QR_MOVIL', '192.168.10.45', NULL),
(2, 1, 4, '2026-11-27 07:08:10', 'CONTINGENCIA', 'MANUAL_INSTRUCTOR', '192.168.10.10', 'Aprendiz en aula con bateria agotada');

INSERT INTO alerta_inasistencia VALUES
(1, 1, 4, '2026-11-27', 3, 'PREVENTIVO', 'Acumula 3 inasistencias en el trimestre; citacion preventiva', 'ABIERTA');

INSERT INTO auditoria_seguridad VALUES
(1, 3, 1, '2026-11-27 07:05:14', 'MARCACION_QR_EXITOSA', '192.168.10.45', 'Firma HMAC y subred 192.168.10.0/24 verificadas', 'EXITOSO'),
(2, 2, 1, '2026-11-27 07:08:10', 'AJUSTE_CONTINGENCIA', '192.168.10.10', 'Registro manual autorizado por instructor id=2', 'ALERTA');
