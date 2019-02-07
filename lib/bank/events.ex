defmodule Bank.Events do
  defmodule AccountOpened, do: defstruct [:account_id]
  defmodule AddedAmount, do: defstruct [:account_id, :amount, :operation]
end
