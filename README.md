# BankApp leads integration platform

This application is responsible for simulate a bank app (like mini transactions).

1. The main feature is create new bank account.
2. The second main feature is transfer the amount with the existing users.

# CQRS

This app is inspired by the article written by [Martin Fowler](https://martinfowler.com/bliki/CQRS.html)

# Application structure

  - API: used by all users. Create user through this api and we create in bank cqrs.

 # Example

 (localhost:6000/api/users/signup) - POST
  - `curl -X POST http://localhost:6000/api/users/signup -H "Content-Type: application/json" -d '{"user": {"name": "user1", "password": "password", "email": "email@mail.com"}}'`

 (localhost:6000/api/users/signin) - POST, will return the token
 - `curl -X POST http://localhost:6000/api/users/signin -H "Content-Type: application/json" -d '{"name": "user1", "password": "password"}'`

 (localhost:6000/api/transfers/:id) - GET
  - `curl -X GET http://localhost:6000/api/transfers/2 -H "Authorization: Bearer ${token}"`

 (localhost:6000/api/transfers) - POST
  - `curl -X POST http://localhost:6000/api/transfers -H "Authorization: Bearer ${token}" -H "Content-Type: application/json" -d '{"transfer": {"source_account_id": "1", "destination_account_id": "2", "amount": 1}}'`

 (localhost:6000/api/cashout) - POST
  - `curl -X POST http://localhost:6000/api/cashout -H "Authorization: Bearer ${token}" -H "Content-Type: application/json" -d '{"cashout": 10}'`

 (localhost:6000/api/report) - GET Permitted: [DD, MM, YYYY, total]
  - `curl -X GET "http://localhost:6000/api/report?report=DD" -H "Authorization: Bearer ${token}" -H "Content-Type: application/json"`


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
