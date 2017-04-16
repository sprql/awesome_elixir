defmodule AwesomeElixir.AwesomeList.Importer do
  alias AwesomeElixir.AwesomeList

  def import(list) do
    Enum.each(list, &import_repository/1)
  end

  defp import_repository({section_struct, link_struct}) do
    with {:ok, section} <- create_section(section_struct),
         {:ok, repository} <- create_repository(link_struct, section)
    do
      repository
    else
      err -> err
    end
  end

  defp create_section(section) do
    section
    |> Map.from_struct
    |> AwesomeList.create_or_update_section
  end

  defp create_repository(link, section) do
    link
    |> Map.from_struct
    |> Map.put(:section_id, section.id)
    |> AwesomeList.create_or_update_repository
  end
end
