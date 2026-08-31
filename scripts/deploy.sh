#!/bin/bash
# Script de despliegue automático para Contabo VPS
set -e

echo "🚀 Iniciando despliegue de Ghost CMS (Blog de Conciliación) en Contabo VPS..."

# 1. Actualizar sistema e instalar Docker y Docker Compose si no están presentes
if ! command -v docker &> /dev/null; then
    echo "📦 Instalando Docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    systemctl enable --now docker
fi

if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
    echo "📦 Instalando Docker Compose..."
    apt-get update && apt-get install -y docker-compose-plugin docker-compose
fi

# 2. Copiar .env si no existe
if [ ! -f .env ]; then
    echo "⚙️ Creando archivo .env a partir de .env.example..."
    cp .env.example .env
    echo "⚠️ ATENCIÓN: Edita el archivo .env con tus credenciales reales de Railway antes de continuar."
fi

# 3. Iniciar contenedor de Ghost
echo "🐳 Iniciando contenedor de Ghost CMS con Docker Compose..."
docker compose up -d

# 4. Configurar Nginx si está instalado
if command -v nginx &> /dev/null; then
    echo "🌐 Configurando Nginx Reverse Proxy..."
    cp nginx/ghost.conf /etc/nginx/sites-available/ghost.conf
    ln -sf /etc/nginx/sites-available/ghost.conf /etc/nginx/sites-enabled/ghost.conf
    nginx -t && systemctl reload nginx
fi

echo "✅ Despliegue completado con éxito."
echo "🔗 Accede a Ghost Admin en: http://TU_IP_CONTABO:2368/ghost o https://tudominio.com/ghost"
