import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :hello_render, HelloRenderWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "FdjjH5WK5WtpaZHRnARwZxWE2eX2DUWhsmN4dM96SR0AjN/ZDWiZxdJEnL+KA/wx",
  server: false

# In test we don't send emails.
config :hello_render, HelloRender.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
