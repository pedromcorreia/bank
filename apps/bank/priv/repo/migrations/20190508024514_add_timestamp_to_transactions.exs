defmodule Bank.Repo.Migrations.AddTimestampToTransactions do
  use Ecto.Migration

  def change do

    alter table(:transactions) do
      timestamps()
    end
  end
end
