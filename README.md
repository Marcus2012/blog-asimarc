# ⚖️ Blog de Noticias de Conciliación & Arbitraje (ASIMARC)

Este repositorio contiene la configuración básica de **Ghost CMS 5.x** en Docker, junto con el tema personalizado para el portal de noticias de Conciliación y Arbitraje, listo para ser desplegado en **Railway**.

---

## 🛠️ Estructura del Repositorio

- `Dockerfile`: Imagen base de Ghost 5 con el tema de conciliación pre-instalado.
- `theme/`: Tema personalizado Handlebars (`index.hbs`, `post.hbs`, `tag.hbs`, `screen.css`).
- `docker-compose.yml`: (Opcional) Para pruebas locales con Docker.
- `.env.example`: Guía de variables de entorno para Railway.

---

## 🚂 Despliegue en Railway

### 1. Variables de Entorno en Railway
En tu servicio de Ghost en Railway, agrega las siguientes variables (puedes hacer referencia a la base de datos de MySQL en el mismo proyecto):

```env
PORT=2368
url=https://${{RAILWAY_PUBLIC_DOMAIN}}

database__client=mysql
database__connection__host=${{MySQL.MYSQLHOST}}
database__connection__port=${{MySQL.MYSQLPORT}}
database__connection__user=${{MySQL.MYSQLUSER}}
database__connection__password=${{MySQL.MYSQLPASSWORD}}
database__connection__database=${{MySQL.MYSQLDATABASE}}
database__connection__ssl__rejectUnauthorized=false
NODE_ENV=production
```

### 2. Configurar Dominio Público
En Railway:
1. Ve a tu servicio de Ghost > **Settings** > **Networking**.
2. Haz clic en **Generate Domain** (o asigna tu dominio personalizado como `noticias.asimarc.org`).

---

## 📦 Comandos Git para subir este proyecto

```bash
git init
git remote add origin https://github.com/Marcus2012/blog-asimarc.git
git add .
git commit -m "Initial commit: Ghost CMS setup with Conciliacion theme"
git branch -M main
git push -u origin main
```
