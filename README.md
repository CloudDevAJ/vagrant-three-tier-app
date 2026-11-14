# Vagrant Three-Tier Web Application

A three-tier web application environment built using Vagrant and VirtualBox.

This project demonstrates how separate virtual machines can be used for the web, application, and database layers of an application.

## Architecture

The environment contains three virtual machines:

- Web Server — receives incoming web requests
- Application Server — runs the Flask application
- Database Server — stores application data

## Technologies Used

- Vagrant
- VirtualBox
- Linux
- Python
- Flask
- MySQL
- Apache / Nginx
- Git and GitHub

## Project Goals

The main goals of this project are to:

- Automate the creation of multiple virtual machines
- Configure communication between the three tiers
- Practice Linux networking and service configuration
- Deploy a Flask application
- Connect the application to a database server


## How the Three-Tier Architecture Works

This project uses Vagrant and VirtualBox to create three separate Linux virtual machines, each responsible for a different part of the application.

### 1. Web Server
The web server receives HTTP requests from users and forwards application requests to the Flask server.

### 2. Application Server
The application server runs a Python Flask application. It processes incoming requests, handles application logic, and communicates with the database server.

### 3. Database Server
The database server stores application data using MySQL. It runs separately from the web and application servers.

### Communication Flow

Browser → Web Server → Flask Application → MySQL Database

### Why Use Three Tiers?

Separating the application into three tiers makes it easier to manage each component independently.

It also demonstrates how multiple virtual machines communicate over a private network and how Vagrant can automate the creation of a multi-server environment.
