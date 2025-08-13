# 📚 NetBox – Documentación y Recursos de Estudio

  <img src="https://raw.githubusercontent.com/netbox-community/netbox/main/docs/netbox_logo_light.svg" width="400" alt="NetBox logo" />



## 📖 Descripción
**NetBox** es una aplicación web de código abierto diseñada para ayudar a gestionar y documentar redes de computadoras. Originalmente desarrollada por [DigitalOcean](https://www.digitalocean.com), ahora es mantenida por la [comunidad de NetBox](https://github.com/netbox-community).  
Su objetivo principal es servir como **fuente de verdad (Source of Truth)** para la infraestructura de red, centralizando información clave como:

- Inventario de dispositivos físicos y virtuales.
- Gestión de direcciones IP (IPAM).
- Gestión de racks, cables y conexiones.
- Documentación de VLANs, VRFs y topologías.
- Control de circuitos y proveedores.
- Registro de conexiones de red y energía.

NetBox es ampliamente utilizado por administradores de sistemas, ingenieros de redes y equipos de infraestructura para documentar y automatizar la gestión de redes.

---

## ✨ Características Principales

- **IPAM** (IP Address Management):  
  Gestión de direcciones IPv4/IPv6, subredes, VRFs, VLANs y prefijos.
- **DCIM** (Data Center Infrastructure Management):  
  Control de racks, dispositivos, módulos, cables y puertos.
- **Virtualización**:  
  Documentación de máquinas virtuales, clústeres y recursos asignados.
- **Integraciones API REST y GraphQL**:  
  Ideal para automatizar tareas y conectarse con otras herramientas.
- **Permisos y Control de Acceso**:  
  Basado en roles y usuarios para un acceso seguro.
- **Extensible y Personalizable**:  
  Plugins, webhooks y scripts para adaptarse a necesidades específicas.

---
## 📺 **Playlist de estudio inicial (Youtube):**  
### **Netbox** (Introducción y tutoriales)
- https://www.youtube.com/watch?v=ii_djUBOddA&list=PL3axWAyLEDFVQmaClQw9okadaNtWzrUIq
  - by [***Arturo Baldo CCESTE***](https://www.youtube.com/@cceste)
  
Esta serie forma parte del canal **Arturo Baldo (CCEste)**, quien ofrece tutoriales concisos y claros sobre cómo implementar y utilizar NetBox, incluyendo temas como:

- Implementando IPAM y DCIM con netbox-docker  
- Link Aggregation y Port Channels en NetBox  
- Interfaces virtuales y VLANs  
- Campos personalizados, importación de datos, circuitos, proveedores y resolución de problemas  
:contentReference[oaicite:0]{index=0}

Estos videos te brindan una base práctica ideal para empezar a comprender NetBox desde cero.

---
## 🔗 Enlaces Útiles

- 🌐 **Sitio oficial**: [https://netbox.dev](https://netbox.dev)  
- 📄 **Documentación oficial**: [https://docs.netbox.dev](https://docs.netbox.dev)  
- 💻 **Repositorio GitHub**: [https://github.com/netbox-community/netbox](https://github.com/netbox-community/netbox)  
- 🐳 **NetBox Docker** (despliegue rápido): [https://github.com/netbox-community/netbox-docker](https://github.com/netbox-community/netbox-docker)  
- 📢 **Comunidad / Discusiones**: [https://github.com/netbox-community/netbox/discussions](https://github.com/netbox-community/netbox/discussions)  

---

## 🚀 Instalación Básica

NetBox puede instalarse en entornos locales o en producción. Las opciones más comunes son:

1. **Instalación manual en Linux**  
   - Requisitos: Python, PostgreSQL, Redis.
   - Guía: [Instalación manual en docs.netbox.dev](https://docs.netbox.dev/en/stable/installation/)

2. **Usando Docker (recomendado para pruebas)**  
   ```bash
   git clone https://github.com/netbox-community/netbox-docker.git
   cd netbox-docker
   docker compose pull
   docker compose up

---

## 📌 Casos de Uso

* Documentación de **centros de datos** y racks.
* Control de **asignación de direcciones IP**.
* Inventario de **dispositivos de red** y servidores.
* Soporte a **automatización de redes** mediante API.

---

## 📚 Recursos de Aprendizaje

* 📺 Playlist oficial de introducción y uso:
  [Ver en YouTube](https://www.youtube.com/watch?v=ii_djUBOddA&list=PL3axWAyLEDFVQmaClQw9okadaNtWzrUIq)
* 📄 Guía paso a paso: [https://docs.netbox.dev/en/stable/](https://docs.netbox.dev/en/stable/)
* 📦 Ejemplos de despliegue con Docker: [NetBox Docker](https://github.com/netbox-community/netbox-docker)

---

## 📜 Licencia

NetBox está licenciado bajo la licencia **Apache 2.0**.
Detalles en: [LICENSE](https://github.com/netbox-community/netbox/blob/develop/LICENSE.txt)

---

> ✍️ **Nota personal:** Este repositorio forma parte de mi biblioteca de conocimientos y temas de estudio sobre herramientas de gestión de infraestructura y redes.
