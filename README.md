# BankApp leads integration platform

This application is responsible for simulate a bank app (like mini transactions).

1. The main feature is create new bank account.
2. The second main feature is transfer the amount with the existing users.

# CQRS

This app is inspired by the article written by [Martin Fowler](https://martinfowler.com/bliki/CQRS.html)

# Application structure

  - Partner api: used by all users. Create user through this api and we create in bank cqrs.
 (localhost:6000/api/leads)

 - Private database: initially used by bank system only. Is our storage with read and event store.

 # Running the application

 Use the `$ iex -S mix phx.server` to run the application.

 # create database.

 Use the `$ mix setup_db` to create the database.

 # Testing

 Test all suite:

 `$ mix tests`

 # Contributing

 To contribute, please follow some patterns:
  - Commit messages, documentation and all code related things in english;
  - Before open pull requests, make sure that `credo` was executed;
