FROM ubuntu:latest

RUN apt-get update && apt-get install curl unzip bc jq -y

WORKDIR /s3_migration

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm awscliv2.zip

COPY ./scripts /s3_migration

RUN chmod +x ./main.sh

ENTRYPOINT ["bash", "./main.sh"]
