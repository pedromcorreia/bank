# Seeds for new accounts
alias Api.Accounts
{:ok, uuid_1} = Bank.create_account
Accounts.create_user(Map.put(%{name: "user1", password: "password"}, :id_bank, uuid_1))
:ok = Bank.add_ammount(uuid_1, 100)

{:ok, uuid_2} = Bank.create_account
Accounts.create_user(Map.put(%{name: "user2", password: "password"}, :id_bank, uuid_2))
:ok = Bank.add_ammount(uuid_2, 100)
