defmodule AwesomeElixir.Repo.Migrations.CreateAwesomeElixir.AwesomeList.Repository do
  use Ecto.Migration

  def change do
    create table(:awesome_list_repositories) do
      add :section_id, references(:awesome_list_sections)
      add :url, :string
      add :name, :string
      add :description, :string
      add :stars, :integer
      add :last_updated_at, :date

      timestamps()
    end

    create index(:awesome_list_repositories, [:name], unique: true)
  end
end
