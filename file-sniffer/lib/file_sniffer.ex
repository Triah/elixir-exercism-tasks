defmodule FileSniffer do
  def type_from_extension(extension) do
    case extension do
      "exe" -> "application/octet-stream"
      "bmp" -> "image/bmp"
      "png" -> "image/png"
      "jpg" -> "image/jpg"
      "gif" -> "image/gif"
      _ -> nil
    end
  end

  def type_from_binary(file_binary) do
    header_size = if byte_size(file_binary) > 8, do: 8, else: byte_size(file_binary) 
    <<binary_head::binary-size(header_size), _::binary>> = file_binary
    case binary_head do
      <<0x7F, 0x45, 0x4C, 0x46, _, _, _, _>> -> "application/octet-stream"
      <<0x42, 0x4D, _,_,_,_,_,_>> -> "image/bmp"
      <<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A>> -> "image/png"
      <<0xFF, 0xD8, 0xFF, _, _, _, _, _>> -> "image/jpg"
      <<0x47, 0x49, 0x46, _, _, _, _, _>> -> "image/gif"
      _ -> nil
    end
  end


  def verify(file_binary, extension) do
    current_file_extension = type_from_extension(extension)
    current_file_binary = type_from_binary(file_binary)
    if current_file_extension == current_file_binary, do: {:ok, current_file_extension}, else: {:error, "Warning, file format and file extension do not match."}
  end
end
