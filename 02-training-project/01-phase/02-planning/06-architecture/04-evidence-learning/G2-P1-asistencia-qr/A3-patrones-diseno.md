# A3 · Patrones de Diseño GoF Aplicados al Sistema `asistencia-qr`

**Proyecto:** Sistema de Control de Asistencia Académica con QR Dinámico (`asistencia-qr`)  
**Autor (GitHub):** `@estiben08` · **Ficha:** 3413974  
**RAP asociado:** 593103 (01) · Incorpora patrones de diseño propendiendo en mejores prácticas para la codificación y mantenibilidad del software (Criterio 3).

---

## 1. Resumen de Patrones GoF Aplicados (3 Patrones Distintos · Ninguno es Singleton)

Se aplican **3 patrones de diseño del catálogo Gang of Four (GoF)** directamente reflejados en el diagrama de clases [`A2-diagrama-clases.svg`](./A2-diagrama-clases.svg) (superando el mínimo exigible de 2 patrones distintos de Singleton):

| # | Patrón GoF | Categoría | Problema Concreto del Caso `asistencia-qr` | Por qué se eligió ese Patrón | Clases del Diagrama `A2` que lo Implementan | Qué Mejora en Mantenibilidad y Extensibilidad |
|---|---|---|---|---|---|---|
| **1** | **Estrategia (*Strategy*)** | Comportamental | Al recibir un escaneo QR (`RF-08`, `RF-09`), el sistema debe aplicar múltiples reglas antifraude (verificar firma `HMAC-SHA256` y ventana de 30 s, verificar coincidencia de subred IP del aula, y verificar que no exista doble registro en la sesión). Si todas estas validaciones se codifican con bloques `if/else` rígidos dentro del controlador o de `SesionAsistencia`, agregar en el futuro una nueva política (como código de sala rotativo CSR o geocerca GPS) obligaría a modificar y arriesgar el núcleo del servicio. | Permite encapsular cada algoritmo de validación antifraude en una clase separada que implementa una misma interfaz polimórfica, de modo que el servicio las evalúe en cadena sin acoplarse a sus detalles internos. | - **Interfaz Estrategia:** `IReglaValidacionAsistencia` (`+validar(solicitud, sesion)`).<br>- **Estrategias Concretas:** `ValidadorFirmaHMAC`, `ValidadorSubredIP`, `ValidadorUnicidadSesion`.<br>- **Contexto:** `ServicioControlAsistencia`. | Cumple el **Principio Abierto/Cerrado (OCP - SOLID)**: para incorporar una cuarta regla antifraude (ej. `ValidadorCodigoSalaCSR`) basta crear una nueva clase que implemente `IReglaValidacionAsistencia` sin tocar una sola línea de `ServicioControlAsistencia`, y permite probar cada regla en pruebas unitarias aisladas. |
| **2** | **Método Fábrica (*Factory Method*)** | Creacional | En la exportación de reportes históricos (`RF-12`), el instructor necesita descargar archivos livianos en formato `.csv` para importarlos a hojas de cálculo simples, mientras que el coordinador administrativo requiere libros `.xlsx` formateados con una pestaña adicional de alertas de deserción (`RF-13`). Si el controlador web instancia directamente `ExportadorCSV` o `ExportadorExcel` según cadenas condicionales, la capa de presentación queda acoplada a las librerías de generación de archivos. | Centraliza la decisión de creación del objeto exportador en una fábrica dedicada que devuelve la abstracción `IExportadorReporte`, desacoplando al cliente del tipo concreto de archivo que se genera. | - **Producto (Interfaz):** `IExportadorReporte` (`+exportar(registros): bytes`).<br>- **Productos Concretos:** `ExportadorCSV`, `ExportadorExcel`.<br>- **Creador / Fábrica:** `FabricaExportadorReporte` (`+crearExportador(formato: str): IExportadorReporte`). | Permite agregar nuevos formatos de exportación institucional en el futuro (por ejemplo, `ExportadorPDF` con acta firmada o `ExportadorJSON`) creando únicamente la clase concreta y registrándola en `FabricaExportadorReporte`, sin alterar los controladores ni las vistas de reportes. |
| **3** | **Fachada (*Facade*)** | Estructural | Las operaciones críticas de aula —como cerrar una sesión de asistencia (`RF-11`, `RF-13`)— requieren coordinar varios subsistemas en orden estricto: invalidar el último `TokenQRSesion`, cambiar el estado de `SesionAsistencia`, cruzar el padrón de `MatriculaFicha` para insertar los registros de «Inasistente», evaluar el umbral de 3 fallas para emitir `AlertaInasistencia` y guardar la traza en auditoría. Si la capa de presentación web invoca directamente a esos 5 componentes, se genera alto acoplamiento y riesgo de transacciones incompletas. | Proporciona un punto de entrada unificado de alto nivel en la capa de servicios que orquesta internamente a las entidades, validadores y repositorios, ofreciendo métodos simples a los controladores HTTP. | - **Fachada de Servicio:** `ServicioControlAsistencia` (`+aperturarSesion()`, `+procesarEscaneoQR()`, `+cerrarYConsolidarFallas()`).<br>- **Subsistemas coordinados:** `SesionAsistencia`, `TokenQRSesion`, `IReglaValidacionAsistencia`, `RegistroAsistencia`, `AlertaInasistencia`. | Reduce drásticamente el **acoplamiento aferente y eferente** entre la capa de presentación (vistas/controladores Flask) y el dominio: los controladores HTTP solo llaman a un método de `ServicioControlAsistencia`, garantizando consistencia transaccional y facilitando el mantenimiento. |

---

## 2. Evidencia de Polimorfismo en Código de Diseño (Patrón Estrategia + Método Fábrica)

```python
from abc import ABC, abstractmethod
from typing import List

class IReglaValidacionAsistencia(ABC):
    @abstractmethod
    def validar(self, solicitud: "SolicitudEscaneo", sesion: "SesionAsistencia") -> "ResultadoValidacion":
        pass

class ValidadorFirmaHMAC(IReglaValidacionAsistencia):
    def validar(self, solicitud: "SolicitudEscaneo", sesion: "SesionAsistencia") -> "ResultadoValidacion":
        # Verifica autenticidad HMAC-SHA256 y vigencia dentro de la ventana de 30 s (RF-05, RF-06, RF-08)
        ...

class ValidadorSubredIP(IReglaValidacionAsistencia):
    def validar(self, solicitud: "SolicitudEscaneo", sesion: "SesionAsistencia") -> "ResultadoValidacion":
        # Verifica que ipOrigenAprendiz pertenezca a la subred CIDR del ambiente (RF-08)
        ...

class ValidadorUnicidadSesion(IReglaValidacionAsistencia):
    def validar(self, solicitud: "SolicitudEscaneo", sesion: "SesionAsistencia") -> "ResultadoValidacion":
        # Verifica que no exista un RegistroAsistencia previo en la misma sesion (RF-09)
        ...

class ServicioControlAsistencia:
    def __init__(self, reglas: List[IReglaValidacionAsistencia]) -> None:
        self._reglas = reglas

    def procesar_escaneo_qr(self, solicitud: "SolicitudEscaneo", sesion: "SesionAsistencia") -> "RegistroAsistencia":
        # Invocación polimórfica: el servicio no conoce qué regla concreta ejecuta
        for regla in self._reglas:
            resultado = regla.validar(solicitud, sesion)
            if not resultado.es_valido:
                raise ValueError(resultado.motivo_rechazo)
        return sesion.registrar_presencia(solicitud)
```
