# Guía de Contribución

¡Gracias por tu interés en contribuir al proyecto Control de Personal! 

## 🚀 Cómo Contribuir

### **Antes de Empezar**

1. **Fork el repositorio**
2. **Clona tu fork localmente**
   ```bash
   git clone https://github.com/tu-usuario/control_de_personal.git
   cd control_de_personal
   ```
3. **Instala las dependencias**
   ```bash
   flutter pub get
   ```
4. **Configura Firebase** (opcional para desarrollo local)
   - Crea un proyecto en Firebase Console
   - Configura las credenciales en `lib/firebase_options.dart`

### **Flujo de Trabajo**

1. **Crea una rama para tu feature**
   ```bash
   git checkout -b feature/nombre-de-tu-feature
   ```

2. **Desarrolla tu feature**
   - Sigue las convenciones de código de Dart/Flutter
   - Escribe tests si es necesario
   - Documenta cambios importantes

3. **Commit tus cambios**
   ```bash
   git add .
   git commit -m "feat: agregar nueva funcionalidad de filtros"
   ```

4. **Push a tu fork**
   ```bash
   git push origin feature/nombre-de-tu-feature
   ```

5. **Crea un Pull Request**
   - Ve a tu fork en GitHub
   - Click en "New Pull Request"
   - Selecciona la rama main del repositorio original
   - Describe tus cambios

## 📝 Convenciones de Código

### **Dart/Flutter**
- Usa **camelCase** para variables y métodos
- Usa **PascalCase** para clases
- Usa **snake_case** para archivos
- Mantén líneas de código bajo 80 caracteres
- Usa 2 espacios para indentación

### **Commits**
Usa el formato **Conventional Commits**:
- `feat:` para nuevas funcionalidades
- `fix:` para correcciones de bugs
- `docs:` para cambios en documentación
- `style:` para cambios de formato
- `refactor:` para refactorización
- `test:` para agregar tests
- `chore:` para tareas de mantenimiento

### **Ejemplos de Commits**
```bash
feat: agregar filtros avanzados en tabla de encargados
fix: corregir error de ordenamiento en nombres vacíos
docs: actualizar README con nuevas funcionalidades
style: mejorar diseño de botones de acción
```

## 🧪 Testing

### **Ejecutar Tests**
```bash
flutter test
```

### **Cobertura de Código**
```bash
flutter test --coverage
```

### **Analizar Código**
```bash
flutter analyze
```

## 📋 Checklist para Pull Requests

Antes de enviar tu PR, asegúrate de:

- [ ] **Código funciona** sin errores
- [ ] **Tests pasan** (si aplica)
- [ ] **Análisis estático** sin warnings
- [ ] **Documentación actualizada** (si es necesario)
- [ ] **Commits descriptivos** y bien formateados
- [ ] **Descripción clara** del PR
- [ ] **Screenshots** de cambios visuales (si aplica)

## 🐛 Reportar Bugs

### **Antes de Reportar**
1. Busca en los issues existentes
2. Verifica que el bug no haya sido reportado
3. Intenta reproducir el bug en la última versión

### **Template para Bug Report**
```markdown
**Descripción del Bug**
Descripción clara y concisa del bug.

**Pasos para Reproducir**
1. Ve a '...'
2. Click en '...'
3. Scroll hasta '...'
4. Ver error

**Comportamiento Esperado**
Descripción de lo que debería pasar.

**Screenshots**
Si aplica, agrega screenshots.

**Información del Sistema**
- OS: [ej. Windows 10]
- Flutter: [ej. 3.19.0]
- Browser: [ej. Chrome 120]

**Contexto Adicional**
Cualquier otra información relevante.
```

## 💡 Sugerencias de Features

### **Template para Feature Request**
```markdown
**Problema a Resolver**
Descripción del problema que esta feature resolvería.

**Solución Propuesta**
Descripción de la solución que propones.

**Alternativas Consideradas**
Otras soluciones que consideraste.

**Contexto Adicional**
Cualquier información adicional.
```

## 🤝 Código de Conducta

### **Nuestros Estándares**
- Usar lenguaje respetuoso e inclusivo
- Ser receptivo a críticas constructivas
- Enfocarse en lo que es mejor para la comunidad
- Mostrar empatía hacia otros miembros

### **Nuestras Responsabilidades**
- Clarificar estándares de comportamiento aceptable
- Tomar acciones correctivas apropiadas y justas
- Responder a situaciones que requieran atención

## 📞 Contacto

### **Preguntas Generales**
- **Issues**: [GitHub Issues](https://github.com/tu-usuario/control_de_personal/issues)
- **Discussions**: [GitHub Discussions](https://github.com/tu-usuario/control_de_personal/discussions)

### **Contacto Directo**
- **Email**: tu-email@ejemplo.com

## 🙏 Agradecimientos

Gracias a todos los contribuidores que han ayudado a hacer este proyecto mejor:

- [Lista de contribuidores](https://github.com/tu-usuario/control_de_personal/graphs/contributors)

---

**¡Gracias por contribuir al proyecto Control de Personal! 🎉** 