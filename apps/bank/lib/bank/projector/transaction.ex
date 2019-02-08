defmodule Bank.Projector.Transaction do
  use Commanded.Projections.Ecto,
    name: "TransactionProjector"

  alias Bank.{Events, Schemas}

  project %Events.AddedAmount{} = event do
    add_values(multi, event)
  end

  project %Events.RemovedAmount{} = event do
    remove_values(multi, event)
  end

  defp add_values(multi, %{account_id: id, amount: amount} = _event) do
    Ecto.Multi.insert(
      multi,
      :add_transaction,
      %Schemas.Transaction{account_id: id, amount: amount}
    )
  end

  defp remove_values(multi, %{account_id: id, amount: amount} = _event) do
    Ecto.Multi.insert(
      multi,
      :add_transaction,
      %Schemas.Transaction{account_id: id, amount: -amount}
    )
  end
end
