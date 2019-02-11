defmodule ApiWeb.TransferController do
  use ApiWeb, :controller

  alias Api.Accounts
  alias Api.Accounts.{Transfer, User}
  alias Bank

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    with {:ok, balance} <- conn.assigns[:current_user]
                                |> Map.get(:id_bank)
                                |> Bank.Bank.get_account(),
         {:ok, transactions} <- conn.assigns[:current_user]
                                |> Map.get(:id_bank)
                                |> Bank.Bank.get_statement(), do
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

  def show(conn, %{"id" => id}) do
    transfer = Accounts.get_transfer!(id)
    render(conn, "show.json", transfer: transfer)
  end

  def update(conn, %{"id" => id, "transfer" => transfer_params}) do
    transfer = Accounts.get_transfer!(id)

    with {:ok, %Transfer{} = transfer} <- Accounts.update_transfer(transfer, transfer_params) do
      render(conn, "show.json", transfer: transfer)
    end
  end

  def delete(conn, %{"id" => id}) do
    transfer = Accounts.get_transfer!(id)
    with {:ok, %Transfer{}} <- Accounts.delete_transfer(transfer) do
      send_resp(conn, :no_content, "")
    end
  end
end
