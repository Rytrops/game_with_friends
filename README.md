# README

Games with Friends by [rytrops](https://github.com/Rytrops)

Contributors:
*  [rytrops](https://github.com/Rytrops)
*  [sllewely](https://github.com/sllewely)


## Ubuntu Setup

Guide is written using WSL2 + Ubuntu.

Update/upgrade unix package manager

```shell
sudo apt update
sudo apt upgrade
```


### Ruby Version Manager

Install ruby version manager.  Follow instructions from [rvm.io](https://rvm.io/).  May need to open a new terminal to use it for the following commands.

Install ruby version

```rvm install 2.7.2```

Set default ruby version 

```rvm --default use 2.7.2```


### Install Bundler and gems

Install bundler

```sudo apt install ruby-bundler```

Install correct bundler version

```gem install bundler:2.2.5```

Install rails project gems

```bundle install```

## Set up Database

```bundle exec rails db:migrate```

## Set up Javascript

Install npm with nvm.  First install nvm: [https://github.com/nvm-sh/nvm](https://github.com/nvm-sh/nvm)

```npm install -g npm```

```npm install yarn```

```yarn```

## Run Server

```rails s```

Open at [http://127.0.0.1:3000](http://127.0.0.1:3000)




...

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
