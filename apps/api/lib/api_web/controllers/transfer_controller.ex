defmodule ApiWeb.TransferController do
  use ApiWeb, :controller

  alias Api.Accounts
  alias Api.Accounts.Transfer

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    IO.inspect conn
    tranfers = Accounts.list_tranfers()
    render(conn, "index.json", tranfers: tranfers)
  end

  def create(conn, %{"transfer" => transfer_params}) do
    IO.inspect conn
    with {:ok, %Transfer{} = transfer} <- Accounts.create_transfer(transfer_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", transfer_path(conn, :show, transfer))
      |> render("show.json", transfer: transfer)
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
