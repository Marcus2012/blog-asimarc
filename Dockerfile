FROM ghost:5-alpine

# Copiar el tema personalizado al directorio de temas de Ghost
COPY theme /var/lib/ghost/content/themes/conciliacion-theme

# Exponer el puerto por defecto de Ghost
EXPOSE 2368

# Comando por defecto para iniciar Ghost
CMD ["node", "current/index.js"]
