FROM ghost:5-alpine

# Copiar el tema a un directorio temporal dentro de la imagen
COPY theme /tmp/asimarc-theme

# Script de inicio: copia automáticamente el tema al volumen persistente en cada arranque
RUN echo '#!/bin/sh' > /docker-entrypoint-custom.sh && \
    echo 'mkdir -p /var/lib/ghost/content/themes/conciliacion-theme' >> /docker-entrypoint-custom.sh && \
    echo 'cp -r /tmp/asimarc-theme/* /var/lib/ghost/content/themes/conciliacion-theme/' >> /docker-entrypoint-custom.sh && \
    echo 'exec node current/index.js' >> /docker-entrypoint-custom.sh && \
    chmod +x /docker-entrypoint-custom.sh

EXPOSE 2368

ENTRYPOINT ["/docker-entrypoint-custom.sh"]
