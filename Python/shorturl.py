# ShortURL (https://github.com/delight-im/ShortURL)
# Copyright (c) delight.im (https://www.delight.im/)
# Licensed under the MIT License (https://opensource.org/licenses/MIT)

class ShortURL:
	"""
	ShortURL: Bijective conversion between natural numbers (IDs) and short strings

	ShortURL.encode() takes an ID and turns it into a short string
	ShortURL.decode() takes a short string and turns it into an ID

	Features:
	+ large alphabet (51 chars) and thus very short resulting strings
	+ proof against offensive words (removed 'a', 'e', 'i', 'o' and 'u')
	+ unambiguous (removed 'I', 'l', '1', 'O' and '0')

	Example output:
	123456789 <=> pgK8p
	"""

	_alphabet = '23456789bcdfghjkmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ-_'
	_base = len(_alphabet)

	def encode(self, number):
		string = ''
		while(number > 0):
			string = self._alphabet[number % self._base] + string
			number //= self._base
		return string

	def decode(self, string):
		number = 0
		for char in string:
			number = number * self._base + self._alphabet.index(char)
		return number
