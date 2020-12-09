defmodule TradeWeb.UserView do
  use TradeWeb, :view

  def render "token.json" , %{token: token } do
    %{
      token: token
    }
  end
end
