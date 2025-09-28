---
layout: default
title: "RM-rmBiblioteca"
---

# RM-rmBiblioteca
*Biblioteca de conocimientos y temas de estudio.*

{% for bloque in site.data.recursos %}
---

  <h2 style="display:inline; vertical-align: middle;">{{ bloque.categoria }}</h2>
  <div style="padding-left: 25px; padding-top: 10px;">

    {% for item in bloque.items %}
    <details>
      <summary style="font-size: 1.1em; padding: 5px 0;">
        <img src="{{ item.img }}" alt="Miniatura" width="60" style="margin-right: 10px; border-radius: 4px; vertical-align: middle;">
        <strong>{{ item.titulo }}</strong> por {{ item.autor }}
      </summary>
      <div style="padding: 15px; overflow: hidden; border-left: 2px solid #ddd; margin-top: 5px; margin-left: 5px;">
        <a href="{{ item.url }}" target="_blank">
          <img src="{{ item.img }}" alt="Miniatura {{ item.titulo }}" width="150" style="float: right; margin-left: 15px; border-radius: 8px;">
        </a>
        <strong><a href="{{ item.url }}" target="_blank">{{ item.titulo }}</a></strong><br>
        por <a href="{{ item.canal }}" target="_blank">{{ item.autor }}</a><br><br>
        <em>{{ item.descripcion }}</em><br><br>
        <strong>Calificación:</strong> {{ "★" | append: "★" | slice: 0, item.estrellas }}<br>
        <em>{{ item.comentario }}</em>
      </div>
    </details>
    {% endfor %}

  </div>
{% endfor %}

---

### Calificación Personal
Cada video tiene una calificación de ⭐ a ⭐⭐⭐⭐⭐ basada en mi criterio personal.
