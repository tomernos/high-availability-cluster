FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

USER root

RUN apt-get update && apt-get install -y \
    openjdk-17-jdk \
    gnupg \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian/jenkins.io-2023.key \
    && echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/" > /etc/apt/sources.list.d/jenkins.list \
    && apt-get update \
    && apt-get install -y jenkins

EXPOSE 8080

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["tail", "-f", "/dev/null"]
