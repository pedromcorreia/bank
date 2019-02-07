defmodule Bank.AccountProjector do
  use Commanded.Projections.Ecto,
    name: "AccountProjector"

  alias Bank.{Events, Schemas}

  project %Events.AccountOpened{account_id: id} do
    Ecto.Multi.insert(
      multi,
      :insert_account,
      %Schemas.Account{account_id: id, amount: 0}
    )
  end
end
