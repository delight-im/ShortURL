# ShortURL (https://github.com/delight-im/ShortURL)
# Copyright (c) delight.im (https://www.delight.im/)
# Licensed under the MIT License (https://opensource.org/licenses/MIT)

# ShortURL: Bijective conversion between natural numbers (IDs) and short strings

# ShortURL.encode() takes an ID and turns it into a short string
# ShortURL.decode() takes a short string and turns it into an ID

# Features:
#     large alphabet (51 chars) and thus very short resulting strings
#     proof against offensive words (removed 'a', 'e', 'i', 'o' and 'u')
#     unambiguous (removed 'I', 'l', '1', 'O' and '0')

# Example output:
#     123456789 <=> pgK8p

class ShortURL

  ALPHABET = "23456789bcdfghjkmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ-_"
  BASE = ALPHABET.length

  def self.enode(num)
    str = ""

    while num > 0 do
      str = ALPHABET[num % BASE] + str
      num /= BASE
    end

    str
  end

  def self.decode(str)
    num = x = 0

    while x < str.length do
      num = num * BASE + ALPHABET.index(str[x]) 
      x += 1
    end

    num
  end

end
