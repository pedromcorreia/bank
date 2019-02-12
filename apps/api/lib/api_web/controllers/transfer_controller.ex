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
      _ ->
        render(conn, "response.json", %{response: :not_found_user})
    end
  end

  def create(conn, %{"transfer" => %{"source_account_id" => source_account_id, "destination_account_id" => destination_account_id, "amount" => amount}}) do
    with %User{id_bank: source_user_id_bank} <- Accounts.get_user(source_account_id),
         %User{id_bank: destination_user_id_bank} <- Accounts.get_user(destination_account_id) do
      response =
        source_user_id_bank
        |> Bank.do_transfer(destination_user_id_bank, amount)
        |> case do
          {:error, :not_found} -> :error
          :ok -> :ok
        end
        render(conn, "response.json", %{response: response})
    else
      _ ->
        render(conn, "response.json", %{response: :not_found_user})
    end
  end
end
