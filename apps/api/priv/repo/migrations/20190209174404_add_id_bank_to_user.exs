defmodule Api.Repo.Migrations.AddIdBankToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :id_bank, :uuid
    end
  end
end
