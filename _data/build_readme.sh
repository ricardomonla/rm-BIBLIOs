#!/usr/bin/env bash
# ==============================================================
# Generador de README.md a partir de _data/recursos.yml
# Requiere: yq (https://github.com/mikefarah/yq) y jq
# ==============================================================

set -o errexit
set -o nounset
set -o pipefail

DATA_FILE="recursos.yml"
README_FILE="../README.md"

HEADER="# 📚 RM-rmBiblioteca
*Biblioteca de conocimientos y temas de estudio.*

<style>
/* === Estilos generales === */
summary {
  font-size: 1.05em;
  padding: 6px 0;
  cursor: pointer;
  display: flex;
  align-items: center;
}
.summary-img {
  margin-right: 10px;
  border-radius: 6px;
  box-shadow: 0 1px 3px rgba(0,0,0,0.25);
}
.detail-card {
  padding: 15px;
  margin: 10px 0 15px 10px;
  border-left: 3px solid #4CAF50;
  border-radius: 8px;
  box-shadow: 0 2px 5px rgba(0,0,0,0.08);
  overflow: hidden;
  background-color: #fdfdfd; /* claro por defecto */
  color: #000; /* texto predeterminado */
}
/* Imagen en detalle flotando a la derecha */
.detail-card img {
  float: right;
  margin-left: 15px;
  border-radius: 8px;
  box-shadow: 0 2px 6px rgba(0,0,0,0.15);
}
/* Autor debajo de la imagen */
.author {
  display: block;
  margin-top: 10px;
  color: #1976d2; /* azul accesible */
}
/* Descripción y comentario sin estilos de fuente */
.desc, .comment {
  font-style: normal;
  color: inherit;
}

/* === Modo oscuro === */
@media (prefers-color-scheme: dark) {
  .detail-card {
    background-color: #1e1e1e;
    border-left-color: #4CAF50;
    color: #ddd;
    box-shadow: 0 2px 5px rgba(255,255,255,0.05);
  }
  .detail-card img {
    box-shadow: 0 2px 6px rgba(255,255,255,0.08);
  }
}
</style>

---
"
FOOTER="
---
### ⭐ Calificación Personal
Cada recurso tiene una valoración de ⭐ a ⭐⭐⭐⭐⭐ según mi criterio personal.
---
"

# Escribe/reescribe el README
printf '%s\n' "$HEADER" > "$README_FILE"

# Recorre cada bloque (categoría)
while IFS= read -r bloque; do
    categoria=$(printf '%s' "$bloque" | jq -r '.categoria // "Sin categoría"')
    printf '\n## 📂 %s\n' "$categoria" >> "$README_FILE"
    printf '<div style="padding-left:20px;padding-top:10px;">\n' >> "$README_FILE"

    while IFS= read -r item; do
        titulo=$(printf '%s' "$item" | jq -r '.titulo // "Sin título"')
        autor=$(printf '%s' "$item" | jq -r '.autor // "Autor desconocido"')
        url=$(printf '%s' "$item" | jq -r '.url // ""')
        canal=$(printf '%s' "$item" | jq -r '.canal // ""')
        img=$(printf '%s' "$item" | jq -r '.img // ""')
        descripcion=$(printf '%s' "$item" | jq -r '.descripcion // "Sin descripción."')
        estrellas=$(printf '%s' "$item" | jq -r '.estrellas // 0')
        comentario=$(printf '%s' "$item" | jq -r '.comentario // ""')

        # Normalizar estrellas en una cadena
        rating=""
        if [ "$estrellas" -gt 0 ] 2>/dev/null; then
            for i in $(seq 1 "$estrellas"); do
                rating="${rating}★"
            done
        else
            rating="(sin calificar)"
        fi

        # Autor con enlace si existe
        if [ -n "$canal" ] && [ "$canal" != "null" ]; then
            autor_html="<a class=\"author\" href=\"$canal\" target=\"_blank\">$autor</a>"
        else
            autor_html="<span class=\"author\">$autor</span>"
        fi

        # Miniatura (summary) y detalle (derecha)
        if [ -n "$img" ] && [ "$img" != "null" ]; then
            summary_img="<img src=\"$img\" alt=\"Miniatura $titulo\" width=\"55\" class=\"summary-img\">"
            detail_img="<a href=\"$url\" target=\"_blank\"><img src=\"$img\" alt=\"Imagen $titulo\" width=\"180\"></a>"
        else
            summary_img=""
            detail_img=""
        fi

        # Bloque HTML
        cat <<EOF >> "$README_FILE"
<details>
  <summary>
    $summary_img
    <span><strong>$titulo</strong></span>
  </summary>
  <div class="detail-card">
    $detail_img
    $autor_html
    <p class="desc">$descripcion</p>
    <p><strong>Calificación:</strong> $rating</p>
    <p class="comment">💭 $comentario</p>
  </div>
</details>

EOF
    done < <(printf '%s\n' "$bloque" | jq -c '.items[]?')

    printf '</div>\n' >> "$README_FILE"
done < <(yq '.[]' "$DATA_FILE" -o=json | jq -c '.')

# Pie
printf '%s\n' "$FOOTER" >> "$README_FILE"

echo "✅ README.md generado a partir de $DATA_FILE"
