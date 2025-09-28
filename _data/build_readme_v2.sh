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
---
"
FOOTER="
---
### ⭐ Calificación Personal
Cada recurso tiene una valoración de ⭐ a ⭐⭐⭐⭐⭐ según mi criterio personal.
---
"

# Escribe/reecribe el README
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

        # Normalizar estrellas
        if ! [[ "$estrellas" =~ ^[0-9]+$ ]]; then
            estrellas=0
        fi
        if [ "$estrellas" -gt 0 ]; then
            rating=$(printf '★%.0s' $(seq 1 "$estrellas"))
        else
            rating="(sin calificar)"
        fi

        # Autor con enlace si existe
        if [ -n "$canal" ] && [ "$canal" != "null" ]; then
            autor_html="<a href=\"$canal\" target=\"_blank\" style=\"color:#1E88E5;\">$autor</a>"
        else
            autor_html="$autor"
        fi

        # Miniatura (summary) y detalle (derecha)
        if [ -n "$img" ] && [ "$img" != "null" ]; then
            summary_img="<img src=\"$img\" alt=\"Miniatura $titulo\" width=\"55\" style=\"margin-right:10px;border-radius:6px;box-shadow:0 1px 3px rgba(0,0,0,0.25);\">"
            detail_img="<a href=\"$url\" target=\"_blank\"><img src=\"$img\" alt=\"Imagen $titulo\" width=\"180\" style=\"float:right;margin-left:15px;border-radius:8px;box-shadow:0 2px 6px rgba(0,0,0,0.15);\"></a>"
        else
            summary_img=""
            detail_img=""
        fi

        # Bloque HTML sin cambiar el fondo
        cat <<EOF >> "$README_FILE"
<details>
  <summary style="font-size:1.05em;padding:6px 0;cursor:pointer;display:flex;align-items:center;">
    $summary_img
    <span><strong>$titulo</strong> <em style="color:#555;">por $autor</em></span>
  </summary>
  <div style="padding:15px;margin:10px 0 15px 10px;border-left:3px solid #4CAF50;border-radius:8px;box-shadow:0 2px 5px rgba(0,0,0,0.08);overflow:hidden;">
    $detail_img#!/usr/bin/env bash
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
---
"
FOOTER="
---
### ⭐ Calificación Personal
Cada recurso tiene una valoración de ⭐ a ⭐⭐⭐⭐⭐ según mi criterio personal.
---
"

# Escribe/reecribe el README
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

        # Normalizar estrellas
        if ! [[ "$estrellas" =~ ^[0-9]+$ ]]; then
            estrellas=0
        fi
        if [ "$estrellas" -gt 0 ]; then
            rating=$(printf '★%.0s' $(seq 1 "$estrellas"))
        else
            rating="(sin calificar)"
        fi

        # Autor con enlace si existe
        if [ -n "$canal" ] && [ "$canal" != "null" ]; then
            autor_html="<a href=\"$canal\" target=\"_blank\" style=\"color:#1E88E5;\">$autor</a>"
        else
            autor_html="$autor"
        fi

        # Miniatura (summary) y detalle (derecha)
        if [ -n "$img" ] && [ "$img" != "null" ]; then
            summary_img="<img src=\"$img\" alt=\"Miniatura $titulo\" width=\"55\" style=\"margin-right:10px;border-radius:6px;box-shadow:0 1px 3px rgba(0,0,0,0.25);\">"
            detail_img="<a href=\"$url\" target=\"_blank\"><img src=\"$img\" alt=\"Imagen $titulo\" width=\"180\" style=\"float:right;margin-left:15px;border-radius:8px;box-shadow:0 2px 6px rgba(0,0,0,0.15);\"></a>"
        else
            summary_img=""
            detail_img=""
        fi

        # Bloque HTML sin cambiar el fondo
        cat <<EOF >> "$README_FILE"
<details>
  <summary style="font-size:1.05em;padding:6px 0;cursor:pointer;display:flex;align-items:center;">
    $summary_img
    <span><strong>$titulo</strong> <em style="color:#555;">por $autor</em></span>
  </summary>
  <div style="padding:15px;margin:10px 0 15px 10px;border-left:3px solid #4CAF50;border-radius:8px;box-shadow:0 2px 5px rgba(0,0,0,0.08);overflow:hidden;">
    $detail_img
    <p><strong>Autor:</strong> $autor_html</p>
    <p style="color:#444;font-style:italic;">$descripcion</p>
    <p><strong>Calificación:</strong> $rating</p>
    <p style="color:#666;">💭 $comentario</p>
  </div>
</details>

EOF
    done < <(printf '%s\n' "$bloque" | jq -c '.items[]?')

    printf '</div>\n' >> "$README_FILE"
done < <(yq '.[]' "$DATA_FILE" -o=json | jq -c '.')

# Pie
printf

    <p><strong>Autor:</strong> $autor_html</p>
    <p style="color:#444;font-style:italic;">$descripcion</p>
    <p><strong>Calificación:</strong> $rating</p>
    <p style="color:#666;">💭 $comentario</p>
  </div>
</details>

EOF
    done < <(printf '%s\n' "$bloque" | jq -c '.items[]?')

    printf '</div>\n' >> "$README_FILE"
done < <(yq '.[]' "$DATA_FILE" -o=json | jq -c '.')

# Pie
printf
