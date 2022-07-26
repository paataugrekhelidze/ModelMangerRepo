FROM cr.sas.com/viya-4-x64_oci_linux_2-docker/sas-score-python3-base:3.23.3-20220517.1652805281593
LABEL model container image

COPY *.* /pybox/model/

USER root
RUN chown sas:sas /pybox/model/
USER sas

USER root
# install pandas 
RUN pip3 install pandas
# install base64 
RUN pip3 install pybase64
# install Pillow 
RUN pip3 install Pillow
# install pytorch 
RUN pip3 install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cpu

USER sas

ENTRYPOINT ["/bin/bash", "startServer.sh"]
