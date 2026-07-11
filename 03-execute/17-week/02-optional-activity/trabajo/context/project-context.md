# Contexto del Proyecto

## Objetivo

Aplicacion movil para toma de asistencia academica con QR temporal y codigo de sala anti-fraude (CSR), usando Ionic React + Capacitor, API backend dockerizada y MongoDB local en Docker. El proposito principal es optimizar el control de ingresos de los aprendices a su entorno de formacion, reemplazando el llamado a lista tradicional por un escaneo agil con codigos QR, minimizando equivocaciones y ahorrando tiempo de clase.

## Finalidad del Proyecto

La meta es permitir que el instructor genere un codigo QR dinamico desde su aplicacion y que los estudiantes lo escaneen con la camara de su celular para registrarse a traves de un formulario web, sin requerir que el estudiante instale aplicaciones adicionales.

## Tecnicas de Levantamiento de Datos

Para estructurar adecuadamente la arquitectura de la solucion (app-attendance) y entender las falencias actuales, se acudio a las siguientes tecnicas:

- **Observacion de Campo:** Se acompano una sesion presencial, notando que el docente invierte una parte considerable del tiempo pasando lista manual o llamando a cada estudiante, lo cual retrasa el inicio de la jornada.
- **Charlas con Instructores (Entrevistas):** Se dialogo brevemente con formadores sobre su metodologia de asistencia. Manifestaron quehaceres tediosos como lidiar con planillas extraviadas o interrumpir la sesion cuando un estudiante se incorpora tarde. Solicitaron que el sistema sea facil de proyectar en pantalla y ofrezca reportes en tiempo real.
- **Cuestionarios a Estudiantes (Encuestas):** Se consulto a un grupo de aprendices sobre su disposicion a marcar su ingreso con el celular mediante un codigo QR. La recepcion fue ampliamente positiva. Para reducir fricciones tecnicas, se decidio por arquitectura publica (HTML form) al escanear el QR, evitando que deban descargar una app o iniciar sesion.

**Conclusion del diagnostico:** La dependencia del registro manual propicia margenes de error altos y consume tiempo efectivo de aprendizaje, evidenciando la urgencia de automatizar el proceso.

## Stack Tecnico

| Capa | Tecnologia |
|------|-----------|
| Frontend | Ionic React 8 + Vite + Capacitor 7 |
| Backend | Node.js 20 + TypeScript + Express 5 + Zod 4 |
| Base de datos | MongoDB 7 via Docker + Mongoose 9 |
| Auth | JWT 24h (jsonwebtoken 9) + bcryptjs 2 |
| Contenedores | Docker Compose (mongo, api, app, db-seed) |
| Reportes | xlsx 0.18.5 (multi-sesion Excel) |

## Instituciones

### SENA
- Rol formador: Instructor
- Unidad academica: Ficha
- Persona inscrita: Aprendiz (rol: APRENDIZ)
- Colores: parametrizados. Pendiente confirmar valores oficiales.

### CORHUILA / Universidad
- Rol formador: Docente
- Unidad academica: Materia
- Persona inscrita: Estudiante (rol: ESTUDIANTE)
- Colores: parametrizados. Pendiente confirmar valores oficiales.

## Perfiles y Usuarios

### Estudiante (Aprendiz)
Usuario en capacitacion que acude al centro de formacion. Su rol es escanear el codigo QR usando la camara de su celular, lo que abrira un navegador web estandar donde ingresara su documento. No requiere instalacion de software ni login.

### Docente (Instructor)
Responsable del ambiente de aprendizaje. Utiliza la interfaz principal (Ionic React/Vite). Su rol es autenticarse (Login), seleccionar la ficha, generar el codigo QR en pantalla, monitorear los ingresos en vivo y dar por cerrada la sesion.

## Roles disponibles

`ADMIN` · `INSTRUCTOR` · `DOCENTE` · `APRENDIZ` · `ESTUDIANTE`

Una persona puede tener multiples roles (array). Los permisos se calculan por union de roles.
El sistema soporta que la misma persona sea INSTRUCTOR en una institucion y DOCENTE en otra.

## Exigencias Funcionales (EF)

- **EF-01:** El sistema (backend en Node.js/Express) permitira al docente crear una sesion en estado *draft* y luego activarla generando un token QR temporal.
- **EF-02:** El aplicativo frontend (Ionic React) proyectara el codigo QR para que el estudiante lo escanee y acceda a un formulario web publico.
- **EF-03:** El sistema validara el registro del estudiante (documento), comprobando que la sesion este activa, que el estudiante pertenezca a la ficha/materia, y bloqueara intentos duplicados.
- **EF-04:** La plataforma del instructor actualizara en tiempo real (cada 10s) la lista de presentes, ausentes y registros rechazados.
- **EF-05:** Toda la aplicacion del instructor estara protegida por autenticacion JWT (JSON Web Token), asegurando que solo personal autorizado administre sesiones.
- **EF-06:** El sistema usara una base de datos centralizada (MongoDB) para guardar el historial, permitiendo al docente extraer reportes consolidados y cerrar la sesion de forma manual cuando lo desee.

## Flujo de autenticacion

1. `POST /api/auth/login` con `{ documento, password }`
2. Backend busca persona activa por documento (cualquier rol)
3. Si el password empieza con `$2` → bcrypt.compare(); si no → comparacion directa (dev)
4. Respuesta: `{ token (JWT 24h), person { id, institutionId, documento, nombre, roles } }`
5. Frontend guarda token en `@capacitor/preferences` (no localStorage)
6. Todas las rutas `/api/*` (excepto `/api/auth/*` y publicas) requieren `Authorization: Bearer <token>`
7. Autorizacion por recurso/accion via coleccion `permissions` en MongoDB

## Sistema anti-fraude CSR (Codigo de Sala Rotativo)

- El instructor activa la sesion → genera QR + codigo de sala de 6 caracteres
- El codigo rota automaticamente cada 90 segundos (configurable: `ROOM_CODE_TTL_SECONDS`)
- Charset: `ABCDEFGHJKLMNPQRSTUVWXYZ23456789` (visualmente no ambiguos)
- El aprendiz/estudiante autenticado ingresa el codigo en su app → registro con doble prueba (JWT + codigo)
- `GET /api/sessions/:id/room-code` → instructor ve el codigo con cuenta regresiva
- `POST /api/attendance/checkin` → aprendiz registra asistencia con el codigo

## Usuarios seed de desarrollo

| Nombre | Documento | Password | Rol SENA | Rol CORHUILA |
|--------|-----------|----------|----------|--------------|
| Instructor SENA | 1079606375 | 1079606375 | INSTRUCTOR | — |
| Docente CORHUILA | 1079606375 | 1079606375 | — | DOCENTE |
| Jesus Gonzalez | 0000000001 | qwerty.2026 | INSTRUCTOR | DOCENTE |
| Aprendices/Estudiantes | (del seed fuente) | (documento) | APRENDIZ o ESTUDIANTE | — |

**Notas:**
- Jesus Gonzalez tiene password almacenada con bcrypt (cost=10). Los demas con texto plano (solo dev).
- Jesus Gonzalez demuestra soporte de doble rol: INSTRUCTOR en SENA y DOCENTE en CORHUILA.
- Antes de produccion ejecutar el script de migracion de passwords.

## Variables de entorno

| Variable | Default | Descripcion |
|----------|---------|-------------|
| `MONGO_URI` | `mongodb://attendance:attendance_dev_password@mongo:27017/app_attendance?authSource=admin` | URI de conexion |
| `JWT_SECRET` | `super-secret-key-for-dev-only` | **Cambiar en produccion** |
| `QR_DEFAULT_TTL_MINUTES` | `10` | TTL del QR de sesion |
| `ROOM_CODE_TTL_SECONDS` | `90` | TTL del codigo de sala rotativo (30-300) |
| `API_CORS_ORIGIN` | `*` | Origen CORS permitido |
| `PORT` | `4000` | Puerto del backend |
| `APP_PORT` | `8080` | Puerto del frontend |

## Comandos

```bash
# Levantar todo desde cero
docker compose up -d --build

# Solo rebuild backend
docker compose up -d --build api

# Solo rebuild frontend
docker compose up -d --build app

# Typecheck backend
cd back && npx tsc --noEmit

# Build frontend
cd app && npm run build

# Tests backend
cd back && npm test

# Ver logs del backend
docker compose logs -f api
```

## Flujo operativo en clase

1. PC con Docker activo
2. `docker compose up -d` (primera vez: `--build`)
3. Tunel publico exponiendo el backend (ej. ngrok, localhost.run)
4. App instalada en celular → configurar URL del backend
5. Instructor inicia sesion y activa QR + codigo de sala
6. Estudiantes/aprendices inician sesion → ingresan codigo de sala

## Restricciones

- Sin SQLite local en app.
- Sin MongoDB Atlas.
- Sin backend embebido.
- La app no contiene credenciales de base de datos.
- La URL del backend no esta quemada en la app (se configura en runtime).

## Pendientes tecnicos

- [ ] Confirmar colores oficiales de SENA y CORHUILA.
- [ ] Script de migracion de passwords a bcrypt para produccion.
- [ ] Configurar `JWT_SECRET` seguro en entorno de produccion.
- [ ] Definir estrategia de despliegue AWS (ECS/EC2 + Atlas o DocumentDB).
- [ ] Limitar `API_CORS_ORIGIN` al dominio de produccion.
