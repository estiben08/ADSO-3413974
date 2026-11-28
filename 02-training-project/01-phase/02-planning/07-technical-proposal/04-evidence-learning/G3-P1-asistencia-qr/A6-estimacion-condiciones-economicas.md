# A6 · Estimación Preliminar de Condiciones Económicas (12 y 36 Meses)

**Proyecto:** Sistema de Control de Asistencia Académica con QR Dinámico (`asistencia-qr`)  
**Autor (GitHub):** `@estiben08` · **Ficha:** 3413974  
**Libro de cálculo con fórmulas vivas adjunto:** [`A6-estimacion-condiciones-economicas.xlsx`](./A6-estimacion-condiciones-economicas.xlsx)  
**Variante del escenario aplicada:** **Variante B** (120 usuarios totales, 30 concurrentes pico, 2 sedes, disponibilidad 99,5 %, tope primer año `$70.000.000 COP`, TRM `$4.000/USD`, IVA `19 %`).  
**RAP asociado:** 593060 (01) · Estima condiciones técnicas y económicas de acuerdo con las características de la solución de software y las necesidades de la empresa (Criterio C6).

---

## 1. Método de Estimación Declarado: Descomposición por Módulos + Tres Puntos PERT

Para evitar cifras arbitrarias, el esfuerzo de talento humano se estimó mediante el método de **Tres Puntos PERT (`E = (O + 4M + P) / 6`)** desglosado en **10 ítems de trabajo** (superando el mínimo exigible de 8 ítems) con una tarifa base de ingeniería ADSO de **`$55.000 COP / hora`** (hoja `2_Esfuerzo_Talento_PERT` del archivo `.xlsx`):

| ID Ítem | Módulo / Actividad del Proyecto (`asistencia-qr`) | Optimista (`O`) | Más Probable (`M`) | Pesimista (`P`) | Horas PERT `=(O+4M+P)/6` | Tarifa Hora (COP) | Costo Directo (COP) |
|---|---|---|---|---|---|---|---|
| **TH-01** | Levantamiento, refinamiento SRS y modelo conceptual UML/MER (`G1`) | 20 h | 24 h | 34 h | **25,0 h** | `$55.000` | `$1.375.000` |
| **TH-02** | Diseño arquitectónico 3 capas, patrones GoF y modelo lógico 3FN (`G2`) | 22 h | 26 h | 36 h | **27,0 h** | `$55.000` | `$1.485.000` |
| **TH-03** | Construcción y pruebas de Base de Datos MySQL 8.0 (11 tablas, índices, pool) | 16 h | 20 h | 30 h | **21,0 h** | `$55.000` | `$1.155.000` |
| **TH-04** | Desarrollo Componente Autenticación RBAC, hash `bcrypt` y Ley 1581 (`CU-01`, `CU-02`) | 24 h | 28 h | 38 h | **29,0 h** | `$55.000` | `$1.595.000` |
| **TH-05** | Desarrollo Motor QR Dinámico 30 s y firma criptográfica `HMAC-SHA256` (`CU-03`, `CU-04`) | 26 h | 30 h | 40 h | **31,0 h** | `$55.000` | `$1.705.000` |
| **TH-06** | Desarrollo Validador Zero-Trust Subred IP, Unicidad y Contingencia (`CU-05` a `CU-07`) | 28 h | 32 h | 42 h | **33,0 h** | `$55.000` | `$1.815.000` |
| **TH-07** | Desarrollo Vistas Responsivas *Mobile-First*, Proyección Aula y Monitoreo AJAX (`CU-08`) | 26 h | 30 h | 40 h | **31,0 h** | `$55.000` | `$1.705.000` |
| **TH-08** | Desarrollo Exportador Streaming CSV/Excel y Motor de Alertas Deserción (`CU-09`, `CU-10`) | 20 h | 24 h | 34 h | **25,0 h** | `$55.000` | `$1.375.000` |
| **TH-09** | Aprovisionamiento Linux/Nginx/Gunicorn TLS 1.3, Scripts Backup y Redes 2 Sedes | 18 h | 22 h | 32 h | **23,0 h** | `$55.000` | `$1.265.000` |
| **TH-10** | Pruebas integrales de carga (30 concurrentes), seguridad, documentación y capacitación | 20 h | 24 h | 34 h | **25,0 h** | `$55.000` | `$1.375.000` |
| **TOTAL** | **10 Ítems de Esfuerzo de Ingeniería** | **220 h** | **260 h** | **360 h** | **270,0 h** | **`$55.000`** | **`$14.850.000`** |

---

## 2. Consolidado Económico Preliminar a 12 y 36 Meses (Clasificación Directos/Indirectos y Únicos/Recurrentes)

Todos los cálculos siguen las **Convenciones del Anexo D** (valores en COP sin IVA, contingencia sobre el subtotal e IVA del 19 % aplicado al final sobre `Subtotal + Contingencia`; ver hoja `3_Economica_Preliminar_12_36M` en [`A6-estimacion-condiciones-economicas.xlsx`](./A6-estimacion-condiciones-economicas.xlsx)):

| Código | Rubro / Concepto | Categoría | Tipo Costo | Periodicidad | Cantidad (Año 1) | Costo Unitario (COP) | Costo 12 Meses (Año 1) | Costo 36 Meses (3 Años) |
|---|---|---|---|---|---|---|---|---|
| **EC-01** | Talento humano de desarrollo e implantación (`270 h PERT`) | 1. Talento Humano | Directo | Único | 1 global | `$14.850.000` | `$14.850.000` | `$14.850.000` |
| **EC-02** | Adaptación a conector MIT `PyMySQL` (reemplazo GPLv2 · Anexo D) | 2. Licencias y PI | Directo | Único | 4 horas | `$55.000` | `$220.000` | `$220.000` |
| **EC-03** | Registro de dominio institucional `.co` + certificado TLS | 2. Licencias y PI | Directo | Recurrente Anual | 1 año | `$80.000` | `$80.000` | `$240.000` |
| **EC-04** | Puntos de Acceso WiFi 6 Empresariales Dual-Band (`2 × 2 sedes`) | 3. Hardware / Red | Directo | Único | 4 unidades | `$780.000` | `$3.120.000` | `$3.120.000` |
| **EC-05** | Switch PoE Gigabit + Cableado Cat6 e instalación (`2 sedes`) | 3. Hardware / Red | Directo | Único | 2 sedes | `$950.000` | `$1.900.000` | `$1.900.000` |
| **EC-06** | Suscripción VPS Cloud Administrado (`$28,8 USD/mes × $4.000`) | 4. Nube y Operación | Directo | Recurrente Mensual | 12 meses | `$115.200` | `$1.382.400` | `$4.147.200` |
| **EC-07** | Almacenamiento externo cifrado para backups (`$5 USD/mes`) | 4. Nube y Operación | Directo | Recurrente Mensual | 12 meses | `$20.000` | `$240.000` | `$720.000` |
| **EC-08** | Soporte técnico preventivo/correctivo y acta mensual backup (`6 h/mes`) | 5. Soporte y Capacitación | Directo | Recurrente Mensual | 12 meses | `$330.000` | `$3.960.000` | `$11.880.000` |
| **EC-09** | Talleres de capacitación y transferencia (`2 sedes`) | 5. Soporte y Capacitación | Indirecto | Único | 2 sedes | `$450.000` | `$900.000` | `$900.000` |
| **EC-10** | Gastos indirectos de administración y gestión (`5 %` de talento) | 6. Indirectos Gestión | Indirecto | Único | 1 global | `$742.500` | `$742.500` | `$742.500` |
| | **SUBTOTAL COSTOS ESTIMADOS (SIN CONTINGENCIA NI IVA)** | | | | | | **`$27.394.900`** | **`$38.719.700`** |
| | **Reserva de Contingencia Preliminar (`10,0 %` del subtotal)** | | | | | | **`$2.739.490`** | **`$3.871.970`** |
| | **TOTAL COSTO CON CONTINGENCIA (BASE ANTES DE IVA)** | | | | | | **`$30.134.390`** | **`$42.591.670`** |
| | **IVA (`19 %` sobre Total con Contingencia — Anexo D)** | | | | | | **`$5.725.534`** | **`$8.092.417`** |
| | **TOTAL ESTIMADO PRELIMINAR CON IVA INCLUIDO (COP)** | | | | | | **`$35.859.924`** | **`$50.684.087`** |
| | **Tope de Presupuesto Primer Año de la Variante B** | | | | | | **`$70.000.000`** | — |
| | **Cumplimiento del Tope (Holgura disponible Año 1)** | | | | | | **Cumple (`+$34.140.076` bajo el tope)** | — |

---

## 3. Rango de Error, Supuestos y Exclusiones

- **Clase de estimación y rango deexactitud:** Estimación analítica por módulos clase II con un **rango de variación de `-7 % a +10 %`** (derivado de la desviación estándar PERT `(P - O) / 6` de los 10 paquetes de trabajo).
- **Supuestos:**
  1. Se aplica la **TRM de referencia de `$4.000 COP / USD`** fijada en el Anexo A para los rubros cotizados en dólares (hosting VPS y almacenamiento de backups).
  2. Las **2 sedes** del cliente ya cuentan con servicio de energía eléctrica estable y enlace básico de Internet de al menos `20 Mbps`; la propuesta incluye los **4 Puntos de Acceso WiFi 6 (`FT-HW-02`)** y switches PoE para garantizar la subred de las aulas.
  3. Los aprendices utilizan sus propios teléfonos móviles (*BYOD*) y cada aula ya dispone del computador/pantalla del instructor.
- **Exclusiones explícitas:**
  1. No incluye la compra de teléfonos móviles para aprendices ni televisores/videobeams de aula.
  2. No incluye licencias de Microsoft Windows Server ni Oracle Database comercial (se emplea stack Linux Ubuntu LTS + MySQL Community sin costo de licenciamiento).
  3. No incluye obras civiles mayores de rotura de muros (el cableado Cat6 considerado es canaleta superficial en las 2 sedes).
