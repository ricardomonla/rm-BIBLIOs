# RM-rmBiblioteca - Gestión de Videos de Estudio

Una aplicación web para gestionar y organizar videos educativos de estudio.

## Características

- **Organización por categorías**: Los videos se agrupan en categorías temáticas
- **Acordeones individuales**: Cada video se puede expandir/colapsar individualmente para ver detalles
- **Miniaturas automáticas**: Generadas automáticamente desde YouTube usando el ID del video
- **Edición inline**: Permite editar descripciones y comentarios personales
- **Guardado automático**: Los cambios se guardan automáticamente en localStorage
- **Interfaz responsive**: Funciona en dispositivos móviles y desktop

## Cómo ejecutar

### Opción 1: Servidor local con Python

1. Abrir una terminal en el directorio del proyecto
2. Ejecutar el comando:
   ```bash
   cd biblioweb && python3 -m http.server 3000
   ```
3. Abrir el navegador y ir a: `http://localhost:3000`

### Opción 2: Abrir directamente en el navegador

1. Abrir el archivo `biblioweb/index.html` directamente en el navegador
2. Nota: Algunas funcionalidades pueden no estar disponibles al abrir archivos locales directamente

## Estructura del proyecto

```
biblioweb/
├── index.html      # Página principal
├── script.js       # Lógica de la aplicación
├── styles.css      # Estilos CSS
├── data.json       # Datos de videos (generado desde bd_videos.yml)
└── bd_videos.yml   # Archivo fuente de datos en formato YAML
```

## Funcionalidades

### Navegación
- **Categorías**: Se muestran como separadores visuales sin colapso
- **Videos**: Click en cualquier parte del video para expandir/colapsar detalles

### Edición
- **Descripción**: Click en el texto de descripción para editar
- **Comentario**: Click en el texto del comentario para editar
- **Calificación**: Click en las estrellas para cambiar la calificación

### Enlaces
- **Miniatura**: Click para abrir el video en YouTube
- **Título**: Click para abrir el video en YouTube
- **Canal**: Click para abrir el canal del autor en YouTube

## Datos

Los datos se cargan desde `bd_videos.yml` y se convierten automáticamente a `data.json`. Si no se puede cargar el YAML, se usa el JSON como respaldo.

## Tecnologías utilizadas

- HTML5
- CSS3
- JavaScript (ES6+)
- js-yaml (para parseo de YAML)