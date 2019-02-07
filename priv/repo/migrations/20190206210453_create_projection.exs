defmodule CreateProjectionVersions do
  use Ecto.Migration

  def change do
    create table(:projections, primary_key: false) do
      add :name, :text, primary_key: true
      add :last_seen_event_number, :bigint

      timestamps()
    end
  end
end
