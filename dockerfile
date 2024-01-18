FROM nginx:stable-alpine3.17-slim
RUN command apk update \
&& apk upgrade \
&& rm -rf /var/cache/apk/* \
&& mkdir /var/www \
&& mkdir /var/www/my_project/ \
&& mkdir /var/www/my_project/img
COPY index.html /var/www/my_project/
COPY img.jpg /var/www/my_project/img/img.jpg
RUN chmod -R 755 /var/www/my_project \
&& addgroup -S lera \
&& adduser -S lera -G lera \
&& chown -R lera:lera /var/www/my_project
RUN sed -i '2s/nginx/lera lera/' /etc/nginx/nginx.conf \
&& sed -i '8s/usr\/share\/nginx\/html/var\/www\/my_project/' /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx","-g","daemon off;"]