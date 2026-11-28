# 01 · Diagramas de Actividades UML de Casos de Uso Críticos

**Proyecto:** Sistema de Control de Asistencia Académica con QR Dinámico (`asistencia-qr`)  
**Autor (GitHub):** `@estiben08`  
**RAP asociado:** 592373 · Realiza diagramas de actividades exponiendo detalles de los casos de uso (Criterio C1).

---

## 1. Archivos Entregados

Se entregan **3 diagramas de actividades UML** (superando el mínimo exigible de 2) correspondientes a los casos de uso críticos del negocio (`CU-03`, `CU-05` y `CU-08`), cada uno con nodo de inicio, nodo de fin, calles (*swimlanes*) por actor/sistema, decisiones con guardas entre corchetes (`[...]`) que cubren todas las salidas, barra de bifurcación y unión (*fork / join*) para acciones concurrentes, y correspondencia 1 a 1 con las ramas de las plantillas extendidas (`02-plantillas-casos-uso-extendidos.md`):

1. **Diagrama de Actividades 1 (`CU-03 Aperturar sesión de asistencia` + `CU-04`):**
   - Fuente editable Draw.io: [`01-actividad-cu03-apertura-sesion.drawio`](./01-actividad-cu03-apertura-sesion.drawio)
   - Imagen SVG: [`01-actividad-cu03-apertura-sesion.svg`](./01-actividad-cu03-apertura-sesion.svg)
   - Imagen PNG: [`01-actividad-cu03-apertura-sesion.png`](./01-actividad-cu03-apertura-sesion.png)
2. **Diagrama de Actividades 2 (`CU-05 Registrar asistencia por escaneo QR` + `CU-06`):**
   - Fuente editable Draw.io: [`01-actividad-cu05-registro-asistencia-qr.drawio`](./01-actividad-cu05-registro-asistencia-qr.drawio)
   - Imagen SVG: [`01-actividad-cu05-registro-asistencia-qr.svg`](./01-actividad-cu05-registro-asistencia-qr.svg)
   - Imagen PNG: [`01-actividad-cu05-registro-asistencia-qr.png`](./01-actividad-cu05-registro-asistencia-qr.png)
3. **Diagrama de Actividades 3 (`CU-08 Monitorear asistencia y cerrar sesión` + `CU-07` y `CU-10`):**
   - Imagen SVG: [`01-actividad-cu08-monitoreo-cierre.svg`](./01-actividad-cu08-monitoreo-cierre.svg)
   - Imagen PNG: [`01-actividad-cu08-monitoreo-cierre.png`](./01-actividad-cu08-monitoreo-cierre.png)

---

## 2. Diagrama de Actividades 1: `CU-03 Aperturar sesión de asistencia` (incluye `CU-04`)

![Diagrama de Actividades CU-03](./01-actividad-cu03-apertura-sesion.svg)

```mermaid
flowchart TD
  subgraph Calle_Instructor["Calle: Instructor"]
    INI((● Inicio)) --> A1["1. Solicitar apertura de sesión de asistencia"]
    A1 --> A2["2. Seleccionar ficha asignada y ambiente de formación"]
    A6["6. Proyectar código QR dinámico en pantalla del aula"] --> FIN((◉ Fin))
    ALT_REABRIR["3a.1 Confirmar reapertura o visualización de sesión existente"] --> A6
    EXC_RED["4b.1 Recibir aviso de red no institucional y corregir conexión"] --> FIN_EXC((◉ Fin sin apertura))
  end

  subgraph Calle_Sistema["Calle: Sistema de Control de Asistencia QR"]
    A2 --> D1{"¿Existe sesión previa de la ficha hoy?"}
    D1 -- "[no existe sesión hoy]" --> D2{"¿Red del aula identificable y válida?"}
    D1 -- "[sesión activa hoy -> Flujo Alterno 3a]" --> ALT_REABRIR
    D1 -- "[sesión ya cerrada hoy -> Excepción 3b]" --> EXC_CERRADA["3b.1 Informar que la jornada de la ficha ya fue cerrada hoy"]
    EXC_CERRADA --> FIN_EXC
    D2 -- "[red institucional válida]" --> FORK1["=== Barra de Bifurcación (Fork) ==="]
    D2 -- "[red inválida o sin IP local -> Excepción 4b]" --> EXC_RED
    FORK1 --> A3["4.1 Registrar sesión en estado Activa con subred del aula"]
    FORK1 --> A4["4.2 Generar primer código QR firmado con vigencia de 30 s (CU-04)"]
    A3 --> JOIN1["=== Barra de Unión (Join) ==="]
    A4 --> JOIN1
    JOIN1 --> A5["5. Activar temporizador de rotación cada 30 segundos"]
    A5 --> A6
  end
```

### Coherencia con la Plantilla Extendida `CU-03` y Justificación de Concurrencia:
- **Calles (*Swimlanes*):** `Instructor` y `Sistema de Control de Asistencia QR`.
- **Decisiones y guardas completas:**
  - Decisión 1 (`¿Existe sesión previa de la ficha hoy?`): `[no existe sesión hoy]` (flujo principal), `[sesión activa hoy]` (corresponde al **Flujo Alterno 3a** de la plantilla `CU-03`) y `[sesión ya cerrada hoy]` (corresponde a la **Excepción 3b** de la plantilla `CU-03`).
  - Decisión 2 (`¿Red del aula identificable y válida?`): `[red institucional válida]` (continúa al paso 4) y `[red inválida o sin IP local]` (corresponde a la **Excepción 4b** de la plantilla `CU-03`).
- **Concurrencia (`Fork / Join`):** Una vez validada la red del aula, el sistema ejecuta en paralelo (mediante bifurcación y unión) la creación del registro de sesión activa con la subred del aula y la generación criptográfica del primer código QR temporal (`CU-04`), uniendo ambos flujos antes de proyectar el QR en pantalla.

---

## 3. Diagrama de Actividades 2: `CU-05 Registrar asistencia por escaneo QR` (incluye `CU-06`)

![Diagrama de Actividades CU-05](./01-actividad-cu05-registro-asistencia-qr.svg)

```mermaid
flowchart TD
  subgraph Calle_Aprendiz["Calle: Aprendiz"]
    INI2((● Inicio)) --> B1["1. Escanear código QR proyectado en el aula"]
    B1 --> B2["2. Enviar solicitud de registro de asistencia con su identidad"]
    ALT_RENOVAR["4a.1 Escanear nuevo código QR recién rotado en pantalla"] --> B2
    B8["7. Visualizar comprobante de asistencia registrada"] --> FIN2((◉ Fin Exitoso))
    B_RECHAZO["Visualizar motivo de rechazo en pantalla móvil"] --> FIN2_ERR((◉ Fin Rechazado))
  end

  subgraph Calle_Sistema2["Calle: Sistema de Control de Asistencia QR (Validación CU-06)"]
    B2 --> B3["3. Verificar estado de la sesión y firma del código QR"]
    B3 --> D2_1{"¿Sesión activa y código QR vigente?"}
    D2_1 -- "[código rotó hace < 5 s -> Flujo Alterno 4a]" --> ALT_AVISO["4a. Solicitar reescaneo del nuevo código en pantalla"]
    ALT_AVISO --> ALT_RENOVAR
    D2_1 -- "[sesión cerrada o firma alterada -> Excepción 4b]" --> EXC2_1["4b. Rechazar por código inválido o sesión cerrada y auditar"]
    EXC2_1 --> B_RECHAZO
    D2_1 -- "[sesión activa y firma válida]" --> D2_2{"¿Misma subred local del aula?"}
    D2_2 -- "[subred diferente -> Excepción 5b]" --> EXC2_2["5b. Rechazar por ubicación fuera de la red del aula y auditar"]
    EXC2_2 --> B_RECHAZO
    D2_2 -- "[subred del aula coincide]" --> D2_3{"¿Tiene asistencia previa en la sesión?"}
    D2_3 -- "[ya tenía asistencia -> Flujo Alterno 6a]" --> ALT_DUP["6a. Informar que su asistencia ya estaba confirmada sin duplicar"]
    ALT_DUP --> B8
    D2_3 -- "[sin registro previo]" --> FORK2["=== Barra de Bifurcación (Fork) ==="]
    FORK2 --> B5["6.1 Asentar asistencia como Presente con hora exacta"]
    FORK2 --> B6["6.2 Actualizar contador en vivo del panel del instructor"]
    B5 --> JOIN2["=== Barra de Unión (Join) ==="]
    B6 --> JOIN2
    JOIN2 --> B8
  end
```

### Coherencia con la Plantilla Extendida `CU-05` y Justificación de Concurrencia:
- **Calles (*Swimlanes*):** `Aprendiz` y `Sistema de Control de Asistencia QR`.
- **Decisiones y guardas completas:**
  - Decisión 1 (`¿Sesión activa y código QR vigente?`): `[sesión activa y firma válida]`, `[código rotó hace < 5 s]` (**Flujo Alterno 4a**: el aprendiz reescanea el código recién actualizado y logra el objetivo) y `[sesión cerrada o firma alterada]` (**Excepción 4b**).
  - Decisión 2 (`¿Misma subred local del aula?`): `[subred del aula coincide]` y `[subred diferente]` (**Excepción 5b**).
  - Decisión 3 (`¿Tiene asistencia previa en la sesión?`): `[sin registro previo]` y `[ya tenía asistencia]` (**Flujo Alterno 6a**: el sistema le muestra su comprobante existente de forma idempotente sin crear duplicado).
- **Concurrencia (`Fork / Join`):** Al aprobar las tres validaciones, el sistema bifurca la confirmación para asentar la presencia del aprendiz con marca de tiempo y actualizar concurrentemente el tablero en vivo del instructor.

---

## 4. Diagrama de Actividades 3: `CU-08 Monitorear asistencia y cerrar sesión` (con `CU-07` y `CU-10`)

![Diagrama de Actividades CU-08](./01-actividad-cu08-monitoreo-cierre.svg)

```mermaid
flowchart TD
  subgraph Calle_Inst3["Calle: Instructor"]
    INI3((● Inicio)) --> C1["1. Consultar panel de monitoreo de la sesión activa"]
    C2["3. Revisar aprendices presentes, pendientes y rechazos"] --> D3_1{"¿Aprendiz en aula sin celular?"}
    D3_1 -- "[sí: contingencia en aula -> Flujo Alterno 3a / CU-07]" --> C_MAN["3a.1 Registrar asistencia manual indicando motivo de contingencia"]
    C_MAN --> C3["4. Solicitar cierre formal de la sesión de asistencia"]
    D3_1 -- "[no: todos escanearon]" --> C3
    C8["8. Visualizar resumen final de la sesión y alertas emitidas"] --> FIN3((◉ Fin))
  end

  subgraph Calle_Sis3["Calle: Sistema de Control de Asistencia QR"]
    C1 --> C1_S["2. Presentar listado en tiempo real de la ficha"]
    C1_S --> C2
    C3 --> D3_2{"¿Sesión sigue abierta al confirmar cierre?"}
    D3_2 -- "[sesión ya expirada por tiempo -> Flujo Alterno 5a]" --> C_EXP["5a. Consolidar cierre por expiración de jornada"]
    D3_2 -- "[error de comunicación al cerrar -> Excepción 5b]" --> C_ERR["5b. Conservar sesión activa e informar reintento al instructor"]
    C_ERR --> C2
    D3_2 -- "[sesión abierta]" --> C4["5. Invalidar código QR y cambiar estado de sesión a Cerrada"]
    C_EXP --> C5["6. Marcar como Inasistentes a los aprendices matriculados sin registro"]
    C4 --> C5
    C5 --> D3_3{"¿Algún inasistente acumula >= 3 fallas?"}
    D3_3 -- "[acumula >= 3 inasistencias -> CU-10]" --> C6["7a. Generar alerta temprana de deserción para seguimiento"]
    D3_3 -- "[menos de 3 inasistencias]" --> C7["7. Consolidar totales de asistencia de la jornada"]
    C6 --> C7
    C7 --> C8
  end
```
