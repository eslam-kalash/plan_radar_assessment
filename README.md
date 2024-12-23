# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

#### * Clone the Repository:
Start by cloning this GitHub repository to your local machine using the following command:


#### * Install Docker:
Make sure you have Docker installed on your system. Docker provides a containerization platform that simplifies the deployment and management of applications.
* For Windows or macOS users, download and install Docker Desktop from the official Docker website: https://www.docker.com/get-started.
* For Linux users, follow the instructions provided in the official Docker documentation to install Docker on your specific distribution: https://docs.docker.com/engine/install/.

#### * Configure environment variables:
Import Application Platform relies on a database, redis and many other containers for storing data. Create a .env file in your project and ensure that the database configuration (e.g., username, password, host) and other details are correctly set for your development environment.


```bash
cd plan_radar_assessment
touch .env
```

Sample .env file:
```bash
BUNDLER_VERSION=2.4.13
ASSESSMENT_DATABASE_PASSWORD=xxxxxxxx
ASSESSMENT_DATABASE_USERNAME=plan_radar
DATABASE_NAME=plan_radar_development
RAILS_ENV=development
REDIS_HOST=redis
REDIS_PORT=6379
RAILS_MAX_THREADS=10
```


#### * Build Docker Image:
Navigate to the project directory and build the Docker image by running the following command:

```bash
cd plan_radar_assessment
docker-compose build up
```
This command will build a Docker image for your Rails application based on the provided Dockerfile.

#### * Start Docker Container:
Once the Docker image is built, you can start the application by running the following command:

```bash
docker-compose run -p 3000:3000 --entrypoint /bin/bash app
bundle exec rails s -b 0.0.0.0
```
This command starts a Docker container based on the image you built and maps port 3000 of the container to port 3000 of your local machine


###  Explanation:
- access the app  container and try to run those command 
```bash
 rails  db:create 
 rails  db:migrate 
 rails  db:seed
```


- run this command to check the sending email as notification for users  in rails console
```bash
 DueDateReminderService.send_reminders
```

- I added whenever if we need to run  this as cronjob , also added sidkiq for future enhancement 
- you can check the specs too 
```bash
bundle exec rspec
```
#### Modules and classes created:
 - app/builders/notification_builder.rb
 - app/builders/email_notification_builder.rb
 - app/builders/sms_notification_builder.rb --  just for future :) 
 - app/dispatchers/notification_dispatcher.rb
 - app/services/due_date_reminder_service.rb
 - app/jobs/due_date_reminder_job.rb
 - config/schedule.rb
 - app/models/ticket.rb
 - app/models/user.rb
 - specs/models
 - specs/jobs
 - specs/factories
 - specs/rails_helper
###  Technologies:
- Sidekiq
- Redis
- Ruby on Rails
- Postgresql