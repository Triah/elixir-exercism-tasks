defmodule PaintByNumber do
  def palette_bit_size(color_count) do
    if Integer.pow(2,1) >= color_count, do: 1, else: palette_bit_size(color_count,2)
  end

  defp palette_bit_size(color_count, count) do
    if Integer.pow(2,count) >= color_count, do: count, else: palette_bit_size(color_count, count+1)
  end

  def empty_picture() do
    <<>>
  end

  def test_picture() do
    <<0::2, 1::2, 2::2, 3::2>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    palette_size = palette_bit_size(color_count)
    <<pixel_color_index::size(palette_size), picture::bitstring>>
  end

  def get_first_pixel(<<>>, _color_count), do: nil
  def get_first_pixel(picture, color_count) do
    palette_size = palette_bit_size(color_count)
    <<value::size(palette_size), _rest::bitstring>> = picture 
    value
  end

  def drop_first_pixel(<<>>, _color_count), do: <<>>
  def drop_first_pixel(picture, color_count) do
    palette_size = palette_bit_size(color_count)
    <<_value::size(palette_size), rest::bitstring>> = picture
    rest
  end

  def concat_pictures(picture1, picture2) do
    <<first::bitstring>> = picture1
    <<second::bitstring>> = picture2
    <<first::bitstring, second::bitstring>>
  end
end
