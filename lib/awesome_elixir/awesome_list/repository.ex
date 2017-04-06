defmodule AwesomeElixir.AwesomeList.Repository do
  use Ecto.Schema

  schema "awesome_list_repositories" do
    field :description, :string
    field :last_updated_at, :date
    field :name, :string
    field :stars, :integer
    field :url, :string

    timestamps()

    belongs_to :section, AwesomeElixir.AwesomeList.Section
  end
end
