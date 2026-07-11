# Plan de Implementacion

## Fase 1: Base del repositorio

- Crear estructura `app`, `back`, `db`, `docs`.
- Crear reglas agentic minimas.
- Crear README y comandos raiz.

## Fase 2: Datos y MongoDB

- Definir colecciones: `institutions`, `academic_units`, `people`, `enrollments`, `attendance_sessions`, `attendance_records`.
- Crear seed idempotente con datos reales de SENA y CORHUILA.
- Crear indices de integridad (documento unico por institucion, token QR unico, etc.).
- Documentar carga y validacion.

## Fase 3: Backend API

- Crear API TypeScript (Node.js 20 + Express 5 + Mongoose + Zod).
- Conectar a MongoDB.
- Exponer health/readiness.
- Implementar autenticacion JWT (24h) con bcrypt.
- Implementar catalogos (instituciones, fichas/materias, personas).
- Implementar sesiones (crear draft, activar QR, cerrar).
- Implementar registro publico de asistencia via QR token.
- Validar errores de negocio (EF-01 a EF-06).

## Fase 4: App Ionic React

- Configurar URL backend/tunel en runtime.
- Seleccionar institucion (SENA/CORHUILA).
- Seleccionar ficha/materia.
- Listar aprendices/estudiantes.
- Crear/activar/cerrar sesiones.
- Mostrar QR temporal en pantalla.
- Consultar presentes, ausentes, rechazados con auto-refresh (10s).
- Exportar reportes Excel multi-sesion.
- Implementar sistema anti-fraude CSR (Codigo de Sala Rotativo).

## Fase 5: Integracion local

- Levantar MongoDB y API con Docker Compose.
- Ejecutar seed idempotente.
- Validar flujo completo con datos reales (SENA y CORHUILA).
- Configurar tunel publico (ngrok/localtunnel) para pruebas en clase.

## Fase 6: Madurez minima

- Documentar contrato API.
- Documentar modelo de datos.
- Documentar pruebas funcionales (functional-checklist, runtime-checklist).
- Registrar ADRs relevantes.
- Migrar passwords a bcrypt antes de produccion.
- Configurar JWT_SECRET seguro y CORS restrictivo.
