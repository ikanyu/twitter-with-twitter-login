# Twitter App with Twitter OAuth and Sinatra
Part of the daily Next Academy bootcamp exercises

## Objective
Explore Twitter OAth

## Setup
```
git clone https://github.com/ikanyu/twitter_with_twitter_login.git
cd twitter_with_twitter_login
bundle install
```

## Setup Database
```
bundle exec rake db:create
bundle exec rake db:migrate
```

## Start Server
```
shotgun config.ru
```
Visit [http://localhost:9393/](http://localhost:9393/) to access the web application
