defmodule ApiWeb.Router do
  use ApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug Api.Auth.Pipeline
  end

  scope "/api", ApiWeb do
    pipe_through :api
    post "/users/signup", UserController, :create
    post "/users/signin", UserController, :signin
  end

  scope "/api", ApiWeb do
    pipe_through [:api, :auth]
    resources "/transfers", TransferController, except: [:new, :edit]
  end
end
