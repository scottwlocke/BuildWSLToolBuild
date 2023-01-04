# Build file for creating a WSL Fedora Distro
# Included Packages 
#   Hashicorpts Packer and Terraform and Vault
#   Ansible and Windows pyWinRM connection files
#   PowerShell 7
#   Git
#   Also add common utils like ping

#   TODO: Add AWX
#   TODO: Add Podman Rootless
#         https://github.com/swseighman/Podman-Fedora-WSL2
#         https://www.redhat.com/sysadmin/run-podman-windows

FROM fedora:latest

ENV PYTHONIOENCODING=utf-8


RUN dnf update -y; \
    dnf install -y glibc-locale-source glibc-langpack-en; \
    localedef -f UTF-8 -i en_US en_US.UTF-8; \
    dnf install -y gcc libffi-devel python3 epel-release; \
    dnf install -y python3-pip; \
    dnf install -y wget; \
    dnf install -y openssh; \
    dnf install -y dnf-plugins-core; \
    dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo; \
    dnf install -y terraform; \
    dnf install -y packer; \
    dnf install -y vault; \
    dnf config-manager --add-repo https://packages.microsoft.com/config/rhel/7/prod.repo; \
    dnf install -y powershell; \
    dnf install -y azure-cli; \
    dnf install -y ansible; \
    dnf install -y golang; \
    dnf install -y git; \
    dnf install -y iproute findutils ncurses; \
    dnf install -y procps-ng; \
    dnf install -y passwd cracklib-dicts; \
    dnf install -y util-linux; \
    dnf install -y iputils; \
    dnf install - y ca-certificates; \
    dnf install -y gnupg; \
    dnf install -y openssl; \
    dnf install libcap; \
    dnf install -y su-exec; \
    dnf clean all

# Create non root user, add to wheel, delete password, and add wsl.conf file 
# TODO: Create password change on first run
RUN useradd -G wheel scott ; \
    passwd -d scott
ADD wsl.conf /etc/wsl.conf
# Switching to non root user to configure PIP installs
USER scott

# Add windows related tools for Ansible via PIP
# TODO: Is this the most efficent way in regards to disk size?
RUN pip3 install --upgrade pip; \
    pip3 install --upgrade virtualenv; \
    pip3 install pywinrm[kerberos]; \
    pip3 install pywinrm; \
    pip3 install jmspath; \
    pip3 install requests
   # ansible-galaxy collection install azure.azcollection 
   #  pip3 install -r ~/.ansible/collections/ansible_collections/azure/azcollection/requirements-azure.txt

