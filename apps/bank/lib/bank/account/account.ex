defmodule Bank.Account do
  alias __MODULE__
  alias Bank.{Commands, Events}

  defstruct opened: false, amount: 0

  def execute(_, %Commands.CreateAccount{} = cmd) do
    %Events.AccountOpened{account_id: cmd.account_id}
  end

  def execute(%{opened: false}, _), do: {:error, :not_found}

  def execute(_, %Commands.AddAmount{} = cmd) do
    %Events.AddedAmount{
      account_id: cmd.account_id,
      amount: cmd.amount,
      operation: cmd.operation
    }
  end

  def execute(%{amount: current_amount}, %{amount: amount_to_add})
      when current_amount < amount_to_add do
    {:error, :insufficient_funds}
  end

  def execute(_, %Commands.RemoveAmount{} = cmd) do
    %Events.RemovedAmount{
      account_id: cmd.account_id,
      amount: cmd.amount,
      operation: cmd.operation
    }
  end

  def apply(_, %Events.AccountOpened{} = event) do
    %Account{
      opened: true,
      amount: 1000
    }
  end

  def apply(s, %Events.AddedAmount{} = event), do: add_value(s, event)
  def apply(s, %Events.RemovedAmount{} = event), do: remove_value(s, event)
  def apply(s, _), do: s

  defp add_value(s, %{amount: amount} = _event) do
    %Account{s | amount: s.amount + amount}
  end

  defp remove_value(s, %{amount: amount} = _event) do
    %Account{s | amount: s.amount - amount}
  end
end
