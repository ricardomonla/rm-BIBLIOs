// script.js - Lógica interactiva para la biblioteca de videos

let data = [];

// Función para validar URLs de forma segura
function isValidUrl(url) {
    try {
        const parsedUrl = new URL(url);
        // Solo permitir protocolos seguros
        return ['http:', 'https:'].includes(parsedUrl.protocol);
    } catch {
        return false;
    }
}

// Función para sanitizar URLs y prevenir XSS
function sanitizeUrl(url) {
    if (!isValidUrl(url)) {
        console.warn('URL inválida detectada:', url);
        return '#'; // URL segura por defecto
    }
    return url;
}

// Función para abrir enlaces de forma segura
function openSafeLink(url, target = '_blank') {
    const safeUrl = sanitizeUrl(url);
    if (safeUrl !== '#') {
        window.open(safeUrl, target, 'noopener,noreferrer');
    } else {
        alert('Enlace no válido o inseguro.');
    }
}

// Función para cargar datos desde JSON (única fuente de datos)
async function loadData() {
    try {
        const response = await fetch('data.json');
        data = await response.json();
        renderBiblioteca();
    } catch (error) {
        // Intentar cargar desde localStorage
        const localData = localStorage.getItem('biblioteca_data');
        if (localData) {
            data = JSON.parse(localData);
            renderBiblioteca();
        } else {
            // Cargar datos de ejemplo si falla
            loadSampleData();
        }
    }
}

// Datos de ejemplo para desarrollo
function loadSampleData() {
    data = [
        {
            categoria: "Comunicación y Colaboración",
            items: [
                {
                    titulo: "GUÍA BÁSICA PARA ENTENDER DISCORD - #ESimple",
                    ytb_id: "GxmmJjcRLOI",
                    aut_nom: "ESimple",
                    aut_canal: "@ESimple",
                    descripcion: "Guía completa para principiantes que cubre creación de cuenta, interfaz, servidores, canales de texto/voz, roles, permisos y configuración esencial de Discord.",
                    estrellas: 5,
                    comentario: "Excelente introducción para nuevos usuarios, con explicaciones claras y ejemplos prácticos de todas las funciones básicas."
                }
            ]
        },
        {
            categoria: "Desarrollo - Editores y Herramientas",
            items: [
                {
                    titulo: "Curso de VISUAL STUDIO CODE desde CERO (Completo)",
                    ytb_id: "TbzrOz8HbFM",
                    aut_nom: "Soy Dalto",
                    aut_canal: "@SoyDalto",
                    descripcion: "Curso completo de 2+ horas cubriendo interfaz, configuración, extensiones, Git, debugging, snippets, Emmet, shortcuts y herramientas avanzadas de VS Code.",
                    estrellas: 5,
                    comentario: "Uno de los mejores cursos en español para dominar VS Code. Muy completo, bien estructurado y con ejemplos prácticos."
                }
            ]
        }
    ];
    renderBiblioteca();
}

// Función para renderizar la biblioteca
function renderBiblioteca() {
    const biblioteca = document.getElementById('biblioteca');
    biblioteca.innerHTML = '';

    data.forEach((cat, catIndex) => {
        const catDiv = document.createElement('div');
        catDiv.className = 'categoria';

        const catTitle = document.createElement('div');
        catTitle.className = 'categoria-titulo';
        catTitle.textContent = `📂 ${cat.categoria}`;
        // Removido onclick para categorías - ahora se activan por video
        catDiv.appendChild(catTitle);

        const catContent = document.createElement('div');
        catContent.className = 'categoria-contenido';

        cat.items.forEach((video, videoIndex) => {
            const videoDiv = document.createElement('div');
            videoDiv.className = 'video';

            // El video completo es clickeable, no solo el header
            videoDiv.addEventListener('click', (e) => {
                // Evitar toggle si se hace click en elementos interactivos
                if (e.target.tagName === 'IMG' || e.target.tagName === 'A' || e.target.tagName === 'INPUT' || e.target.tagName === 'LABEL' || e.target.contentEditable === 'true') {
                    return;
                }
                e.stopPropagation(); // Prevenir bubbling
                toggleVideo(videoDiv);
            });

            const headerDiv = document.createElement('div');
            headerDiv.className = 'video-header';

            // Miniatura del video con fallback
            const img = document.createElement('img');
            img.className = 'video-thumbnail';
            const thumbnailUrl = `https://img.youtube.com/vi/${video.ytb_id}/maxresdefault.jpg`;
            console.log(`Loading thumbnail for ${video.titulo}: ${thumbnailUrl} (ytb_id: ${video.ytb_id})`);
            img.src = thumbnailUrl;
            img.alt = `Miniatura ${video.titulo}`;
            img.onclick = () => openSafeLink(`https://www.youtube.com/watch?v=${video.ytb_id}`);

            // Fallback si maxresdefault no existe
            img.onerror = function() {
                console.warn(`Miniatura maxresdefault no disponible para ${video.ytb_id}, intentando hqdefault`);
                const hqUrl = `https://img.youtube.com/vi/${video.ytb_id}/hqdefault.jpg`;
                console.log(`Fallback to hqdefault: ${hqUrl}`);
                this.src = hqUrl;
                this.onerror = function() {
                    console.warn(`Miniatura hqdefault tampoco disponible para ${video.ytb_id}, usando mqdefault`);
                    const mqUrl = `https://img.youtube.com/vi/${video.ytb_id}/mqdefault.jpg`;
                    console.log(`Fallback to mqdefault: ${mqUrl}`);
                    this.src = mqUrl;
                    this.onerror = function() {
                        console.error(`Ninguna miniatura disponible para ${video.ytb_id}, usando placeholder`);
                        console.log(`Final fallback to placeholder for ${video.ytb_id}`);
                        this.src = 'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTIwIiBoZWlnaHQ9IjkwIiB2aWV3Qm94PSIwIDAgMTIwIDkwIiBmaWxsPSJub25lIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgo8cmVjdCB3aWR0aD0iMTIwIiBoZWlnaHQ9IjkwIiBmaWxsPSIjZGRkIi8+Cjx0ZXh0IHg9IjYwIiB5PSI0NSIgZm9udC1mYW1pbHk9IkFyaWFsLCBzYW5zLXNlcmlmIiBmb250LXNpemU9IjEyIiBmaWxsPSIjOTk5IiB0ZXh0LWFuY2hvcj0ibWlkZGxlIiBkeT0iMC4zZW0iPk5vIGltYWdlPC90ZXh0Pgo8L3N2Zz4=';
                    };
                };
            };

            headerDiv.appendChild(img);

            // Título del video - ahora sin onclick directo, usa el header clickable
            const titleP = document.createElement('p');
            titleP.className = 'video-titulo';
            titleP.textContent = video.titulo;
            titleP.tabIndex = 0; // Accesibilidad
            titleP.onkeydown = (e) => {
                if (e.key === 'Enter' || e.key === ' ') {
                    e.preventDefault();
                    toggleVideo(videoDiv);
                }
            };
            headerDiv.appendChild(titleP);

            videoDiv.appendChild(headerDiv);

            const detailsDiv = document.createElement('div');
            detailsDiv.className = 'video-detalles';

            // Enlace al autor (video) - REMOVED: duplicado con canal

            // Descripción - EDITABLE
            const descDiv = document.createElement('div');
            descDiv.className = 'video-descripcion-container';
            const descP = document.createElement('p');
            descP.className = 'video-descripcion';
            descP.textContent = video.descripcion;
            descP.contentEditable = true;
            descP.onblur = () => updateDescription(catIndex, videoIndex, descP.textContent);
            descDiv.appendChild(descP);
            detailsDiv.appendChild(descDiv);

            // Sistema de calificación con estrellas
            const ratingDiv = document.createElement('div');
            ratingDiv.className = 'star-rating';
            ratingDiv.setAttribute('role', 'radiogroup');
            ratingDiv.setAttribute('aria-label', 'Calificación del video');

            for (let i = 5; i >= 1; i--) {
                const input = document.createElement('input');
                input.type = 'radio';
                input.id = `star-${catIndex}-${videoIndex}-${i}`;
                input.name = `rating-${catIndex}-${videoIndex}`;
                input.value = i;
                if (i === video.estrellas) input.checked = true;
                input.onchange = () => updateRating(catIndex, videoIndex, i);

                const label = document.createElement('label');
                label.htmlFor = `star-${catIndex}-${videoIndex}-${i}`;
                label.textContent = '★';
                label.setAttribute('aria-label', `${i} estrella${i > 1 ? 's' : ''}`);

                ratingDiv.appendChild(input);
                ratingDiv.appendChild(label);
            }

            detailsDiv.appendChild(ratingDiv);

            // Comentario - EDITABLE
            const commentDiv = document.createElement('div');
            commentDiv.className = 'video-comentario-container';
            const commentP = document.createElement('p');
            commentP.className = 'video-comentario';
            commentP.textContent = '💭 ' + video.comentario;
            commentP.contentEditable = true;
            commentP.onblur = () => updateComment(catIndex, videoIndex, commentP.textContent.replace('💭 ', ''));
            commentDiv.appendChild(commentP);
            detailsDiv.appendChild(commentDiv);

            // Canal del autor - INTEGRADO: mostrar solo una vez con enlace al canal
            const canalDiv = document.createElement('div');
            canalDiv.className = 'video-canal';
            const canalLink = document.createElement('a');
            canalLink.href = '#'; // Usar onclick para validación
            canalLink.innerHTML = '<span class="youtube-icon">📺</span>' + video.aut_nom + ' (' + video.aut_canal + ')';
            canalLink.onclick = (e) => {
                e.preventDefault();
                openSafeLink(`https://www.youtube.com/${video.aut_canal}`);
            };
            canalLink.tabIndex = 0;
            canalLink.onkeydown = (e) => {
                if (e.key === 'Enter' || e.key === ' ') {
                    e.preventDefault();
                    openSafeLink(`https://www.youtube.com/${video.aut_canal}`);
                }
            };
            canalDiv.appendChild(canalLink);
            detailsDiv.appendChild(canalDiv);

            videoDiv.appendChild(detailsDiv);

            catContent.appendChild(videoDiv);
        });

        catDiv.appendChild(catContent);
        biblioteca.appendChild(catDiv);
    });
}

// Función para alternar visibilidad de categorías (obsoleta)
function toggleCategoria(content) {
    content.style.display = content.style.display === 'block' ? 'none' : 'block';
}

// Función para alternar visibilidad de videos
function toggleVideo(videoDiv) {
    const detailsDiv = videoDiv.querySelector('.video-detalles');
    if (detailsDiv) {
        const currentDisplay = window.getComputedStyle(detailsDiv).display;
        const isVisible = currentDisplay !== 'none';
        detailsDiv.style.display = isVisible ? 'none' : 'block';
    }
}

// Función para actualizar calificación
function updateRating(catIndex, videoIndex, rating) {
    data[catIndex].items[videoIndex].estrellas = rating;
    saveData();
}

// Función para actualizar descripción
function updateDescription(catIndex, videoIndex, description) {
    data[catIndex].items[videoIndex].descripcion = description.trim();
    saveData();
}

// Función para actualizar comentario
function updateComment(catIndex, videoIndex, comment) {
    data[catIndex].items[videoIndex].comentario = comment.trim();
    saveData();
}

// Función para guardar datos
function saveData() {
    // Guardar en localStorage como respaldo
    localStorage.setItem('biblioteca_data', JSON.stringify(data));

    // Intentar guardar en archivo JSON (requiere servidor)
    fetch('data.json', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(data, null, 2)
    })
    .then(response => {
        if (!response.ok) {
            // No se pudo guardar en data.json, usando localStorage
        }
    })
    .catch(error => {
        // Error guardando en data.json, usando localStorage
    });
}

// Función para optimizar base de datos (similar al código original)
function optimizeDatabase() {
    // Eliminar duplicados basados en ytb_id
    const seenIds = new Set();
    data.forEach(cat => {
        cat.items = cat.items.filter(video => {
            if (seenIds.has(video.ytb_id)) {
                return false;
            }
            seenIds.add(video.ytb_id);
            return true;
        });
    });

    // Ordenar categorías alfabéticamente
    data.sort((a, b) => a.categoria.localeCompare(b.categoria));

    // Ordenar videos por estrellas (descendente) luego por título
    data.forEach(cat => {
        cat.items.sort((a, b) => {
            if (b.estrellas !== a.estrellas) {
                return b.estrellas - a.estrellas;
            }
            return a.titulo.localeCompare(b.titulo);
        });
    });

    // Formatear consistentemente
    data.forEach(cat => {
        cat.items.forEach(video => {
            if (video.aut_canal && !video.aut_canal.startsWith('@')) {
                video.aut_canal = '@' + video.aut_canal;
            }
            video.titulo = video.titulo.trim();
            video.aut_nom = video.aut_nom.trim();
            video.descripcion = video.descripcion.trim();
            video.comentario = video.comentario.trim();
        });
    });

    console.log('Base de datos optimizada');
}

// Inicializar cuando el DOM esté listo
document.addEventListener('DOMContentLoaded', () => {
    loadData();
});

// Exportar funciones para uso global si es necesario
window.optimizeDatabase = optimizeDatabase;
window.renderBiblioteca = renderBiblioteca;