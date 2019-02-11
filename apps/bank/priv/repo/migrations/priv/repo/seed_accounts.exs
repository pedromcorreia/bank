# Seeds for new accounts
{:ok, uuid_1} = Bank.create_account
{:ok} = Bank.add_ammount(uuid_1, 100)
{:ok, uuid_2} = Bank.create_account
{:ok} = Bank.add_ammount(uuid_2, 100)
