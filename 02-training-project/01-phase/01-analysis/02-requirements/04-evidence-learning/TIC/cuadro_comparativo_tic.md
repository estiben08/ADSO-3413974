# Cuadro Comparativo: Equipos TIC, Periféricos y Servicios
**Proyecto Formativo:** Desarrollo de software orientado a servicios V2.

## 1. Equipos TIC
| Equipo / Dispositivo | Características Principales | Ventajas | Uso Sugerido en el Proyecto |
| :--- | :--- | :--- | :--- |
| **Computador de Escritorio (Desktop)** | Alta capacidad de procesamiento, escalable, requiere estar conectado a la corriente. | Mayor rendimiento por menor costo. Fácil de actualizar (RAM, GPU). | Estación de trabajo principal para programación y pruebas de software pesadas. |
| **Computador Portátil (Laptop)** | Procesador de consumo eficiente, batería integrada, todo en uno. | Movilidad y flexibilidad para trabajar en cualquier lugar. | Trabajo remoto, reuniones con el equipo y presentaciones del software. |
| **Dispositivo Móvil (Smartphone/Tablet)** | Pantalla táctil, procesador ARM, sensores integrados (GPS, cámara). | Alta portabilidad, conectividad constante (4G/5G). | Pruebas de interfaces responsivas (Mobile First) y testing de la aplicación. |

## 2. Periféricos
| Tipo | Dispositivo | Función / Características | Aplicación en el Desarrollo |
| :--- | :--- | :--- | :--- |
| **Entrada** | Teclado Mecánico y Ratón Ergonómico | Permiten ingresar datos e interactuar con la interfaz del sistema. | Escritura de código (confort para largas horas) y navegación en el IDE. |
| **Salida** | Monitor Externo (24" o 27") | Dispositivo de visualización principal o extendida. | Visualizar el código en una pantalla y el resultado (interfaz web/app) en la otra. |
| **Mixto** | Diadema con Micrófono (Headset) | Entrada de audio (micrófono) y salida de audio (auriculares). | Comunicación efectiva en reuniones de equipo (Scrum/Dailies). |

## 3. Tecnologías de Almacenamiento
| Tecnología | Velocidad | Características | Recomendación para el Proyecto |
| :--- | :--- | :--- | :--- |
| **HDD (Disco Mecánico)** | Lenta (80 - 160 MB/s) | Partes móviles, mayor probabilidad de fallo físico. Alta capacidad a bajo costo. | Almacenamiento de respaldos (backups) y archivos históricos pesados. |
| **SSD SATA** | Media-Alta (hasta 550 MB/s) | Memoria flash sin partes móviles. Más resistente y rápido que el HDD. | Unidad secundaria para guardar recursos del proyecto, máquinas virtuales o contenedores. |
| **SSD NVMe (M.2)** | Muy Alta (hasta 7000+ MB/s) | Conexión directa a la placa base por bus PCIe. Rendimiento extremo. | **Elección principal:** Instalar aquí el Sistema Operativo y los IDEs (VS Code, bases de datos) para compilación rápida. |

## 4. Sistemas Operativos
| Sistema Operativo | Pilar Principal / Características | Ventajas para Desarrollo |
| :--- | :--- | :--- |
| **Windows** | Amplia compatibilidad de software, entorno gráfico intuitivo (GUI), DirectX. | Compatibilidad universal, soporte para WSL (Windows Subsystem for Linux) muy útil en dev. |
| **Linux (Ubuntu/Debian)** | Código abierto, excelente gestión de procesos y seguridad, terminal potente. | Entorno nativo para servidores, Docker y desarrollo backend moderno. |
| **macOS** | Basado en Unix, ecosistema cerrado y altamente optimizado. | Exclusivo y necesario si el software requiere desarrollo para entornos iOS/Apple. |

## 5. Servicios de Internet y Conectividad
| Servicio / Herramienta | Tipo de Servicio | Uso en el Proyecto de Desarrollo |
| :--- | :--- | :--- |
| **GitHub / GitLab** | Plataforma Colaborativa / Repositorio | Control de versiones del código fuente, trabajo colaborativo y revisión de código. |
| **Google Workspace / Office 365** | Ofimática en la Nube | Redacción de requerimientos, manuales de usuario y colaboración en tiempo real. |
| **Fibra Óptica / Wi-Fi 6** | Conectividad | Subida y bajada rápida de imágenes Docker, repositorios pesados y videollamadas sin latencia. |
| **AWS / Azure / Google Cloud** | Computación en la Nube (IaaS/PaaS) | Despliegue del software orientado a servicios (servidores de prueba y producción). |
