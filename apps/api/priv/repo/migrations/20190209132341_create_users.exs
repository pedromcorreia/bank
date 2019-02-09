defmodule Api.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :encrypted_password, :string

      timestamps()
    end

    create unique_index(:users, [:name])
  end
end
