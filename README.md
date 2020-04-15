![Create Github Release](https://github.com/KikeMendez/automate-cdk-github-action-kmzz/workflows/Create%20Github%20Release/badge.svg)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)

# Automate-CDK
A github action to manage your aws infrastructure by using aws cdk

For references about the available command options check [AWS CDK Toolkit (cdk)](https://docs.aws.amazon.com/cdk/latest/guide/tools.html)   
As you should be able to run any of the AWS CDK on this action
## Configuring credentials
The recommended way is to save your credentials as [secrets](https://help.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets) in your github repository  

Then just be sure you set the environment variables as follow:

```yaml
env:
  AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
  AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
  AWS_DEFAULT_REGION: 'us-east-1'
```

## Usage

You can build this action by directly referring to it from the repository
```yaml
uses: KikeMendez/automate-cdk-github-action-kmzz:v1.0.0@master
```
or to save some seconds you can use a pre built docker image
```yaml
uses: docker://kikemnzz/automate-cdk-github-action-kmzz:v1.0.0
```
Check image versions available here: https://hub.docker.com/r/kikemnzz/automate-cdk-github-action-kmzz/tags?page=1&ordering=name
## Action Inputs:

| Action      | Description | Default     |
| :---        |    :----:   |          ---: |
| cdk_stack_directory      | stack location |   - |
| cdk_stack      | stack name |   - |
| cdk_action      | cdk command | -|
| cdk_version      | aws cdk version |   latest |



## Deploy All
Make sure the first step is building your application
```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2      
      # Build your application here
      - run: echo 'Build and tests passed!'

      # Deploy stacks
      - name: cdk deploy all stacks
        uses: docker://kikemnzz/automate-cdk-github-action-kmzz:v1.0.0
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          AWS_DEFAULT_REGION: 'us-east-1'
        with:
          cdk_action: 'deploy --verbose --require-approval never'
```
In the example above by default this action will use the latest version of [aws-cdk](https://www.npmjs.com/package/aws-cdk) 

## Choose AWS CDK Version
In case a previous version of aws-cdk is required for your application set the aws cdk version you need  
```yaml
with:
  cdk_version: '1.31.0'
```

## Deploy Individual Stacks
The example below shows how you could use it within a monorepo
```yaml
      - name: deploying first stack
        uses: docker://kikemnzz/automate-cdk-github-action-kmzz:v1.0.0
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID_MyStack1 }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY_MyStack1 }}
          AWS_DEFAULT_REGION: 'us-east-1'
        with:
          cdk_version: '1.9.0'
          cdk_action: 'deploy'
          cdk_stack: 'MyStack1'
          cdk_stack_directory: 'stack/path'

      - name: deploying second stack
        uses: docker://kikemnzz/cdk-github-action-kmzz:1.0.0
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID_MyStack2 }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY_MyStack2 }}
          AWS_DEFAULT_REGION: 'eu-west-1'
        with:
          cdk_version: '1.19.0'
          cdk_action: 'deploy'
          cdk_stack: 'MyStack2'
          cdk_stack_directory: 'stack/path'
```

If all your stacks are using the same credentials you can set the environment variables at the job level
```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    env:
      AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID_MyStack1 }}
      AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY_MyStack1 }}
      AWS_DEFAULT_REGION: 'us-east-1'
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
[MIT](LICENSE)

## Author
[KikeMendez](https://github.com/KikeMendez)
