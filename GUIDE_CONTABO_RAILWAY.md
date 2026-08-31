# 📘 Guía Completa: Despliegue de Ghost CMS en Contabo con Base de Datos MySQL en Railway

Esta guía explica paso a paso cómo conectar tu base de datos MySQL de Railway con la instancia de Ghost CMS ejecutándose en Docker sobre tu servidor VPS en Contabo, además de cómo activar el tema personalizado para noticias de conciliación.

---

## 1. Requisitos Previos en Railway

En tu proyecto de **Railway**:
1. Entra a tu servicio de **MySQL**.
2. Dirígete a la pestaña **Variables** o **Connect**.
3. Copia las siguientes variables de conexión externa:
   - `MYSQLHOST` / `RAILWAY_TCP_PROXY_DOMAIN` (Ej: `roundhouse.proxy.rlwy.net`)
   - `MYSQLPORT` / `RAILWAY_TCP_PROXY_PORT` (Ej: `3306` o el puerto asignado)
   - `MYSQLUSER` (Ej: `root`)
   - `MYSQLPASSWORD`
   - `MYSQLDATABASE` (Ej: `railway`)

> ⚠️ **Importante**: Ghost 5.x requiere estrictamente **MySQL 8**. Verifica que tu instancia de Railway sea de MySQL 8.x.

---

## 2. Preparación en Contabo VPS

Conéctate por SSH a tu servidor Contabo:
```bash
ssh root@TU_IP_CONTABO
```

Crea el directorio del proyecto y clona/transfiere esta carpeta (`Blog`):
```bash
mkdir -p /opt/ghost-blog
cd /opt/ghost-blog
```

### Configura tus Variables de Entorno (`.env`)
Copia `.env.example` a `.env`:
```bash
cp .env.example .env
nano .env
```

Ingresa las credenciales de Railway:
```env
BLOG_URL=https://tudominio.com
RAILWAY_MYSQL_HOST=roundhouse.proxy.rlwy.net
RAILWAY_MYSQL_PORT=3306
RAILWAY_MYSQL_USER=root
RAILWAY_MYSQL_PASSWORD=tu_password_de_railway
RAILWAY_MYSQL_DATABASE=railway
```

---

## 3. Despliegue con Docker Compose

Ejecuta el script de despliegue o levanta los contenedores con Docker Compose:

```bash
docker compose up -d
```

Verifica que el contenedor de Ghost esté en ejecución:
```bash
docker compose ps
docker compose logs -f ghost
```

---

## 4. Configurar Reverse Proxy con Nginx & SSL (Certbot)

### Paso A: Instalar Nginx y Certbot en Contabo
```bash
apt update && apt install -y nginx certbot python3-certbot-nginx
```

### Paso B: Copiar configuración de Nginx
```bash
cp nginx/ghost.conf /etc/nginx/sites-available/tudominio.com.conf
ln -s /etc/nginx/sites-available/tudominio.com.conf /etc/nginx/sites-enabled/

# Reemplaza 'tudominio.com' por tu dominio real en el archivo de nginx:
nano /etc/nginx/sites-available/tudominio.com.conf

# Recargar Nginx
nginx -t && systemctl reload nginx
```

### Paso C: Generar Certificado SSL Gratuito
```bash
certbot --nginx -d tudominio.com -d www.tudominio.com
```

---

## 5. Configurar Ghost Admin y Subir el Tema Personalizado

1. Abre tu navegador e ingresa a: `https://tudominio.com/ghost` (o `http://TU_IP_CONTABO:2368/ghost`).
2. Crea la cuenta del Administrador (Nombre, Correo, Contraseña, Título del sitio: *"Noticias de Conciliación & Arbitraje"*).
3. Para instalar el Tema Personalizado:
   - Comprime la carpeta `theme/` en un archivo `.zip` (`conciliacion-theme.zip`).
   - En Ghost Admin, ve a **Settings ⚙️ (Ajustes) > Design > Change theme > Upload theme**.
   - Arrastra el archivo `.zip` generado y haz clic en **Activate**.

---

## 6. Estructura Recomendada de Contenido para Noticias de Conciliación

Te sugerimos crear las siguientes **Etiquetas (Tags)** principales dentro de Ghost Admin:

1. 🏷️ **Noticias & Actualidad**: Artículos sobre cambios en centros de conciliación, eventos y convocatorias.
2. 📜 **Normativa & Legislación**: Leyes, decretos y jurisprudencia aplicable a la conciliación en derecho y equidad.
3. 💼 **Casos & Jurisprudencia**: Análisis de actas de conciliación, efectividad y precedentes judiciales.
4. 🎓 **Capacitación & Guias**: Guías para conciliadores, formatos de actas y constancias de no acuerdo.
