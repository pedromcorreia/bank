defmodule Api.Repo.Migrations.AddEmailToAccounts do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :email, :string
    end
  end
end
