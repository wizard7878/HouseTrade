defmodule Trade.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :Trade,
  module: Trade.Guardian,
  error_handler: Trade.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
