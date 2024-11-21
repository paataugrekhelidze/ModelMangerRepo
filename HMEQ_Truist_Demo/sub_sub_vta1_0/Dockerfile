FROM cr.sas.com/viya-4-x64_oci_linux_2-docker-testready/sas-decisions-runtime-base:1.92.19-20241106.1730869838940
LABEL model container image
USER root
RUN chown sas:sas /modules
USER sas
ENV SAS_SCR_APP_PATH=/sub_sub_vta1_0
COPY --chown=sas:sas unzipped/ /modules/
COPY --chown=sas:sas manifest/ /manifest/
ENV LD_LIBRARY_PATH=/opt/scr/viya/home/SASFoundation/utilities/bin:/opt/scr/viya/home/SASFoundation/sasexe
