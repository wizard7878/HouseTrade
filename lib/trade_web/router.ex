defmodule TradeWeb.Router do
  use TradeWeb, :router
  alias Trade.Guardian

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers

  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
    plug :put_user_token
  end

  scope "/api" , TradeWeb do
    pipe_through [:api, :jwt_authenticated]

    resources "/sorder", SecondaryOrderController, except: [:new, :edit] # پیشنهاد خرید و فروش (بازار ثانویه)
    resources "/porders", PrimitiveOrderController, except: [:new, :edit,:update]  # پیشنهاد خرید عرضه اولیه
    resources "/houses", HouseController, except: [:new, :edit] # عرضه های اولیه موجود

  end

  scope "/auth", TradeWeb do
    pipe_through :api

    post "/users/create" , UserController , :createUser
    post "/users/login" , UserController , :login
  end

  scope "/", TradeWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: TradeWeb.Telemetry
    end
  end


  defp put_user_token(conn, _) do
    if current_user = conn.private[:guardian_default_resource] do
      token = Phoenix.Token.sign(conn, "key", current_user.id)
      assign(conn, :user_token, token)
    else
      conn
    end
  end
end
