defmodule ApiWeb.TransferController do
  use ApiWeb, :controller

  alias Api.Accounts
  alias Api.Accounts.{User}
  alias Bank

  action_fallback ApiWeb.FallbackController

  def show(conn, %{"id" => id}) do
    with %User{id_bank: id_bank} <- Accounts.get_user(id),
         {:ok, balance} <- Bank.get_account(id_bank),
         {:ok, transactions} <- Bank.get_statement(id_bank) do
      render(conn, "index.json", balance: balance, transactions: transactions)
    else
      a ->
        render(conn, "response.json", %{response: :not_found_user})
    end
  end

  def create(conn, %{"transfer" => %{"source_account_id" => source_account_id, "destination_account_id" => destination_account_id, "amount" => amount}}) do
    with {:ok, %User{} = source_user} <- Accounts.get_user(source_account_id),
         {:ok, %User{} = destination_user} <- Accounts.get_user(destination_account_id) do
      response =
        source_user
        |> Map.get(:id_bank)
        |> Bank.do_transfer(destination_user.id_bank, amount)
        |> case do
          {:error, :not_found} -> :error
          :ok -> :ok
        end
        render(conn, "response.json", %{response: response})
    else
      {:error, :not_found} ->
        render(conn, "response.json", %{response: :not_found_user})
    end
  end
end
