defmodule Bank.Commands do
  defmodule CreateAccount, do: defstruct [:account_id]
  defmodule AddAmount, do: defstruct [:account_id, :amount, :operation]
  defmodule RemoveAmount, do: defstruct [:account_id, :amount, :operation]
end
