defmodule Bank.Account do
  alias __MODULE__
  alias Bank.{Commands, Events}

  defstruct []

  def execute(_, %Commands.CreateAccount{} = cmd) do
    %Events.AccountOpened{account_id: cmd.account_id}
  end
  def execute(_, %Commands.AddAmount{} = cmd) do
    %Events.AddedAmount{
      account_id: cmd.account_id,
      amount: cmd.amount,
      operation: cmd.operation
    }
  end

  def apply(s, _), do: s
end
