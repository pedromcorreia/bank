defmodule Api.DefaultController do
  use ApiWeb, :controller

  def index(conn, _params) do
    text conn, "Api!"
  end
end
