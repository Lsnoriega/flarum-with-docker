FROM mondedie/flarum:latest

# Copia los archivos de configuración de Flarum a la imagen


# Copia los assets, extensiones y logs (si es necesario)
COPY mnt/docker/flarum/assets /flarum/app/public/assets
COPY mnt/docker/flarum/extensions /flarum/app/extensions
COPY mnt/docker/flarum/storage/logs /flarum/app/storage/logs

# Cambia el directorio de trabajo a la raíz de la aplicación Flarum
WORKDIR /flarum/app

# Añade /flarum/app al PATH
ENV PATH=$PATH:/flarum/app

# Instala las extensiones que necesitas
RUN composer require fof/nightmode:"*"
RUN composer require fof/upload:"*"
RUN composer require fof/best-answer:"*"
RUN composer require fof/follow-tags:"*"
# ... instala todas las extensiones que necesites

# Cambia los permisos del ejecutable flarum
RUN chmod +x /flarum/app/flarum


# Limpia la caché
RUN php flarum cache:clear