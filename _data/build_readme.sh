#!/usr/bin/env bash
# ==============================================================
# Generador de README.md a partir de _data/recursos.yml
# Requiere: yq (https://github.com/mikefarah/yq)
# ==============================================================

DATA_FILE="recursos.yml"
README_FILE="../README.md"

HEADER="# 📚 RM-rmBiblioteca
*Colección de recursos, conocimientos y temas de estudio.*
"
FOOTER="
---

### ⭐ Calificación Personal
Cada video tiene una calificación de 1 a 5 estrellas (⭐ a ⭐⭐⭐⭐⭐) basada en mi criterio personal.
"

# Iniciar archivo
echo "$HEADER" > "$README_FILE"

# Recorrer categorías
yq '.[]' "$DATA_FILE" -o=json | jq -c '.' | while read -r bloque; do
    categoria=$(echo "$bloque" | jq -r '.categoria')
    echo "---" >> "$README_FILE"
    echo "## 🔹 $categoria" >> "$README_FILE"
    echo "" >> "$README_FILE"

    echo "$bloque" | jq -c '.items[]' | while read -r item; do
        titulo=$(echo "$item" | jq -r '.titulo')
        autor=$(echo "$item" | jq -r '.autor')
        url=$(echo "$item" | jq -r '.url')
        canal=$(echo "$item" | jq -r '.canal')
        img=$(echo "$item" | jq -r '.img')
        descripcion=$(echo "$item" | jq -r '.descripcion')
        estrellas=$(echo "$item" | jq -r '.estrellas')
        comentario=$(echo "$item" | jq -r '.comentario')

        # Generar bloque Markdown
        cat <<EOF >> "$README_FILE"
<details>
<summary><strong>$titulo</strong> — por $autor</summary>

![Miniatura]($img)

**Título:** [$titulo]($url)  
**Autor:** [$autor]($canal)  

📖 *$descripcion*  

**Calificación:** $(printf '⭐%.0s' $(seq 1 $estrellas))  
💬 *$comentario*

</details>

EOF
    done

done

# Cerrar archivo
echo "$FOOTER" >> "$README_FILE"

echo "✅ README.md generado a partir de $DATA_FILE"
