FROM ubuntu:22.04

# Install Ansible and OpenSSH server
RUN apt-get update && apt-get install -y \
  ansible \
  openssh-server \
  && mkdir /var/run/sshd

# Create ansible_user with password
RUN useradd -ms /bin/bash ansible_user && echo "ansible_user:password" | chpasswd

# Give sudo access without password
RUN echo 'ansible_user ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Enable SSH to allow root login and password authentication
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
  sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Expose SSH port
EXPOSE 22

# Start SSH service and keep container running
CMD ["/usr/sbin/sshd", "-D"]
