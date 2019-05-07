defmodule Api.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Api.Repo

  alias Api.Accounts.User

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

  iex> get_user!(123)
  %User{}

  iex> get_user!(456)
  ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc false
  def get_user(id), do: Repo.get(User, id)

  @doc false
  def get_by_name(name) do
    case Repo.get_by(User, name: name) do
      nil ->
        {:error, :not_found}
      user ->
        {:ok, user}
    end
  end

  @doc """
  Creates a user.

  ## Examples

  iex> create_user(%{field: value})
  {:ok, %User{}}

  iex> create_user(%{field: bad_value})
  {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    IO.inspect attrs
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
    |> IO.inspect
  end
end
