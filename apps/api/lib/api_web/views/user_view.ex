defmodule ApiWeb.UserView do
  use ApiWeb, :view

  def render("user.json", %{user: user, token: token}) do
    %{
      name: user.name,
      token: token
    }
  end
end
