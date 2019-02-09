defmodule Api.Accounts.Transfer do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tranfers" do

    timestamps()
  end

  @doc false
  def changeset(transfer, attrs) do
    transfer
    |> cast(attrs, [])
    |> validate_required([])
  end
end
