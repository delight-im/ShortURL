--[[
	ShortURL (https://github.com/delight-im/ShortURL)
	Copyright (c) delight.im (https://www.delight.im/)
	Licensed under the MIT License (https://opensource.org/licenses/MIT)

	..................................................................

	ShortURL: Bijective conversion between natural numbers (IDs) and short strings

	ShortURL:encode() takes an ID and turns it into a short string
	ShortURL:decode() takes a short string and turns it into an ID

	Features:
	+ large alphabet (51 chars) and thus very short resulting strings
	+ proof against offensive words (removed 'a', 'e', 'i', 'o' and 'u')
	+ unambiguous (removed 'I', 'l', '1', 'O' and '0')

	Example output:
	123456789 <=> pgK8p
]]--

local ShortURL = {
	alphabet = "23456789bcdfghjkmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ-_"
}

function ShortURL:encode(num)
	local base = self.alphabet:len()
	local str = ""

	while num > 0 do
		str = string.sub(self.alphabet, num % base, num % base) .. str
		num = math.floor(num / base)
	end

	return str
end

function ShortURL:decode(str)
	local base = self.alphabet:len()
	local num = 0

	for i = 1, str:len(), 1 do
		num = num * base + string.find(self.alphabet, str:sub(i, i), 1, true)
	end

	return num
end

return ShortURL
