defmodule AwesomeElixir.AwesomeListTest do
  use AwesomeElixir.DataCase

  alias AwesomeElixir.AwesomeList
  alias AwesomeElixir.AwesomeList.{Section, Repository}

  @create_attrs %{description: "some description", name: "some name"}
  @update_attrs %{description: "some updated description", name: "some updated name"}
  @invalid_attrs %{description: nil, name: nil}

  def fixture(:section, attrs \\ @create_attrs) do
    {:ok, section} = AwesomeList.create_section(attrs)
    section
  end

  test "list_sections/1 returns all sections" do
    section = fixture(:section)
    assert AwesomeList.list_sections() == [section]
  end

  test "get_section! returns the section with given id" do
    section = fixture(:section)
    assert AwesomeList.get_section!(section.id) == section
  end

  test "create_or_update_section/1 creates and updates a section" do
    assert {:ok, %Section{} = section} = AwesomeList.create_or_update_section(@create_attrs)
    assert section.description == "some description"
    assert section.name == "some name"

    assert {:ok, %Section{} = updated_section} =
      %{section | description: "new description"}
      |> Map.from_struct
      |> AwesomeList.create_or_update_section

    assert updated_section.description == "new description"
    assert updated_section.name == "some name"

    IO.inspect(section)
    IO.inspect(updated_section)
  end

  test "create_or_update_section/1 with invalid data returns error changeset" do
    section = fixture(:section)
    invalid_attrs = %{name: section.name, description: ""}
    assert {:error, %Ecto.Changeset{}} = AwesomeList.create_or_update_section(invalid_attrs)
  end

  test "create_section/1 with valid data creates a section" do
    assert {:ok, %Section{} = section} = AwesomeList.create_section(@create_attrs)
    assert section.description == "some description"
    assert section.name == "some name"
  end

  test "create_section/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = AwesomeList.create_section(@invalid_attrs)
  end

  test "update_section/2 with valid data updates the section" do
    section = fixture(:section)
    assert {:ok, section} = AwesomeList.update_section(section, @update_attrs)
    assert %Section{} = section
    assert section.description == "some updated description"
    assert section.name == "some updated name"
  end

  test "update_section/2 with invalid data returns error changeset" do
    section = fixture(:section)
    assert {:error, %Ecto.Changeset{}} = AwesomeList.update_section(section, @invalid_attrs)
    assert section == AwesomeList.get_section!(section.id)
  end

  test "delete_section/1 deletes the section" do
    section = fixture(:section)
    assert {:ok, %Section{}} = AwesomeList.delete_section(section)
    assert_raise Ecto.NoResultsError, fn -> AwesomeList.get_section!(section.id) end
  end

  test "change_section/1 returns a section changeset" do
    section = fixture(:section)
    assert %Ecto.Changeset{} = AwesomeList.change_section(section)
  end

  test "create_or_update_repository/1 creates and updates a repository" do
    section = fixture(:section)

    repository_attrs = %{
      url: "https://test.url/",
      description: "some description",
      name: "some name",
      section_id: section.id
    }

    assert {:ok, %Repository{} = repository} = AwesomeList.create_or_update_repository(repository_attrs)

    assert repository.description == "some description"
    assert repository.name == "some name"
    assert repository.section_id == section.id

    new_section = fixture(:section, %{name: "new_name", description: "new description"})

    new_repository_attrs =
      repository
      |> Map.from_struct
      |> Map.put(:section_id, new_section.id)
      |> Map.put(:description, "new description")

    assert {:ok, %Repository{} = updated_repository} = AwesomeList.create_or_update_repository(new_repository_attrs)

    assert updated_repository.description == "new description"
    assert updated_repository.name == "some name"
    assert updated_repository.section_id == new_section.id
  end
end
