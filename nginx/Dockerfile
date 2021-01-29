ARG IMAGE_REPO
FROM ${IMAGE_REPO:-uselagoon}/nginx

ENV NGINX_DIR=/etc/nginx

COPY index.html /usr/share/nginx/html/index.html

RUN mkdir -p ${NGINX_DIR}/sites-available
RUN mkdir -p ${NGINX_DIR}/sites-enabled

COPY nginx/setup/nginx.conf ${NGINX_DIR}
COPY nginx/setup/sites-available/* ${NGINX_DIR}/sites-available

RUN ln -s ${NGINX_DIR}/sites-available/ckan.conf ${NGINX_DIR}/sites-enabled/ckan.conf

EXPOSE 80