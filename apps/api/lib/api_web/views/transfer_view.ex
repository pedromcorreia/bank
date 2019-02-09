defmodule ApiWeb.TransferView do
  use ApiWeb, :view
  alias ApiWeb.TransferView

  def render("index.json", %{tranfers: tranfers}) do
    %{data: render_many(tranfers, TransferView, "transfer.json")}
  end

  def render("show.json", %{transfer: transfer}) do
    %{data: render_one(transfer, TransferView, "transfer.json")}
  end

  def render("transfer.json", %{transfer: transfer}) do
    %{id: transfer.id}
  end
end
