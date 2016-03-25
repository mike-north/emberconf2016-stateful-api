use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :pullrequest, Pullrequest.Endpoint,
  secret_key_base: "wPXFdD2wiy/dU2s/KPBg4YlW35haBxKDsw8Oua/hb7xz56Xav+gfkTt1z2OudDcb"

# Configure your database
config :pullrequest, Pullrequest.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "pullrequest_prod",
  pool_size: 20
