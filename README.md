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
En tu servicio de Ghost en Railway, ve a la pestaña **Variables** y configura:

```env
PORT=2368
url=https://${{RAILWAY_PUBLIC_DOMAIN}}
NODE_ENV=production

database__client=mysql
database__connection__host=${{MySQL.MYSQLHOST}}
database__connection__port=${{MySQL.MYSQLPORT}}
database__connection__user=${{MySQL.MYSQLUSER}}
database__connection__password=${{MySQL.MYSQLPASSWORD}}
database__connection__database=${{MySQL.MYSQLDATABASE}}
database__connection__ssl__rejectUnauthorized=false
```

> ⚠️ **Importante para acceder a `/ghost` sin bucles de redirección:**
> La variable `url` debe incluir obligatoriamente el protocolo `https://` y coincidir exactamente con el dominio público generado por Railway o tu dominio personalizado (sin barra al final `/`).

### 2. Configurar Dominio Público
En Railway:
1. Ve a tu servicio de Ghost > **Settings** > **Networking**.
2. Haz clic en **Generate Domain** (o asigna tu dominio personalizado).

---

## 🎨 Gestión y Despliegue del Tema (`theme/`)

Ghost utiliza un volumen persistente en Railway, por lo que los temas se actualizan de forma nativa a través de su interfaz de administración o su API.

### Opción A: Cargar el archivo ZIP (Método Directo)
1. El archivo `conciliacion-theme.zip` ya se encuentra generado en la raíz del proyecto.
   *(Si haces cambios en `theme/`, regenera el ZIP ejecutando `powershell Compress-Archive -Path theme/* -DestinationPath conciliacion-theme.zip -Force` o `npm run zip` dentro de `theme/`).*
2. Ingresa al panel de administración: `https://tu-dominio.up.railway.app/ghost`.
3. Ve a **Settings (ícono de engranaje)** > **Design & branding** > **Change theme**.
4. Haz clic en **Upload theme** (esquina superior derecha) y selecciona `conciliacion-theme.zip`.
5. Haz clic en **Activate**.

### Opción B: Despliegue Automático con GitHub Actions
El repositorio incluye el workflow `.github/workflows/deploy-theme.yml` usando `TryGhost/action-deploy-theme@v2`.
Para activarlo:
1. En tu panel de Ghost (`/ghost`), ve a **Settings** > **Integrations** > **Add custom integration** (llámala por ejemplo `GitHub Actions`).
2. Copia la **Ghost Admin API URL** y la **Admin API Key**.
3. En GitHub, ve a tu repositorio > **Settings** > **Secrets and variables** > **Actions** y crea dos secretos:
   - `GHOST_ADMIN_API_URL`: Tu URL del blog (ej: `https://tu-dominio.up.railway.app`)
   - `GHOST_ADMIN_API_KEY`: Tu clave de Admin API copiada de Ghost
4. A partir de ese momento, cada `git push` a `main` actualizará automáticamente el diseño en producción.
