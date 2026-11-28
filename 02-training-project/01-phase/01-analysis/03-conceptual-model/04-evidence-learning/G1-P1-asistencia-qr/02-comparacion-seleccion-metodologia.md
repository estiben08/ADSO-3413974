# 02 · Comparación de Metodologías y Selección Justificada

**Proyecto:** Sistema de Control de Asistencia Académica con QR Dinámico (`asistencia-qr`)  
**Autor (GitHub):** `@estiben08`  
**RAP asociado:** 592375 · Planear actividades de análisis de acuerdo con la metodología seleccionada (Criterios C1 y C2).

---

## 1. Matriz Comparativa de Metodologías frente a las Características del Proyecto

Se evalúan las cuatro metodologías estudiadas en la guía (**RUP**, **Scrum**, **Programación Extrema - XP** y **RAD**) contrastándolas directamente con los **4 aspectos de caracterización** definidos en `01-caracterizacion-solucion.md` y dos criterios técnicos adicionales del caso (trazabilidad de artefactos UML y gestión de reglas antifraude):

| Criterio derivado de la caracterización | RUP (Rational Unified Process) | Scrum (Marco Ágil Iterativo e Incremental) | XP (Extreme Programming) | RAD (Rapid Application Development) |
|---|---|---|---|---|
| **1. Adecuación al tipo de proyecto** *(App web institucional con validación QR/HMAC/IP y reportes)* | **Alta en modelado, baja en agilidad:** Su enfoque por fases (Inicio, Elaboración, Construcción, Transición) y casos de uso modela muy bien la seguridad, pero genera sobrecarga documental para un MVP web de aula. | **Muy Alta:** Permite estructurar los requisitos en un *Product Backlog* priorizado (MoSCoW) y entregar incrementos verificables por Sprint (Sprint 1: Análisis y modelo conceptual; Sprint 2: Diseño y BD; Sprint 3: Módulo QR/IP; Sprint 4: Reportes y alertas). | **Media:** Excelente para calidad de código (TDD, integración continua), pero carece de énfasis en artefactos formales de análisis y modelado conceptual de datos que exige el proyecto formativo. | **Media-Baja:** Orientado a generación rápida de interfaces con herramientas CASE/Low-Code, pero débil cuando el núcleo crítico es criptografía HMAC y validación de red a nivel de protocolo. |
| **2. Ajuste al tamaño del equipo** *(1 a 3 aprendices con ajuste individual y dedicación parcial)* | **Baja:** RUP presupone roles especializados separados (arquitecto, analista de procesos, ingeniero de pruebas, gestor de configuración) que desbordan a un equipo de 1–3 aprendices. | **Muy Alta:** Funciona de forma óptima en equipos pequeños y autoorganizados donde los miembros asumen responsabilidades transversales con objetivos claros por Sprint. | **Media:** Prácticas obligatorias como programación en parejas (*Pair Programming*) al 100 % del tiempo no son viables cuando gran parte del trabajo de ajuste y entrega es individual. | **Media:** Requiere equipos SWAT altamente experimentados en herramientas de prototipado rápido para cumplir plazos comprimidos de 60–90 días. |
| **3. Respuesta a la estabilidad de requisitos** *(Núcleo estable con ajustes iterativos en rotación QR, contingencia y alertas)* | **Media:** Tolera cambios entre iteraciones de la fase de Elaboración, pero su control formal de cambios encarece ajustes rápidos derivados de pruebas en el aula. | **Muy Alta:** Congela el objetivo durante el Sprint (dando estabilidad al modelado y codificación), pero permite ajustar prioridades y criterios de aceptación en cada *Sprint Review* y *Sprint Planning*. | **Alta:** Diseñada para requisitos altamente volátiles que cambian incluso dentro de la misma semana, lo cual es más extremo de lo que requiere `asistencia-qr`. | **Media:** Si los requisitos de seguridad cambian después de la fase de diseño conjunto (JAD), obliga a rehacer prototipos completos. |
| **4. Aprovechamiento de la disponibilidad del cliente** *(Retroalimentación semanal en sesiones presenciales SENA)* | **Media:** La validación con el cliente se concentra en hitos formales al cierre de cada fase, desaprovechando el contacto semanal en el ambiente de formación. | **Muy Alta:** Se alinea exactamente con el ritmo semanal de la ficha: las sesiones presenciales operan como *Sprint Review* y refinamiento con el instructor (*Product Owner*). | **Media-Baja:** XP exige un «cliente en sitio» (*On-site Customer*) disponible a tiempo completo todos los días junto a los programadores, condición que ningún instructor tiene fuera de las sesiones de clase. | **Alta:** Utiliza talleres JAD intensivos con el usuario, aunque exige disponibilidad continua en bloques largos que no coinciden con el horario académico. |
| **5. Soporte a trazabilidad UML y verificación (Guías G1–G3)** | **Muy Alta:** Nativo en UML (casos de uso, actividades, dominio, clases, despliegue). | **Alta (con definición de *Definition of Done*):** Al incorporar en la *Definición de Terminado (DoD)* los artefactos UML, listas de chequeo y matriz de trazabilidad del programa ADSO, combina orden documental y entregas ágiles. | **Baja:** Minimiza la documentación previa en favor de pruebas unitarias y metáforas simples. | **Baja:** Prioriza pantallas funcionales sobre modelos conceptuales, normalización y matrices de trazabilidad. |

---

## 2. Evaluación Cuantitativa Ponderada

Se asigna peso a los criterios según las restricciones reales del proyecto formativo y se califica cada metodología de 1 a 5:

| Criterio | Peso | RUP | Scrum | XP | RAD |
|---|---|---|---|---|---|
| Adecuación al tipo de proyecto y reglas antifraude (QR/HMAC/IP) | 25 % | 4,0 | **5,0** | 3,5 | 3,0 |
| Ajuste al tamaño del equipo (1–3 aprendices, trabajo individual verificable) | 25 % | 2,0 | **5,0** | 3,0 | 3,0 |
| Gestión de estabilidad media-alta con refinamiento en aula | 20 % | 3,5 | **4,8** | 4,2 | 3,2 |
| Sincronía con la disponibilidad semanal del cliente (instructor/aprendices) | 15 % | 3,0 | **5,0** | 2,5 | 3,8 |
| Trazabilidad de artefactos de análisis y verificación por listas de chequeo | 15 % | **5,0** | **4,5** | 2,0 | 2,5 |
| **Puntaje Ponderado Total (sobre 5,0)** | **100 %** | **3,43** | **4,89** | **3,14** | **3,09** |

---

## 3. Metodología Seleccionada y Justificación

### Metodología seleccionada: **Scrum**

> **Nota sobre regla de arbitraje #7 (`Rubricas_G1.md`):** Se selecciona **Scrum** como metodología única de gestión y desarrollo para el proyecto `asistencia-qr`, estructurando la fase de análisis en **2 Sprints de 1 semana cada uno** (con entregas incrementales de artefactos verificados en su *Definition of Done*). No se realiza una mezcla no justificada: dentro del marco Scrum, los elementos del *Product Backlog* de la fase de análisis producen como incremento verificable los modelos UML y el MER exigidos por el estándar técnico del programa.

### Justificación vinculada a las 4 características de la solución:

1. **Por el tamaño del equipo (1–3 aprendices con consolidación individual por `@estiben08`):** A diferencia de RUP —que exige múltiples roles administrativos y decenas de artefactos ceremoniales—, Scrum permite concentrar el esfuerzo en un flujo ligero de *Product Backlog -> Sprint Backlog -> Incremento verificado*, ideal para una carga de 6 a 12 horas semanales.
2. **Por la disponibilidad semanal del cliente en el SENA:** Las sesiones presenciales de los sábados y los encuentros semanales con el instructor funcionan de forma natural como eventos de *Sprint Planning*, *Sprint Review* y validación de prototipos, sin requerir el cliente a tiempo completo diario que exige XP.
3. **Por la estabilidad media-alta de los requisitos:** Scrum permite fijar en el *Sprint Backlog* los 12 requisitos funcionales (`RF-01` a `RF-12`) priorizados con MoSCoW (*Must Have*, *Should Have*, *Could Have*), e incorporar en el segundo Sprint los ajustes derivados de la verificación (como el caso de uso de registro manual por contingencia `CU-07` y las alertas tempranas `CU-10`).
4. **Por el tipo de proyecto y control de calidad:** En Scrum, la **Definición de Terminado (*Definition of Done - DoD*)** de cada actividad de análisis exige que todo caso de uso tenga trazabilidad hacia un requisito funcional, su flujo de actividades, su clase de dominio, su entidad en el MER y su validación en la lista de chequeo de 18 criterios antes de cerrar el Sprint.
