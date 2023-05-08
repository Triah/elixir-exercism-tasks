defmodule Username do
  def sanitize(''), do:  ''
  def sanitize([head | tail]) do
    case head do
      x when x in ?a..?z -> [x | sanitize(tail)]
      ?_ -> [?_ | sanitize(tail)]
      ?ä -> 'ae' ++ sanitize(tail)
      ?ö -> 'oe' ++ sanitize(tail)
      ?ü -> 'ue' ++ sanitize(tail)
      ?ß -> 'ss' ++ sanitize(tail)
      _ -> '' ++ sanitize(tail)
    end
  end
end
