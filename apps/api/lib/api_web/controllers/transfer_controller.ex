defmodule ApiWeb.TransferController do
  use ApiWeb, :controller

  alias Api.Accounts
  alias Api.Accounts.{Transfer, User}
  alias Bank

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    tranfers = Accounts.list_tranfers()
    render(conn, "index.json", tranfers: tranfers)
  end

  def create(conn, %{"transfer" => %{"name_target" => name_target, "amount" => amount}}) do
    with {:ok, %User{} = user } <- Accounts.get_by_name(name_target) do
      conn.assigns[:current_user]
      |> Map.get(:id_bank)
      |> Bank.do_transfer(user.id_bank, amount)
      |> case do
        {:error, :not_found} -> {:error, :not_found}
        _ -> {:ok, :success}
      end
      conn
      |> render("show.json")
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
