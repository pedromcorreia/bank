defmodule Bank.AccountProjector do
  use Commanded.Projections.Ecto,
    name: "AccountProjector"

  alias Bank.{Events, Schemas}
  alias Bank.Schemas.Account

  project %Events.AccountOpened{account_id: id} do
    Ecto.Multi.insert(
      multi,
      :insert_account,
      %Schemas.Account{account_id: id, amount: 0}
    )
  end

  project %Events.AddedAmount{} = event do
    change_amount(multi, event.account_id, event.amount)
  end

  defp change_amount(multi, id, amount) do
    Ecto.Multi.insert(
      multi,
      :change_amount,
      %Account{account_id: id, amount: amount},
      conflict_target: :account_id,
      on_conflict: [inc: [amount: amount]]
    )
  end
end
