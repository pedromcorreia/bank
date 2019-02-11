defmodule Web.UserPlug do
  @moduledoc false

  import Plug.Conn

  def init(_), do: nil

  def call(%Plug.Conn{private: private} = conn, _opts) do
    assign(conn, :current_user, Map.get(private, :guardian_default_resource))
  end
end
