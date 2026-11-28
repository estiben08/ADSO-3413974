# G3 · Propuesta técnica · README de entrega (Producto 2)

## 1. Identificación

| Campo | Valor |
|---|---|
| Producto | P2 Propuesta técnica y validación |
| Usuario de GitHub del autor | `@estiben08` |
| Ficha | 3413974 |
| Variante del escenario asignada (A, B, C o D) | **Variante B** (120 usuarios totales, 30 usuarios concurrentes pico, 2 sedes, disponibilidad objetivo `99,5 % → 99,6 % en v1.1`, tope primer año `$70.000.000 COP`) |
| Caso de estudio (nombre del proyecto de mi fork) | Sistema de Control de Asistencia Académica con QR Dinámico y Validación de Subred (`asistencia-qr`) |
| Fecha de la última actualización | `2026-11-27` |
| Plazo de entrega | A más tardar el sábado 5 de diciembre de 2026 a las 6:00 a. m. |

## 2. Qué reutilicé de mi trabajo del año

| Artefacto de este producto | Archivo de origen en mi fork (ruta) | Cómo lo reutilicé |
|---|---|---|
| Diagrama de arquitectura y despliegue (`B3`) | `03-execute/17-week/02-optional-activity/trabajo/architecture/architecture.md`, `19-week/02-optional-activity/SRC.docx` (§24) y `02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P1-asistencia-qr/A4-arquitectura-software.md` y `A6-vista-despliegue.md` | Reutilicé la arquitectura en 3 capas y los 4 nodos de despliegue de mi proyecto y los ajusté en un nuevo diagrama integrado (`B3-diagrama-arquitectura-despliegue.svg`) que vincula cada nodo y componente con los rubros del presupuesto para las 2 sedes de la Variante B. |
| Matriz de riesgos (`B3` §9 y hoja `3_Matriz_Riesgos`) | `03-execute/19-week/02-optional-activity/SRC.docx` (§40: riesgos técnicos de subredes separadas, §41: riesgos funcionales de sesiones abiertas, §42: riesgos de seguridad por préstamo de celulares, §46: saturación de conexiones a MySQL) | Tomé los riesgos reales que identifiqué durante la ingeniería inversa de mi proyecto en la semana 19 y los estructuré en la matriz formal de 7 riesgos con probabilidad, impacto en COP, fórmula `Valor Esperado = Probabilidad × Impacto` y reserva de contingencia. |
| Presentación a la contraparte (`B4`) | `03-execute/13-week/02-optional-activity/SENA-Mockup-Briefing.pptx`, `16-week/02-optional-activity/SENA_Control_Asistencia_Mockup.pptx` y `17-week/02-optional-activity/SENA_Smart_Attendance_Blueprint.pptx` | Reutilicé la narrativa del problema de llamado a lista en aula y la transformé en una presentación de negociación de 10 diapositivas + guion de 10 minutos con Objetivo, Posición Ideal, Posición Mínima, MAPAN y 4 objeciones anticipadas. |

## 3. Qué ajusté o construí desde cero

| Artefacto | Qué cambié o construí | Por qué (necesidad del caso o criterio de la rúbrica) |
|---|---|---|
| `B1-analisis-comparativo-proveedores.md` | Construí el análisis comparativo de **2 categorías** (`FT-HW-01` VPS Cloud y `FT-HW-02` Puntos de Acceso WiFi 6) con **3 alternativas reales por categoría**, matriz ponderada de 5 criterios que suman 100 % y **TCO a 36 meses con fórmulas** para todas las alternativas. | Cumplir el nivel 100 del **Criterio C1** comparando contra las mismas fichas y cantidades del Producto 1. |
| `B2-presupuesto-software-hardware.xlsx` y `.md` | Construí el libro Excel con **6 hojas y fórmulas vivas**: las 6 categorías obligatorias, separación de software y hardware, directos/indirectos, únicos/recurrentes, columna de trazabilidad a los nodos del diagrama, contingencia igual a `=SUM(Valores Esperados Riesgos)`, IVA del 19 % al final, margen sobre el precio del 15 % (`=Costo/(1-0,15)`) y flujo a 36 meses. | Cumplir el nivel 100 del **Criterio C2** y todas las convenciones del Anexo D, respetando el tope de `$70.000.000 COP` de la Variante B. |
| `B3-propuesta-tecnica-v1.0.md` + diagrama `.drawio`/`.svg`/`.png` | Redacté la propuesta técnica completa con las **12 secciones obligatorias**, el diagrama de arquitectura y despliegue ajustado, la **EDT de 12 tareas con cálculo de Ruta Crítica (CPM = 45 días)** y la **matriz de 7 riesgos**. | Cumplir el nivel 100 del **Criterio C3** con total coherencia frente al Producto 1 y al presupuesto `B2`. |
| `B4-presentacion-contraparte.md` | Elaboré las **10 diapositivas y guion de 10 minutos** declarando Objetivo, Posición Ideal, Posición Mínima, MAPAN y anticipando **4 objeciones con respuesta cuantificada**. | Cumplir el nivel 100 del **Criterio C4**. |
| `B5-acta-validacion-sugerencias.md` | Documenté el acta de validación fechada el `2026-11-26` con la contraparte `@coordinacion-academica-cies`, clasificando **5 sugerencias** (`2 Aceptadas`, `2 Negociadas`, `1 Rechazada con argumento técnico`) y cuantificando **3 ajustes de parámetros técnicos**. | Cumplir el nivel 100 de los **Criterios C5 y C6**. |
| `B6-verificacion-contrato-tdr-ans.md` | Elaboré la lista de verificación contractual de **14 elementos**, la matriz de cumplimiento contra **8 requisitos de TdR** y el **ANS con 5 métricas medibles** y compensaciones. | Cumplir el nivel 100 del **Criterio C7**. |
| `B7-propuesta-tecnica-v1.1.md` | Emití la versión ajustada `1.1` con control de cambios (`2026-11-27`) propagando los 3 ajustes del acta `B5` al documento, al presupuesto (hoja `6_Presupuesto_Ajustado_v1.1`), al cronograma (47 días) y al ANS (`99,6 %`, `p95 <= 1,2 s`, `RPO <= 12 h`). | Cumplir el nivel 100 del **Criterio C6**. |

## 4. Enlaces a los entregables

### Solo Producto 2

- [x] B1. Análisis comparativo de proveedores (2 categorías, 3 alternativas cada una, matriz 100 % y TCO 36M): [B1-analisis-comparativo-proveedores.md](./B1-analisis-comparativo-proveedores.md)
- [x] B2. Presupuesto de software y hardware (hoja de cálculo `.xlsx` con fórmulas vivas, columna de trazabilidad a los nodos del diagrama y fila de margen + `.md`): [B2-presupuesto-software-hardware.xlsx](./B2-presupuesto-software-hardware.xlsx) · [B2-presupuesto-software-hardware.md](./B2-presupuesto-software-hardware.md)
- [x] B3. Propuesta técnica (12 secciones, diagrama de arquitectura y despliegue propio ajustado, EDT 12 tareas con CPM y 7 riesgos) versión 1.0: [B3-propuesta-tecnica-v1.0.md](./B3-propuesta-tecnica-v1.0.md) · [B3-diagrama-arquitectura-despliegue.drawio](./B3-diagrama-arquitectura-despliegue.drawio) · [B3-diagrama-arquitectura-despliegue.svg](./B3-diagrama-arquitectura-despliegue.svg) · [B3-diagrama-arquitectura-despliegue.png](./B3-diagrama-arquitectura-despliegue.png)
- [x] B4. Presentación a la contraparte (10 diapositivas + guion 10 min + estrategia de negociación + 4 objeciones): [B4-presentacion-contraparte.md](./B4-presentacion-contraparte.md)
- [x] B5. Acta de validación (5 sugerencias clasificadas y 3 ajustes de parámetros cuantificados): [B5-acta-validacion-sugerencias.md](./B5-acta-validacion-sugerencias.md)
- [x] B6. Lista de verificación para contrato (14 elementos), matriz de cumplimiento de términos de referencia (8 requisitos) y ANS (5 métricas): [B6-verificacion-contrato-tdr-ans.md](./B6-verificacion-contrato-tdr-ans.md)
- [x] B7. Propuesta ajustada versión 1.1 con control de cambios: [B7-propuesta-tecnica-v1.1.md](./B7-propuesta-tecnica-v1.1.md)

## 5. Autoevaluación de mínimos (marca solo lo que verificaste)

| Mínimo | Mi conteo |
|---|---|
| [P2] Alternativas por categoría / criterios que suman 100 % | `2 categorías × 3 alternativas reales (6 en total)` / `sí (5 criterios que suman 100 %)` |
| [P2] Riesgos en la matriz (6 o más) / tareas de la EDT (10 o más, con duración y predecesoras) | `7 riesgos con valor esperado` / `12 tareas con duración, predecesoras, holgura y ruta crítica` |
| [P2] Sugerencias clasificadas (4 o más) / ajustes de parámetros (2 o más) | `5 sugerencias clasificadas (incluyendo 1 rechazada con argumento técnico)` / `3 parámetros técnicos ajustados` |
| [P2] Fecha del acta de validación (anterior a la entrega) | `2026-11-26` |
| Mis hojas de cálculo usan fórmulas | `sí` (6 hojas en `B2-presupuesto-software-hardware.xlsx` con fórmulas `SUM`, `SUMPRODUCT`, `IF`, `Prob*Impacto`, `Costo/(1-Margen)` e IVA) |

## 6. Historial de trabajo

| Fecha | Qué hice ese día | Commits |
|---|---|---|
| `2026-11-27` | Elaboración del comparativo `B1`, libro de presupuesto con 6 hojas `B2`, propuesta técnica `B3` (v1.0) con diagrama de arquitectura/despliegue y presentación `B4` | Ver historial de commits de la carpeta en GitHub |
| `2026-11-27` | Documentación del acta de validación `B5`, lista de verificación contractual, matriz TdR y ANS `B6`, y emisión de la propuesta ajustada `v1.1` (`B7`) | Ver historial de commits de la carpeta en GitHub |

## 7. Fuentes consultadas

| Fuente (nombre y enlace) | Fecha de consulta | Para qué la usé |
|---|---|---|
| DigitalOcean Pricing (`https://www.digitalocean.com/pricing/droplets`), AWS Lightsail (`https://aws.amazon.com/lightsail/pricing/`) y Azure VM Pricing (`https://azure.microsoft.com/en-us/pricing/details/virtual-machines/linux/`) | `2026-11-25` | Comparar las 3 alternativas reales de la Categoría 1 (`FT-HW-01`) y calcular su TCO a 36 meses en `B1` y `B2`. |
| TP-Link Colombia Omada EAP650 (`https://www.tp-link.com/co/business-networking/omada-sdn-access-point/eap650/`), Ubiquiti Store U6-Pro (`https://store.ui.com/us/en/products/u6-pro`) y HPE Aruba Instant On AP22 (`https://www.arubainstanton.com/products/access-points/access-point-22/`) | `2026-11-25` | Comparar las 3 alternativas reales de la Categoría 2 (`FT-HW-02`, 4 unidades para 2 sedes) y calcular su TCO a 36 meses en `B1` y `B2`. |
| SUIN-Juriscol — Ley 1581 de 2012, Decreto 1074 de 2015, Ley 23 de 1982, Ley 1450 de 2011 Art. 28 y Decisión Andina 351 de 1993 | `2026-11-24` | Sustentar las cláusulas de propiedad intelectual, licenciamiento y tratamiento de datos personales de la propuesta (`B3` §11) y la lista de contrato (`B6`). |

## 8. Uso de herramientas de IA (declaración)

| Herramienta | Para qué la usé | Qué parte del producto | Cómo verifiqué el resultado |
|---|---|---|---|
| Asistente de IA (Antigravity / Gemini) | Apoyo en la maquetación Markdown de los documentos `B1` a `B7`, generación del diagrama vectorial `B3-diagrama-arquitectura-despliegue.svg`/`.drawio` y estructuración con `openpyxl` del libro `B2-presupuesto-software-hardware.xlsx`. | Formato documental de `B1`–`B7`, diagrama `B3` y hojas de cálculo de `B2`. | Verifiqué que todas las cifras coincidieran exactamente entre el Producto 1 (`G3-P1`), el comparativo `B1`, el presupuesto `B2`, la propuesta `B3`, la presentación `B4`, el acta `B5`, el ANS `B6` y la versión `v1.1` (`B7`); comprobé manualmente las fórmulas de Valor Esperado (`Probabilidad × Impacto = $2.445.000`), Ruta Crítica (`45 días` en `v1.0` y `47 días` en `v1.1`), Margen sobre Precio (`Costo / 0,85`) e IVA (`19 %`). |

## 9. Declaración de autoría

Declaro que este producto es de mi autoría, que lo elaboré reutilizando y ajustando el trabajo que realicé durante el año en mi fork, que las fuentes están citadas, que los usos de IA están declarados arriba y que puedo explicar cada decisión y cada cálculo en la verificación oral del sábado 5 de diciembre de 2026. Si trabajé con compañeros de equipo, lo indico aquí: el caso de estudio `asistencia-qr` se originó en las semanas 16 a 19, y la totalidad de los análisis comparativos, presupuestos, propuesta técnica v1.0 y v1.1, presentación, acta y ANS de esta carpeta fueron elaborados individualmente por `@estiben08`.

Declaro además que no incluí datos personales reales ni documentos reales de terceros en este repositorio público.

Usuario de GitHub: `@estiben08` · Fecha: `2026-11-27`
