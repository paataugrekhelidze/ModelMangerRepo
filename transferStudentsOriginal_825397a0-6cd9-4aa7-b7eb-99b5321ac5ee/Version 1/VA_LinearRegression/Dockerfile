FROM crcache-az-us-east.unx.sas.com/viya-4-x64_oci_linux_2-docker/sas-score-python3-base:3.67.0-20240212.1707765143966
LABEL model container image


COPY *.* /pybox/model/


USER root
RUN chown sas:sas /pybox/model/
USER sas


ENTRYPOINT ["/bin/bash", "startServer.sh"]
