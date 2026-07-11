# Contrato API

Base local:

```text
http://localhost:4000
```

La app debe usar la URL configurada por el usuario. En clase normalmente sera la URL publica del tunel.

## Convenciones

- Formato: REST JSON.
- **Autenticacion**: JWT Bearer token requerido en todas las rutas `/api/*` salvo `/api/auth/*`.
  - Header: `Authorization: Bearer <token>`
  - Errores sin token o token invalido: `401 UNAUTHORIZED`
- Errores:

```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "La solicitud no cumple el contrato esperado.",
    "details": [],
    "trace_id": "uuid"
  }
}
```

## Autenticacion

### `POST /api/auth/login` — **publico**

Autentica un formador (ADMIN, INSTRUCTOR, DOCENTE).

Request:

```json
{
  "documento": "1079606375",
  "password": "1079606375"
}
```

Response `200`:

```json
{
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "person": {
      "id": "...",
      "institutionId": "...",
      "nombre": "NOMBRE APELLIDO",
      "documento": "1079606375",
      "roles": ["INSTRUCTOR"]
    }
  }
}
```

Errores relevantes:

- `INVALID_CREDENTIALS` (401) — documento no existe, no es formador, o contrasena incorrecta.

## Salud

### `GET /health`

Valida que el proceso API responde.

### `GET /ready`

Valida que la API puede consultar MongoDB.

## Catalogos — **requieren Auth**

### `GET /api/institutions`

Lista instituciones activas.

### `GET /api/institutions/{institutionId}/units`

Lista fichas o materias de la institucion.

### `GET /api/units/{unitId}/people`

Lista aprendices o estudiantes inscritos en la ficha/materia.

## Sesiones — **requieren Auth**

### `POST /api/sessions`

Crea sesion en estado `draft`.

Request:

```json
{
  "institutionId": "ObjectId",
  "unitId": "ObjectId",
  "qrTtlMinutes": 10
}
```

Errores relevantes:

- `INSTITUTION_NOT_FOUND`
- `UNIT_INSTITUTION_MISMATCH`
- `UNIT_EMPTY`

### `POST /api/sessions/{sessionId}/activate`

Activa la sesion y genera `qrToken`, `qrExpiresAt` y `attendanceUrl`.

### `POST /api/sessions/{sessionId}/close`

Cierra la sesion. Despues del cierre no se aceptan registros.

### `GET /api/sessions/{sessionId}`

Consulta estado, conteos y URL de asistencia si existe.

### `GET /api/sessions`

Historial basico. Query params opcionales:

- `institutionId`
- `unitId`
- `limit`

### `GET /api/sessions/{sessionId}/present`

Lista registros aceptados.

### `GET /api/sessions/{sessionId}/absent`

Calcula inscritos sin registro aceptado.

### `GET /api/sessions/{sessionId}/rejections`

Lista intentos rechazados, incluyendo duplicados.

## QR publico — **sin Auth**

### `GET /attendance/{token}`

Pagina HTML publica para registrar documento.

### `POST /public/attendance/{token}/register`

Request form o JSON:

```json
{
  "documento": "1001001001"
}
```

Validaciones (Exigencias Funcionales cubiertas):

- **EF-03:** Sesion inexistente → rechazo.
- **EF-03:** Sesion no activa → rechazo.
- **EF-03:** Sesion cerrada → rechazo.
- **EF-03:** QR expirado → rechazo.
- **EF-03:** Documento no encontrado → rechazo.
- **EF-03:** Documento de otra ficha/materia → rechazo.
- **EF-03:** Documento duplicado → rechazo (bloqueo de doble asistencia).
- **EF-06:** Registro exitoso → aviso visual de confirmacion al estudiante.
