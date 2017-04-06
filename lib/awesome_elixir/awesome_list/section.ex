defmodule AwesomeElixir.AwesomeList.Section do
  use Ecto.Schema

  schema "awesome_list_sections" do
    field :description, :string
    field :name, :string

    timestamps()
  end
end
