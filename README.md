
[![Build Status](https://travis-ci.org/drioemgaoin/RubyLoginComponent.svg?branch=master)](https://travis-ci.org/drioemgaoin/RubyLoginComponent) [![Code Climate](https://codeclimate.com/github/drioemgaoin/RubyLoginComponent/badges/gpa.svg)](https://codeclimate.com/github/drioemgaoin/RubyLoginComponent)

[Live Demo](https://fast-basin-54294.herokuapp.com/)
___
RubyLoginComponent is an authentication component for Rails based on Devise.

You can find more about how Devise works by taking a look on the [wiki](https://github.com/plataformatec/devise)

## Starting with Rails?
If you are building your first Rails application, we recommend you do not use Devise. Devise requires a good understanding of the Rails Framework. In such cases, we advise you to start a simple authentication system from scratch. Today, we have three resources that should help you get started:

Michael Hartl's online book: https://www.railstutorial.org/book/modeling_users
Ryan Bates' Railscast: http://railscasts.com/episodes/250-authentication-from-scratch
Codecademy's Ruby on Rails: Authentication and Authorization: http://www.codecademy.com/en/learn/rails-auth
Once you have solidified your understanding of Rails and authentication mechanisms, we assure you Devise will be very pleasant to work with. 😃

## Ruby version
RubyLoginComponent works with a Ruby version >5.0.1.

## System dependencies

## Installation
To install RubyLoginComponent, you need to clone the project
```
$ git clone https://github.com/drioemgaoin/RubyLoginComponent.git
```

Then install the gems
```
$ bundle install
```

## Configuration
RubyLoginComponent uses [gem figaro](https://github.com/laserlemon/figaro) to set the environment variables needed by Devise to work properly.

The gem takes advantage of Ruby’s ability to set environment variables as well as read them. The gem reads a config/application.yml file and sets environment variables before anything else is configured in the Rails application.

So, you need to create **config/application.yml** file and add it in .gitignore because it needs to be kept secret from anyone and don't be checkin in your public repository.

Then copy the following configurations, one per environment you want for your project
```
development:
  GMAIL_USERNAME: YOUR_ADDRESS_GMAIL
  GMAIL_PASSWORD: YOUR_PASSWORD_GMAIL
  FACEBOOK_SECRET: YOUR_FACEBOOK_SECRET
  FACEBOOK_KEY: YOUR_FACEBOOK_KEY
  GOOGLE_SECRET: YOUR_GOOGLE_SECRET
  GOOGLE_KEY: YOUR_GOOGLE_KEY
  TOKEN_SECRET: YOUR_TOKEN_SECRET
  jwt_algorithm: YOUR_JWT_ALGORITHM
  SECRET_KEY_BASE: YOUR_SECRET_KEY_BASE

test:
  MAIL_USERNAME: YOUR_ADDRESS_GMAIL
  GMAIL_PASSWORD: YOUR_PASSWORD_GMAIL
  FACEBOOK_SECRET: YOUR_FACEBOOK_SECRET
  FACEBOOK_KEY: YOUR_FACEBOOK_KEY
  GOOGLE_SECRET: YOUR_GOOGLE_SECRET
  GOOGLE_KEY: YOUR_GOOGLE_KEY
  TOKEN_SECRET: YOUR_TOKEN_SECRET
  jwt_algorithm: YOUR_JWT_ALGORITHM
  SECRET_KEY_BASE: YOUR_SECRET_KEY_BASE

production:
  MAIL_USERNAME: YOUR_ADDRESS_GMAIL
  GMAIL_PASSWORD: YOUR_PASSWORD_GMAIL
  FACEBOOK_SECRET: YOUR_FACEBOOK_SECRET
  FACEBOOK_KEY: YOUR_FACEBOOK_KEY
  GOOGLE_SECRET: YOUR_GOOGLE_SECRET
  GOOGLE_KEY: YOUR_GOOGLE_KEY
  TOKEN_SECRET: YOUR_TOKEN_SECRET
  jwt_algorithm: YOUR_JWT_ALGORITHM
  SECRET_KEY_BASE: YOUR_SECRET_KEY_BASE
```

## Database creation
RubyLoginComponent use a database to store information about the user authentication and profile.

In development and test environment, I used sqlite3 because I didn't want to setup a server for that.
In production, I used postgretsql because heroku hasn't letted me the choice.

To create the database with the schema, just run the following command
```
$ rails db:migrate
```

If you want to reset your database and reload your current schema, you can run
```
$ rails db:reset db:migrate
```

If you want to destroy your db, create it and then migrate your current schema, you can run
```
$ rails db:drop db:create db:migrate
```

## Continuous Integration
I setup Continuous Integration for this project by using [Travis CI](https://travis-ci.org/).

[Here](https://docs.travis-ci.com/user/languages/ruby/), the documentation to setup travis-ci for a ruby project

## Unit test
To run the tests, you just need to run
```
$ rails test
```

I will try very soon, to had a report more readable.

## Deployment


## Credits
[Plataformatec](https://github.com/plataformatec) for [Devise](https://github.com/plataformatec/devise).
