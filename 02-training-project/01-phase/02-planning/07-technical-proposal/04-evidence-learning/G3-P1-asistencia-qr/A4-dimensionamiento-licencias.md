# A4 · Dimensionamiento de Licencias, Inventario de Dependencias y Propiedad Intelectual

**Proyecto:** Sistema de Control de Asistencia Académica con QR Dinámico (`asistencia-qr`)  
**Autor (GitHub):** `@estiben08` · **Ficha:** 3413974  
**Variante del escenario aplicada:** **Variante B** (`U_tot = 120` usuarios totales, `U_conc = 30` usuarios concurrentes pico, `S = 2` sedes, disponibilidad `99,5 %`, TRM `= $4.000 COP/USD`).  
**RAP asociado:** 593060 (01) · Dimensiona las licencias de software de acuerdo con las características de la solución y las necesidades de la empresa (Criterio C4).

---

## 1. Tabla de Dimensionamiento de Licencias por Componente (7 Componentes · Mínimo Exigible: 6)

Cada cantidad se calcula mediante **fórmula explícita derivada de los parámetros de la Variante B** (`U_tot = 120`, `U_conc = 30`, `S = 2`, equipo de desarrollo `D = 2`):

| # | Componente Tecnológico | Categoría | Tipo de Licencia | Modelo de Cobro | Fórmula de Cálculo de Cantidad (desde Variante B) | Cantidad Calculada | Costo Unitario y Periodicidad (COP, sin IVA) | Costo a 12 Meses / 36 Meses (COP) | Obligación Legal y Técnica de Cumplimiento |
|---|---|---|---|---|---|---|---|---|---|
| **1** | **Ubuntu Server 24.04 LTS (64-bit)** | Sistema Operativo Servidor (`Nodo 3` y `Nodo 4`) | Código Abierto (**GPLv2 / Licencias POSIX**) | Gratuita por instancia (sin cobro por núcleo ni por CAL de usuario) | `N_instancias = ceil(U_conc / 60) = ceil(30 / 60) = 1 instancia central para las S = 2 sedes` | **1 instancia servidor** | `$0` (Único / Recurrente) | `$0` (12M) / `$0` (36M) | Mantener avisos de copyright originales; no conlleva obligación copyleft sobre aplicaciones que se ejecutan en espacio de usuario. |
| **2** | **MySQL 8.0 Community Edition** | Motor de Base de Datos Relacional (`Nodo 4`) | Código Abierto (**GPLv2**) | Gratuita para uso interno institucional / servidor sin redistribución comercial del motor modificado | `N_motores = 1 motor centralizado` con `Pool = ceil(U_conc * 0,66) = 20 conexiones persistentes` | **1 motor BD (20 conexiones en pool)** | `$0` (Recurrente) | `$0` (12M) / `$0` (36M) | **Obligación GPLv2:** Si se distribuye el software a un tercero junto con el conector GPL, aplica copyleft salvo que se use la *Universal FOSS Exception* o un conector MIT (`PyMySQL`, ver §2). |
| **3** | **Python 3.12 + Flask 3.0 Framework** | Lenguaje POO y Framework Web (`Nodo 3`) | Código Abierto Permisiva (**PSF License + BSD-3-Clause**) | Gratuita sin límite de núcleos, nodos ni usuarios concurrentes | `N_workers = (2 * vCPU) + 1 = (2 * 2) + 1 = 5 procesos (4 workers activos + 1 maestro) para U_conc = 30` | **1 entorno (4 workers WSGI para 120 usuarios)** | `$0` (Recurrente) | `$0` (12M) / `$0` (36M) | **Atribución (BSD-3 / PSF):** Conservar el aviso de copyright y la cláusula de exención de garantía en la documentación técnica; permite uso comercial y privado sin liberar código propio. |
| **4** | **Nginx 1.26 + Gunicorn 22.0 + Let's Encrypt TLS** | Servidor Web Proxy Inverso, WSGI y Certificado TLS 1.3 (`Nodo 3`) | Código Abierto Permisiva (**BSD-2-Clause + MIT**) | Gratuita (certificado TLS X.509 automatizado vía protocolo ACME) | `N_proxy = 1 proxy inverso` que termina TLS para las `S = 2 sedes` y `U_tot = 120 usuarios` | **1 instancia proxy + 1 certificado TLS wildcard/dominio** | `$0` (Certificado) + `$80.000 / año` (Dominio `.co` institucional) | `$80.000` (12M) / `$240.000` (36M) | **Atribución (BSD-2 / MIT):** Conservar licencia en distribución; renovar automáticamente el certificado TLS cada 90 días mediante `certbot`. |
| **5** | **VS Code + Draw.io Desktop + Git + DBeaver Community** | Herramientas de Desarrollo, Modelado UML/MER y Gestión BD | Código Abierto / Freeware (**MIT + Apache-2.0**) | Gratuita para uso individual, académico y comercial | `N_puestos_dev = D = 2 puestos de desarrollo/mantenimiento` | **2 licencias de puesto de desarrollo** | `$0` (Recurrente) | `$0` (12M) / `$0` (36M) | Cumplir términos de licencia Apache-2.0 y MIT; no empaquetar binarios de las herramientas dentro del entregable al cliente. |
| **6** | **Suscripción VPS Cloud Administrado (2 vCPU, 4 GB RAM, 80 GB NVMe + Backups)** | Hosting / Nube e Infraestructura de Operación (`FT-HW-01`) | Suscripción Comercial Cloud (**Términos de Servicio IaaS**) | Suscripción mensual por capacidad de cómputo y almacenamiento (USD convertido a TRM `$4.000/USD`) | `N_vps = ceil(U_conc / 40) = ceil(30 / 40) = 1 nodo VPS` + `20 %` de sobrecosto por backups automáticos (`$24 USD + $4,8 USD = $28,8 USD/mes ≈ $115.200 COP/mes`) | **1 suscripción anual (12 meses/año) para 2 sedes** | `$115.200 / mes` (`$28,8 USD × $4.000`) | `$1.382.400` (12M) / `$4.147.200` (36M) | Cumplir la Política de Uso Aceptable (AUP) del proveedor cloud, mantener pago mensual/anual vigente y no alojar tráfico ilícito. |
| **7** | **GitHub (Repositorio + GitHub Actions CI/CD) y Controladora WiFi Omada/UniFi OS** | Control de Versiones, Integración Continua y Gestión de Red (`FT-HW-02`) | Freemium / Incluida en Hardware (**Plan Free 2.000 min/mes + Firmware embebido**) | Gratuita dentro de la cuota de 2.000 minutos/mes de CI/CD; controladora WiFi sin licencia anual por AP | `Minutos_CI_mes = 20 despliegues/mes * 4 min = 80 min/mes <= 2.000 min`; `Licencias_AP = S * 2 = 4 APs (sin cobro anual)` | **1 cuenta org + 4 licencias perpetuas embebidas en APs** | `$0 / mes` | `$0` (12M) / `$0` (36M) | No superar 2.000 min/mes de ejecución en repositorios privados; no almacenar datos personales reales ni secretos en el repositorio. |
| | **TOTAL LICENCIAS Y SUSCRIPCIONES DE SOFTWARE/NUBE** | | | | | | | **`$1.462.400` (12M)** / **`$4.387.200` (36M)** | |

---

## 2. Inventario de Dependencias del Código Fuente y Alerta de Compatibilidad (6 Dependencias · Mínimo Exigible: 5)

A partir del archivo `requirements.txt` y la sección 27 de `03-execute/19-week/02-optional-activity/SRC.docx`, se auditan las **6 dependencias directas del código Python** verificando su licencia, obligaciones y compatibilidad con el software propio:

| # | Librería / Paquete (`requirements.txt`) | Versión | Licencia Exacta | Tipo de Licencia | Uso en `asistencia-qr` | ¿Compatible con Licencia Propia (MIT / Cesión)? | Alerta de Compatibilidad y Acción / Costo de Reemplazo (Anexo D) |
|---|---|---|---|---|---|---|---|
| **1** | `Flask` | `3.0.3` | **BSD-3-Clause** | Permisiva | Enrutamiento HTTP, Blueprints MVC y sesiones firmadas (`Capa 1`). | **Sí (100 % compatible)** | Sin restricción copyleft. Solo exige mantener el aviso de copyright de Pallets en `THIRD_PARTY_NOTICES.txt`. |
| **2** | `Werkzeug` | `3.0.3` | **BSD-3-Clause** | Permisiva | Utilidades WSGI y módulo criptográfico de hash de contraseñas con sal. | **Sí (100 % compatible)** | Sin restricción copyleft. Exige conservar aviso de copyright BSD-3. |
| **3** | `qrcode` | `7.4.2` | **BSD-3-Clause** | Permisiva | Generación matricial 2D de los códigos QR rotativos cada 30 s (`CU-04`). | **Sí (100 % compatible)** | Sin restricción copyleft. Exige conservar aviso de copyright BSD-3. |
| **4** | `Pillow` (`PIL`) | `10.4.0` | **MIT-CMU (HPND)** | Permisiva | Renderizado de imagen PNG/SVG del código QR proyectado en el aula. | **Sí (100 % compatible)** | Sin restricción copyleft. Compatible con cualquier licencia comercial o abierta. |
| **5** | `bcrypt` | `4.1.3` | **Apache-2.0** | Permisiva | Derivación de hash seguro con sal (`$2b$12$`) para `usuario.password_hash` (`P-04`). | **Sí (100 % compatible)** | Exige conservar aviso `LICENSE` y `NOTICE`; incluye cláusula explícita de concesión de patentes. |
| **6** | `mysql-connector-python` | `8.4.0` | **GPLv2 (con Oracle Universal FOSS Exception)** | **Copyleft Fuerte (Alerta Crítica)** | Conector de `ComponentePersistenciaSQL` y `MySQLConnectionPool` hacia MySQL 8.0. | **⚠️ ALERTA DE COMPATIBILIDAD GPLv2** | **Análisis y Solución:** `mysql-connector-python` está bajo **GPLv2**. Si el software `asistencia-qr` se entrega bajo licencia **cerrada/propietaria cedida en exclusividad al cliente**, la GPLv2 exige liberar el código fuente completo salvo que se publique bajo una licencia OSI cubierta por la *Universal FOSS Exception* o se reemplace la librería.<br>**Acción y Costo de Reemplazo (Convención Anexo D):** Para garantizar libertad contractual total sin contaminación GPLv2, se contempla la opción de reemplazar `mysql-connector-python` por **`PyMySQL 1.1.1` (Licencia MIT permisiva)** + `DBUtils (MIT)` para el pool.<br>- **Cálculo del costo de reemplazo:** `4 horas de desarrollo/pruebas × $55.000 COP/hora = $220.000 COP` (pago único registrado junto al rubro de licencias). |

---

## 3. Decisión y Justificación de la Licencia del Software Propio (`asistencia-qr`)

### 3.1 Régimen aplicable según la Ley 23 de 1982 (modificada por el Art. 28 de la Ley 1450 de 2011) y la Decisión Andina 351 de 1993

1. **Derechos Morales (Perpetuos, Inalienables e Irrenunciables):** Conforme al Artículo 30 de la Ley 23 de 1982 y el Artículo 11 de la Decisión Andina 351 de 1993, el autor `@estiben08` conserva a perpetuidad la **paternidad de la obra** (el derecho a que su nombre/usuario figure como creador del software y su arquitectura).
2. **Derechos Patrimoniales y Modalidad de Licencia Elegida para la Propuesta:**
   - Se selecciona el modelo de **Licencia de Uso Institucional Perpetua con Entrega de Código Fuente bajo Licencia Permisiva Interna (basada en MIT / Cesión No Exclusiva para la Entidad Contratante)**:
     - **Por qué se elige esta licencia:**
       1. Permite a la institución educativa (SENA / Centro de Formación) desplegar, modificar, auditar y escalar el software en sus **2 sedes** (y futuras sedes) sin pagar regalías recurrentes por cada nuevo aprendiz o instructor.
       2. Es **100 % compatible** tanto con las librerías permisivas del proyecto (`Flask`, `Werkzeug`, `qrcode`, `Pillow`, `bcrypt`, `PyMySQL`) como con la *Oracle Universal FOSS Exception* (ya que MIT está aprobada por la OSI).
       3. Protege al autor mediante la cláusula de limitación de responsabilidad más allá del periodo de garantía pactado (`12 meses`) y permite reutilizar el conocimiento y componentes base en su portafolio profesional.
