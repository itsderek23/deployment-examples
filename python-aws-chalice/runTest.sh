
#!bin/bash
cd /var/task
echo "Deploying the lambda, and update with envs" 
declare RESULT=($(chalice deploy)) ; \
aws lambda update-function-configuration \
            --function-name python_chalice_lambda_regression_test-dev \
            --region us-east-2 \
            --environment Variables="{ROOKOUT_TOKEN=$ROOKOUT_TOKEN,ROOKOUT_ROOK_TAGS=python_chalice_lambda_regression_test-dev,ROOKOUT_DEBUG=1,ROOKOUT_LOG_TO_STDERR=1}" 
echo "Sleeping for 20 secs" 
sleep 20
echo "Triggering the lambda/ checking to see the result" 
curl ${RESULT[26]}
echo "Sleeping for 60 seconds more" 
sleep 60
echo "Trying to get logs" 
chalice logs index
chalice logs python_chalice_lambda_regression_test-dev
echo "Deleting the stage" 
chalice delete --stage dev
