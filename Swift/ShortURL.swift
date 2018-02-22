/*
 * ShortURL (https://github.com/delight-im/ShortURL)
 * Copyright (c) delight.im (https://www.delight.im/)
 * Licensed under the MIT License (https://opensource.org/licenses/MIT)
 */

import UIKit

/// ShortURL: Bijective conversion between natural numbers (IDs) and short strings
///
/// ShortURL.encode() takes an ID and turns it into a short string
/// ShortURL.decode() takes a short string and turns it into an ID
///
/// Features:
/// + large alphabet (51 chars) and thus very short resulting strings
/// + proof against offensive words (removed 'a', 'e', 'i', 'o' and 'u')
/// + unambiguous (removed 'I', 'l', '1', 'O' and '0')
///
/// Example output:
/// 123456789 <=> pgK8p
///
/// Swift 4
class ShortURL {

	static let alphabet = "23456789bcdfghjkmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ-_"
	static let base: Int = alphabet.count

	static func encode(num: Int) -> String {
		var str = ""
		var n = num

		while (n > 0) {
			let idx = n % base
			let index = alphabet.index(alphabet.startIndex, offsetBy: idx)

			str = String(alphabet[index]) + str
			n = n / base
		}

		return String(str)
	}

	static func decode(str: String) -> Int {
		return str.map { char in
			alphabet.distance(from: alphabet.startIndex, to: alphabet.index(of: char)!)
			}.reduce(0) { (result: Int, idx) -> Int in
				return (result * base) + idx
		}
	}
}
