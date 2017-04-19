# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :awesome_elixir,
  ecto_repos: [AwesomeElixir.Repo],
  awesome_list_url: "https://raw.githubusercontent.com/h4cc/awesome-elixir/master/README.md"

# Configures the endpoint
config :awesome_elixir, AwesomeElixir.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "D7iFR++VTopr83hwYtJ6PLM9MDfBWqttzUtjNFg8tWzAUJkLHcNB0NSqmnpamZKi",
  render_errors: [view: AwesomeElixir.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: AwesomeElixir.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
