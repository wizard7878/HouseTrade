defmodule Trade.UserAccountTest do
  use Trade.DataCase

  alias Trade.UserAccount

  describe "credentials" do
    alias Trade.UserAccount.User

    @valid_attrs %{email: "some email", hash_password: "some hash_password"}
    @update_attrs %{email: "some updated email", hash_password: "some updated hash_password"}
    @invalid_attrs %{email: nil, hash_password: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> UserAccount.create_user()

      user
    end

    test "list_credentials/0 returns all credentials" do
      user = user_fixture()
      assert UserAccount.list_credentials() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert UserAccount.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = UserAccount.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.hash_password == "some hash_password"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserAccount.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = UserAccount.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      assert user.hash_password == "some updated hash_password"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = UserAccount.update_user(user, @invalid_attrs)
      assert user == UserAccount.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = UserAccount.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> UserAccount.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = UserAccount.change_user(user)
    end
  end
end
