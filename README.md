## Bootstrap
generate boilerplate with:
rails new <app-name>

generate an entity that we can render in the ui with its related data model with:
rails generate scaffold post title:string content:text
rails generate scaffold <component-name> <field-name-i:type-i>

after adding an entity we should update the schemas wih:
rails db:migrate

we can add this html tag for an acceptable style in application.html.erb
<link rel="stylesheet" href="https://cdn.simplecss.org/simple.min.css">

to interact with the app from the cli we can use
rails console

to use rich text area (contains images or can be styled) or any other gem we can install it with
rails action_text:install

to import any js library we can use
./bin/importmap pin js-lib-name (client is going to need access to internet to fetch js from cdn)

./bin/importmap pin js-lib-name --download (to download locally in the the repo)



Things you may want to cover:

* Ruby version

* System dependencies
redis should be running in the bg so that the thunder_update can take place
* How to run the test suite
rails test

* Deployment instructions
rails db:system:change --to=postgresql

heroku create

git push heroku main

