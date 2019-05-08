defmodule BankApp.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Dependencies listed here are available only for this
  # project and cannot be accessed from applications inside
  # the apps folder.
  #
  # Run "mix help deps" for examples and options.
  defp deps do
    [
      {:credo, "~> 0.10.0", only: [:dev, :test], runtime: false},
      {:faker, "~> 0.12", only: :test}
    ]
  end

  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      setup_es: ["event_store.create", "event_store.init"],
      setup_ecto: ["ecto.create", "ecto.migrate"],
      setup_db: ["setup_es", "setup_ecto"],
      drop_db: ["ecto.drop", "event_store.drop"],
      reset_db: ["drop_db", "setup_db"],
      test: ["reset_db", "test --trace"]
    ]
  end
end
