FROM node:latest

LABEL name="Automate-CDK"
LABEL repository="https://github.com/KikeMendez/automate-cdk-github-action-kmzz"
LABEL homepage="https://github.com/KikeMendez/automate-cdk-github-action-kmzz"
LABEL "com.github.actions.name" = "Automate-CDK"
LABEL "com.github.actions.description" = "A github action to manage your aws infrastructure by using aws cdk"
LABEL "com.github.actions.icon" = "tool"
LABEL "com.github.actions.color" = "black"
LABEL maintainer="Enrique Mendez <kikemnzz@gmail.com>"

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

COPY entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
