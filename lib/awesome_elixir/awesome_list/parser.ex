defmodule AwesomeElixir.AwesomeList.Parser do
  def parse(list) do
    _parse(list, [])
  end

  def _parse([], result) do
    Enum.reverse(result)
  end

  def _parse([line | rest], result) do
    cond do
      String.match?(line, ~r/^#\s*\w+/) ->
        [section] = Regex.run(~r/^#\s*(.+)$/, line, capture: :all_but_first)
        _parse(rest, [{:section, section} | result])
      String.match?(line, ~r/^##\s*\w+/) ->
        [subsection] = Regex.run(~r/^##\s*(.+)$/, line, capture: :all_but_first)
        _parse(rest, [{:subsection, subsection} | result])
      String.match?(line, ~r/^\*\w+/) ->
        [subsection_description] = Regex.run(~r/^\*(.+)\*$/, line, capture: :all_but_first)
        _parse(rest, [{:subsection_description, subsection_description} | result])
      String.match?(line, ~r/^\*\s+\[\w+/) ->
        [name, link] = Regex.run(~r/^\*\s+\[(.+?)\]\((.+?)\)/, line, capture: :all_but_first)
        _parse(rest, [{:link, name, link} | result])
      true -> _parse(rest, result)
    end
  end
end
