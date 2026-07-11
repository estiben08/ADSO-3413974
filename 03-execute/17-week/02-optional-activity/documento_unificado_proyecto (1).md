# Especificación del Proyecto: Sistema de Asistencia SENA

## 1. Planteamiento General
Se requiere un sistema que permita registrar asistencia de la manera más eficiente (sin tener en cuenta la integración automática con Sofia Plus).

## 2. Solución Propuesta
Se propone una solución mediante una aplicación web que agiliza el proceso de toma de asistencia y mejora el control de esta mediante los siguientes ítems:
1. Autenticación de usuarios.
2. Generación de un código QR dinámico, cambiante cada 5 minutos, para la sesión de formación.
3. Restricción por red institucional del SENA.
4. Un registro único por aprendiz para cada clase.
5. Control de historial de asistencia.

---

## 3. Funcionalidad y Flujo del Sistema

### 3.1. Registro de Asistencia — Instructor
1. Inicia la sesión de formación en el sistema.
2. Genera un QR temporal (cambia automáticamente cada 5 minutos).
3. Habilita el registro durante el tiempo indicado.
4. Al cerrarse la ventana de tiempo, el sistema marca automáticamente como "inasistente" a quien no se registró. El instructor puede corregir este estado manualmente después (ej. aprendiz sin celular).

### 3.2. Registro de Asistencia — Aprendiz
1. Se conecta al internet institucional del SENA.
2. Escanea el QR proyectado por el instructor.
3. Accede con sus credenciales en la página a la que dirige el QR.
4. El sistema valida al momento de enviar el formulario:
   - Que la sesión esté activa.
   - Que el QR escaneado corresponda al vigente en ese instante (si caducó, solicita volver a escanear).
   - Que se encuentre en la red institucional (verificando la IP pública).
   - Que no haya registrado asistencia exitosamente para esa formación anteriormente.

### 3.3. Registro Inicial de Aprendices (Importación)
1. El instructor copia los listados desde Sofia Plus (separados por *enters*).
2. Los pega en el sistema.
3. **El sistema:**
   - Los registra con su número de documento.
   - Si un documento ya existe, lo asocia a la ficha actual sin duplicar el registro.
   - Valida el formato de cada línea (documento numérico, sin espacios) e informa cuáles líneas no se pudieron procesar.

### 3.4. Consulta de Historial
El instructor puede consultar la asistencia por ficha, aprendiz o rango de fechas, ver totales de asistentes/inasistentes, y corregir registros manualmente.

---

## 4. Seguridad y Control de Riesgos

### 4.1. QR Dinámico con Firma Digital
- **Mecanismo:** Cada sesión genera un código QR que cambia cada 5 minutos. El QR no es un texto simple, contiene un token (JWT) firmado digitalmente con la clave privada del servidor (HMAC-SHA256 o RS256).
- **Prevención:** Evita la reutilización de códigos antiguos. Es imposible falsificar un QR sin la clave privada del servidor.

### 4.2. Restricción por Red Institucional
- **Mecanismo:** Solo dispositivos conectados a la IP pública asignada a la sede pueden registrar asistencia.
- **Prevención:** Evita registros desde casa u otras ubicaciones. *Nota: La opción para desactivar esto es exclusiva del administrador y genera un log de auditoría.*

### 4.3. Doble Factor frente a Suplantación
- **Mecanismo:** Se exige escanear el QR vigente Y autenticarse con credenciales propias simultáneamente.
- **Prevención:** Compartir el QR por WhatsApp no sirve, ya que la otra persona necesitaría también el usuario y contraseña del aprendiz ausente.

### 4.4. Control de Registro Único
- **Mecanismo:** Se permiten reintentos fallidos (por QR vencido, red incorrecta o credenciales erróneas). Sin embargo, una vez logrado un **registro exitoso**, cualquier intento posterior es rechazado inmediatamente mostrando un mensaje de error genérico.
- **Prevención:** Evita la duplicación de registros o la manipulación de estadísticas por parte del aprendiz.

### 4.5. Mitigación de Riesgos Específicos
- **Compartir el QR:** Mitigado por el tiempo de expiración corto (5 min) y el doble factor (QR + Credenciales).
- **Caída de la Red del SENA:** Mitigado con registro manual y **Modo sin conexión** (guardado local en el navegador del instructor con sincronización posterior automática).
- **Aprendiz sin celular:** Registro manual por parte del instructor con el número de documento.
- **QR refrescado durante registro:** El sistema avisa y solicita volver a escanear.

---

## 5. Mejoras Propuestas (Valor Agregado)

1. **Sistema de Alertas Tempranas de Deserción:** El sistema calcula porcentajes de asistencia. Si un aprendiz tiene tendencia descendente (ej. inasistió 3 sesiones consecutivas o bajó 10% en dos semanas), genera una alerta automática al instructor.
2. **Panel de Administración Separado:** Para gestión de usuarios, vista global de fichas, configuración de IPs/Tiempos, y un log de auditoría completo.
3. **Modo Sin Conexión (Offline):** Capacidad del navegador del instructor de seguir capturando datos si se cae el internet, sincronizando con el servidor al volver la conexión.

---

## 6. Actores del Sistema

| Actor                    |      Descripción                                                   |
| :------------------------| :----------------------------------------------------------------- |
| **Aprendiz**             | Escanea el QR para registrar su asistencia a las sesiones.         |
| **Instructor**           | Administra sus fichas, genera el QR, carga aprendices y supervisa. |
| **Administrador**        | Gestiona el sistema globalmente (IPs, roles, auditoría).           |
| **Sistema (Automático)** | Ejecuta tareas de fondo (refresco QR, alertas, sincronización).    |

---

## 7. Casos de Uso Principales (CU)

- **CU01 - Generar Sesión y QR:** El Instructor inicia sesión; el sistema genera un QR firmado que cambia cada 5 min.
- **CU02 - Registrar Asistencia vía QR:** El Aprendiz escanea, se autentica y el sistema valida reglas (red, QR vigente, duplicidad).
- **CU03 - Registrar Asistencia Manual:** El Instructor asiste manualmente a un aprendiz (ej. si no tiene celular).
- **CU04 - Cierre de Sesión Automático:** El Sistema marca como "inasistentes" a quienes no registraron asistencia al cierre.
- **CU05 - Importar Listado:** El Instructor pega datos de Sofia Plus; el sistema asocia o crea aprendices ignorando duplicados.
- **CU06 - Consultar Historial:** El Instructor consulta reportes de asistencia mediante filtros.
- **CU07 - Gestionar Configuración:** El Administrador ajusta IPs válidas, tiempos de expiración y umbrales de alerta.
- **CU08 - Sincronización Offline:** El Sistema guarda datos sin red y los sincroniza al recuperar la conexión.
- **CU09 - Alerta de Deserción:** El Sistema notifica al instructor basándose en algoritmos de tendencias de inasistencia.

---

## 8. Especificación de Requerimientos

### 8.1. Requerimientos Funcionales (RF)
*   **RF01:** El sistema debe permitir la autenticación basada en roles (Aprendiz, Instructor, Administrador).
*   **RF02:** El sistema debe generar un QR único por sesión y actualizarlo automáticamente cada 5 minutos.
*   **RF03:** El sistema debe validar que la IP pública del aprendiz coincida con la red configurada del SENA al momento de registrar.
*   **RF04:** El sistema debe impedir registros duplicados de un mismo aprendiz en una misma sesión.
*   **RF05:** El sistema debe permitir al instructor la carga masiva de documentos numéricos separados por salto de línea.
*   **RF06:** El sistema debe poseer un Modo Offline para guardar registros de asistencia en el navegador temporalmente.
*   **RF07:** El sistema debe calcular porcentajes de asistencia y generar alertas de riesgo de deserción al instructor.
*   **RF08:** El sistema debe permitir al Administrador desactivar la restricción de red temporalmente, registrando el evento en un log.
