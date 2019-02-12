defmodule ApiWeb.UserControllerTest do
  use ApiWeb.ConnCase

  alias Api.Accounts

  @create_attrs %{password: "encrypted_password", name: "some name", id_bank: "cdfdaf44-ee35-11e3-846b-14109ff1a304"}
  @invalid_attrs %{encrypted_password: nil, name: nil, id_bank: nil}

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post conn, user_path(conn, :create), user: @create_attrs
      response = json_response(conn, 201)
      assert "some name" == Map.get(response, "name")
      assert is_bitstring(Map.get(response, "token"))
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, user_path(conn, :create), user: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "signin user" do
    test "signin user when data is valid", %{conn: conn} do
      user = fixture(:user)
      conn = post conn, user_path(conn, :signin), name: user.name, password: user.password
      response = json_response(conn, 201)
      assert "some name" == Map.get(response, "name")
      assert is_bitstring(Map.get(response, "token"))
    end

    test "renders unauthorized when data is invalid", %{conn: conn} do
      user = fixture(:user)
      conn = post conn, user_path(conn, :signin), name: user.name, password: "not right"
      assert json_response(conn, 401)["errors"] == %{"detail" => "Unauthorized"}
    end
  end
end
