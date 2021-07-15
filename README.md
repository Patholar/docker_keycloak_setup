## SMART-on-FHIR dockerized setup
This repository contains the dockerized setup of [SMART-on-FHIR](https://github.com/openmrs/openmrs-module-smartonfhir) project.

Ensure you have [Docker](https://docs.docker.com/get-docker/) and [Docker compose](https://docs.docker.com/compose/install/) installed locally.

To run the SMART-on-FHIR project, Follow the instructions mentioned below:
1. Clone the repository locally

        git clone https://github.com/theanandankit/openmrs-keycloak-dockerized-setup.git

2. Run the docker-compose

        docker-compose up

3. You should be able to access the OpenMRS, keycloak at the following urls: 

| Instance  |     URL       | credentials (user : password)|
|---------- |:-------------:|------:                       |
| OpenMRS   |  http://localhost:8080/openmrs  | admin : Admin123 |
| keycloak   |    http://localhost:8180  |  admin : Admin123 | 

4. You will also need a SMART App running locally. Here is a [DEMO SAMRT App](https://github.com/theanandankit/Demo-Smart-App). 

5. Stop Docker-compose

        docker-compose down -v

## Main Repositories
* Openmrs-contrib-keycloak-smart-auth https://github.com/openmrs/openmrs-contrib-keycloak-smart-auth

* Openmrs-contrib-keycloak-auth https://github.com/openmrs/openmrs-contrib-keycloak-auth
