# Inception — User Documentation

## Services Provided
The stack includes:
- **WordPress**: the main website and content management system.
- **MariaDB**: database backend for WordPress.
- **Nginx**: web server handling HTTP/HTTPS requests.

## Starting and Stopping the Project
- Start all services:

make up

- Stop all services:

make down


Accessing the Website and Admin Panel

Website: https://manbengh.42.fr

WordPress admin panel: https://manbengh.42.fr/wp-admin/

⚠️ SSL is self-signed. If your browser warns about it, click Advanced → Proceed anyway.




-- Credentials

- Admin account:

  Username: manbengh42

  Password: passmanbengh

- Visitor account:

  Username: visit

  Password: visitpass

- Credentials are defined in the .env file.



-- Verifying Services

- Check running containers:

docker ps

- Inspect logs if a service is not running correctly:

docker logs <container_name>

