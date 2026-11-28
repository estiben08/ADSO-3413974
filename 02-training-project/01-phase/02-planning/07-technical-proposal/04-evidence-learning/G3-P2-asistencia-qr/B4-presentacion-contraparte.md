# B4 · Presentación de la Propuesta Técnica y Estrategia de Negociación con la Contraparte

**Proyecto:** Sistema de Control de Asistencia Académica con QR Dinámico (`asistencia-qr`)  
**Autor / Proponente (GitHub):** `@estiben08` · **Ficha:** 3413974  
**Contraparte:** Coordinación Académica y de Infraestructura TI (`@coordinacion-academica-cies`)  
**RAP asociado:** 593061 (03) · Realiza la presentación de la propuesta según propósitos de la negociación (Criterio C4).

---

## 1. Declaración del Propósito y Estrategia de Negociación (Método Harvard — Negociación por Intereses)

Antes de iniciar la sesión con la contraparte, se definen formalmente los cuatro parámetros estratégicos de la negociación:

| Parámetro de Negociación | Definición Cuantificada y Técnica para `asistencia-qr` (Variante B) |
|---|---|
| **1. Objetivo de la Negociación** | Lograr la aprobación técnica, económica y contractual de la propuesta `asistencia-qr` para las **2 sedes** (120 usuarios, 30 concurrentes), acordando el alcance, el ANS (`>= 99,5 %`) y el cronograma de 45 días hábiles sin comprometer la calidad arquitectónica ni la seguridad antifraude. |
| **2. Posición Ideal (Oferta Inicial `v1.0`)** | Firma por el valor de la Oferta Base `v1.0`: **`$41.019.860 COP` con IVA incluido** (Año 1), plazo de **45 días hábiles**, disponibilidad mensual del **`99,5 %`**, tiempo de respuesta `p95 <= 1,5 s`, `RPO <= 24 h` (1 backup diario) y margen comercial del **`15 %`**. |
| **3. Posición Mínima de Reserva (Límite Inferior Aceptable)** | Precio total Año 1 no inferior a **`$38.500.000 COP` con IVA** (margen mínimo del `10 %` sobre costos reales) o absorción parcial de hasta **22 horas adicionales** de mejoras de valor para el cliente (como segundo backup diario `RPO <= 12 h` y código de sala rotativo `CSR` para aprendices sin cámara) por un ajuste controlado a **`$43.841.352 COP` con IVA** (`v1.1`, manteniendo más de `$26.158.648 COP` de ahorro bajo el tope de `$70.000.000 COP`), con plazo máximo de **48 días hábiles**. |
| **4. Mejor Alternativa a un Acuerdo Negociado (MAPAN / BATNA)** | - **MAPAN del Proponente (`@estiben08`):** Si el cliente exige recortar el presupuesto por debajo del costo directo (`$29.299.900 COP`) o eliminar los 4 APs WiFi 6 (`FT-HW-02`), ofrecer la **Modalidad Solo-Software + Nube (`SaaS Institucional`)** por **`$33.850.000 COP` con IVA**, dejando la red WiFi física bajo responsabilidad y riesgo exclusivo de la infraestructura actual del cliente.<br>- **MAPAN del Cliente:** Contratar un software comercial SaaS genérico de control biométrico o de turnos por suscripción por usuario (`~$35.000 COP/usuario/mes × 120 usuarios = $50.400.000 COP/año` recurrentes sin propiedad del código ni validación de subred de aula), el cual resulta `2,6 veces` más costoso a 36 meses que nuestra propuesta (`$151,2 M` vs. `$58,07 M`). |

---

## 2. Estructura de las 10 Diapositivas y Guion de Sustentación (10 Minutos · Orden del Interés del Cliente)

La presentación sigue estrictamente la secuencia orientada al valor del negocio: **(1) Problema → (2) Beneficio cuantificado → (3) Solución y Arquitectura → (4) Costo y TCO → (5) Plazo y Ruta Crítica → (6) Riesgos y Garantías → (7) Siguientes Pasos**.

---

### Diapositiva 1 · Portada y Propósito del Encuentro (Minuto 0:00 – 0:45)
- **Contenido visual:**
  - Título: *Propuesta Técnica y Económica: Sistema de Control de Asistencia QR Zero-Trust (`asistencia-qr`) para 2 Sedes*.
  - Parámetros Variante B: `120 Usuarios Totales` · `30 Concurrentes Pico` · `2 Sedes` · `Meta ANS: 99,5 %`.
  - Proponente: `@estiben08` · Ficha 3413974.
- **Guion oral:** *"Buenos días. Hoy presentamos la propuesta técnica y económica para transformar el control de asistencia en las 2 sedes de formación, garantizando que los 120 usuarios y hasta 30 aprendices simultáneos registren su asistencia en menos de 90 segundos con cero suplantación remota y ahorrando más del 40 % respecto a su tope presupuestal."*

---

### Diapositiva 2 · El Problema Actual y su Costo Oculto en las 2 Sedes (Minuto 0:45 – 1:45)
- **Contenido visual:**
  - `12 a 15 minutos` perdidos por clase en planillas de papel = **`384 horas de clase perdidas al año`** en las 2 sedes (`1.920 sesiones/año`).
  - Fraude en formularios web simples: el enlace o captura del QR se reenvía por WhatsApp a aprendices fuera de la sede.
  - Detección tardía de deserción: las 3 inasistencias se descubren semanas después.
- **Guion oral:** *"El problema no es solo tecnológico, es pedagógico y administrativo: 12 minutos pasando lista por sesión equivalen a 384 horas de formación perdidas al año en las dos sedes. Y cuando se usa un formulario web normal, basta compartir el enlace por WhatsApp para marcar asistencia desde la casa."*

---

### Diapositiva 3 · Beneficio Directo para el Negocio e Indicadores de Impacto (Minuto 1:45 – 2:45)
- **Contenido visual:**
  - **Tiempo de registro en aula:** De `12 min` → **`< 90 segundos`** (`-88 %` de tiempo operativo).
  - **Bloqueo de suplantación remota:** **`100 %`** de intentos fuera del WiFi del aula rechazados y auditados.
  - **Alertas tempranas de deserción:** De `30 días de retraso` → **Instantáneas al cierre de sesión** (`>= 3 fallas`).
  - **Cero fricción móvil:** `0 aplicaciones nativas` que instalar (funciona desde el navegador del celular).
- **Guion oral:** *"Con `asistencia-qr` recuperamos más de 330 horas efectivas de clase al año, bloqueamos de raíz el fraude externo y entregamos a coordinación y Bienestar las alertas de deserción el mismo día en que un aprendiz cumple su tercera falla."*

---

### Diapositiva 4 · Cómo Funciona la Solución: Triple Candado Zero-Trust (Minuto 2:45 – 4:00)
- **Contenido visual:**
  - **Candado 1 (Tiempo):** Código QR dinámico en el proyector del aula que **rota cada 30 segundos** (`CU-04`).
  - **Candado 2 (Criptografía):** Firma digital **`HMAC-SHA256`** de 64 caracteres imposible de falsificar (`RF-05`).
  - **Candado 3 (Ubicación de Red):** Validación de **Subred IP local (`192.168.X.0/24`)** que comprueba que el celular del aprendiz está conectado al Punto de Acceso WiFi 6 del salón (`CU-06`).
  - **Válvula de contingencia en aula:** Registro manual auditado por el instructor cuando un aprendiz presente no tiene batería o cámara (`CU-07`).
- **Guion oral:** *"¿Cómo evitamos que una foto del QR enviada por WhatsApp funcione? Con tres candados simultáneos: el QR caduca cada 30 segundos, lleva una firma HMAC-SHA256 verificada en el servidor, y el validador comprueba que la IP del celular pertenezca a la misma subred WiFi del aula."*

---

### Diapositiva 5 · Arquitectura en 3 Capas e Infraestructura para 2 Sedes (Minuto 4:00 – 5:15)
- **Contenido visual:**
  - Diagrama integrado [`B3-diagrama-arquitectura-despliegue.svg`](./B3-diagrama-arquitectura-despliegue.svg) (`Nodo 1 PC Aula`, `Nodo 2 4 APs WiFi 6 TP-Link EAP650`, `Nodo 3 VPS Cloud DigitalOcean Ubuntu + Nginx TLS 1.3 + Gunicorn 4 workers`, `Nodo 4 MySQL 8.0 11 tablas 3FN + Pool 20 conexiones`).
- **Guion oral:** *"La arquitectura separa presentación, lógica con patrones GoF y base de datos relacional en 11 tablas normalizadas en 3FN. Gracias al pool de 20 conexiones pre-abiertas y los 4 puntos de acceso WiFi 6 en las dos sedes, 30 aprendices escaneando al mismo tiempo reciben respuesta en menos de 1,5 segundos."*

---

### Diapositiva 6 · Comparativo de Proveedores y Cumplimiento Legal (Minuto 5:15 – 6:15)
- **Contenido visual:**
  - Selección objetiva por matriz ponderada y TCO a 36 meses (`B1`):
    - **Nube (`FT-HW-01`):** DigitalOcean Droplet Premium NVMe (`$6,49 M` TCO 36M) vs. AWS Lightsail (`$7,51 M`) y Azure (`$10,15 M`).
    - **Red WiFi 6 (`FT-HW-02`):** 4 APs TP-Link Omada EAP650 (`$4,17 M` TCO 36M) vs. Ubiquiti U6-Pro (`$4,88 M`) y Aruba AP22 (`$5,40 M`).
  - Cumplimiento normativo verificado (`A3`): **Ley 1581 de 2012** (datos personales), **Ley 23 de 1982** y **Decisión Andina 351** (derecho de autor y código 100 % libre de riesgo GPLv2 usando `PyMySQL` MIT).
- **Guion oral:** *"Cada proveedor fue elegido tras comparar tres alternativas reales a 36 meses. Además, reemplazamos el conector GPLv2 por PyMySQL bajo licencia MIT para que la institución reciba el sistema sin riesgos legales ni cobros ocultos por licencia."*

---

### Diapositiva 7 · Presupuesto Transparente y Comparación con el Tope de la Variante B (Minuto 6:15 – 7:30)
- **Contenido visual:**
  - **Subtotal Costos (6 Categorías: Software `$20,99 M` + Hardware/Nube `$5,86 M`):** `$26.854.900 COP`.
  - **Reserva de Contingencia (Suma EMV de 7 riesgos = `9,10 %`):** `$2.445.000 COP`.
  - **Precio de Venta antes de IVA (Margen `15 %`):** `$34.470.471 COP`.
  - **IVA (`19 %`):** `$6.549.389 COP`.
  - **OFERTA TOTAL AÑO 1 CON IVA (`v1.0`):** **`$41.019.860 COP`** vs. **Tope Variante B: `$70.000.000 COP`** (**Ahorro: `$28.980.140 COP`**).
  - **Operación anual Años 2 y 3 (con IVA):** Solo **`$8.526.385 COP / año`** (TCO total 36 meses con IVA: `$58.072.630 COP`).
- **Guion oral:** *"Nuestra oferta total para el primer año, incluyendo desarrollo, los 4 puntos de acceso WiFi 6 instalados en las 2 sedes, servidor cloud, capacitación, contingencia, margen e IVA del 19 %, es de $41.019.860 COP: casi 29 millones por debajo de su tope de 70 millones. Y a partir del segundo año, mantener todo el sistema operando con soporte y nube cuesta solo $8,52 millones al año."*

---

### Diapositiva 8 · Cronograma Scrum (45 Días Hábiles) y Ruta Crítica Calculada (Minuto 7:30 – 8:30)
- **Contenido visual:**
  - **4 Sprints / 12 Tareas EDT (`T-01` a `T-12`):**
    - *Hito 1 (Día 4):* Especificaciones y orden de compra de red (`30 %` pago inicial).
    - *Hito 2 (Día 13):* Entorno Cloud y Base de Datos MySQL 11 tablas activos.
    - *Hito 3 (Día 32):* Motor QR dinámico, validador Zero-Trust y red WiFi 6 en 2 sedes (`40 %` segundo pago).
    - *Hito 4 (Día 45):* Pruebas de carga, capacitación y salida en vivo (`30 %` pago final).
  - **Holgura de compras físicas:** `10 días de holgura` en la instalación de los APs WiFi 6 (`T-03`).
- **Guion oral:** *"El proyecto dura 45 días hábiles divididos en 4 Sprints con entregables verificables. Calculamos la ruta crítica y dejamos 10 días de holgura en la entrega física de los equipos de red para que ningún trámite logístico retrase la salida a producción."*

---

### Diapositiva 9 · Matriz de Riesgos, ANS (99,5 %) y Garantías (Minuto 8:30 – 9:15)
- **Contenido visual:**
  - **7 riesgos cuantificados (`R1` a `R7`)** respaldados por `$2.445.000 COP` de reserva de contingencia.
  - **Acuerdo de Nivel de Servicio (`ANS / SLA`):** Disponibilidad mensual `>= 99,5 %`, respuesta en validación QR `p95 <= 1,5 s`, `RPO <= 24 h` (ajustable a `12 h`), `RTO <= 2 h`.
  - **Garantía:** `12 meses` en software y hardware + simulacro mensual de restauración con acta.
- **Guion oral:** *"Respaldamos la operación con un Acuerdo de Nivel de Servicio medible: 99,5 % de disponibilidad mensual, respuesta inferior a 1,5 segundos en hora pico, 12 meses de garantía y pruebas mensuales de restauración de copias de seguridad."*

---

### Diapositiva 10 · Decisiones del Comité y Siguientes Pasos (Minuto 9:15 – 10:00)
- **Contenido visual:**
  1. Revisión y registro de sugerencias de la contraparte en el **Acta de Validación (`B5`)**.
  2. Emisión inmediata de la versión ajustada **`v1.1` (`B7`)** incorporando las mejoras acordadas.
  3. Firma de orden de inicio e Hito 1.
- **Guion oral:** *"Estamos dentro del plazo, muy por debajo del tope de 70 millones y con todos los diseños y el modelo de base de datos ya verificados. Escuchamos ahora sus observaciones y sugerencias para dejarlas consignadas en el acta de validación y emitir la versión definitiva 1.1."*

---

## 3. Anticipación de 4 Objeciones del Cliente con su Respuesta Técnica y Económica (Mínimo Exigible: 3)

| # | Objeción Anticipada de la Contraparte | Respuesta Argumentada con Cifras y Beneficio para el Negocio |
|---|---|---|
| **Objeción 1** | *«¿Qué pasa si varios aprendices tienen el teléfono con la cámara dañada o muy antigua y no pueden enfocar el código QR en el televisor del salón?»* | **Respuesta:** Además del registro manual por contingencia del instructor (`CU-07`), podemos incorporar en la versión ajustada `v1.1` un **Código de Sala Rotativo (`CSR`) alfanumérico de 6 caracteres** proyectado debajo del QR que rota al mismo tiempo y exige las mismas 3 validaciones (sesión activa, vigencia temporal y **misma subred IP del aula**). El costo incremental es de solo `12 horas ($660.000 COP de costo directo)` y elimina al 100 % la dependencia de la cámara sin abrir ninguna brecha de seguridad. |
| **Objeción 2** | *«Un respaldo diario (`RPO <= 24 horas`) significa que si el servidor falla a las 5:00 p. m., podríamos perder las asistencias tomadas en la jornada de la mañana. ¿Podemos bajar el RPO a 12 horas o menos?»* | **Respuesta:** Totalmente viable. Podemos programar en `v1.1` **dos respaldos transaccionales cifrados al día** (uno al cierre de la jornada mañana a las `12:30 p. m.` y otro al cierre nocturno a las `11:30 p. m.`) más replicación de logs binarios, reduciendo el **`RPO` de 24 horas a `<= 12 horas`** y elevando la disponibilidad del ANS del **`99,5 %` al `99,6 %`**, por un incremento en almacenamiento S3 de apenas `$12.000 COP/mes ($144.000/año)`. |
| **Objeción 3** | *«¿Por qué debemos comprar los 4 Puntos de Acceso WiFi 6 (`$2.580.000`) y 2 Switches (`$1.900.000`) si las sedes ya tienen routers WiFi domésticos?»* | **Respuesta:** Porque un router doméstico colapsa cuando **30 teléfonos envían peticiones TLS en los mismos 15 segundos** y no soporta etiquetado de subred por `VLAN 802.1Q`. Sin los 4 APs WiFi 6 empresariales (`TP-Link Omada EAP650`, que soportan `250+` clientes y `OFDMA`), el tiempo de respuesta superaría los `1,5 segundos` y se presentarían falsos rechazos de IP (`Riesgo R1 y R2`). Con una inversión única de `$4,48 millones`, garantizamos 3 años de operación estable en las 2 sedes sin pagar licencias anuales de red. |
| **Objeción 4** | *«¿Podemos eliminar la validación de subred IP para que los aprendices puedan registrar asistencia con sus propios datos móviles (4G/5G) cuando no quieran conectarse al WiFi del SENA?»* | **Respuesta (Objeción que se rechaza técnicamente protegiendo el interés del cliente):** Si permitiéramos marcar asistencia desde redes de datos móviles (4G/5G de operadores públicos), **se destruiría el control antifraude principal del proyecto**: cualquier aprendiz en su casa con datos móviles recibiría una foto del QR por WhatsApp dentro de los 30 segundos y marcaría asistencia sin estar en la sede. La solución correcta para no depender de un único router es precisamente la red local WiFi 6 dedicada en aula que funciona incluso si cae la salida hacia otros portales externos. |
