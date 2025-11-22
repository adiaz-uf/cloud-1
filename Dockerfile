FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y openssh-server python3 sudo && \
    mkdir /var/run/sshd && \
    echo 'root:test123' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    apt-get clean

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]