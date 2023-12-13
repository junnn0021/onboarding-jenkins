FROM ubuntu:20.04

ENV TZ Asia/Seoul
ENV PYTHONIOENCODING UTF-8
ENV LC_CTYPE C.UTF-8

RUN touch /etc/default/locale

RUN echo 'export TEST=LJS' >> ~/.bashrc

RUN apt-get update && \
    apt-get install -y curl wget cron unzip vim software-properties-common

RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.7

RUN apt-get install -qq -y init systemd

RUN curl "https://d1vvhvl2y92vvt.cloudfront.net/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm awscliv2.zip && \
    rm -rf aws

RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 1

RUN apt-get install -y fontconfig openjdk-17-jre

RUN wget -O /usr/share/keyrings/jenkins-keyring.asc \
    https://pkg.jenkins.io/debian/jenkins.io-2023.key

RUN echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian binary/ | tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null

RUN echo "Acquire::Check-Valid-Until \"false\";\nAcquire::Check-Date \"false\";" | cat > /etc/apt/apt.conf.d/10no--check-valid-until

RUN apt-get update && \
    apt-get install -y jenkins

COPY run_check_jenkins.sh /run_check_jenkins.sh

RUN chmod +x /run_check_jenkins.sh

# RUN echo "*/5 * * * * /run_check_jenkins.sh >> /var/log/cron.log 2>&1" | crontab -

RUN curl -s https://get.docker.com | sh

RUN usermod -aG docker jenkins

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN systemctl mask systemd

CMD ["/usr/sbin/init"]

