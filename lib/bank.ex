defmodule Bank do
  @moduledoc """
  Documentation for Bank.
  """

  alias Bank.{Commands, Router, Repo}
  alias Bank.Schemas.Account

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
      account_id: account_id,
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

  def get_account(id) do
    case Repo.get(Account, id) do
      nil -> {:error, :not_found}
      account -> {:ok, account}
    end
  end
end
