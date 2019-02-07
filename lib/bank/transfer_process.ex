defmodule Bank.TransferProcess do
  use Commanded.ProcessManagers.ProcessManager,
    name: "TransferProcess",
    router: Bank.Router

  alias Bank.{Transfer, Commands, Events}

  defstruct []

  def handle(state, event)

  def apply(state, event)
end
