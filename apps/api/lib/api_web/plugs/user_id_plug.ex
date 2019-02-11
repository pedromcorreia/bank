defmodule Web.UserIdPlug do
  @moduledoc false

  import Plug.Conn

  def init(_), do: nil

  def call(%Plug.Conn{private: private} = conn, _opts) do
    id_bank =
      private
      |> Map.get(:guardian_default_resource)
      |> Map.get(:id_bank)
    assign(conn, :current_user, id_bank)
  end
end
