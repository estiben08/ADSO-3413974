# A1 · Ficha de Interpretación del Informe de Análisis y Plataforma Tecnológica

**Proyecto:** Sistema de Control de Asistencia Académica con QR Dinámico (`asistencia-qr`)  
**Autor (GitHub):** `@estiben08` · **Ficha:** 3413974  
**Competencia:** 220501095 · Diseñar la solución de software de acuerdo con procedimientos y requisitos técnicos  
**RAP asociado:** 593103 (01) · Elaborar los artefactos de diseño del software siguiendo las prácticas de la metodología seleccionada (Criterio 1).  
**Informe de análisis de entrada:** [`../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-asistencia-qr/08-informe-analisis.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-asistencia-qr/08-informe-analisis.md) y `03-execute/19-week/02-optional-activity/SRC.docx`.

---

## 1. Requisitos Funcionales Seleccionados para el Diseño (13 RF con ID del SRS)

Se toma el **100 % de los 13 requisitos funcionales** especificados en el informe de análisis (superando el mínimo exigible de 8 RF):

| ID | Requisito Funcional (Síntesis del Informe de Análisis) | Caso de Uso Asociado | Prioridad |
|---|---|---|---|
| **RF-01** | Autenticar usuarios registrados (`Administrador`, `Instructor`, `Aprendiz`) validando documento, contraseña con hash y estado activo. | `CU-01 Autenticar usuario` | *Must Have* |
| **RF-02** | Administrar el catálogo de usuarios, centros, ambientes de formación y fichas académicas con su programa y jornada. | `CU-02 Gestionar catálogo académico y usuarios` | *Must Have* |
| **RF-03** | Vincular e importar masivamente aprendices a una ficha de formación por documento evitando duplicidad de personas. | `CU-02 Gestionar catálogo académico y usuarios` | *Should Have* |
| **RF-04** | Aperturar una sesión de asistencia activa seleccionando ficha y ambiente, capturando la subred IP del aula. | `CU-03 Aperturar sesión de asistencia` | *Must Have* |
| **RF-05** | Generar un token QR único por sesión que incluya identificador, marca temporal y firma criptográfica `HMAC-SHA256`. | `CU-04 Generar token QR dinámico firmado` | *Must Have* |
| **RF-06** | Rotar y refrescar automáticamente el código QR proyectado cada 30 segundos, invalidando ventanas previas. | `CU-04 Generar token QR dinámico firmado` | *Must Have* |
| **RF-07** | Permitir al aprendiz autenticado escanear el código QR proyectado desde el navegador de su teléfono móvil. | `CU-05 Registrar asistencia por escaneo QR` | *Must Have* |
| **RF-08** | Validar en cada escaneo que la sesión esté activa, la firma HMAC y vigencia sean válidas, y la IP del aprendiz coincida con la subred del aula. | `CU-06 Validar subred IP y firma del código QR` | *Must Have* |
| **RF-09** | Impedir doble registro de asistencia del mismo aprendiz en una misma sesión y auditar todo intento rechazado con su causal. | `CU-06 Validar subred IP y firma del código QR` | *Must Have* |
| **RF-10** | Registrar o ajustar manualmente asistencia por contingencia en aula (aprendiz sin celular o falla de cámara) con motivo obligatorio. | `CU-07 Registrar asistencia manual por contingencia` | *Should Have* |
| **RF-11** | Monitorear en tiempo real presentes, pendientes y rechazos, y cerrar la sesión asignando «Inasistente» a quienes no registraron ingreso. | `CU-08 Monitorear asistencia y cerrar sesión` | *Must Have* |
| **RF-12** | Consultar historial de asistencia filtrando por ficha, aprendiz y fechas, y exportar en formato CSV y Excel (`.xlsx`). | `CU-09 Exportar reporte histórico de asistencia` | *Should Have* |
| **RF-13** | Generar automáticamente alerta temprana de riesgo de deserción cuando un aprendiz acumule 3 o más inasistencias en una ficha. | `CU-10 Generar alerta temprana de inasistencia` | *Could Have* |

---

## 2. Requisitos No Funcionales con Métrica Cuantificable (5 RNF · Mínimo Exigible: 3)

| ID | Categoría | Descripción y Métrica de Aceptación |
|---|---|---|
| **RNF-01** | **Desempeño** | La validación completa de un escaneo QR (`RF-08`, `RF-09`) y su respuesta HTTP deben ejecutarse en **<= 1,5 segundos en el percentil 95 (`p95 <= 1500 ms`)** con **35 aprendices** escaneando concurrentemente en la misma ventana de 30 segundos. |
| **RNF-02** | **Seguridad** | Contraseñas almacenadas exclusivamente con **hash y sal criptográfica (`bcrypt` / `Argon2id`)**, firma de tokens QR mediante **`HMAC-SHA256`** con clave secreta en variable de entorno, y tráfico cifrado de extremo a extremo por **`HTTPS (TLS 1.3)`**. |
| **RNF-03** | **Usabilidad y Compatibilidad Móvil** | Interfaz web responsiva (*Mobile-First*, desde `360px` de ancho) que opere en navegadores móviles estándar (Chrome Android / Safari iOS) sin instalar aplicaciones nativas. |
| **RNF-04** | **Disponibilidad y Fiabilidad** | Disponibilidad operativa mínima del **99,5 % mensual** durante el horario académico (lunes a sábado, 6:00 a. m. a 10:00 p. m.) con respaldo diario automatizado (`RPO <= 24 h`, `RTO <= 2 h`). |
| **RNF-05** | **Mantenibilidad** | Arquitectura modular con separación estricta entre presentación, lógica de negocio/validación y persistencia, aplicando patrones GoF para permitir nuevas reglas de validación o formatos de reporte sin modificar las clases existentes (Principio Abierto/Cerrado - SOLID). |

---

## 3. Ficha Consolidada de Interpretación y Selección Justificada de Plataforma Tecnológica

| Elemento | Definición y Justificación para el Caso `asistencia-qr` |
|---|---|
| **Actores del sistema** | `Administrador` (gestión de catálogo maestro y reportes), `Instructor` (apertura de sesión QR, monitoreo en vivo, contingencias y reportes), `Aprendiz` (escaneo móvil de QR en red del aula) y `Temporizador del Sistema` (rotación de QR cada 30 s y cierre por ventana). |
| **Restricciones del proyecto** | 1. Despliegue económico en un servidor Linux ligero (VPS o servidor local de centro con Docker/Nginx).<br>2. Los aprendices usan sus propios teléfonos de gama variada sin instalar apps nativas.<br>3. Sin conexión directa a API privada de SofíaPlus (intercambio por archivos CSV/Excel).<br>4. Equipo de desarrollo pequeño que requiere alta legibilidad y mantenibilidad del código. |
| **Lenguaje Orientado a Objetos seleccionado y justificación (≥ 3 condiciones concretas del caso)** | **Python 3.12 (con Programación Orientada a Objetos, clases abstractas `abc.ABC`, tipado estático `typing` y arquitectura modular sobre Flask Blueprints):**<br>1. **Soporte nativo a POO y polimorfismo (`RNF-05`):** Permite implementar clases abstractas, herencia (`Usuario` → `Instructor`, `Aprendiz`, `Administrador`) e interfaces formales (`ABC` / `Protocol`) para los patrones Estrategia (`IReglaValidacionAsistencia`) y Método Fábrica (`IExportadorReporte`).<br>2. **Criptografía y generación QR en biblioteca estándar/madura (`RF-05`, `RNF-02`):** Cuenta con los módulos nativos `hmac`, `hashlib`, `secrets` y `ipaddress` (para cálculo exacto de subredes CIDR `192.168.X.0/24`) más `qrcode` y `Werkzeug.security` sin sobrecarga externa.<br>3. **Desempeño con Pool de Conexiones y bajo consumo en servidor pequeño (`RNF-01`):** Ejecutado bajo Gunicorn con `MySQLConnectionPool`, atiende ráfagas de 35 peticiones concurrentes en menos de 120 ms con menos de 250 MB de RAM.<br>4. **Continuidad con la base de código del año (`SRC.docx`):** Reutiliza y profesionaliza el prototipo funcional desarrollado por el autor en la semana 19. |
| **Tipo de Base de Datos seleccionada y justificación (≥ 3 condiciones concretas del caso)** | **Base de Datos Relacional (MySQL 8.0 / compatible con SQL estándar ANSI en SQLite3 y PostgreSQL):**<br>1. **Integridad transaccional ACID frente a ráfagas concurrentes (`RF-08`, `RF-09`, `RNF-04`):** Cuando 35 aprendices escanean el QR en los mismos 30 segundos, el motor relacional garantiza mediante transacciones y la restricción `UNIQUE (id_sesion, id_aprendiz)` que ningún aprendiz registre doble asistencia por condición de carrera.<br>2. **Estructura de datos altamente estructurada e invariante (`RF-02` a `RF-13`):** Las relaciones entre centros, ambientes, usuarios, fichas, matrículas (`N:M`), sesiones, tokens QR y registros de asistencia son fijas y exigen integridad referencial estricta (`FOREIGN KEY` con `ON DELETE RESTRICT`).<br>3. **Consultas analíticas y cruces para reportes y alertas (`RF-11`, `RF-12`, `RF-13`):** Detectar a los aprendices matriculados que no escanearon al cierre de la sesión (`LEFT JOIN` entre `matricula_ficha` y `registro_asistencia`) o contar quiénes acumulan `>= 3` inasistencias (`GROUP BY` + `HAVING`) es exacto e inmediato en SQL relacional.<br>4. **Auditoría y cumplimiento normativo (`RNF-02`):** Permite aplicar controles declarativos `CHECK`, vistas por rol y trazabilidad inmutable en `auditoria_seguridad`. |

---

## 4. Lista de Entregables de Diseño de la Solución (Índice Técnico)

1. **`A1` · Ficha de interpretación y plataforma tecnológica:** [`A1-ficha-interpretacion-plataforma.md`](./A1-ficha-interpretacion-plataforma.md)
2. **`A2` · Diagrama de clases de diseño orientado a objetos (12 clases):** [`A2-diagrama-clases.md`](./A2-diagrama-clases.md), [`.drawio`](./A2-diagrama-clases.drawio), [`.mmd`](./A2-diagrama-clases.mmd), [`.svg`](./A2-diagrama-clases.svg), [`.png`](./A2-diagrama-clases.png)
3. **`A3` · Patrones de diseño GoF aplicados (Estrategia, Método Fábrica y Fachada):** [`A3-patrones-diseno.md`](./A3-patrones-diseno.md)
4. **`A4` · Arquitectura del software en 3 capas y decisiones frente a RNF:** [`A4-arquitectura-software.md`](./A4-arquitectura-software.md), [`.drawio`](./A4-arquitectura.drawio), [`.svg`](./A4-arquitectura.svg), [`.png`](./A4-arquitectura.png)
5. **`A5` · Vista de componentes UML (6 componentes con interfaces):** [`A5-vista-componentes.md`](./A5-vista-componentes.md), [`.drawio`](./A5-vista-componentes.drawio), [`.svg`](./A5-vista-componentes.svg), [`.png`](./A5-vista-componentes.png)
6. **`A6` · Vista de despliegue UML (4 nodos con artefactos y protocolos):** [`A6-vista-despliegue.md`](./A6-vista-despliegue.md), [`.drawio`](./A6-vista-despliegue.drawio), [`.svg`](./A6-vista-despliegue.svg), [`.png`](./A6-vista-despliegue.png)
7. **`A7` · Matriz de trazabilidad bidireccional (Análisis → Diseño):** [`A7-matriz-trazabilidad.md`](./A7-matriz-trazabilidad.md)
