defmodule ApiWeb.TransferController do
  use ApiWeb, :controller

  alias Api.Accounts
  alias Api.Accounts.{Transfer, User}
  alias Bank

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    with {:ok, balance} <- Bank.get_account(conn.assigns[:current_user]),
         {:ok, transactions} <- Bank.get_statement(conn.assigns[:current_user]) do
      render(conn, "index.json", balance: balance, transactions: transactions)
    end
  end

  def create(conn, %{"transfer" => %{"name_target" => name_target, "amount" => amount}}) do
    with {:ok, %User{} = user } <- Accounts.get_by_name(name_target) do
      response =
        conn.assigns[:current_user]
        |> Map.get(:id_bank)
        |> Bank.do_transfer(user.id_bank, amount)
        |> case do
          {:error, :not_found} -> :error
          :ok -> :ok
        end
      conn
      |> render("response.json", %{response: response})
    end
  end
end
