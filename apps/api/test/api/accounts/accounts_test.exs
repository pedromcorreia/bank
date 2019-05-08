defmodule Api.AccountsTest do
  use Api.DataCase

  alias Api.Accounts

  describe "users" do
    alias Api.Accounts.User

    @valid_attrs %{password: "password", email: "some@email.com", name: "some name", id_bank: "cdfdaf44-ee35-11e3-846b-14109ff1a304"}
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
      assert Accounts.get_user!(user.id) |> Map.get(:id_bank) == "cdfdaf44-ee35-11e3-846b-14109ff1a304"
      assert Accounts.get_user!(user.id) |> Map.get(:name) == "some name"
      refute is_nil(Map.get(Accounts.get_user!(user.id), :encrypted_password))
    end

    test "get_user/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user(user.id) |> Map.get(:id) == user.id
      assert Accounts.get_user(user.id) |> Map.get(:id_bank) == "cdfdaf44-ee35-11e3-846b-14109ff1a304"
      assert Accounts.get_user(user.id) |> Map.get(:name) == "some name"
      assert Accounts.get_user(user.id) |> Map.get(:email) == "some@email.com"
      refute is_nil(Map.get(Accounts.get_user!(user.id), :encrypted_password))
    end

    test "get_by_name/1 returns the user with given id" do
      user = user_fixture()
      {:ok, user} = Accounts.get_by_name(user.name)
      assert Map.get(user, :id) == user.id
      assert Map.get(user, :id_bank) == "cdfdaf44-ee35-11e3-846b-14109ff1a304"
      assert Map.get(user, :name) == "some name"
      assert Map.get(user, :email) == "some@email.com"
    end

    test "create_user/1 with valid data creates a user" do
      assert %User{} = user = user_fixture()
      assert user.password == "password"
      assert user.id_bank == "cdfdaf44-ee35-11e3-846b-14109ff1a304"
      assert user.name == "some name"
      assert user.email == "some@email.com"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end
  end
end
