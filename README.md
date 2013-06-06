## SWorD ##
SWorD (Social Web of real Domotics) is a prototype social network where users, homes, providers, devices and appliances can interact and act in a "smarter" way, by talking each other and thus lowering the technical knowledge to use home automation and domotics systems.

### LAB2 ###
1) Creation of static pages for our social network: home, about and contact

- `rails generate controller Pages home about contact` (or from the RubyMine menu *Tools > Run Rails Generator...*)

2) Add title to HTML files: "SWorD | Page name"

- by using the `provide` method in each view, i.e., `<% provide :title, 'Page name' %>`
- by editing the title tag in `app/views/layouts/application.html.erb`, i.e., `<title>SWorD | <%= yield(:title) %>`
- learn more about `provide` at [http://api.rubyonrails.org/classes/ActionView/Helpers/CaptureHelper.html#method-i-provide](http://api.rubyonrails.org/classes/ActionView/Helpers/CaptureHelper.html#method-i-provide)

3) Add an helper to avoid wrong rendering if the page title is not declared

- in `app/helpers/application_helper.rb`
- by editing the title tag in `app/views/layouts/application.html.erb`

### LAB3 - Preparation ###
1) Fill with some contents all the views

2) Add `bootstrap-sass` gem to include the Bootstrap framework with Sass support [http://twitter.github.io/bootstrap/](http://twitter.github.io/bootstrap/)

- update the `Gemfile`
- run `bundle install`

3) Add and fill a custom SCSS file in `app/assets/stylesheets`

