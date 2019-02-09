defmodule ApiWeb.Router do
  use ApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ApiWeb do
    pipe_through :api
  end

  pipeline :browser do
    plug(:accepts, ["html"])
  end

  pipeline :auth do
    plug Api.Auth.Pipeline
  end

  scope "/", ApiWeb do
    pipe_through :api
    post "/users/signup", UserController, :create
    post "/users/signin", UserController, :signin
  end

  #scope "/api", BusiApiWeb do
  #  pipe_through [:api, :auth]
  #  resources "/businesses", BusinessController, except: [:new, :edit]
  #end
end
