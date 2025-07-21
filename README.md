# Control de Personal

Aplicación Flutter para la gestión y control de personal en obras de construcción.

## 🏗️ Características Principales

- **Gestión de Trabajadores**: Administración completa de datos de empleados
- **Gestión de Proyectos**: Control de obras y proyectos
- **Control de Asistencia**: Registro diario por encargados
- **Exportación PDF**: Generación de reportes en formato PDF
- **Sincronización Firebase**: Almacenamiento en la nube
- **Filtros y Búsqueda**: Búsqueda avanzada de trabajadores y proyectos

## 📱 Funcionalidades

### 🏢 Administración
- Gestión de trabajadores (nombre, empresa, NAF/IPF, DNI)
- Gestión de proyectos (obra, constructora, estado, tipo)
- Sincronización automática con Firebase
- Pantallas emergentes compactas para edición

### 👥 Control de Personal
- Registro diario de asistencia
- 20 páginas por mes (400 filas totales)
- Filtros por nombre y obra
- Ordenación ascendente/descendente
- Exportación a PDF con formato profesional
- Selector de obra integrado en la barra de desplazamiento

### 👨‍💼 Encargados
- **DIONI**
- **GERMAN**  
- **LUTE**
- **VICTOR**

### 🎯 Características Técnicas
- Pantallas emergentes compactas y optimizadas
- Selector de trabajador/obra con búsqueda
- Persistencia completa en Firebase
- Interfaz responsive y moderna
- Navegación intuitiva con tabs por meses

## 🛠️ Tecnologías

- **Flutter**: Framework de desarrollo multiplataforma
- **Firebase Firestore**: Base de datos en la nube
- **PDF**: Generación de reportes profesionales
- **Material Design 3**: Interfaz de usuario moderna

## 🚀 Instalación

1. Clona el repositorio
```bash
git clone [URL_DEL_REPOSITORIO]
cd control_de_personal
```

2. Instala las dependencias
```bash
flutter pub get
```

3. Configura Firebase (ver sección de configuración)

4. Ejecuta la aplicación
```bash
flutter run
```

## 🔧 Configuración Firebase

1. Crea un proyecto en [Firebase Console](https://console.firebase.google.com/)
2. Habilita Firestore Database
3. Configura las reglas de seguridad
4. Descarga y coloca `google-services.json` (Android) y `GoogleService-Info.plist` (iOS)
5. Actualiza `lib/firebase_options.dart` con tu configuración

## 📊 Estructura del Proyecto

```
lib/
├── main.dart                 # Archivo principal de la aplicación
├── services/
│   └── firebase_service.dart # Servicios de Firebase
├── firebase_options.dart     # Configuración de Firebase
├── file_saver.dart          # Utilidades para guardar archivos
├── io_file_saver.dart       # Guardado para móvil/desktop
└── web_file_saver.dart      # Guardado para web
```

## 🎨 Características de la UI

- **Diseño Material 3**: Interfaz moderna y consistente
- **Temas personalizados**: Colores corporativos
- **Responsive**: Adaptable a diferentes tamaños de pantalla
- **Accesibilidad**: Navegación intuitiva y clara

## 📈 Funcionalidades Avanzadas

- **Paginación inteligente**: 20 filas por página
- **Filtros dinámicos**: Búsqueda en tiempo real
- **Exportación personalizada**: PDF con datos filtrados
- **Sincronización automática**: Datos siempre actualizados
- **Backup automático**: Datos seguros en la nube

## 🔒 Seguridad

- Autenticación Firebase
- Reglas de seguridad en Firestore
- Datos encriptados en tránsito
- Backup automático de información

## 📄 Licencia

Este proyecto es privado y confidencial. Todos los derechos reservados.

## 🤝 Soporte

Para soporte técnico o consultas sobre la aplicación, contacta al equipo de desarrollo.

---

**Versión**: 1.0.0  
**Última actualización**: Diciembre 2024  
**Desarrollado con**: Flutter & Firebase
