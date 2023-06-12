FROM grafana/grafana:8.0.0-ubuntu

USER 0
# OS update
RUN apt-get update -q
RUN apt-get install ca-certificates -q

# Language configuration
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
COPY grafana_icon.svg /usr/share/grafana/public/img/grafana_icon.svg

COPY certs/ /usr/local/share/ca-certificates/
RUN chown root:root /usr/local/share/ca-certificates/*
RUN chmod 644 /usr/local/share/ca-certificates/UOL_CA_Intranet_*
RUN update-ca-certificates
WORKDIR /usr/share/grafana
ENV GF_PATHS_CONFIG=/etc/grafana/conf/grafana.ini
# USER 472
ENTRYPOINT ["/run.sh"]
# CMD ["/usr/sbin/grafana-server", "--homepath=/usr/share/grafana", "--config=/etc/grafana/grafana.ini", "cfg:default.paths.data=/var/lib/grafana", "cfg:default.paths.logs=/var/log/grafana", "cfg:default.paths.plugins=/var/lib/grafana/plugins"]
