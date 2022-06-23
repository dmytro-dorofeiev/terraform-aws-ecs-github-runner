
FROM ubuntu:20.04

ARG VERSION=2.293.0
ENV DEBIAN_FRONTEND=noninteractive
ENV RUNNER_ALLOW_RUNASROOT=true
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    jq \
    git \
    unzip \
    iputils-ping \
    libcurl4 \
    libicu66 \
    libunwind8 \
    netcat \
    wget \
    && apt-get clean \
    && rm -rf /var/cache/apt

RUN mkdir actions-runner \
    && cd actions-runner \
    && curl -O -L https://github.com/actions/runner/releases/download/v$VERSION/actions-runner-linux-x64-$VERSION.tar.gz \
    && tar xzf ./actions-runner-linux-x64-$VERSION.tar.gz \
    && ./bin/installdependencies.sh \
    && mkdir /_work \
    && rm -f actions-runner-linux-x64-$VERSION.tar.gz

COPY ./start.sh actions-runner
RUN chmod +x actions-runner/start.sh
RUN ls -l

WORKDIR /actions-runner

CMD ["./start.sh"]
