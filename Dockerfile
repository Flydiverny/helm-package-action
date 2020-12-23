FROM alpine:3.12

LABEL "name"="helm-package-action"
LABEL "maintainer"="Markus Maga <markus@maga.se>"
LABEL "version"="0.2.0"

LABEL "repository"="http://github.com/flydiverny/helm-package-action"
LABEL "homepage"="http://github.com/flydiverny/helm-package-action"

LABEL "com.github.actions.name"="Helm Package"
LABEL "com.github.actions.description"="Action for running helm package on helm charts to create versioned chart archive file(s)"
LABEL "com.github.actions.icon"="anchor"
LABEL "com.github.actions.color"="blue"

ARG K8S_VERSION=v1.18.14
ARG HELM_VERSION=v2.17.0
ENV HELM_HOME=/usr/local/helm

RUN apk -v --update --no-cache add \
  ca-certificates \
  bash

RUN wget -O /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$K8S_VERSION/bin/linux/amd64/kubectl && \
  chmod +x /usr/local/bin/kubectl

RUN wget -q https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm && \
  chmod +x /usr/local/bin/helm

RUN helm init --client-only

COPY ./helm-package.sh /usr/bin/helm-package

ENTRYPOINT ["helm-package"]
CMD ["help"]
