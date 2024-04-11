FROM crcache-az-us-east.unx.sas.com/viya-4-x64_oci_linux_2-docker/sas-score-python3-base:3.67.0-20240212.1707765143966
LABEL model container image

COPY *.* /pybox/model/


USER root
RUN chown sas:sas /pybox/model/
USER sas

USER root
# install unzip
RUN microdnf install unzip
# install sqlitedevel 
RUN microdnf install sqlite-devel
# install compiler 
RUN microdnf install gcc-c++
#  clean 
RUN microdnf clean all
# install gzip
RUN microdnf install gzip
# recompile python
RUN wget https://www.python.org/ftp/python/3.9.0/Python-3.9.0.tgz && tar -xvf Python-3.9.0.tgz && cd Python-3.9.0 && microdnf install gcc openssl-devel bzip2-devel libffi-devel -y && ./configure --prefix=/usr/local && make && make install && echo 'export PATH=/usr/local/bin:$PATH' >> ~/.bashrc && source ~/.bashrc
# install prereqs 
RUN pip3 install gunicorn Flask Jinja2 markupsafe flasgger scikit-learn pylzma
# install pandas 
RUN pip3 install pandas
# install pytorch1 
RUN pip3 install torch --extra-index-url https://download.pytorch.org/whl/cpu
# install pytorch2 
RUN pip3 install torchvision --extra-index-url https://download.pytorch.org/whl/cpu
# install pytorch3 
RUN pip3 install torchaudio --extra-index-url https://download.pytorch.org/whl/cpu
# install pypdf 
RUN pip3 install -q pypdf
# install python-dotenv 
RUN pip3 install -q python-dotenv
# install transformers 
RUN pip3 install -q transformers
#  upgrade pip 
RUN pip install --upgrade pip
# install langchain_community 
RUN pip3 install langchain_community
# install langchain 
RUN pip3 install --upgrade --quiet langchain
# install langchain-core 
RUN pip3 install --upgrade --quiet langchain-core
# install nemoguardrails 
RUN pip3 install --upgrade --quiet nemoguardrails
# install pysqlite3-binary 
RUN pip3 install --upgrade --quiet pysqlite3-binary
# install chromadb 
RUN pip3 install --upgrade --quiet chromadb
# install sentence-transformers 
RUN pip3 install --upgrade --quiet sentence-transformers
# open permission 
RUN chmod 777 -R /home

USER sas

ENTRYPOINT ["/bin/bash", "startServer.sh"]
