defmodule Account.AccountTest do
  use ExUnit.Case

  alias Bank.Account

  describe "account" do

    @valid_attrs %{password: "password", name: "some name", id_bank: "cdfdaf44-ee35-11e3-846b-14109ff1a304"}
    @invalid_attrs %{password: nil, name: nil}

    def user_fixture(attrs \\ @valid_attrs) do
      {:ok, user} =
        attrs
        |> Enum.into(attrs)
        |> Accounts.create_user()

      user
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) |> Map.get(:id) == user.id
    end
  end
end
