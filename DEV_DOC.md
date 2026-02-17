# Inception — Developer Documentation

## Environment Setup
- Prerequisites:
  - Docker installed
  - Docker Compose or Docker Compose plugin
  - Unix-like environment (Linux, macOS, or Linux VM)
- Clone the repository:

git clone <repository_url>
cd <repository_folder>

- Configure the `.env` file with correct database and WordPress credentials.

## Building and Launching
- Build and start all services:

make up

- Stop all services:

make down

- Completely reset the project (remove containers, volumes, and persistent data):

make erase

## Managing Containers and Volumes
- List running containers:

docker ps

- Check container logs:

docker logs <container_name>

- Remove volumes manually if needed:

docker volume rm <volume_name>

## Data Persistence
- Persistent data is stored in Docker volumes:
  - MariaDB data: `/home/manbengh/data/mariadb`
  - WordPress data: `/home/manbengh/data/wordpress`

- Volumes ensure data remains intact even if containers are stopped, restarted, or rebuilt.

