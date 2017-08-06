# Basic Rails

Rails Web Application Template

## Goal

Deploying basic application within 10 minutes to local vagrant, heroku, EC2.
This Application have several basic feature.

* User Authentication
* API(OAuth2.0)
* Admin Page
* Connect to MySQL or PostgreSQL
* Application Cache
* Queue System
* Testing with rspec
* Dockerized Application
* Basic Design

## Usage 

* Initialize

```bash
$ bin/rails new hoge --skip-turbolinks -T --skip-bundle -m https://raw.githubusercontent.com/tzmfreedom/basic-rails/master/template.rb
$ cd hoge
$ make install # call `bundle install`
```

* Database

migration
```bash
$ make migrate # `bundle exec rake db:migrate`
```

seed
```bash
$ make seed # `bundle exec rake db:seed`
```

* Run Web application

```
$ make run
```

* Run backend queue system

```bash
$ make run_queue
```

* Deploy

```bash
$ make deploy
```

* Test

```bash
$ make test
```
