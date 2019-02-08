defmodule Bank do
  @moduledoc """
  Documentation for Bank.
  """

  alias Bank.{Commands, Router, Repo, Transfer}
  alias Bank.Schemas.{Account, Transaction}

  def create_account do
    id = UUID.uuid4
    %Commands.CreateAccount{account_id: id}
    |> Router.dispatch
    |> case do
      :ok -> {:ok, id}
      err -> err
    end
  end

  def add_ammount(id, amount) do
    %Commands.AddAmount{
      account_id: id,
      amount: amount
    }
    |> Router.dispatch
  end

  def remove_ammount(id, amount) do
    %Commands.RemoveAmount{
      account_id: id,
      amount: amount
    }
    |> Router.dispatch
  end

  def get_ammount(id) do
    case get_account(id) do
      {:ok, account} -> account.amount
      _ -> {:error, :not_found}
    end
  end

  def list_accounts do
    Repo.all(Account)
  end

  def get_account(id) do
    case Repo.get(Account, id) do
      nil -> {:error, :not_found}
      account -> {:ok, account}
    end
  end

  def get_statement(id) do
    with {:ok, _account} <- get_account(id),
    do: {:ok, Repo.all(statement_query(id))}
  end

  defp statement_query(id) do
    import Ecto.Query

    from t in Transaction,
      where: t.account_id == ^id
  end

  def do_transfer(source_id, target_id, amount) do
    %Commands.RemoveAmount{
      account_id: source_id,
      amount: amount,
      operation: %Transfer{
        transfer_id: UUID.uuid4,
        source_id: source_id,
        target_id: target_id,
        amount: amount
      }
    }
    |> Router.dispatch
  end
end
