defmodule Api.AccountsTest do
  use Api.DataCase

  alias Api.Accounts

  describe "users" do
    alias Api.Accounts.User

    @valid_attrs %{encrypted_password: "some encrypted_password", name: "some name"}
    @update_attrs %{encrypted_password: "some updated encrypted_password", name: "some updated name"}
    @invalid_attrs %{encrypted_password: nil, name: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.encrypted_password == "some encrypted_password"
      assert user.name == "some name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.encrypted_password == "some updated encrypted_password"
      assert user.name == "some updated name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "tranfers" do
    alias Api.Accounts.Transfer

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def transfer_fixture(attrs \\ %{}) do
      {:ok, transfer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_transfer()

      transfer
    end

    test "list_tranfers/0 returns all tranfers" do
      transfer = transfer_fixture()
      assert Accounts.list_tranfers() == [transfer]
    end

    test "get_transfer!/1 returns the transfer with given id" do
      transfer = transfer_fixture()
      assert Accounts.get_transfer!(transfer.id) == transfer
    end

    test "create_transfer/1 with valid data creates a transfer" do
      assert {:ok, %Transfer{} = transfer} = Accounts.create_transfer(@valid_attrs)
    end

    test "create_transfer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_transfer(@invalid_attrs)
    end

    test "update_transfer/2 with valid data updates the transfer" do
      transfer = transfer_fixture()
      assert {:ok, transfer} = Accounts.update_transfer(transfer, @update_attrs)
      assert %Transfer{} = transfer
    end

    test "update_transfer/2 with invalid data returns error changeset" do
      transfer = transfer_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_transfer(transfer, @invalid_attrs)
      assert transfer == Accounts.get_transfer!(transfer.id)
    end

    test "delete_transfer/1 deletes the transfer" do
      transfer = transfer_fixture()
      assert {:ok, %Transfer{}} = Accounts.delete_transfer(transfer)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_transfer!(transfer.id) end
    end

    test "change_transfer/1 returns a transfer changeset" do
      transfer = transfer_fixture()
      assert %Ecto.Changeset{} = Accounts.change_transfer(transfer)
    end
  end
end
