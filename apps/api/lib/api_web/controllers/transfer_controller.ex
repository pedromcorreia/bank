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

  def cashout(conn, %{"cashout" => cashout}) do
    case Bank.remove_ammount(conn.assigns.current_user, cashout) do
      :ok ->
        conn
        |> ApiWeb.Email.welcome_email(cashout)
        |> ApiWeb.Mailer.deliver_now()

        render(conn, "response.json", %{response: cashout})
      {:error, :insufficient_funds} ->
        render(conn, "response.json", %{response: :insufficient_funds})
    end
  end

  def report(conn, %{"report" => report}) do
    with {:ok, report} <- Bank.get_statement(conn.assigns.current_user, report) do
        render(conn, "response.json", %{response: report})
    end
  end
end
