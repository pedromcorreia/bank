defmodule Api.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :encrypted_password, :string
    field :name, :string
    field :email, :string
    field :password, :string, virtual: true
    field :id_bank, :binary_id

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email,:password, :id_bank])
    |> validate_required([:name, :email,:password, :id_bank])
    |> validate_length(:password, min: 6)
    |> unique_constraint(:name)
    |> put_hashed_password()
  end

  defp put_hashed_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}}
      ->
        put_change(changeset, :encrypted_password, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        changeset
    end
  end
end
