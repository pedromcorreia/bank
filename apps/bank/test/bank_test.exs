defmodule BankTest do
  use ExUnit.Case
  doctest Bank

  describe "bank" do
    def account_fixture() do
      {:ok, id} = Bank.create_account()

      id
    end

    test "create_account/1 returns the ok and id_account" do
      {:ok, id} = Bank.create_account()
      assert is_bitstring(id)
    end

    test "add_ammount/2 returns the ok and id_account" do
      id = account_fixture()
      assert :ok == Bank.add_ammount(id, 0)
      assert :ok == Bank.add_ammount(id, 100)
    end

    test "try add ammount for id not exist and raise error" do
      assert {:error, :not_found} == Bank.add_ammount("not_existent", 0)
    end

    test "remove_ammount/2 returns the ok and id_account" do
      id = account_fixture()
      assert :ok == Bank.remove_ammount(id, 0)
    end

    test "try remove_ammount/2 from not amount and returns error" do
      id = account_fixture()
      assert {:error, :insufficient_funds} == Bank.remove_ammount(id, 100)
    end

    test "try add remove for id not exist and raise error" do
      assert {:error, :not_found} == Bank.remove_ammount("not_existent", 0)
    end

    test "try get_account/1 from not amount and returns error" do
      assert {:error, :not_found} == Bank.get_account(UUID.uuid4())
    end

    test "try get_statement/1 from not amount and returns error" do
      assert {:error, :not_found} == Bank.get_statement(UUID.uuid4())
    end

    test "try do_transfer/3 returns ok" do
      id_2 = account_fixture()
      id = account_fixture()
      assert :ok == Bank.do_transfer(id, id_2, 0)
    end
  end
end
