# Ansible Docker Project

This project demonstrates how to use Ansible to manage Docker containers as target hosts. It allows for the automation of various tasks and configurations without the need for a paid Virtual Private Cloud (VPC) like Linode, making it a cost-effective solution for learning and practicing Ansible.

## Project Overview

The main goal of this project is to create a local Ansible environment using Docker containers, which serve as the target hosts. This approach allows you to simulate a multi-server setup on your local machine without incurring any costs.

## Project Structure

The project is organized into the following components:

1.  **Dockerfile**:

    - This file defines the setup for the Ansible environment and includes the installation of required packages such as Ansible and OpenSSH server.
    - It also creates a user (`ansible_user`) with password-based authentication and grants sudo privileges without requiring a password.

2.  **docker-compose.yml**:

    - This file defines the services, networks, and configurations for the Docker containers.
    - It sets up three Docker containers that will act as the target hosts for Ansible, along with an Ansible control container.

3.  **ansible_data/hosts**:

    - This is the inventory file that lists the Docker containers (hosts) that Ansible will manage.
    - Each entry specifies the hostnames, IP addresses, and connection parameters for Ansible to connect via SSH.

## Getting Started

### Prerequisites

- **Docker**: Ensure that Docker is installed on your machine.
- **Docker Compose**: Required for managing multi-container Docker applications.
- **SSH Access**: You need SSH access to your local machine to set up keys for passwordless authentication.

### Installation and Setup

1.  **Clone the Repository**

    - Clone this repository to your local machine:

    ```bash
    git clone https://github.com/yourusername/your-repo-name.git
    cd your-repo-name
    ```

2.  **Build and Run the Docker Containers**

    - Use Docker Compose to build and run the containers in detached mode:

    ```bash
    docker-compose up --build -d
    ```

3.  **Configure SSH Access**

    - You need to copy your SSH public key to each of the Docker containers to enable passwordless access. Run the following commands:

    ```bash
    ssh-copy-id -i ~/.ssh/id_rsa.pub ansible_user@172.20.0.10
    ssh-copy-id -i ~/.ssh/id_rsa.pub ansible_user@172.20.0.11
    ssh-copy-id -i ~/.ssh/id_rsa.pub ansible_user@172.20.0.12`
    ```

### Running Ansible

- To test the SSH connectivity to all managed hosts, run the following command:

```bash
  ansible all -m ping
```

- If everything is set up correctly, you should receive a success message from each container.

### Automating Tasks with Ansible

- Create Ansible playbooks to automate tasks across your containers. For example, you can create a playbook to install packages, configure services, or manage files.
- Example playbook (`distribute_keys.yml`):

  yaml

  Copy code

```yaml
  ---
  - name: Distribute SSH keys to all containers
    hosts: all
    tasks:
    - name: Ensure SSH key is present
      authorized_key:
      user: ansible_user
      state: present
      key: "{{ lookup('file', '/path/to/your/public/key.pub') }}"
```

### Stopping and Removing Containers

- To stop and remove the containers, run:

```bash
  docker-compose down
```

## Conclusion

This project serves as an effective way to practice Ansible in a controlled environment using Docker containers. It eliminates the need for external services and allows you to experiment with various Ansible modules and playbooks.

## License

This project is licensed under the MIT License.

## Acknowledgments

- Special thanks to the Ansible community for their documentation and support.
- Thanks to Docker for providing an excellent platform for containerization.

