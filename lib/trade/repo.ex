defmodule Trade.Repo do
  use Ecto.Repo,
    otp_app: :trade,
    adapter: Ecto.Adapters.Postgres
end
