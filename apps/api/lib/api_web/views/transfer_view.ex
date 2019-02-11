defmodule ApiWeb.TransferView do
  use ApiWeb, :view
  alias ApiWeb.TransferView

  def render("index.json", %{balance: balance, transactions: transactions}) do
    %{transfers: render_many(transactions, TransferView, "transfer.json"), balance: balance.amount}
  end

  def render("transfer.json", %{transfer: transfer}) do
    %{id_transfer: transfer.id, amount: transfer.amount}
  end

  def render("response.json", %{response: response}) do
    %{response: response}
  end
end
