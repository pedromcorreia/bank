defmodule ApiWeb.TransferControllerTest do
  use ApiWeb.ConnCase

  alias Api.Accounts
  alias Api.Accounts.Transfer

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:transfer) do
    {:ok, transfer} = Accounts.create_transfer(@create_attrs)
    transfer
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all tranfers", %{conn: conn} do
      conn = get conn, transfer_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create transfer" do
    test "renders transfer when data is valid", %{conn: conn} do
      conn = post conn, transfer_path(conn, :create), transfer: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, transfer_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, transfer_path(conn, :create), transfer: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update transfer" do
    setup [:create_transfer]

    test "renders transfer when data is valid", %{conn: conn, transfer: %Transfer{id: id} = transfer} do
      conn = put conn, transfer_path(conn, :update, transfer), transfer: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, transfer_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn, transfer: transfer} do
      conn = put conn, transfer_path(conn, :update, transfer), transfer: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete transfer" do
    setup [:create_transfer]

    test "deletes chosen transfer", %{conn: conn, transfer: transfer} do
      conn = delete conn, transfer_path(conn, :delete, transfer)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, transfer_path(conn, :show, transfer)
      end
    end
  end

  defp create_transfer(_) do
    transfer = fixture(:transfer)
    {:ok, transfer: transfer}
  end
end
