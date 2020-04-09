# Automate-CDK
A github action to manage your aws infrastructure by using aws cdk

## Configuring credentials
The recommended way is to save your credentials as [secrets](https://help.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets) in your github repository  

Then just be sure you set the environment variables as follow:

```$xslt
env:
  AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
  AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
  AWS_DEFAULT_REGION: 'us-east-1'
```

## Usage

You can build this action by directly referring it from the repository
```$xslt
uses: KikeMendez/automate-cdk-github-action-kmzz:v1.0.0@master
```
or by using a pre built docker image
```$xslt
uses: docker://kikemnzz/automate-cdk-github-action-kmzz:v1.0.0
```

For references about the available command options check [AWS CDK Toolkit (cdk)](https://docs.aws.amazon.com/cdk/latest/guide/tools.html) 

## Deploy all stacks 
Be aware that the first step should be build your application
```$xslt
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2      
      # Build your application here

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
In the example above by default this action will use the lasted version of [aws-cdk](https://www.npmjs.com/package/aws-cdk) 

In case a previous version of aws-cdk is required for your application set the aws cdk version you need
```$xslt
with:
  cdk_version: '1.31.0'
  cdk_action: 'deploy --verbose --require-approval never'
```

## cdk action on specific stacks
The example below shows how you could use it within a monorepo
```$xslt
      - name: diff MyStack1 in directory mystack-1
        uses: docker://kikemnzz/automate-cdk-github-action-kmzz:v1.0.0
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID_MyStack1 }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY_MyStack1 }}
          AWS_DEFAULT_REGION: 'us-east-1'
        with:
          cdk_action: 'diff'
          cdk_stack: 'MyStack1'
          cdk_stack_directory: 'mystack-1'

      - name: cdk diff
        uses: docker://kikemnzz/cdk-github-action-kmzz:1.0.0
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID_MyStack23 }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY_MyStack23 }}
          AWS_DEFAULT_REGION: 'eu-west-1'
        with:
          cdk_version: '1.19.0'
          cdk_action: 'diff'
          cdk_stack: 'MyStack23'
          cdk_stack_directory: 'mystack-23'
```

If all your stacks are using the same credentials you can set the environment variables at the job level
```$xslt
jobs:
  deploy:
    runs-on: ubuntu-latest
    env:
      AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID_MyStack1 }}
      AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY_MyStack1 }}
      AWS_DEFAULT_REGION: 'us-east-1'
    steps:
      - uses: actions/checkout@v2     
      - name: doctor MyStack1 in directory mystack-1
        uses: docker://kikemnzz/automate-cdk-github-action-kmzz:v1.0.0
        with:
          cdk_action: 'doctor'
          cdk_stack: 'MyStack1'
          cdk_stack_directory: 'mystack-1'

      - name: cdk synth
        uses: docker://kikemnzz/cdk-github-action-kmzz:1.0.0
        with:
          cdk_version: '1.19.0'
          cdk_action: 'synth'
          cdk_stack: 'MyStack23'
          cdk_stack_directory: 'mystack-23'
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
[MIT](LICENSE)

## Author
[KikeMendez](https://github.com/KikeMendez)
