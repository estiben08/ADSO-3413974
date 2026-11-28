# B3 · Evidencia de Normalización Paso a Paso (0FN → 1FN → 2FN → 3FN)

**Proyecto:** Sistema de Control de Asistencia Académica con QR Dinámico (`asistencia-qr`)  
**Autor (GitHub):** `@estiben08` · **Ficha:** 3413974  
**RAP asociado:** 593101 (02) · Normaliza el modelo lógico de acuerdo con el tipo de base de datos (Criterio 3).

---

## 1. Alcance de la Evidencia

Cumpliendo el nivel 100 de la rúbrica (`Rubricas_G2.md` §3.2 Criterio 3) y el formato de la sección 8 de `Plantillas_G2.md`, se normalizan paso a paso (`0FN → 1FN → 2FN → 3FN`) **dos estructuras desnormalizadas reales tomadas de las planillas e insumos iniciales del proyecto**:
- **Caso de Normalización 1 (con Llave Compuesta y Dependencia Funcional Parcial en 2FN + Transitiva en 3FN):** `planilla_sesion_asistencia_0fn` con llave primaria compuesta `(id_sesion, id_aprendiz)`.
- **Caso de Normalización 2 (con Llave Simple y Dependencias Funcionales Transitivas encadenadas en 3FN):** `ficha_ambiente_centro_0fn` con llave primaria `id_ficha`.

---

## 2. Caso de Normalización 1 · Tabla con Llave Compuesta (`planilla_sesion_asistencia_0fn`)

### 2.1 Estado de partida en 0FN (Forma No Normalizada)
En el levantamiento inicial de las planillas de asistencia (`asistenciaSENA.txt` y `SRC.docx`), un registro consolidado por sesión y aprendiz almacenaba en una sola fila:

```text
planilla_sesion_asistencia_0fn (
  id_sesion,                 -- Parte 1 de la llave compuesta
  id_aprendiz,               -- Parte 2 de la llave compuesta
  numero_documento_aprendiz,
  nombre_aprendiz,
  correo_aprendiz,
  telefonos_aprendiz,        -- ¡VIOLACIÓN 1FN! Varios teléfonos en una celda: "3105550101, 3158880202"
  id_ficha,
  numero_ficha,
  nombre_programa,
  jornada_ficha,
  fecha_sesion,
  hora_apertura_sesion,
  ip_subred_aula,
  fecha_hora_marcacion,
  estado_asistencia,
  modalidad_registro,
  ip_origen_aprendiz
)
Llave primaria candidata compuesta: PK = (id_sesion, id_aprendiz)
```

Muestra de datos en `0FN` que evidencia anomalías de repetición y grupos multivaluados:

| `id_sesion` | `id_aprendiz` | `nombre_aprendiz` | `telefonos_aprendiz` *(No atómico)* | `id_ficha` | `numero_ficha` | `nombre_programa` | `fecha_sesion` | `estado_asistencia` |
|---|---|---|---|---|---|---|---|---|
| 101 | 501 | Aprendiz Uno | `3105550101, 3158880202` | 10 | `3413974` | `ADSO` | `2026-11-27` | `PRESENTE` |
| 101 | 502 | Aprendiz Dos | `3204440303` | 10 | `3413974` | `ADSO` | `2026-11-27` | `PRESENTE` |

---

### 2.2 Dependencias Funcionales (`DF`) Identificadas en el Caso 1

1. **`DF-1 (Dependencia total sobre la llave compuesta)`:**
   `(id_sesion, id_aprendiz) → fecha_hora_marcacion, estado_asistencia, modalidad_registro, ip_origen_aprendiz`
2. **`DF-2 (Dependencia parcial respecto a id_aprendiz — Viola 2FN)`:**
   `id_aprendiz → numero_documento_aprendiz, nombre_aprendiz, correo_aprendiz`
3. **`DF-3 (Dependencia parcial respecto a id_sesion — Viola 2FN)`:**
   `id_sesion → fecha_sesion, hora_apertura_sesion, ip_subred_aula, id_ficha, numero_ficha, nombre_programa, jornada_ficha`
4. **`DF-4 (Dependencia transitiva dentro de los datos de la sesión — Viola 3FN)`:**
   `id_sesion → id_ficha` y `id_ficha → numero_ficha, nombre_programa, jornada_ficha` (donde `id_ficha` no es superllave de `sesion_asistencia`).

---

### 2.3 Tabla Resumen Paso a Paso (`0FN → 1FN → 2FN → 3FN`) del Caso 1

| Paso | Violación Detectada | Dependencias Funcionales (`DF`) Escritas | Resultado de la Transformación (Esquema Antes y Después) |
|---|---|---|---|
| **Paso a 1FN** *(Atomicidad)* | La columna `telefonos_aprendiz` no es atómica: almacena múltiples números separados por comas en una sola celda. | Relación multivaluada: `id_aprendiz ->> numero_telefono` | **Se extrae el atributo multivaluado a una tabla independiente:**<br>1. `telefono_usuario(id_telefono PK, id_usuario FK, numero_telefono, tipo_telefono, es_principal)`<br>2. `planilla_1fn(id_sesion PK, id_aprendiz PK, numero_documento_aprendiz, nombre_aprendiz, correo_aprendiz, id_ficha, numero_ficha, nombre_programa, jornada_ficha, fecha_sesion, hora_apertura_sesion, ip_subred_aula, fecha_hora_marcacion, estado_asistencia, modalidad_registro, ip_origen_aprendiz)` |
| **Paso a 2FN** *(Eliminación de dependencias parciales sobre la llave compuesta)* | En `planilla_1fn`, la llave primaria es compuesta `(id_sesion, id_aprendiz)`, pero los atributos del aprendiz dependen **solo de `id_aprendiz`** (`DF-2`) y los atributos de la sesión y ficha dependen **solo de `id_sesion`** (`DF-3`). | - **Parcial 1:** `id_aprendiz → numero_documento_aprendiz, nombre_aprendiz, correo_aprendiz`<br>- **Parcial 2:** `id_sesion → fecha_sesion, hora_apertura_sesion, ip_subred_aula, id_ficha, numero_ficha, nombre_programa, jornada_ficha`<br>- **Total:** `(id_sesion, id_aprendiz) → fecha_hora_marcacion, estado_asistencia, modalidad_registro, ip_origen_aprendiz` | **Se descompone en 3 tablas donde todo atributo no clave depende por completo de su llave:**<br>1. `usuario(id_usuario PK, numero_documento, nombre_completo, correo_institucional, ...)`<br>2. `sesion_ficha_2fn(id_sesion PK, fecha_sesion, hora_apertura, ip_subred_aula, id_ficha, numero_ficha, nombre_programa, jornada_ficha)`<br>3. `registro_asistencia(id_registro PK, id_sesion FK, id_aprendiz FK, fecha_hora_marcacion, estado_asistencia, modalidad_registro, ip_origen_aprendiz)` con `UNIQUE (id_sesion, id_aprendiz)` |
| **Paso a 3FN** *(Eliminación de dependencias transitivas)* | En `sesion_ficha_2fn`, los atributos `numero_ficha`, `nombre_programa` y `jornada_ficha` dependen de `id_ficha`, el cual depende de `id_sesion` (`id_sesion → id_ficha → numero_ficha, nombre_programa, jornada_ficha`). | **Transitiva:** `id_sesion → id_ficha` y `id_ficha → numero_ficha, nombre_programa, jornada_ficha` | **Se separa la entidad determinante no clave en su propia tabla en 3FN:**<br>1. `ficha_formacion(id_ficha PK, numero_ficha UK, nombre_programa, jornada, ...)`<br>2. `sesion_asistencia(id_sesion PK, id_ficha FK, id_instructor FK, id_ambiente FK, fecha_sesion, hora_apertura, hora_cierre, ip_subred_aula, estado_sesion)` |

---

## 3. Caso de Normalización 2 · Tabla con Dependencias Transitivas Encadenadas (`ficha_ambiente_centro_0fn`)

### 3.1 Estado de partida en 0FN (Forma No Normalizada)
En el catálogo administrativo inicial (`SRC.docx` §34), los datos de la ficha, su ambiente de formación asignado y el centro regional se concentraban en una sola estructura:

```text
ficha_ambiente_centro_0fn (
  id_ficha,                  -- Llave primaria simple
  numero_ficha,
  nombre_programa,
  nivel_formacion,
  etiquetas_competencias,    -- ¡VIOLACIÓN 1FN! Lista repetida: "220501093, 220501095, 220501094"
  id_ambiente_habitual,
  codigo_ambiente,
  nombre_ambiente,
  capacidad_cupos_ambiente,
  subred_cidr_aula,
  id_centro,
  codigo_centro,
  nombre_centro,
  regional_centro,
  ciudad_sede_centro
)
Llave primaria: PK = id_ficha
```

---

### 3.2 Dependencias Funcionales (`DF`) Identificadas en el Caso 2

1. **`DF-A (Dependencia directa de la ficha)`:**
   `id_ficha → numero_ficha, nombre_programa, nivel_formacion, id_ambiente_habitual`
2. **`DF-B (Primera dependencia transitiva: Ficha → Ambiente — Viola 3FN)`:**
   `id_ambiente_habitual → codigo_ambiente, nombre_ambiente, capacidad_cupos_ambiente, subred_cidr_aula, id_centro`
3. **`DF-C (Segunda dependencia transitiva: Ambiente/Ficha → Centro — Viola 3FN)`:**
   `id_centro → codigo_centro, nombre_centro, regional_centro, ciudad_sede_centro`

---

### 3.3 Tabla Resumen Paso a Paso (`0FN → 1FN → 2FN → 3FN`) del Caso 2

| Paso | Violación Detectada | Dependencias Funcionales (`DF`) Escritas | Resultado de la Transformación (Esquema Antes y Después) |
|---|---|---|---|
| **Paso a 1FN** *(Atomicidad)* | La columna `etiquetas_competencias` contiene una lista de valores separados por coma en una misma celda, impidiendo integridad atómica. | Atributo no atómico eliminado del catálogo maestro de ficha; cada columna conserva un único valor escalar por fila. | `ficha_ambiente_centro_1fn(id_ficha PK, numero_ficha, nombre_programa, nivel_formacion, id_ambiente_habitual, codigo_ambiente, nombre_ambiente, capacidad_cupos_ambiente, subred_cidr_aula, id_centro, codigo_centro, nombre_centro, regional_centro, ciudad_sede_centro)` |
| **Paso a 2FN** *(Verificación de llave simple)* | La tabla `ficha_ambiente_centro_1fn` tiene **llave primaria simple (`id_ficha`)** (de una sola columna). Por definición de la teoría relacional, toda tabla en 1FN cuya llave primaria es simple carece de dependencias parciales y **ya se encuentra en 2FN**. | `id_ficha → {todos los atributos no clave de la tabla}` | El esquema en 2FN coincide con `ficha_ambiente_centro_1fn`, quedando listo para el análisis de dependencias transitivas hacia 3FN. |
| **Paso a 3FN** *(Eliminación de dependencias transitivas)* | Existen dos cadenas de dependencia transitiva:<br>1. `id_ficha → id_ambiente_habitual → codigo_ambiente, nombre_ambiente, capacidad_cupos_ambiente, subred_cidr_aula, id_centro` (`DF-B`).<br>2. `id_ambiente_habitual → id_centro → codigo_centro, nombre_centro, regional_centro, ciudad_sede_centro` (`DF-C`).<br>Esto generaba anomalías de actualización (cambiar la subred de un ambiente obligaba a actualizar todas las fichas) y de eliminación. | - `id_ficha → numero_ficha, nombre_programa, nivel_formacion, id_centro, id_instructor_lider`<br>- `id_ambiente → codigo_ambiente, nombre_ambiente, capacidad_cupos, subred_cidr_aula, id_centro`<br>- `id_centro → codigo_centro, nombre_centro, regional, ciudad_sede` | **Se descompone en 3 tablas independientes en Tercera Forma Normal (3FN):**<br>1. `centro_formacion(id_centro PK, codigo_centro UK, nombre_centro, regional, ciudad_sede, estado_centro)`<br>2. `ambiente_formacion(id_ambiente PK, id_centro FK, codigo_ambiente UK, nombre_ambiente, capacidad_cupos, subred_cidr_aula, estado_ambiente)`<br>3. `ficha_formacion(id_ficha PK, id_centro FK, id_instructor_lider FK, numero_ficha UK, nombre_programa, nivel_formacion, jornada, fecha_inicio, fecha_fin, estado_ficha)` |

---

## 4. Declaración sobre el Modelo Final (100 % en 3FN)

El modelo lógico final de **11 tablas** ([`B2-modelo-logico-relacional.md`](./B2-modelo-logico-relacional.md)) queda libre de grupos repetitivos (cumple **1FN**), libre de dependencias funcionales parciales sobre llaves compuestas (cumple **2FN**) y libre de dependencias funcionales transitivas entre atributos no clave (cumple **3FN**). No se introduce ninguna desnormalización oculta; el atributo `total_inasistencias` en `alerta_inasistencia` registra la fotografía histórica (*snapshot* de auditoría) del conteo exacto en la fecha en que se disparó la alerta (`RF-13`).
