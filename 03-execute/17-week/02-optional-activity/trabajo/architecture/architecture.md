# Arquitectura — app-attendance

## Topologia de ejecucion

```
Celular del estudiante
    │ (Escanea QR con camara)
    ▼
Navegador → GET /attendance/{token}   ← HTML form publico
             POST /public/attendance/{token}/register
                    │
                    ▼
              API (back/)
              Express 5 + Mongoose
              Puerto 4000
                    │ Autenticado con JWT (rutas /api/*)
                    │
              PC instructor/docente
              App Ionic React (app/)
              Puerto 8080 (dev) / localhost capacitor
                    │
                    ▼
              MongoDB 7
              Puerto 27017
              Volumen Docker persistente
```

## Capas

| Capa | Tecnologia | Puerto | Responsabilidad |
|---|---|---|---|
| `app/` | Ionic React + Vite + Capacitor | 8080 (docker) / 5173 (dev) | UI del instructor/docente |
| `back/` | Node 20 + Express 5 + Mongoose | 4000 | Reglas de negocio, validacion, JWT |
| `db/` | MongoDB 7 | 27017 | Persistencia, seed idempotente |

## Flujo de autenticacion

```
App (instructor) → POST /api/auth/login {documento, password}
                ← JWT (24h) + datos del usuario

App → todas las rutas /api/* con Authorization: Bearer <JWT>
API → middleware authenticate → verifica JWT → pasa req.user al handler
```

## Flujo de sesion de asistencia

```
Instructor → POST /api/sessions            → crea sesion draft
          → POST /api/sessions/:id/activate → genera QR token
          → QR URL = {backendUrl}/attendance/{token}
          → muestra QR en pantalla

Estudiante → escanea QR → formulario HTML
          → POST /public/attendance/{token}/register {documento}
          → validaciones: token activo, persona inscrita, sin duplicado
          → registro accepted o rejected con reason code

Instructor → GET /api/sessions/:id/present | absent | rejections
          → ve resultados en tiempo real (auto-refresh 10s cuando activa)
          → POST /api/sessions/:id/close → cierra sesion
```

## Casos de Uso

### CU-01: Gestionar y Activar Sesion
- **Usuario:** Docente/Instructor
- **Proposito:** Iniciar el proceso de toma de asistencia generando el codigo QR.
- **Paso a paso:**
  1. El docente se loguea en la app con documento y contrasena.
  2. Selecciona la institucion y la ficha/materia correspondiente.
  3. Crea la sesion y la "activa".
  4. El sistema genera y proyecta un codigo QR en pantalla vinculado al token temporal.

### CU-02: Marcar Ingreso
- **Usuario:** Estudiante/Aprendiz
- **Proposito:** Registrar su llegada de forma digital.
- **Paso a paso:**
  1. El estudiante escanea el QR proyectado por el docente.
  2. Se abre un formulario HTML publico en su navegador.
  3. Ingresa su numero de documento y envia.
  4. El backend evalua las reglas de negocio (sesion activa, no duplicado, etc.).
  5. La pantalla le arroja un aviso de aceptacion o de rechazo (con su motivo).

### CU-03: Monitorear y Cerrar Asistencia
- **Usuario:** Docente/Instructor
- **Proposito:** Auditar presencias y dar por finalizado el registro.
- **Paso a paso:**
  1. Mientras la sesion esta activa, la app hace auto-refresh consultando el API.
  2. El docente visualiza listas de: Presentes, Ausentes y Rechazos.
  3. Al finalizar, el docente cierra la sesion, bloqueando nuevos registros.

### CU-04: Emitir Reportes
- **Usuario:** Docente/Instructor
- **Proposito:** Extraer tabla resumen de puntualidad de un grupo.
- **Paso a paso:**
  1. El docente define las fechas y el codigo del curso.
  2. El servidor compila los datos almacenados.
  3. Se visualiza o exporta un documento Excel con la estadistica de llegadas.

## Esquema de Clases (UML Textual)

```
========================
|      Formador        | (Docente/Instructor)
========================
| - id                 |
| - documento          |
| - institutionId      |
| - roles (JWT)        |
========================
| + iniciarSesion()    |
| + activarQR()        |
| + emitirReporte()    |
========================
          | 1
          |
          | 0..*
========================
|      Session         |
========================
| - sessionId          |
| - unitId (Ficha)     |
| - qrToken            |
| - estado (draft/act) |
| - qrExpiresAt        |
========================
| + cerrarSesion()     |
========================
          | 1
          |
          | 0..*
========================
|  Registro (Attendance)|
========================
| - documentoEstudiante|
| - timestamp          |
| - status (accepted/  |
|   rejected)          |
| - reasonCode         |
========================
| + marcarIngreso()    |
========================
```

Mapeo de cardinalidad:
- Un Formador gestiona multiples Sesiones (1 a 0..*).
- Una Sesion genera multiples Registros de asistencia (1 a 0..*).

## Modelo de Casos de Uso (Texto)

```
                    PLATAFORMA APP-ATTENDANCE
       ==============================================
       |                                            |
       |        [App: Iniciar/Cerrar Sesion QR]     |
       |                                            |
       |        [Web: Formulario Publico QR]         |
       |                                            |
       |        [App: Monitoreo y Reportes]         |
       |                                            |
       ==============================================

     O                                                O
    -|-  ------- (Escanea) -- Web Form               -|-
    / \                                              / \
ESTUDIANTE                                        DOCENTE
                                                     |
                                                     +---- App: Iniciar/Cerrar Sesion QR
                                                     |
                                                     +---- App: Monitoreo y Reportes
```

Mapeo de interacciones:
- El **Estudiante** interactua unicamente a traves del formulario web publico (`/attendance/{token}`) al escanear el QR, sin usar la App principal ni requerir Auth.
- El **Docente** opera de forma autenticada consumiendo las rutas privadas de la API (`/api/sessions`) para administrar los QR y los reportes.

## Restricciones de diseno

- No SQLite, no Atlas, no backend embebido en la app.
- Frontend NO se conecta directamente a MongoDB.
- URLs de backend configurables en runtime (permite tunel HTTP en clase).
- Token QR es opaco — el backend tiene todo el estado de la sesion.
- Colores institucionales pendientes de confirmacion oficial (`officialColorsConfirmed: false`).

## Infraestructura Docker Compose

```yaml
mongo      → MongoDB 7 con healthcheck
db-seed    → mongosh idempotente (carga datos reales o sinteticos)
api        → imagen del backend, espera a que db-seed complete
app        → nginx sirviendo el build de Vite
```
