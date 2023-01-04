# Build a Docker Container with Fedora as an Ansible Control Node
This is just an attempt and generating a custom WSL image for use with WSL2.  

# ** THIS IS FOR DEVELOPMENT AND TESTING ONLY NOT PRODUCTION **

Based it off of Fedora since it is 
focused on Ansible and other utilities.
## Pre-Requistes

- Docker Desktop Installed
- WSL2 Installed

## Assumed parameters
- DOCKERNAME = Name for Docker Container
- XXXXXXXXXXX = Container ID from built Docker container
- PATH output directory
- IMAGE.tar the Docker Exported Tarball
- WSLNAME Name that will be used in WSL
- WSLPATH Path to folder where the WSL disk image will be held, create before hand

# Docker Build Command
```
docker build . -t DOCKERNAME
````

# Run interactively
```
docker run -it DOCKERNAME
```

# Identify the Container that was built
```
docker container ls -a
```

- Make note of Container ID from output

# Export Docker Container to Tar file
```
docker export -o PATH\WSLName.tar XXXXXXXXXXX
```
XXXXXXXXX will be the Container ID from the previous step.
# Import into WSL 2
```
wsl --import WSLNAME WSLPATH PATH\IMAGE.tar --version 2                                        
```

Add the --version 2 to ensure it is built for WSL2 Environment

## TODO
- Configure Vault with Certs
- PowerShell Scripts