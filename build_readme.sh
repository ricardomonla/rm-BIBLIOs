#!/usr/bin/env bash
# ==============================================================
# Generador de README.md a partir de _data/recursos.yml
# Requiere: yq (https://github.com/mikefarah/yq)
# ==============================================================

DATA_FILE="_data/recursos.yml"
README_FILE="README.md"

HEADER="# RM-rmBiblioteca
*Biblioteca de conocimientos y temas de estudio.*
"
FOOTER="
---

### Calificación Personal
Cada video tiene una calificación de ⭐ a ⭐⭐⭐⭐⭐ basada en mi criterio personal.
"

# Iniciar archivo
echo "$HEADER" > "$README_FILE"

# Recorrer categorías
yq '.[]' "$DATA_FILE" -o=json | jq -c '.' | while read -r bloque; do
    categoria=$(echo "$bloque" | jq -r '.categoria')
    echo "---" >> "$README_FILE"
    echo "  <h2 style=\"display:inline; vertical-align: middle;\">$categoria</h2>" >> "$README_FILE"
    echo "  <div style=\"padding-left: 25px; padding-top: 10px;\">" >> "$README_FILE"

    echo "$bloque" | jq -c '.items[]' | while read -r item; do
        titulo=$(echo "$item" | jq -r '.titulo')
        autor=$(echo "$item" | jq -r '.autor')
        url=$(echo "$item" | jq -r '.url')
        canal=$(echo "$item" | jq -r '.canal')
        img=$(echo "$item" | jq -r '.img')
        descripcion=$(echo "$item" | jq -r '.descripcion')
        estrellas=$(echo "$item" | jq -r '.estrellas')
        comentario=$(echo "$item" | jq -r '.comentario')

        # Generar bloque HTML
        cat <<EOF >> "$README_FILE"
    <details>
      <summary style="font-size: 1.1em; padding: 5px 0;">
        <img src="$img" alt="Miniatura" width="60" style="margin-right: 10px; border-radius: 4px; vertical-align: middle;">
        <strong>$titulo</strong> por $autor
      </summary>
      <div style="padding: 15px; overflow: hidden; border-left: 2px solid #ddd; margin-top: 5px; margin-left: 5px;">
        <a href="$url" target="_blank">
          <img src="$img" alt="Miniatura $titulo" width="150" style="float: right; margin-left: 15px; border-radius: 8px;">
        </a>
        <strong><a href="$url" target="_blank">$titulo</a></strong><br>
        por <a href="$canal" target="_blank">$autor</a><br><br>
        <em>$descripcion</em><br><br>
        <strong>Calificación:</strong> $(printf '★%.0s' $(seq 1 $estrellas))<br>
        <em>$comentario</em>
      </div>
    </details>
EOF
    done

    echo "  </div>" >> "$README_FILE"
done

# Cerrar archivo
echo "$FOOTER" >> "$README_FILE"

echo "✅ README.md generado a partir de $DATA_FILE"
