#!/usr/bin/env python3
import yaml
from pathlib import Path

# Rutas
DATA_FILE = Path("_data/recursos.yml")
README_FILE = Path("README.md")

# Plantilla de cada item
ITEM_TEMPLATE = """    <details>
      <summary style="font-size: 1.1em; padding: 5px 0;">
        <img src="{img}" alt="Miniatura" width="60" style="margin-right: 10px; border-radius: 4px; vertical-align: middle;">
        <strong>{titulo}</strong> por {autor}
      </summary>
      <div style="padding: 15px; overflow: hidden; border-left: 2px solid #ddd; margin-top: 5px; margin-left: 5px;">
        <a href="{url}" target="_blank">
          <img src="{img}" alt="Miniatura {titulo}" width="150" style="float: right; margin-left: 15px; border-radius: 8px;">
        </a>
        <strong><a href="{url}" target="_blank">{titulo}</a></strong><br>
        por <a href="{canal}" target="_blank">{autor}</a><br><br>
        <em>{descripcion}</em><br><br>
        <strong>Calificación:</strong> {"★" * estrellas}<br>
        <em>{comentario}</em>
      </div>
    </details>
"""

# Plantilla general
HEADER = """# RM-rmBiblioteca
*Biblioteca de conocimientos y temas de estudio.*
"""

FOOTER = """
---

### Calificación Personal
Cada video tiene una calificación de ⭐ a ⭐⭐⭐⭐⭐ basada en mi criterio personal.
"""

def main():
    data = yaml.safe_load(DATA_FILE.read_text(encoding="utf-8"))

    out = [HEADER]

    for bloque in data:
        out.append("---\n")
        out.append(f'  <h2 style="display:inline; vertical-align: middle;">{bloque["categoria"]}</h2>\n')
        out.append('  <div style="padding-left: 25px; padding-top: 10px;">\n')

        for item in bloque["items"]:
            out.append(ITEM_TEMPLATE.format(
                titulo=item["titulo"],
                autor=item["autor"],
                url=item["url"],
                canal=item.get("canal", ""),
                img=item["img"],
                descripcion=item["descripcion"],
                estrellas=item["estrellas"],
                comentario=item["comentario"]
            ))

        out.append("  </div>\n")

    out.append(FOOTER)

    # Guardar README
    README_FILE.write_text("".join(out), encoding="utf-8")
    print(f"✅ README.md generado a partir de {DATA_FILE}")

if __name__ == "__main__":
    main()
