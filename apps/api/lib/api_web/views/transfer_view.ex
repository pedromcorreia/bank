defmodule ApiWeb.TransferView do
  use ApiWeb, :view
  alias ApiWeb.TransferView

  def render("index.json", %{transactions: transactions}) do
    %{data: render_many(transactions, TransferView, "transfer.json")}
  end

  def render("show.json", %{transaction: transaction}) do
    %{data: render_one(transaction, TransferView, "transfer.json")}
  end

  def render("transfer.json", %{transfer: transfer}) do
    %{id: transfer.id}
  end

  def render("response.json", %{response: response}) do
    %{response: response}
  end
end
