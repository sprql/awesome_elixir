defmodule AwesomeElixir.AwesomeListTest do
  use AwesomeElixir.DataCase

  alias AwesomeElixir.AwesomeList
  alias AwesomeElixir.AwesomeList.Section

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
end
