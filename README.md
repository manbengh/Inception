*This project has been created as part of the 42 curriculum by manbengh.*

# Inception

## Description
Inception is a web stack project that simulates a real production environment using **Docker** containers. 
It runs **WordPress**, **MariaDB**, and **Nginx**, showing how multiple services can work together in isolation.
The project highlights key concepts like 
**containerization**, **network communication between services**, **persistent storage with volumes**, and environment configuration using **.env files**.
It is designed to help students understand modern deployment workflows and the differences between virtual machines and containers.


---


## Project Architecture 

- Sources: The srcs folder contains Dockerfiles for Nginx, WordPress, MariaDB, and a docker-compose.yml to orchestrate the services.

- Virtual Machines vs Docker: Docker is lighter, faster to deploy, and easier to scale.

- Secrets vs Environment Variables: Environment variables are used for simplicity; secrets are recommended in production.

- Docker Network vs Host Network: Containers communicate securely over an isolated network.

- Docker Volumes vs Bind Mounts: Volumes manage persistent data automatically and are portable.

---

## Instructions

- Clone the repo:


git clone <repository_url>
cd <repository_folder>

- Set up .env (make sure WordPress and MariaDB variables match):

WARNING ! If you change .env, delete volumes to apply changes:

make down -v
rm -rf /home/manbengh/data


- Start the services:

make up

- Stop services:

make down

--Usage

- Access WordPress admin: https://manbengh.42.fr/wp-admin/

- Self-signed SSL warning: click Advanced → Proceed anyway

- Troubleshoot:

docker ps
docker logs wordpress

---

## Resources
- [Docker Documentation](https://docs.docker.com) – for containerization, volumes, and networking
- [Docker Compose Documentation](https://docs.docker.com/compose/) – for multi-container orchestration
- [WordPress Documentation](https://wordpress.org/support/) – WordPress setup and management
- [MariaDB Documentation](https://mariadb.org/documentation/) – database setup and management


---

## AI Usage
AI was used to help **understand the project concepts**, such as Docker, container networking, volumes, and environment configuration.
