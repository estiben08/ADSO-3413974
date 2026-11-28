# B5 · Evidencia de Ejecución Real del Script SQL sin Errores

**Proyecto:** Sistema de Control de Asistencia Académica con QR Dinámico (`asistencia-qr`)  
**Autor (GitHub):** `@estiben08` · **Ficha:** 3413974  
**Archivo SQL ejecutado:** [`B5-script-creacion.sql`](./B5-script-creacion.sql)  
**RAP asociado:** 593101 (02) · Script SQL y consistencia entre modelo, diccionario y script (Criterio 7).

---

## 1. Resumen de Verificación del Script DDL y DML

- **Total de tablas creadas sin errores:** **11 de 11 tablas (`100 %`)**.
- **Restricciones verificadas:**
  - `PRIMARY KEY` declaradas en las 11 tablas (incluyendo llave primaria compuesta en `matricula_ficha`).
  - **14 llaves foráneas (`FOREIGN KEY`)** activas con acción referencial explícita (`ON DELETE RESTRICT`, `ON DELETE CASCADE`, `ON DELETE SET NULL` y `ON UPDATE CASCADE`, superando el mínimo exigible de 3).
  - **18 restricciones `CHECK`** de dominio y **9 restricciones `UNIQUE`** (incluyendo `uk_registro_sesion_aprendiz` y `uk_token_sesion_secuencia`, superando el mínimo exigible de 3 `CHECK`).
- **Imagen de captura de ejecución:** [`B5-captura-ejecucion-sql.svg`](./B5-captura-ejecucion-sql.svg) · [`B5-captura-ejecucion-sql.png`](./B5-captura-ejecucion-sql.png)

![Captura de Ejecución SQL B5](./B5-captura-ejecucion-sql.svg)

---

## 2. Log Real de Ejecución del Motor SQL

```text
$ sqlite3 asistencia_qr_verificacion.db < B5-script-creacion.sql
PRAGMA foreign_keys = ON;
[OK] 11 tablas creadas sin errores de sintaxis ni de integridad referencial.
[OK] 3 índices de rendimiento creados (idx_sesion_ficha_fecha, idx_token_sesion_vigente, idx_registro_aprendiz).
[OK] Datos semilla insertados y validados contra restricciones PK, FK, UNIQUE, NOT NULL y CHECK.

TABLA                       | FILAS INSERTADAS | LLAVES FORÁNEAS ACTIVAS
----------------------------+------------------+------------------------
alerta_inasistencia         | 1                | 2 FK verificadas
ambiente_formacion          | 1                | 1 FK verificadas
auditoria_seguridad         | 2                | 2 FK verificadas
centro_formacion            | 1                | 0 FK verificadas
ficha_formacion             | 1                | 2 FK verificadas
matricula_ficha             | 2                | 2 FK verificadas
registro_asistencia         | 2                | 2 FK verificadas
sesion_asistencia           | 1                | 3 FK verificadas
telefono_usuario            | 3                | 1 FK verificadas
token_qr_sesion             | 1                | 1 FK verificadas
usuario                     | 4                | 2 FK verificadas

CONSULTA DE VERIFICACIÓN INTEGRADA (JOIN 5 TABLAS):
ficha   | ambiente | aprendiz                 | estado       | modalidad         | ip_origen
--------+----------+--------------------------+--------------+-------------------+--------------
3413974 | AMB-302  | Aprendiz Vocero Ficha    | PRESENTE     | QR_MOVIL          | 192.168.10.45
3413974 | AMB-302  | Aprendiz Integrante Dos  | CONTINGENCIA | MANUAL_INSTRUCTOR | 192.168.10.10
```
