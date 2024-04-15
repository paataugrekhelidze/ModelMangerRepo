FROM crcache-az-us-east.unx.sas.com/viya-4-x64_oci_linux_2-docker/sas-score-python3-base:3.67.0-20240212.1707765143966
LABEL model container image

COPY *.* /pybox/model/

USER root
RUN chown sas:sas /pybox/model/
USER sas


USER root
# install pandas 1.5.3
RUN pip3 install pandas==1.5.3
# install scikit-learn 1.4.0
RUN pip3 install scikit-learn==1.4.0
# open permission 
RUN chmod 777 -R /pybox

USER sas

ENTRYPOINT ["/bin/bash", "startServer.sh"]
