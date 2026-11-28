# B1 · Análisis Comparativo de Proveedores y Cálculo de TCO a 36 Meses

**Proyecto:** Sistema de Control de Asistencia Académica con QR Dinámico (`asistencia-qr`)  
**Autor (GitHub):** `@estiben08` · **Ficha:** 3413974  
**Variante del escenario aplicada:** **Variante B** (120 usuarios totales, 30 concurrentes pico, 2 sedes, disponibilidad 99,5 %, TRM `$4.000 COP/USD`).  
**Hoja de cálculo con fórmulas vivas:** Hoja `2_Comparativo_TCO_36M` en [`B2-presupuesto-software-hardware.xlsx`](./B2-presupuesto-software-hardware.xlsx).  
**RAP asociado:** 593062 (02) · Elabora análisis comparativo de proveedores considerando costos, cantidad y especificaciones técnicas definidas (Criterio C1).

---

## 1. Normalización frente a las Fichas Técnicas del Producto 1 (`A2`)

Para garantizar una comparación justa y sin sesgos, todas las alternativas se evalúan exactamente contra la **misma especificación técnica y la misma cantidad** definida en el Producto 1 ([`../G3-P1-asistencia-qr/A2-fichas-tecnicas-diligenciadas.md`](../G3-P1-asistencia-qr/A2-fichas-tecnicas-diligenciadas.md)):
- **Categoría 1 · Infraestructura Cloud / VPS Administrado (`Ficha FT-HW-01`, Cantidad = 1 instancia central para 2 sedes durante 36 meses):** Mínimo `2 vCPU`, `4 GB RAM`, `80 GB SSD/NVMe`, `>= 2 TB/mes` de transferencia, SLA `>= 99,5 %` y servicio de *Backups/Snapshots* automáticos activado.
- **Categoría 2 · Equipos de Red Inalámbrica de Aula (`Ficha FT-HW-02`, Cantidad = 4 unidades físicas: 2 APs por cada una de las 2 sedes):** Estándar `WiFi 6 (802.11ax)` Dual-Band `>= 1800 Mbps`, soporte `>= 150` clientes por AP, puerto `1 Gbps PoE`, soporte `>= 8 SSID con VLAN 802.1Q` y controlador de gestión sin licencia anual obligatoria.

---

## 2. Categoría 1: Infraestructura Cloud VPS Administrado (`FT-HW-01` · 3 Alternativas Reales)

### 2.1 Comparativo Técnico y de Precios Públicos Verificados (TRM = `$4.000 COP/USD`)

| Atributo Comparado (contra `FT-HW-01`) | Alternativa 1A: **DigitalOcean Droplet Premium Intel/AMD NVMe + Backups** *(Recomendada)* | Alternativa 1B: **Amazon Web Services (AWS) Lightsail 4 GB + Automatic Snapshots** *(Mejor Descartada)* | Alternativa 1C: **Microsoft Azure Virtual Machine B2s + Managed Disk 80 GB + Azure Backup** |
|---|---|---|---|
| **Fuente oficial y fecha de consulta** | `https://www.digitalocean.com/pricing/droplets`<br>Consultado: `2026-11-25` | `https://aws.amazon.com/lightsail/pricing/`<br>Consultado: `2026-11-25` | `https://azure.microsoft.com/en-us/pricing/details/virtual-machines/linux/`<br>Consultado: `2026-11-25` |
| **Procesador y Memoria RAM** | `2 vCPU Premium NVMe` · `4 GB RAM` (Cumple 100 %) | `2 vCPU` · `4 GB RAM` (Cumple 100 %) | `2 vCPU (B2s burstable)` · `4 GB RAM` (Cumple, pero sujeto a créditos de CPU) |
| **Almacenamiento y Transferencia** | `80 GB NVMe SSD` · `4 TB / mes` (Supera los `2 TB` de la ficha) | `80 GB SSD` · `4 TB / mes` (Supera los `2 TB` de la ficha) | `80 GB Standard SSD E6` · Tráfico saliente cobrado por GB adicional |
| **SLA de Disponibilidad Mensual** | **`99,99 %`** (Supera el `99,5 %` de la Variante B) | **`99,9 %`** (Supera el `99,5 %` de la Variante B) | **`99,9 %`** (Supera el `99,5 %` de la Variante B) |
| **Costo mensual (Instancia + Backups)** | `$24,00 USD + $4,80 USD (20% backup) = $28,80 USD/mes` → **`$115.200 COP/mes`** | `$24,00 USD + $8,50 USD (snapshots) = $32,50 USD/mes` → **`$130.000 COP/mes`** | `$35,00 USD + $11,00 USD (disco + backup) = $46,00 USD/mes` → **`$184.000 COP/mes`** |

### 2.2 Costo Total de Propiedad (TCO) Completo a 36 Meses — Categoría 1 (Todos los 5 Rubros Obligatorios)

| Rubro del TCO (36 Meses) | Fórmula de Cálculo | Alt. 1A: **DigitalOcean** *(Recomendada)* | Alt. 1B: **AWS Lightsail** *(Mejor Descartada)* | Alt. 1C: **Azure B2s** *(Descartada)* |
|---|---|---|---|---|
| **1. Adquisición / Aprovisionamiento inicial** | Horas de configuración inicial × `$55.000/h` | `$220.000` (4 h) | `$275.000` (5 h) | `$385.000` (7 h) |
| **2. Licencias / Suscripción Cloud (36 meses)** | `Costo_mensual_USD × $4.000 × 36 meses` | **`$4.147.200`** (`$28,80 × 4.000 × 36`) | **`$4.680.000`** (`$32,50 × 4.000 × 36`) | **`$6.624.000`** (`$46,00 × 4.000 × 36`) |
| **3. Soporte técnico y mantenimiento (36 meses)** | Horas de administración cloud en 3 años | `$1.080.000` | `$1.260.000` | `$1.440.000` |
| **4. Operación y almacenamiento externo backups (36 meses)** | Bucket S3/Spaces off-site × `36 meses` | `$720.000` (`$5 USD × 4.000 × 36`) | `$864.000` (`$6 USD × 4.000 × 36`) | `$1.152.000` (`$8 USD × 4.000 × 36`) |
| **5. Capacitación / Transición operativa** | Horas de transferencia al administrador del centro | `$330.000` (6 h) | `$440.000` (8 h) | `$550.000` (10 h) |
| **TCO TOTAL A 36 MESES (`=SUM(1..5)`)** | **Suma integral de los 5 rubros a 36 meses** | **`$6.497.200 COP`** | **`$7.519.000 COP`** | **`$10.151.000 COP`** |

---

## 3. Categoría 2: Puntos de Acceso WiFi 6 Empresariales (`FT-HW-02` · 4 Unidades para 2 Sedes)

### 3.1 Comparativo Técnico y de Precios Públicos Verificados (Cantidad Normalizada = 4 Unidades)

| Atributo Comparado (contra `FT-HW-02`) | Alternativa 2A: **TP-Link Omada EAP650 AX3000 Dual-Band PoE** *(Recomendada)* | Alternativa 2B: **Ubiquiti UniFi U6-Pro AX5400 Dual-Band PoE** *(Mejor Descartada)* | Alternativa 2C: **HPE Aruba Instant On AP22 WiFi 6 (R4W02A)** |
|---|---|---|---|
| **Fuente oficial y fecha de consulta** | `https://www.tp-link.com/co/business-networking/omada-sdn-access-point/eap650/`<br>Consultado: `2026-11-25` | `https://store.ui.com/us/en/products/u6-pro`<br>Consultado: `2026-11-25` | `https://www.arubainstanton.com/products/access-points/access-point-22/`<br>Consultado: `2026-11-25` |
| **Velocidad WiFi 6 y Capacidad Concurrente** | **`AX3000 (2976 Mbps)`** · **`250+ clientes/AP`** (Supera los `1800 Mbps` y `150 clientes` de la ficha) | **`AX5400 (5373 Mbps)`** · **`300+ clientes/AP`** (Supera ampliamente la ficha) | **`AX1800 (1774 Mbps)`** · **`75 clientes recomendados/AP`** (Por debajo de los 150 clientes de la ficha) |
| **Soporte VLAN 802.1Q y Controlador ($0)** | `16 SSID con VLAN Tag` · Software Omada SDN Controller 100 % gratuito + **Incluye adaptador en caja** | `8 SSID con VLAN Tag` · Software UniFi Network Server gratuito (no incluye inyector PoE en caja) | `8 SSID con VLAN` · Gestión por nube gratuita (no incluye inyector PoE en caja) |
| **Precio unitario público y Total 4 Unidades** | `$645.000 COP / unidad` → **`$2.580.000 COP` (4 unidades)** | `$795.000 COP / unidad` → **`$3.180.000 COP` (4 unidades)** | `$860.000 COP / unidad` (con inyector) → **`$3.440.000 COP` (4 unidades)** |

### 3.2 Costo Total de Propiedad (TCO) Completo a 36 Meses — Categoría 2 (Todos los 5 Rubros Obligatorios)

| Rubro del TCO (36 Meses · 4 Unidades en 2 Sedes) | Fórmula de Cálculo | Alt. 2A: **TP-Link Omada EAP650** *(Recomendada)* | Alt. 2B: **Ubiquiti UniFi U6-Pro** *(Mejor Descartada)* | Alt. 2C: **HPE Aruba AP22** *(Descartada)* |
|---|---|---|---|---|
| **1. Adquisición de las 4 unidades físicas** | `4 unidades × Precio_Unitario_COP` | **`$2.580.000`** (`4 × $645.000`) | **`$3.180.000`** (`4 × $795.000`) | **`$3.440.000`** (`4 × $860.000`) |
| **2. Licencias de controlador SDN (36 meses)** | Licenciamiento anual por AP × 3 años | **`$0`** (Controlador gratuito de por vida) | **`$0`** (UniFi OS gratuito de por vida) | **`$0`** (Portal cloud gratuito) |
| **3. Soporte técnico y mantenimiento (36 meses)** | Revisión preventiva semestral de red en 2 sedes | `$540.000` | `$540.000` | `$680.000` |
| **4. Operación eléctrica PoE y ajustes de VLAN (36 meses)** | Consumo PoE (`~13 W × 4 APs`) y reconfiguración de subredes | `$720.000` | `$780.000` | `$840.000` |
| **5. Capacitación en gestión de SSID/Subredes** | Taller técnico para administradores de las 2 sedes | `$330.000` (6 h) | `$385.000` (7 h) | `$440.000` (8 h) |
| **TCO TOTAL A 36 MESES (`=SUM(1..5)`)** | **Suma integral de los 5 rubros a 36 meses** | **`$4.170.000 COP`** | **`$4.885.000 COP`** | **`$5.400.000 COP`** |

---

## 4. Matriz Ponderada de Evaluación (5 Criterios que Suman 100 %) y Justificación de Decisiones

| Criterio de Evaluación | Peso (%) | Cat. 1: **DigitalOcean** | Cat. 1: **AWS Lightsail** | Cat. 1: **Azure B2s** | Cat. 2: **TP-Link EAP650** | Cat. 2: **Ubiquiti U6-Pro** | Cat. 2: **Aruba AP22** |
|---|---|---|---|---|---|---|---|
| **1. Cumplimiento técnico frente a ficha `A2`** | **30 %** | 95 | 92 | 92 | 95 | 96 | 88 |
| **2. Costo Total de Propiedad (TCO a 36 meses)** | **25 %** | 96 | 84 | 65 | 96 | 82 | 74 |
| **3. Nivel de servicio (SLA), garantías y fiabilidad** | **20 %** | 92 | 94 | 95 | 90 | 90 | 90 |
| **4. Soporte, documentación y disponibilidad local** | **15 %** | 90 | 88 | 86 | 94 | 88 | 85 |
| **5. Facilidad de administración y cero costos ocultos** | **10 %** | 96 | 88 | 72 | 95 | 92 | 86 |
| **TOTAL PONDERADO (`=SUMPRODUCT`)** | **100 %** | **`94,10 / 100`** 🏆 | `88,40 / 100` | `81,95 / 100` | **`94,10 / 100`** 🏆 | `89,70 / 100` | `83,65 / 100` |

### Recomendación y Justificación de las Alternativas Descartadas:
1. **En Categoría 1 (VPS Cloud `FT-HW-01`), se recomienda `DigitalOcean Droplet Premium 4 GB / 80 GB NVMe + Backups` (`94,10 pts`, TCO 36M = `$6.497.200 COP`):**
   - **Por qué gana:** Ofrece discos NVMe de alto rendimiento, SLA del `99,99 %` y tarifa plana predecible con backups automáticos al 20 % del valor del nodo, ahorrando **`$1.021.800 COP`** frente a AWS Lightsail y **`$3.653.800 COP`** frente a Azure B2s en 36 meses.
   - **Por qué se descartan AWS Lightsail y Azure B2s:** AWS Lightsail encarece los snapshots automáticos y la administración IAM para un equipo pequeño; Azure B2s utiliza CPU por créditos (*burstable*) y cobra tráfico saliente por separado, elevando el TCO en un `56,2 %`.
2. **En Categoría 2 (Red WiFi 6 `FT-HW-02`), se recomienda `TP-Link Omada EAP650 AX3000 (4 unidades)` (`94,10 pts`, TCO 36M = `$4.170.000 COP`):**
   - **Por qué gana:** Supera los `1800 Mbps` exigidos (`2976 Mbps`), soporta `250+` dispositivos por AP con `16 VLANs`, incluye fuente de alimentación en la caja y cuenta con distribuidor oficial y garantía directa en Colombia, ahorrando **`$715.000 COP`** frente a Ubiquiti U6-Pro y **`$1.230.000 COP`** frente a Aruba AP22.
   - **Por qué se descartan Ubiquiti U6-Pro y Aruba AP22:** Ubiquiti U6-Pro tiene excelente radio pero no incluye adaptador de corriente en caja y su costo de importación es `23 %` superior; Aruba Instant On AP22 solo recomienda `75 clientes` por unidad (incumpliendo los `150 clientes` de la característica `7.2` de `FT-HW-02`).
