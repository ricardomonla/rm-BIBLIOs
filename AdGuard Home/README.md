[![Artículo en dev.to sobre AdGuard Home](https://images.openai.com/thumbnails/url/SWD_9Xicu1mUUVJSUGylr5-al1xUWVCSmqJbkpRnoJdeXJJYkpmsl5yfq5-Zm5ieWmxfaAuUsXL0S7F0Tw5JyvRwCkszyDXTzY50jDKOL3fRjQhzNfYvSfGICsjPN68wMUjx1fUqMguICM4K9kz3rswoqMrP9UxUKwYAp8Io0Q)](https://dev.to/disane/adguard-home-your-ultimate-protection-on-the-internet-1oc9)

# 🛡️ AdGuard Home – Biblioteca de Conocimiento y Estudio

---

## 1. Introducción Visual

![AdGuard Home Logo](https://adguard.com/favicon.ico)  
**AdGuard Home** simboliza protección, privacidad y control a nivel de red. Se implementa como un servidor DNS que filtra anuncios y rastreadores antes de que lleguen a los dispositivos de tu red.

---

## 2. ¿Qué es AdGuard Home?

**AdGuard Home** es un software de código abierto que funciona como un servidor DNS a nivel de red, especializado en bloquear anuncios, rastreadores y sitios maliciosos.  
Una vez instalado, protege **todos los dispositivos** conectados a tu red **sin necesidad de instalar software adicional en cada uno**.

Opera redirigiendo dominios de publicidad o rastreo hacia un “agujero negro” (*black hole*), impidiendo su carga en cualquier dispositivo conectado.

---

## 3. Beneficios Clave

- **Bloqueo total de anuncios y rastreadores** en toda la red.
- **DNS seguro y eficiente** con soporte para DoH (DNS-over-HTTPS) y DoT (DNS-over-TLS).
- **Código abierto y gratuito**, con desarrollo activo.
- **Interfaz web intuitiva** para configurar filtros, ver estadísticas y ajustar reglas.

---

## 4. Enlaces Relevantes

- 🌐 **Sitio oficial**: [AdGuard Home Overview](https://adguard.com/en/adguard-home/overview.html)  
- 💻 **Repositorio GitHub**: [AdguardTeam/AdGuardHome](https://github.com/AdguardTeam/AdGuardHome) *(Licencia GPL-3.0)*  
- 📄 **Guía de inicio rápido**: [Getting Started](https://github.com/AdguardTeam/AdGuardHome/wiki/Getting-Started)  
- 📝 **Blog y documentación técnica**: [AdGuard Blog](https://adguard.com/en/blog/introducing-adguard-home.html)  

---

## 5. Instalación Rápida

### Opción A: Instalación manual en Linux

```bash
wget https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_amd64.tar.gz
tar xvf AdGuardHome_linux_amd64.tar.gz
cd AdGuardHome
sudo ./AdGuardHome -s install
```

Accede en el navegador a:
`http://<tu_ip>:3000`

---

### Opción B: Instalación con Docker

```yaml
version: '3'
services:
  adguardhome:
    image: adguard/adguardhome
    container_name: adguardhome
    restart: unless-stopped
    ports:
      - "53:53/tcp"
      - "53:53/udp"
      - "3000:3000/tcp"
    volumes:
      - "./data/work:/opt/adguardhome/work"
      - "./data/conf:/opt/adguardhome/conf"
```

Inicia con:

```bash
docker-compose up -d
```

Accede en el navegador a:
`http://<host>:3000`

---

## 6. Casos de Uso Común

* Protección de toda la red doméstica contra publicidad y rastreadores.
* Seguridad adicional para dispositivos IoT.
* Alternativa o complemento a Pi-hole.
* Control y privacidad sin depender de DNS de terceros.

---

## 7. Recursos Adicionales

* 🌐 **DNS público de AdGuard**: [AdGuard DNS](https://adguard-dns.io/en/public-dns.html)
* 🆕 **Historial de versiones y cambios**: [Release Notes](https://adguard.com/en/versions/home/release.html)

---

## 8. Licencia

AdGuard Home está licenciado bajo **GPL-3.0**, promoviendo software libre y de código abierto.

---

### Resumen Visual

| Sección                | Contenido Destacado        |
| ---------------------- | -------------------------- |
| 1. Introducción Visual | Logo y concepto principal  |
| 2. ¿Qué es?            | Definición y propósito     |
| 3. Beneficios          | Ventajas clave             |
| 4. Enlaces             | Recursos oficiales         |
| 5. Instalación         | Pasos manual y con Docker  |
| 6. Casos de Uso        | Ejemplos prácticos         |
| 7. Recursos            | Extras útiles              |
| 8. Licencia            | Información de la licencia |

---

