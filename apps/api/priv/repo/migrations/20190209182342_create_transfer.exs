defmodule Api.Repo.Migrations.CreateTranfers do
  use Ecto.Migration

  def change do
    create table(:tranfers) do

      timestamps()
    end

  end
end
