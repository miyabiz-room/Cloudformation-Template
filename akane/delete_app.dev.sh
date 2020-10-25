#!/bin/sh

cd `dirname $0`

BASENAME=$(basename $0)
FILENAME=${BASENAME%.*}
ENV_TYPE=${FILENAME##*.}

APP_DIR=app
S3_DIR=s3-app/

BUCKET_NAME=$(cat ${S3_DIR}${ENV_TYPE}-parameters.json | jq -r '.Parameters[] | select(.ParameterKey == "AppS3Bucket").ParameterValue')

aws s3 rm s3://${BUCKET_NAME} --recursive

cd ${APP_DIR}

amplify delete

exit 0