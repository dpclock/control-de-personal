# Control de Personal - Sistema de Gestión

Una aplicación Flutter para la gestión de personal y control de asistencia en empresas constructoras.

## 🏗️ Características Principales

### **Gestión de Personal**
- ✅ Control de asistencia por día
- ✅ Gestión de trabajadores (SEANSA y TOLEBRICK)
- ✅ Gestión de proyectos/obras de construcción
- ✅ Seguimiento por encargados (DIONI, GERMAN, LUTE, VICTOR)
- ✅ Filtros y búsqueda avanzada
- ✅ Ordenamiento inteligente de datos

### **Funcionalidades Avanzadas**
- 📊 **Tabla tipo Excel** con 12 meses (pestañas)
- 🔍 **Búsqueda en tiempo real** por nombre y obra
- 📈 **Cálculo automático** de totales por fila
- 📄 **Exportación a PDF** por mes
- ☁️ **Sincronización con Firebase** como respaldo
- 📱 **Multiplataforma**: Web, Android, iOS, Windows, macOS

### **Interfaz Intuitiva**
- 🎨 **Material Design 3** con gradientes modernos
- 📱 **Responsive** para diferentes tamaños de pantalla
- ⚡ **Scroll horizontal** para tablas grandes
- 🔄 **Paginación optimizada**
- 🎯 **Navegación intuitiva** entre pestañas

## 🚀 Instalación y Configuración

### **Requisitos Previos**
- Flutter SDK (versión 3.7.2 o superior)
- Dart SDK
- Firebase project configurado

### **Pasos de Instalación**

1. **Clonar el repositorio**
```bash
git clone https://github.com/tu-usuario/control_de_personal.git
cd control_de_personal
```

2. **Instalar dependencias**
```bash
flutter pub get
```

3. **Configurar Firebase**
   - Crear proyecto en [Firebase Console](https://console.firebase.google.com/)
   - Descargar `google-services.json` para Android
   - Configurar `firebase_options.dart` con tus credenciales

4. **Ejecutar la aplicación**
```bash
flutter run
```

## 📱 Uso de la Aplicación

### **Pantalla Principal**
- Selecciona un **encargado** (DIONI, GERMAN, LUTE, VICTOR)
- Navega por los **12 meses** usando las pestañas
- Completa los datos de **trabajadores** y **obras**
- Registra la **asistencia** día a día

### **Gestión de Datos**
- **Agregar trabajadores**: Botón flotante (+) en pestaña Trabajadores
- **Editar datos**: Click en icono de editar (lápiz)
- **Eliminar elementos**: Click en icono de eliminar (papelera)
- **Buscar**: Campo de búsqueda en tiempo real

### **Filtros y Organización**
- **Click en encabezados**: Abre opciones de filtro y ordenamiento
- **Búsqueda por texto**: Filtra por contenido específico
- **Ordenamiento**: Alfabético o numérico ascendente/descendente
- **Limpiar filtros**: Botón en barra de estado

### **Exportación**
- **Exportar PDF**: Menú de opciones → Exportar PDF
- **Compartir datos**: Menú de opciones → Compartir
- **Guardar configuración**: Menú de opciones → Guardar

## 🛠️ Tecnologías Utilizadas

### **Frontend**
- **Flutter**: Framework de desarrollo multiplataforma
- **Dart**: Lenguaje de programación
- **Material Design 3**: Sistema de diseño

### **Backend**
- **Firebase Firestore**: Base de datos en la nube
- **Firebase Auth**: Autenticación (preparado para futuro)
- **Firebase Core**: Configuración base

### **Dependencias Principales**
```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^3.6.0
  cloud_firestore: ^5.4.0
  firebase_auth: ^5.3.1
  pdf: ^3.10.7
  path_provider: ^2.1.2
  share_plus: ^7.2.1
  permission_handler: ^11.3.0
```

## 📊 Estructura de Datos

### **Trabajadores**
- **SEANSA**: ~122 trabajadores predefinidos
- **TOLEBRICK**: ~80 trabajadores predefinidos
- **Gestión dinámica**: Agregar, editar, eliminar

### **Proyectos/Obras**
- **~80 proyectos** de construcción predefinidos
- **Constructoras**: AVINTIA, ARPADA, ASENTIS, etc.
- **Gestión dinámica**: Agregar, editar, eliminar

### **Control de Asistencia**
- **Valores por día**: 1-10 (horas), V (vacaciones), F (faltó), ZZ (sin asignar)
- **Cálculo automático**: Total de horas por fila
- **Persistencia**: Datos guardados en Firebase

## 🌐 Despliegue Web

### **GitHub Pages**
La aplicación está configurada para desplegarse automáticamente en GitHub Pages.

### **URL de Producción**
```
https://tu-usuario.github.io/control_de_personal/
```

### **Configuración Automática**
- **Workflow GitHub Actions**: Despliegue automático en push a main
- **Flutter Web**: Compilación optimizada para web
- **Firebase Hosting**: Configurado como alternativa

## 🔧 Configuración de Desarrollo

### **Variables de Entorno**
```bash
# Firebase Configuration
FIREBASE_API_KEY=tu-api-key
FIREBASE_PROJECT_ID=tu-project-id
FIREBASE_MESSAGING_SENDER_ID=tu-sender-id
```

### **Scripts Útiles**
```bash
# Ejecutar en modo desarrollo
flutter run -d chrome

# Construir para web
flutter build web

# Ejecutar tests
flutter test

# Analizar código
flutter analyze
```

## 📈 Roadmap

### **Próximas Funcionalidades**
- 🔐 **Autenticación de usuarios**
- 📊 **Reportes avanzados**
- 📱 **Notificaciones push**
- 🔄 **Sincronización offline**
- 📈 **Gráficos y estadísticas**

### **Mejoras Técnicas**
- ⚡ **Optimización de rendimiento**
- 🎨 **Temas personalizables**
- 🌍 **Internacionalización**
- 📱 **PWA (Progressive Web App)**

## 🤝 Contribución

### **Cómo Contribuir**
1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

### **Estándares de Código**
- **Dart/Flutter**: Seguir las convenciones oficiales
- **Commits**: Usar mensajes descriptivos
- **Documentación**: Mantener README actualizado

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## 📞 Soporte

### **Contacto**
- **Email**: tu-email@ejemplo.com
- **Issues**: [GitHub Issues](https://github.com/tu-usuario/control_de_personal/issues)
- **Discussions**: [GitHub Discussions](https://github.com/tu-usuario/control_de_personal/discussions)

### **Documentación Adicional**
- [Flutter Documentation](https://docs.flutter.dev/)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Material Design](https://material.io/design)

---

**Desarrollado con ❤️ usando Flutter y Firebase**
