#!/usr/bin/env bash
# ==============================================================
# Generador de README.md a partir de _data/recursos.yml
# Requiere: yq (https://github.com/mikefarah/yq) y jq
# ==============================================================

set -o errexit
set -o nounset
set -o pipefail

DATA_FILE="./bd_videos.yml"
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

# Escribe/reescribe el README
printf '%s\n' "$HEADER" > "$README_FILE"

# Recorre cada bloque (categoría)
while IFS= read -r bloque; do
    categoria=$(printf '%s' "$bloque" | jq -r '.categoria // "Sin categoría"')
    printf '\n## 📂 %s\n' "$categoria" >> "$README_FILE"
    printf '<div style="padding-left:20px;padding-top:10px;">\n' >> "$README_FILE"

    while IFS= read -r item; do
        titulo=$(printf '%s' "$item" | jq -r '.titulo // "Sin título"') 
        ytb_id=$(printf '%s' "$item" | jq -r '.ytb_id // ""')
        aut_nom=$(printf '%s' "$item" | jq -r '.aut_nom // ""')
        aut_canal=$(printf '%s' "$item" | jq -r '.aut_canal // ""')
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

        # Autor
        autor_html="<a href=\"https://www.youtube.com/$aut_canal\" target=\"_blank\" style=\"display:block; margin-top:10px; color:#1976d2; text-decoration:none;\">$aut_nom</a>"
        
        # Miniatura (summary) y detalle (derecha)
        summary_img="<img src=\"https://i.ytimg.com/vi/$ytb_id/mqdefault.jpg\" alt=\"Miniatura $titulo\" width=\"55\" style=\"margin-right:10px; border-radius:6px; box-shadow:0 1px 3px rgba(0,0,0,0.25);\">"
        
        detail_img="<a href=\"https://www.youtube.com/watch?v=$ytb_id\" target=\"_blank\"><img src=\"https://i.ytimg.com/vi/$ytb_id/mqdefault.jpg\" alt=\"Imagen $titulo\" width=\"180\" style=\"float:right; margin-left:15px; border-radius:8px; box-shadow:0 2px 6px rgba(0,0,0,0.15);\"></a>"

        # Bloque HTML con estilos inline en todo
        cat <<EOF >> "$README_FILE"
<details>
  <summary style="font-size:1.05em; padding:6px 0; cursor:pointer; display:flex; align-items:center;">
    $summary_img
    <span><strong>$titulo</strong></span>
  </summary>
  <div style="padding:15px; margin:10px 0 15px 10px; border-left:3px solid #4CAF50; border-radius:8px; box-shadow:0 2px 5px rgba(0,0,0,0.08); overflow:hidden; background-color:#fdfdfd; color:#000;">
    $detail_img
    $autor_html
    <p style="font-style:normal; color:inherit;">$descripcion</p>
    <p><strong>Calificación:</strong> $rating</p>
    <p style="font-style:normal; color:inherit;">💭 $comentario</p>
  </div>
</details>

EOF
    done < <(printf '%s\n' "$bloque" | jq -c '.items[]?')

    printf '</div>\n' >> "$README_FILE"
done < <(yq '.[]' "$DATA_FILE" -o=json | jq -c '.')

# Pie
printf '%s\n' "$FOOTER" >> "$README_FILE"

echo "✅ README.md generado a partir de $DATA_FILE"
