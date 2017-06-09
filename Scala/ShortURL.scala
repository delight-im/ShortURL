/*
 * ShortURL (https://github.com/delight-im/ShortURL)
 * Copyright (c) delight.im (https://www.delight.im/)
 * Licensed under the MIT License (https://opensource.org/licenses/MIT)
 */

/**
 * ShortURL: Bijective conversion between natural numbers (IDs) and short strings
 *
 * ShortURL.encode() takes an ID and turns it into a short string
 * ShortURL.decode() takes a short string and turns it into an ID
 *
 * Features:
 * + large alphabet (51 chars) and thus very short resulting strings
 * + proof against offensive words (removed 'a', 'e', 'i', 'o' and 'u')
 * + unambiguous (removed 'I', 'l', '1', 'O' and '0')
 *
 * Example output:
 * 123456789 <=> pgK8p
 */
object ShortURL {

	val Alphabet: String = "23456789bcdfghjkmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ-_"
	val Base: Int = Alphabet.length()

	def encode(num: Int): String = {
		var str = new StringBuilder()
		var n = num

		while (n > 0) {
			str.insert(0, Alphabet.charAt(n % Base))
			n = n / Base
		}

		return str.toString()
	}

	def decode(str: String): Int = {
		return 0.to(str.length() - 1).foldLeft(0)((num, i) => num * Base + Alphabet.indexOf(str.charAt(i)))
	}

}
