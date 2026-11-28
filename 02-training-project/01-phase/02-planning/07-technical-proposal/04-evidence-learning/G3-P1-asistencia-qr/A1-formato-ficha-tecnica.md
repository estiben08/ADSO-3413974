# A1 · Formato Propio de Ficha Técnica de Bienes y Servicios TI

**Proyecto:** Sistema de Control de Asistencia Académica con QR Dinámico (`asistencia-qr`)  
**Autor (GitHub):** `@estiben08` · **Ficha:** 3413974  
**Competencia:** 220501094 · Estructurar propuesta técnica de servicio de tecnología de la información según requisitos técnicos y normativa  
**RAP asociado:** 593060 (01) · Diseña formatos de fichas técnicas de acuerdo con estándares (Criterio C1).

---

## 1. Estándares Técnicos de Referencia del Formato

Este formato propio fue diseñado integrando los elementos exigidos por tres estándares reconocidos en ingeniería de software y adquisición de tecnología:
1. **ISO/IEC 25010:2011 (SQuaRE — Modelo de Calidad de Sistemas y Software):** Estructura las características técnicas medibles según atributos de eficiencia de desempeño, compatibilidad, usabilidad, fiabilidad, seguridad, mantenibilidad y portabilidad.
2. **ISO/IEC/IEEE 29148:2018 (Ingeniería de Requisitos):** Exige que cada especificación técnica sea *verificable, sin ambigüedad, cuantificable (valor + unidad de medida)* y neutral frente a marcas comerciales.
3. **Guía de Compras Públicas de Tecnología (Colombia Compra Eficiente — Acuerdos Marco de Precios TI):** Incorpora campos de identificación de catálogo, cantidad, unidad de medida, condiciones de licenciamiento/propiedad intelectual, garantía, soporte y método de verificación objetiva.

---

## 2. Estructura del Formato Propio (14 Campos Obligatorios · Mínimo Exigible: 12)

Este formato de **14 campos** se aplica de manera uniforme en las **4 fichas técnicas diligenciadas** del archivo [`A2-fichas-tecnicas-diligenciadas.md`](./A2-fichas-tecnicas-diligenciadas.md):

| # Campo | Nombre del Campo en la Ficha Técnica | Qué se registra en este campo | Regla de Calidad y Verificación |
|---|---|---|---|
| **01** | **Código e Identificación de la Ficha** | Identificador único (`FT-SW-01`, `FT-SW-02`, `FT-HW-01`, `FT-HW-02`), versión del formato y fecha de emisión. | Código alfanumérico trazable al presupuesto y a la arquitectura. |
| **02** | **Denominación Genérica del Bien o Servicio** | Nombre técnico neutral del componente de software, servicio cloud o equipo de infraestructura. | Prohibido usar marcas o modelos propietarios como requisito obligatorio. |
| **03** | **Categoría y Clasificación TI** | Clasificación del ítem: `Software Propio / Aplicación`, `Software Base / Motor BD`, `Infraestructura Cloud / VPS` o `Hardware de Red / Conectividad`. | Permite separar software y hardware en el presupuesto (`B2`). |
| **04** | **Variante del Escenario y Nodo de Arquitectura** | Parámetros de la **Variante B** (120 usuarios totales, 30 concurrentes pico, 2 sedes, disponibilidad 99,5 %) y nodo del diagrama de despliegue (`Nodo 1` a `Nodo 4`). | Garantiza trazabilidad directa entre ficha, variante y diagrama. |
| **05** | **Descripción Funcional y Propósito en la Solución** | Función que cumple el bien o servicio dentro del Sistema de Control de Asistencia QR (`asistencia-qr`). | Vinculado a los requisitos funcionales (`RF-01` a `RF-13`). |
| **06** | **Cantidad Requerida y Unidad de Medida** | Cantidad numérica exacta requerida para cubrir las 2 sedes y 120 usuarios, junto con su unidad (`Instancia`, `Licencia`, `Suscripción mensual`, `Unidad física`). | Calculada con fórmula a partir de los parámetros de la Variante B. |
| **07** | **Especificaciones y Características Técnicas Medibles (Mínimo 6 filas)** | Tabla estructurada con: **`ID Característica` · `Atributo Técnico` · `Valor Exigido` · `Unidad de Medida` · `Método de Verificación Objetiva`**. | Cero adjetivos subjetivos («rápido», «moderno»); todo valor lleva número, unidad y prueba de verificación. |
| **08** | **Requisitos de Compatibilidad e Interoperabilidad** | Sistemas operativos, navegadores, protocolos de red (`HTTPS TLS 1.3`, `TCP/3306`, `802.11ax`, `CIDR IPv4`) y formatos de intercambio (`CSV`, `XLSX`, `JSON`) con los que debe interoperar. | Evita bloqueos de integración entre los 4 nodos del despliegue. |
| **09** | **Normatividad Legal y Estándares Técnicos que Cumple** | Leyes nacionales y estándares internacionales exigibles al componente (Ley 1581 de 2012, Ley 23 de 1982, Decisión Andina 351, ISO/IEC 25010, ISO/IEC 27001, WCAG 2.2, IEEE 802.11ax). | Coherente con la tabla de referentes técnicos (`A3`). |
| **10** | **Modelo de Licenciamiento y Propiedad Intelectual** | Tipo de licencia (`MIT`, `BSD-3`, `GPLv2`, `Suscripción Cloud`, `Cesión Patrimonial`), métrica de licenciamiento y obligaciones de cumplimiento. | Coherente con el dimensionamiento de licencias (`A4`). |
| **11** | **Condiciones de Operación, Nivel de Servicio (ANS) y Capacidad** | Disponibilidad mensual mínima (`>= 99,5 %`), `RPO`, `RTO`, concurrencia soportada (`>= 30 usuarios pico`) y ventana de mantenimiento. | Coherente con las condiciones técnicas (`A5`) y el ANS (`B6`). |
| **12** | **Condiciones de Garantía, Mantenimiento y Soporte Técnico** | Duración de la garantía (en meses), tiempos de respuesta ante incidentes críticos, cobertura de actualizaciones y parches de seguridad. | Mínimo 12 meses de garantía o cobertura durante los 36 meses de TCO. |
| **13** | **Entregables de Verificación y Criterios de Aceptación** | Artefactos o pruebas que el proveedor debe entregar para dar por recibido el ítem (acta de pruebas de carga, certificado TLS, script SQL, manual técnico). | Permite auditar el cumplimiento en la lista de verificación contractual. |
| **14** | **Observaciones, Supuestos y Restricciones** | Condiciones especiales de instalación en las 2 sedes, exclusiones o notas de compatibilidad justificada. | Documenta supuestos operativos de la Variante B. |

---

## 3. Plantilla en Blanco Lista para Diligenciar (Campos 01 a 14)

```markdown
### FICHA TÉCNICA [01. Código: FT-XX-00] · Versión 1.0
- **02. Denominación genérica:** [Nombre técnico sin marca]
- **03. Categoría TI:** [Software Propio / Software Base / Infraestructura Cloud / Hardware de Red]
- **04. Variante y Nodo:** Variante B (120 usuarios, 30 concurrentes, 2 sedes, 99,5 %) · [Nodo X del diagrama]
- **05. Descripción funcional:** [Propósito dentro del sistema]
- **06. Cantidad y unidad de medida:** [Cantidad numérica] · [Unidad de medida]

#### 07. Características Técnicas Medibles (Mínimo 6)
| # | Característica / Atributo | Valor Exigido | Unidad de Medida | Método de Verificación Objetiva |
|---|---|---|---|---|
| 7.1 | | | | |
| 7.2 | | | | |
| 7.3 | | | | |
| 7.4 | | | | |
| 7.5 | | | | |
| 7.6 | | | | |

- **08. Compatibilidad e interoperabilidad:** [Protocolos, SO, navegadores, formatos]
- **09. Normatividad y estándares que cumple:** [Normas legales y estándares técnicos]
- **10. Licenciamiento y propiedad intelectual:** [Tipo de licencia, modelo de cobro, obligaciones]
- **11. Condiciones de operación y ANS:** [Disponibilidad, concurrencia, RPO, RTO]
- **12. Garantía y soporte técnico:** [Plazo de garantía, SLA de soporte]
- **13. Entregables y criterios de aceptación:** [Pruebas y actas requeridas]
- **14. Observaciones y restricciones:** [Supuestos operativos]
```
