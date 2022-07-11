defmodule Exagon.Repo do
  use Ecto.Repo,
    otp_app: :exagon,
    adapter: Ecto.Adapters.Postgres
end
