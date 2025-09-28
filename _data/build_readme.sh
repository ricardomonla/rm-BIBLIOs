#!/usr/bin/env bash
# ==============================================================
# Generador de README.md a partir de _data/recursos.yml
# Requiere: yq (https://github.com/mikefarah/yq)
# ==============================================================

DATA_FILE="recursos.yml"
README_FILE="../README.md"

HEADER="# 📚 RM-rmBiblioteca
*Biblioteca de conocimientos y temas de estudio.*
"
FOOTER="
---

### ⭐ Calificación Personal
Cada recurso tiene una valoración de ⭐ a ⭐⭐⭐⭐⭐ según mi criterio personal.
"

# Iniciar archivo
echo "$HEADER" > "$README_FILE"

# Recorrer categorías
yq '.[]' "$DATA_FILE" -o=json | jq -c '.' | while read -r bloque; do
    categoria=$(echo "$bloque" | jq -r '.categoria')
    echo "---" >> "$README_FILE"
    echo "## 📂 $categoria" >> "$README_FILE"
    echo "<div style=\"padding-left: 20px; padding-top: 10px;\">" >> "$README_FILE"

    echo "$bloque" | jq -c '.items[]' | while read -r item; do
        titulo=$(echo "$item" | jq -r '.titulo')
        autor=$(echo "$item" | jq -r '.autor')
        url=$(echo "$item" | jq -r '.url')
        canal=$(echo "$item" | jq -r '.canal // ""')
        img=$(echo "$item" | jq -r '.img')
        descripcion=$(echo "$item" | jq -r '.descripcion')
        estrellas=$(echo "$item" | jq -r '.estrellas')
        comentario=$(echo "$item" | jq -r '.comentario')

        # Bloque autor con o sin enlace
        if [ -n "$canal" ] && [ "$canal" != "null" ]; then
            autor_html="<a href=\"$canal\" target=\"_blank\" style=\"color:#1E88E5;\">$autor</a>"
        else
            autor_html="$autor"
        fi

        # Generar bloque HTML
        cat <<EOF >> "$README_FILE"
<details>
  <summary style="font-size: 1.05em; padding: 6px 0; cursor: pointer; display:flex; align-items:center;">
    <img src="$img" alt="Miniatura $titulo" width="55" style="margin-right: 10px; border-radius: 6px; box-shadow: 0 1px 3px rgba(0,0,0,0.25);">
    <span><strong>$titulo</strong> <em style="color:#555;">por $autor</em></span>
  </summary>
  <div style="padding: 15px; margin: 10px 0 15px 10px; border-left: 3px solid #4CAF50; background:#fdfdfd; border-radius:8px; box-shadow: 0 2px 5px rgba(0,0,0,0.08); overflow: hidden;">
    <a href="$url" target="_blank">
      <img src="$img" alt="Miniatura $titulo" width="180" style="float: right; margin-left: 15px; border-radius: 8px; box-shadow: 0 2px 6px rgba(0,0,0,0.15);">
    </a>
    <p><strong>Autor:</strong> $autor_html</p>
    <p style="color:#444; font-style:italic;">$descripcion</p>
    <p><strong>Calificación:</strong> $(printf '★%.0s' $(seq 1 $estrellas))</p>
    <p style="color:#666;">💭 $comentario</p>
  </div>
</details>
EOF
    done

    echo "</div>" >> "$README_FILE"
done

# Cerrar archivo
echo "$FOOTER" >> "$README_FILE"

echo "✅ README.md generado a partir de $DATA_FILE"
