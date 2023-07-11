FROM python:3.8-alpine

LABEL "com.github.actions.name"="AWSCLI"
LABEL "com.github.actions.description"="Wraps the AWSCLI for common Github Actions"
LABEL "com.github.actions.icon"="refresh-cw"
LABEL "com.github.actions.color"="green"

LABEL version="0.1.0"
LABEL repository="https://github.com/welingtonsampaio/action-awscli"
LABEL homepage="https://alboompro.com/"
LABEL maintainer="Welington Sampaio <welington.sampaio@alboompro.com>"

# https://github.com/aws/aws-cli/blob/master/CHANGELOG.rst
ENV AWSCLI_VERSION='1.29.2'

RUN pip install --quiet --no-cache-dir awscli==${AWSCLI_VERSION}

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]