#!/bin/bash -x

exitFatal() {
    echo 'command failed. Exiting...'
    exit 1
}

docker image rm s3_migration:0.0.1 --force || exitFatal
docker image build --platform linux/x86_64 -t s3_migration:0.0.1 . || exitFatal
docker run --platform linux/x86_64 --env-file aws_credentials --env-file assignment_variables s3_migration:0.0.1 || exitFatal
