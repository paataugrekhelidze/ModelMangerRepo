FROM crcache-az-us-east.unx.sas.com/viya-4-x64_oci_linux_2-docker/sas-score-python3-base:3.65.2-20240108.1704743638535
LABEL model container image

COPY *.* /pybox/model/

USER root
RUN chown sas:sas /pybox/model/
USER sas

USER root
# install sklearn 
RUN pip3 install scikit-learn==1.3.0
# install xgboost 
RUN pip3 install xgboost==1.7.6
# install pandas 
RUN pip3 install pandas

USER sas

ENTRYPOINT ["/bin/bash", "startServer.sh"]
