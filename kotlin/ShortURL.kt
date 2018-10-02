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
	private val ALPHABET = "23456789bcdfghjkmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ"
	private val BASE = ALPHABET.length

	fun encode(num: Int): String {
		var number = num
		val stringBuilder = StringBuilder()
		while (number > 0) {
			stringBuilder.insert(0, ALPHABET[number % BASE])
			number /= BASE
		}

		return stringBuilder.toString()
	}

	fun decode(string: String): Int {
		var number = 0
		for (i in 0 until string.length) {
			number = number * BASE + ALPHABET.indexOf(string[i])
		}

		return number
	}
}
