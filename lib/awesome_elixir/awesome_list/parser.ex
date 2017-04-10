defmodule AwesomeElixir.AwesomeList.Parser do
  def parse(list) do
    list
    |> Enum.reduce([], &parse_line/2)
    |> Enum.reverse
  end

  defp parse_line(line, result) do
    cond do
      String.match?(line, ~r/^#\s*\w+/) ->
        [section] = Regex.run(~r/^#\s*(.+)$/, line, capture: :all_but_first)
        [{:section, section} | result]
      String.match?(line, ~r/^##\s*\w+/) ->
        [subsection] = Regex.run(~r/^##\s*(.+)$/, line, capture: :all_but_first)
        [{:subsection, subsection} | result]
      String.match?(line, ~r/^\*\w+/) ->
        [subsection_description] = Regex.run(~r/^\*(.+)\*$/, line, capture: :all_but_first)
        [{:subsection_description, subsection_description} | result]
      String.match?(line, ~r/^\*\s+\[\w+/) ->
        [name, link] = Regex.run(~r/^\*\s+\[(.+?)\]\((.+?)\)/, line, capture: :all_but_first)
        [{:link, name, link} | result]
      true -> result
    end
  end
end
