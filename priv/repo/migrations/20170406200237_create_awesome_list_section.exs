defmodule AwesomeElixir.Repo.Migrations.CreateAwesomeElixir.AwesomeList.Section do
  use Ecto.Migration

  def change do
    create table(:awesome_list_sections) do
      add :name, :string
      add :description, :string

      timestamps()
    end

  end
end
