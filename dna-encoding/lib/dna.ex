defmodule DNA do
  def encode_nucleotide(code_point) do
    case code_point do
      ?A -> Bitwise.bsl(1,0)
      ?C -> Bitwise.bsl(1,1)
      ?G -> Bitwise.bsl(1,2)      
      ?T -> Bitwise.bsl(1,3)
      _ -> Bitwise.bsl(0,0)
    end
  end

  def decode_nucleotide(encoded_code) do
    case encoded_code do
      0 -> ?\s
      1 -> ?A
      2 -> ?C
      4 -> ?G
      8 -> ?T
    end
  end

  def encode(dna) do
    do_encode(dna, <<>>)
  end

  defp do_encode(dna, encoding) do
    [head | tail] = dna
    current_encoding = encode_nucleotide(head)
    <<curr_val::bitstring>> = encoding
    enc = <<curr_val::bitstring, current_encoding::4>>
    if length(tail) > 0, do: do_encode(tail,enc), else: enc
  end

  def decode(dna) do
    do_decode(dna)
  end

  defp do_decode(dna, current_message \\[]) do
    <<h::4, rest::bitstring>> = dna
    list = [decode_nucleotide(h) | current_message]
    if rest == "", do: Enum.reverse(list), else: do_decode(rest, list)
  end
end
