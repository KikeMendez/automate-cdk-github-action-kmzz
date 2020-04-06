#!/bin/bash
echo "${PWD}"

printenv;

# Validate AWS Credentials
  if [ "${AWS_ACCESS_KEY_ID}" == "" ]; then
   	echo "Input AWS_ACCESS_KEY_ID cannot be empty"
		exit 1
  fi

  if [ "${AWS_SECRET_ACCESS_KEY}" == "" ]; then
   	echo "Input AWS_SECRET_ACCESS_KEY cannot be empty"
		exit 1
  fi

# Configure aws cli with a default profile
aws configure set aws_access_key_id "${AWS_ACCESS_KEY_ID}";
aws configure set aws_secret_access_key "${AWS_SECRET_ACCESS_KEY}";
cat ~/.aws/credentials
aws s3 ls
ls -a
cdk bootstrap;

#
#GITHUB_HEAD_REF=
#GITHUB_ACTOR=KikeMendez
#GITHUB_ACTION=KikeMendezcdk-github-action-kmzz
#PWD=/github/workspace
#HOME=/github/home
#RUNNER_TEMP=/home/runner/work/_temp
#RUNNER_WORKSPACE=/home/runner/work/action-cdk-test
#GITHUB_REF=refs/heads/master
#GITHUB_SHA=878d1ae02a262d7c41f4649995dee7f2d368a87b
#ACTIONS_RUNTIME_TOKEN=***
#GITHUB_RUN_ID=71355398
#NODE_VERSION=13.12.0
#GITHUB_EVENT_PATH=/github/workflow/event.json
#RUNNER_OS=Linux
#GITHUB_BASE_REF=
#INPUT_CDK_ACTION=bootstrap
#AWS_ACCESS_KEY_ID=***
#SHLVL=1
#GITHUB_REPOSITORY=KikeMendez/action-cdk-test
#GITHUB_EVENT_NAME=push
#GITHUB_RUN_NUMBER=7
#GITHUB_WORKFLOW=CDK Test
#PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
#GITHUB_WORKSPACE=/github/workspace
#ACTIONS_RUNTIME_URL=https://pipelines.actions.githubusercontent.com/fSOm4ZJu1qt3gPeod8pgAF7xOrNK7G2bKPhhWIQA1lK3ndwbr0/
#ACTIONS_CACHE_URL=https://artifactcache.actions.githubusercontent.com/fSOm4ZJu1qt3gPeod8pgAF7xOrNK7G2bKPhhWIQA1lK3ndwbr0/