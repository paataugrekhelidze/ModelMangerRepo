FROM crcache-az-us-east.unx.sas.com/viya-4-x64_oci_linux_2-docker/sas-decisions-runtime-base:1.76.26-20240319.1710863071860
LABEL model container image
USER root
RUN chown sas:sas /modules
USER sas

ENV SAS_SCR_APP_PATH=/gradientboostingpipeline1
COPY --chown=sas:sas unzipped/ /modules/
COPY --chown=sas:sas manifest/ /manifest/
ENV LD_LIBRARY_PATH=/opt/scr/viya/home/SASFoundation/utilities/bin:/opt/scr/viya/home/SASFoundation/sasexe
