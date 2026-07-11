# Checklist Funcional

## Preparacion

- [ ] Docker Desktop activo.
- [ ] `.env` creado desde `.env.example`.
- [ ] `npm run install:all` ejecutado.
- [ ] `npm run docker:up` activo.
- [ ] `npm run docker:seed` ejecutado.
- [ ] `GET /ready` responde `ready`.

## Flujo SENA (Exigencias Funcionales)

- [ ] Configurar URL backend (EF-05: autenticacion JWT requerida).
- [ ] Seleccionar SENA.
- [ ] Ver rol Instructor.
- [ ] Ver unidades como Ficha.
- [ ] Ver personas como Aprendices.
- [ ] Crear sesion sobre una ficha (EF-01: crear sesion draft y activar QR temporal).
- [ ] Activar QR (EF-02: proyectar codigo QR para escaneo).
- [ ] Registrar documento valido SENA desde el QR (EF-06: aviso visual de confirmacion).
- [ ] Ver presente en la app (EF-04: actualizacion en tiempo real cada 10s).
- [ ] Reintentar mismo documento y ver rechazo duplicado (EF-03: bloqueo de doble asistencia).
- [ ] Cerrar sesion (EF-06: base de datos centralizada con historial).
- [ ] Intentar registrar despues del cierre y ver rechazo (EF-03: validacion de sesion activa).

## Flujo CORHUILA / Universidad

- [ ] Seleccionar CORHUILA.
- [ ] Ver rol Docente.
- [ ] Ver unidades como Materia.
- [ ] Ver personas como Estudiantes.
- [ ] Crear sesion sobre una materia.
- [ ] Registrar estudiante inscrito.
- [ ] Registrar estudiante de otra materia y ver rechazo (EF-03: validacion de pertenencia).
- [ ] Ver presentes, ausentes y rechazados.
- [ ] Ver historial.
- [ ] Exportar reporte Excel multi-sesion.

## Tunel

- [ ] Exponer `http://localhost:4000`.
- [ ] Configurar URL publica en la app.
- [ ] Validar `/health` y `/ready` desde la app.
- [ ] Generar QR con URL publica.
- [ ] Abrir QR desde otro celular.
