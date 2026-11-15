
# Vagrant Provisioning

## Overview

This project uses Vagrant to manage a three-tier virtual machine environment.

Provisioning scripts automate software installation and server configuration, reducing repetitive manual setup.

## Web Server

The web tier receives HTTP requests from users.

The web provisioning script is responsible for preparing the web server environment and configuring communication with the application tier.

## Application Server

The application tier runs the application's backend logic.

Its provisioning script prepares the runtime environment and dependencies needed to run the application.

## Database Server

The database tier stores application data.

Its provisioning script prepares the database environment and configures the database service.

## Provisioning Workflow

1. Vagrant reads the Vagrantfile.
2. VirtualBox creates the configured virtual machines.
3. Vagrant configures VM networking.
4. Provisioning scripts run on their assigned virtual machines.
5. Required software and services are configured.
6. The environment becomes ready for testing.

## Verification

The exact software versions, provisioning commands, and application tests will be documented after the configuration has been reviewed and tested.
