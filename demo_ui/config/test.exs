import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :demo_ui, DemoUiWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "3MEA2VzChamkU1Wp6SzxCehKnfMFmqmn8TdjvBVjX/4Zgv/oJOC9DtoUdfRvq9DZ",
  server: false

# In test we don't send emails.
config :demo_ui, DemoUi.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
