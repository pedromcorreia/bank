defmodule Api.AccountsTest do
  use Api.DataCase

  alias Api.Accounts

  describe "users" do
    alias Api.Accounts.User

    @valid_attrs %{password: "password", name: "some name", id_bank: "cdfdaf44-ee35-11e3-846b-14109ff1a304"}
    @invalid_attrs %{password: nil, name: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) |> Map.get(:id) == user.id
      assert Accounts.get_user!(user.id) |> Map.get(:id_bank) == "cdfdaf44-ee35-11e3-846b-14109ff1a304"
      assert Accounts.get_user!(user.id) |> Map.get(:name) == "some name"
      assert not is_nil(Map.get(Accounts.get_user!(user.id), :encrypted_password))
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.password == "password"
      assert user.id_bank == "cdfdaf44-ee35-11e3-846b-14109ff1a304"
      assert user.name == "some name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end
  end
end
