defmodule Bank.Process.Transfer do
  use Commanded.ProcessManagers.ProcessManager,
    name: "TransferProcess",
    router: Bank.Router

  alias Bank.{Transfer, Commands, Events}

  defstruct []

  def interested?(%Events.RemovedAmount{operation: %{transfer_id: transfer_id} = _operation}) do
    {:start, transfer_id}
  end

  def interested?(%Events.AddedAmount{operation: %{transfer_id: transfer_id} = _operation}) do
    {:stop, transfer_id}
  end

  def handle(_, %Events.RemovedAmount{} = event) do
    %Commands.AddAmount{
      account_id: event.operation.target_id,
      amount: event.operation.amount,
      operation: event.operation
    }
  end

  def apply(state, _event), do: state
end
