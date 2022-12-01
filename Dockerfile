# syntax=docker/dockerfile:1
FROM curlimages/curl

RUN <<EOF
echo "#!/bin/bash" >> /tmp/run.sh
echo 'while true; do curl -f http://httpbin.org/get -i; DT_PREFIX=`date -u +"%Y-%m-%dT%H-%M-%S.%3N"`; echo [ ${DT_PREFIX} ] ticking ...;sleep 3;  done' >> /tmp/run.sh
EOF

HEALTHCHECK \
    --interval=10s \
    --timeout=3s \
    --start-period=3s \
    --retries=3 \
  CMD curl -f http://httpbin.org/get || exit 1

CMD ["/bin/sh", "/tmp/run.sh"]
