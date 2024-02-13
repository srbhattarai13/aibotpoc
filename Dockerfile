# FROM ubuntu:latest

# RUN mkdir /opt/aibotpoc
# USER root
# RUN chmod -R 777 /opt/aibotpoc
# WORKDIR /opt/aibotpoc

# RUN apt-get update && DEBIAN_FRONTEND=“noninteractive” apt-get install -y --no-install-recommends \
#        nginx \
#        curl \
#        ca-certificates \
#        apache2-utils \
#        certbot \
#        wget \
#        python3.10\
#        python3-certbot-nginx \
#        python3-pip\
#        sudo \
#        cifs-utils \
#        && \
#     rm -rf /var/lib/apt/lists/*
# RUN apt-get install -y curl
# COPY .env ./
# COPY requirements.txt .
# RUN pip install -r requirements.txt
# COPY . .
# ENV PATH="/usr/local/bin:${PATH}"
# COPY run.sh .
# COPY project_contents .
# RUN chmod a+x run.sh
# CMD ["run.sh"]




FROM python:3.10-slim



COPY requirements.txt requirements.txt
RUN pip install -U pip
RUN pip install -r requirements.txt
COPY .env ./

# Copy app code and set working directory

COPY . .

EXPOSE 8501
ENTRYPOINT streamlit run project_contents/app/app.py --server.port=8501 --server.address=0.0.0.0
CMD ["./run.sh"]
