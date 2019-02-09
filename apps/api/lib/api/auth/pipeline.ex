defmodule Api.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :api,
    module: Api.Auth.Guardian,
    error_handler: Api.Auth.ErrorHandler

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
