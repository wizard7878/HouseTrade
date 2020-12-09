defmodule TradeWeb.UserController do
  use TradeWeb, :controller

  alias Trade.UserAccount
  alias Trade.UserAccount.User



  def createUser(conn , params) do
    IO.inspect(params)
    token = UserAccount.createuser(params)
    render conn , "token.json" , token: token
  end

  def login(conn,%{"email" => email , "password" => password}) do
    token = UserAccount.login_user(email , password)
    render conn , "token.json" , token: token
  end
end
