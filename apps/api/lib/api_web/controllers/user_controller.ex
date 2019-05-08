defmodule ApiWeb.UserController do
  use ApiWeb, :controller

  alias Api.Accounts
  alias Api.Accounts.User
  alias Api.Auth.Guardian

  action_fallback ApiWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, id} <- Bank.create_account(),
         {:ok, %User{} = user} <- Accounts.create_user(Map.put(user_params, "id_bank", id)),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("user.json", %{user: user, token: token})
    end
  end

  def signin(conn, %{"name" => name, "password" => password}) do
    with {:ok, user, token} <- Guardian.authenticate(name, password) do
      conn
      |> put_status(:created)
      |> render("user.json", %{user: user, token: token})
    end
  end
end
