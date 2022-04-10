# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby & rails version
  - Ruby 2.5.7
  - Rails 5.2.7

* Database initialization
  - rails db:migrate

* How to run the test suite
  - Have no time to do unfortunately

* Services (job queues, cache servers, search engines, etc.)
  - Notifaction service run after create ticket

* How to deal with the project
  - `bundle install`
  - `rails db:migrate`
  - `rails s`
  - Create User `http://localhost:3000/users/new`
  - Create Ticket `http://localhost:3000/tickets/new`
  - After save the service will run depend on user profile configuration and create bg job.
  - In case of update ticket, will reschedule the background job with new time.
  - In case of destroy ticket, will cancel the background.
