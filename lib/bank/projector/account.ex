defmodule Bank.Projector.Account do
  use Commanded.Projections.Ecto,
    name: "AccountProjector"

  alias Bank.Events
  alias Bank.Schemas.Account

  project %Events.AccountOpened{account_id: id} do
    Ecto.Multi.insert(
      multi,
      :insert_account,
      %Account{account_id: id, amount: 0}
    )
  end

  project %Events.AddedAmount{} = event do
    add_amount(multi, event)
  end

  project %Events.RemovedAmount{} = event do
    remove_amount(multi, event)
  end

  defp add_amount(multi, %{account_id: id, amount: amount} = _event) do
    Ecto.Multi.insert(
      multi,
      :change_amount,
      %Account{account_id: id, amount: amount},
      conflict_target: :account_id,
      on_conflict: [inc: [amount: amount]]
    )
  end

  defp remove_amount(multi, %{account_id: id, amount: amount} = _event) do
    Ecto.Multi.insert(
      multi,
      :change_amount,
      %Account{account_id: id, amount: -amount},
      conflict_target: :account_id,
      on_conflict: [inc: [amount: -amount]]
    )
  end
end
