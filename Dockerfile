FROM ubuntu:22.04

# Install OpenSSH server so Ansible can connect
RUN apt-get update && apt-get install -y openssh-server python3 sudo

# Create a user for Ansible to use
RUN useradd -m -s /bin/bash ansible_user && \
    echo "ansible_user:password" | chpasswd && \
    usermod -aG sudo ansible_user

# Allow passwordless sudo (Ansible often needs this)
RUN echo "ansible_user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set up SSH
RUN mkdir /var/run/sshd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]