# ShortURL (https://github.com/delight-im/ShortURL)
# Copyright (c) delight.im (https://www.delight.im/)
# Licensed under the MIT License (https://opensource.org/licenses/MIT)

defmodule ShortURL do
  @moduledoc """
  ShortURL: Bijective conversion between natural numbers (IDs) and short strings

  ShortURL.encode/1 takes an ID and turns it into a short string
  ShortURL.decode/1 takes a short string and turns it into an ID

  ## Features:

    * large alphabet (51 chars) and thus very short resulting strings
    * proof against offensive words (removed 'a', 'e', 'i', 'o' and 'u')
    * unambiguous (removed 'I', 'l', '1', 'O' and '0')

  ## Examples:

      iex> ShortURL.encode(123456789)
      "pgK8p"

      iex> ShortURL.decode("pgK8p")
      123456789

  """

  @alphabet "23456789bcdfghjkmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ-_"
  @base String.length(@alphabet)

  @doc "Takes an ID and turns it into a short string"
  def encode(num) when is_integer(num) do
    encode_rec("", num)
  end

  @doc "Takes a short string and turns it into an ID"
  def decode(str) when is_bitstring(str) do
    decode_rec(str, 0, 0)
  end

  defp encode_rec(str, num) do
    if num > 0 do
      encode_rec(String.at(@alphabet, rem(num, @base)) <> str, div(num, @base))
    else
      str
    end
  end

  defp decode_rec(str, num, index) do
    if index < String.length(str) do
      {alphabet_index, 1} = :binary.match(@alphabet, String.at(str, index))
      decode_rec(str, num * @base + alphabet_index, index + 1)
    else
      num
    end
  end
end
