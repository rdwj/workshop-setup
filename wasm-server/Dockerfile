FROM registry.redhat.io/ubi9/httpd-24

COPY plugin.wasm /var/www/html/plugin.wasm

USER 0
RUN chmod 644 /var/www/html/plugin.wasm
USER 1001
