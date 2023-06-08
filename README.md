# What's the weather

## Setup

### Setup Local Development
- Setup the correct ruby environment
- Install gem dependencies via bundler

#### Setup ruby
- Install your preferred Ruby version manager
- [rvm](https://rvm.io/rvm/install) or [rbenv](https://github.com/rbenv/rbenv#installation)
- Install Ruby via RBENV
- `$ rbenv install 3.2.1`

#### Setup rails
- `$ gem install rails`
- `$ bundle install`


### DB
- Create the db `$ bin/rails db:create`
- To migrate the db just run `$ bin/rails db:migrate`

## Run
Now that your environment is setup, you are ready to start the application.

`$ bin/dev`


This script will launch the puma server at `http://localhost:3000`

## Docker
If you wish to run the application through docker make sure you have it installed
- Open your etc/hosts file and add this line: `127.0.0.1 postgres`
- Run `$ docker-compose up`

This script will download the required images to run the application and will launch the puma server at `http://localhost:3000`

### DB
- To migrate the db you can run `$ docker-compose run rails rails db:migrate`

- You should be all set now
