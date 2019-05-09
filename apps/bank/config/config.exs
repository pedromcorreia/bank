use Mix.Config

config :logger, level: String.to_atom(System.get_env("LOGLVL") || "error")

config :bank,
  ecto_repos: [Bank.Repo]

config :bank, Bank.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("PG_PASSWORD") || "postgres",
  password: System.get_env("PG_PASSWORD") || "postgres",
  database: "bank_readstore_dev",
  hostname: System.get_env("PG_HOST") || "localhost",
  port: 5432,
  pool_size: 10

config :commanded,
  event_store_adapter: Commanded.EventStore.Adapters.EventStore

# Configure the event store database
config :eventstore, EventStore.Storage,
  serializer: EventStore.TermSerializer,
  username: System.get_env("PG_PASSWORD") || "postgres",
  password: System.get_env("PG_PASSWORD") || "postgres",
  database: "bank_eventstore_dev",
  hostname: System.get_env("PG_HOST") || "localhost",
  port: 5432,
  pool_size: 10

config :commanded_ecto_projections,
  repo: Bank.Repo
