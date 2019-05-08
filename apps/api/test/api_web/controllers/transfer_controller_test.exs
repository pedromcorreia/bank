defmodule ApiWeb.TransferControllerTest do
  use ApiWeb.ConnCase

  alias Api.Accounts
  alias Api.Accounts.User
  alias Api.Auth.Guardian

  @invalid_attrs %{encrypted_password: nil, name: nil, id_bank: nil}

  def fixture(:user) do
    {:ok, id} = Bank.create_account()

    attrs = %{password: "password", name: Faker.Name.first_name(), email: Faker.Internet.email()}
    {:ok, %User{} = user} = Accounts.create_user(Map.put(attrs, :id_bank, id))

    user
  end

  def authenticate(conn) do
    user_attrs = %{password: "password", name: Faker.Name.first_name(), email: Faker.Internet.email()}
    {:ok, id} = Bank.create_account()
    {:ok, %User{} = user} = Accounts.create_user(Map.put(user_attrs, :id_bank, id))

    {:ok, jwt, _full_claims} = Guardian.encode_and_sign(user)

    Plug.Conn.put_req_header(conn, "authorization", "Bearer #{jwt}")
  end

  setup %{conn: conn} do
    conn =
      conn
      |> put_req_header("accept", "application/json")
      |> authenticate()

    {:ok, conn: conn}
  end

  describe "show" do
    test "renders user when data is valid", %{conn: conn} do
      user = fixture(:user)
      conn = get conn, transfer_path(conn, :show, user.id)
      response = json_response(conn, 200)
      assert 1000 == Map.get(response, "balance")
      assert is_list(Map.get(response, "transfers"))
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, user_path(conn, :create), user: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "create" do
    test "renders ok when data is valid", %{conn: conn} do
      user = fixture(:user)
      user_2 = fixture(:user)
      conn = post conn, transfer_path(conn, :create), transfer: %{source_account_id: user.id, destination_account_id: user_2.id, amount: 0}
      assert %{"response" => "ok"} == json_response(conn, 200)
      assert is_map(json_response(conn, 200))
    end

    test "renders not_found_user when data is invalid", %{conn: conn} do
      user = fixture(:user)
      conn = post conn, transfer_path(conn, :create), transfer: %{source_account_id: user.id, destination_account_id: 99999, amount: 0}
      assert json_response(conn, 200)["response"] == "not_found_user"
    end
  end

  describe "cashout" do
    test "renders amount when data is valid", %{conn: conn} do
      user = fixture(:user)
      conn = post conn, transfer_path(conn, :cashout), %{cashout: 10}
      assert %{"response" => 10} == json_response(conn, 200)
      assert is_map(json_response(conn, 200))
    end

    test "renders insufficient_funds when hasn't sufficient funds", %{conn: conn} do
      user = fixture(:user)
      conn = post conn, transfer_path(conn, :cashout), %{cashout: 1001}
      assert %{"response" => "insufficient_funds"} == json_response(conn, 200)
      assert is_map(json_response(conn, 200))
    end
  end

  describe "report" do
    test "return 200 with report DD", %{conn: conn} do
      user = fixture(:user)
      Bank.remove_ammount(user.id_bank, 100)
      conn = get conn, transfer_path(conn, :report, %{report: "DD"})
      assert json_response(conn, 200)
      assert is_map(json_response(conn, 200))
    end

    test "return 200 with report MM", %{conn: conn} do
      user = fixture(:user)
      Bank.remove_ammount(user.id_bank, 100)
      conn = get conn, transfer_path(conn, :report, %{report: "MM"})
      assert json_response(conn, 200)
      assert is_map(json_response(conn, 200))
    end

    test "return 200 with report YYYY", %{conn: conn} do
      user = fixture(:user)
      Bank.remove_ammount(user.id_bank, 100)
      conn = get conn, transfer_path(conn, :report, %{report: "YYYY"})
      assert json_response(conn, 200)
      assert is_map(json_response(conn, 200))
    end

    test "return 200 with report total", %{conn: conn} do
      user = fixture(:user)
      Bank.remove_ammount(user.id_bank, 100)
      conn = get conn, transfer_path(conn, :report, %{report: "total"})
      assert json_response(conn, 200)
      assert is_map(json_response(conn, 200))
    end
  end
end
