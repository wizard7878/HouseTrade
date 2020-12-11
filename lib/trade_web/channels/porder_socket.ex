defmodule TradeWeb.RoomChannel do
  use Phoenix.Channel
  alias Trade.PrimitiveShop
  alias Trade.PrimitiveShop.{PrimitiveOrder}
  alias Trade.UserAccount.Credential
  alias Trade.Repo
  def join("room:lobby",_params,socket) do
    {:ok,socket}
  end

  def handle_in(_name,%{"primitive_order" => primitive_order_params},socket) do
    credential_id = socket.assigns.user_id
    user = Repo.get(Credential,credential_id)
    case PrimitiveShop.create_primitive_order(primitive_order_params,user) do

      {:ok, %PrimitiveOrder{} = primitive_order} ->
        PrimitiveShop.update_house_info_after_order(primitive_order_params)
        broadcast!(socket,"room:lobby:new",%{primitive_order: primitive_order})
      nil ->
        {:reply,%{error: "more than limit"} , socket}
    end
  end
end
