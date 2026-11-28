# B2 · Presupuesto de Software y Hardware con Trazabilidad Arquitectónica, Contingencia EMV, IVA y Margen

**Proyecto:** Sistema de Control de Asistencia Académica con QR Dinámico (`asistencia-qr`)  
**Autor (GitHub):** `@estiben08` · **Ficha:** 3413974  
**Libro de cálculo oficial con 6 hojas y fórmulas vivas:** [`B2-presupuesto-software-hardware.xlsx`](./B2-presupuesto-software-hardware.xlsx)  
**Variante del escenario aplicada:** **Variante B** (120 usuarios totales, 30 concurrentes pico, 2 sedes, disponibilidad `99,5 %`, tope primer año `$70.000.000 COP`, TRM `$4.000/USD`, IVA `19 %`).  
**RAP asociado:** 593062 (02) · Estima costos de software y hardware de acuerdo con las características del negocio (Criterio C2).

---

## 1. Cumplimiento de Todas las Reglas Financieras y de Trazabilidad del Criterio C2 y Anexo D

1. **6 categorías obligatorias:** (1) Talento humano, (2) Licencias de software, (3) Hardware e infraestructura de red, (4) Nube y operación, (5) Capacitación, soporte y gestión, y (6) Reserva de contingencia.
2. **Separación de Software y Hardware, Directos/Indirectos y Únicos/Recurrentes:** En la hoja `4_Presupuesto_v1.0` se totalizan por separado el subtotal de Software/Servicios (`$21.372.500 COP` en Año 1) y el subtotal de Hardware/Infraestructura (`$5.482.400 COP` en Año 1).
3. **Columna de trazabilidad a cada nodo y componente del diagrama (`B3-diagrama-arquitectura-despliegue.svg`):** Cada rubro indica el nodo (`Nodo 1` a `Nodo 4`) o componente (`A5`) que financia, y la fila `EXCL-1` declara explícitamente los elementos excluidos con justificación (PCs de aula existentes y teléfonos *BYOD* de aprendices).
4. **Contingencia ligada por fórmula viva a la Matriz de Riesgos:** La celda `J20` (`='3_Matriz_Riesgos'!$I$11`) toma la suma exacta de los valores esperados (`Probabilidad × Impacto`) de los 7 riesgos de la hoja `3_Matriz_Riesgos`, dando **`$2.445.000 COP`**, que equivale al **`9,10 %` del subtotal (`$26.854.900 COP`)**, dentro del rango del **`5 % al 15 %`** establecido en el Anexo D.
5. **Fórmula de utilidad/margen declarada (Anexo D):** Se declara explícitamente el uso de **Margen sobre el Precio de Venta (`Margen = 15 %`)**:
   \[
   \text{Precio de Venta antes de IVA} = \frac{\text{Costo Total con Contingencia}}{1 - \text{Margen}} = \frac{\$29.299.900}{1 - 0,15} = \frac{\$29.299.900}{0,85} = \$34.470.471\text{ COP}
   \]
   *(Nota de equivalencia Anexo D: un margen sobre el precio del `15,0 %` equivale a un recargo sobre el costo del `17,647 % = 0,15 / 0,85`).*
6. **Aplicación del IVA del 19 % al final:** El IVA (`19 %`) se calcula al final sobre el total con contingencia y margen (`$34.470.471 × 19 % = $6.549.389 COP`), arrojando un **Precio Total de Venta con IVA de `$41.019.860 COP` en el Año 1**, que respeta con **`$28.980.140 COP` de holgura** el tope de `$70.000.000 COP` de la Variante B.

---

## 2. Tabla General del Presupuesto (`v1.0` · Hoja `4_Presupuesto_v1.0`)

| Código | Categoría | Rubro / Concepto | Tipo | Clasif. | Periodicidad | Nodo / Componente del Diagrama (`B3`) | Cant. Año 1 | Valor Unitario (COP) | Subtotal Año 1 (12M) | Total Horizonte 36M |
|---|---|---|---|---|---|---|---|---|---|---|
| **PR-01** | 1. Talento Humano | Ingeniería de análisis, diseño 3 capas, BD 3FN y codificación Python/MySQL (`222 h PERT`) | Software | Directo | Único | `Nodo 3`: Servidor App (`Componentes 1 a 7 de A5`) | 222 h | `$55.000` | `$12.210.000` | `$12.210.000` |
| **PR-02** | 1. Talento Humano | Ingeniería DevOps, despliegue TLS 1.3, subredes 2 sedes y pruebas QA (`48 h PERT`) | Software | Directo | Único | `Nodos 2, 3 y 4` (`Nginx + Gunicorn + MySQL + Red`) | 48 h | `$55.000` | `$2.640.000` | `$2.640.000` |
| **PR-03** | 2. Licencias de Software | Adaptación a conector MIT `PyMySQL` para eliminar restricción GPLv2 (Anexo D) | Software | Directo | Único | `Nodo 3`: `ComponentePersistenciaSQL` (Pool BD) | 4 h | `$55.000` | `$220.000` | `$220.000` |
| **PR-04** | 2. Licencias de Software | Dominio institucional `.co` + Certificado TLS 1.3 + Licencias OSS (`$0`) | Software | Directo | Recurrente Anual | `Nodo 3`: Proxy Inverso `Nginx 1.26` (Puerto 443) | 1 año | `$80.000` | `$80.000` | `$240.000` |
| **PR-05** | 3. Hardware e Infraestructura | Puntos de Acceso WiFi 6 **TP-Link Omada EAP650** (`2 por sede × 2 sedes` · Ganador `B1`) | Hardware | Directo | Único | `Nodo 2`: Red Inalámbrica de Aula (`FT-HW-02` · 2 Sedes) | 4 uds | `$645.000` | `$2.580.000` | `$2.580.000` |
| **PR-06** | 3. Hardware e Infraestructura | Switches Gigabit PoE 8 puertos + Cableado Cat6 e instalación en 2 sedes | Hardware | Directo | Único | `Nodo 1 y Nodo 2`: Conectividad LAN/WLAN de Aulas | 2 sedes | `$950.000` | `$1.900.000` | `$1.900.000` |
| **PR-07** | 4. Nube y Operación | Suscripción VPS Cloud **DigitalOcean Droplet Premium** (`2 vCPU, 4GB, 80GB NVMe + Backups` · Ganador `B1`) | Hardware / Nube | Directo | Recurrente Mensual | `Nodo 3` (App) y `Nodo 4` (Motor MySQL 8.0 · `FT-HW-01`) | 12 mes | `$115.200` | `$1.382.400` | `$4.147.200` |
| **PR-08** | 4. Nube y Operación | Almacenamiento Object Storage S3/Spaces cifrado `AES-256` para réplica off-site de backups (`$5 USD/mes`) | Software / Nube | Directo | Recurrente Mensual | `Nodo 4`: Agente de Respaldo Automatizado (`P-07`) | 12 mes | `$20.000` | `$240.000` | `$720.000` |
| **PR-09** | 5. Capacitación y Soporte | Soporte técnico preventivo/correctivo, parches LTS y simulacro mensual de restauración (`6 h/mes`) | Servicio / Software | Directo | Recurrente Mensual | `Nodos 3 y 4`: Mantenimiento ANS `99,5 %` y Acta `P-08` | 12 mes | `$330.000` | `$3.960.000` | `$11.880.000` |
| **PR-10** | 5. Capacitación y Soporte | Talleres de transferencia y manuales para instructores y administradores (`2 sedes`) | Servicio / Software | Indirecto | Único | `Nodo 1` (PC Aula Instructor) y `Nodo 2` (Aprendices) | 2 sedes | `$450.000` | `$900.000` | `$900.000` |
| **PR-11** | 5. Capacitación y Soporte | Gastos indirectos de gestión de proyecto y coordinación administrativa (`5 %` de talento) | Servicio / Gestión | Indirecto | Único | Transversal a todos los Nodos y Componentes | 1 global | `$742.500` | `$742.500` | `$742.500` |
| **EXCL-1** | Exclusión Justificada | Computadores de aula del instructor y teléfonos móviles de aprendices (*BYOD* / Existentes) | Hardware Excluido | n/a | n/a | `Nodo 1` (PC existente) y `Nodo 2` (Smartphones *BYOD*) | 0 | `$0` | `$0` | `$0` |
| | **Desglose Software vs. Hardware** | **Subtotal Software y Servicios** (`PR-01` a `PR-04`, `PR-08` a `PR-11`) | | | | | | | **`$20.992.500`** | **`$29.552.500`** |
| | **Desglose Software vs. Hardware** | **Subtotal Hardware e Infraestructura** (`PR-05`, `PR-06`, `PR-07`) | | | | | | | **`$5.862.400`** | **`$8.627.200`** |
| | **SUBTOTAL GENERAL** | **SUBTOTAL COSTOS DIRECTOS E INDIRECTOS (SIN CONTINGENCIA NI IVA)** | | | | | | | **`$26.854.900`** | **`$38.179.700`** |
| | **6. Contingencia** | **Reserva de Contingencia (`=SUM(Valores Esperados Matriz de Riesgos)` = `9,10 %` del subtotal)** | | | | Cubre riesgos `R1` a `R7` (Hoja `3_Matriz_Riesgos`) | | | **`$2.445.000`** | **`$3.300.750`** |
| | **COSTO TOTAL** | **COSTO TOTAL CON CONTINGENCIA (`=Subtotal + Contingencia`)** | | | | | | | **`$29.299.900`** | **`$41.480.450`** |
| | **Margen / Utilidad** | **Utilidad Comercial (`15 %` Margen sobre el Precio: `=Precio - Costo`)** | | | | Fórmula: `Precio = Costo / (1 - 0,15)` | | | **`$5.170.571`** | **`$7.320.079`** |
| | **PRECIO ANTES DE IVA** | **PRECIO DE VENTA ANTES DE IVA (`=Costo / 0,85`)** | | | | | | | **`$34.470.471`** | **`$48.800.529`** |
| | **IVA (19 %)** | **Impuesto al Valor Agregado (`19 %` aplicado al final sobre Precio con Contingencia)** | | | | Convención Anexo D | | | **`$6.549.389`** | **`$9.272.101`** |
| | **PRECIO TOTAL v1.0** | **PRECIO TOTAL DE VENTA CON IVA INCLUIDO (OFERTA v1.0 EN COP)** | | | | | | | **`$41.019.860`** | **`$58.072.630`** |
| | **Control de Tope** | **Tope Primer Año Variante B (`$70.000.000`) · Holgura disponible:** | | | | | | | **`+$28.980.140` (Cumple)** | — |

---

## 3. Flujo Económico Anualizado a 36 Meses (Hoja `5_Flujo_36_Meses`)

| Concepto del Flujo | Año 1 (Meses 1–12) | Año 2 (Meses 13–24) | Año 3 (Meses 25–36) | Total Acumulado 36 Meses |
|---|---|---|---|---|
| **1. Inversión Única Inicial (CAPEX: Desarrollo, Red WiFi 6, Switches, PyMySQL, Capacitación)** | `$21.192.500` | `$0` | `$0` | **`$21.192.500`** |
| **2. Operación Recurrente Anual (OPEX: VPS DigitalOcean, Backups S3, Dominio `.co`, Soporte 6 h/mes)** | `$5.662.400` | `$5.662.400` | `$5.662.400` | **`$16.987.200`** |
| **3. Subtotal de Costos por Año** | **`$26.854.900`** | **`$5.662.400`** | **`$5.662.400`** | **`$38.179.700`** |
| **4. Reserva de Contingencia Anualizada (Riesgos R1–R7)** | `$2.445.000` | `$427.875` | `$427.875` | **`$3.300.750`** |
| **5. Costo Total con Contingencia** | **`$29.299.900`** | **`$6.090.275`** | **`$6.090.275`** | **`$41.480.450`** |
| **6. Precio de Venta antes de IVA (`=Costo / (1 - 0,15)`)** | `$34.470.471` | `$7.165.029` | `$7.165.029` | **`$48.800.529`** |
| **7. IVA (`19 %`)** | `$6.549.389` | `$1.361.356` | `$1.361.356` | **`$9.272.101`** |
| **8. FLUJO TOTAL CON IVA INCLUIDO POR AÑO (COP)** | **`$41.019.860`** | **`$8.526.385`** | **`$8.526.385`** | **`$58.072.630`** |
