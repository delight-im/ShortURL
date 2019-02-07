/*
 * ShortURL (https://github.com/delight-im/ShortURL)
 * Copyright (c) delight.im (https://www.delight.im/)
 * Licensed under the MIT License (https://opensource.org/licenses/MIT)
 */

/**
 * shorturl: Bijective conversion between natural numbers (IDs) and short strings
 *
 * shorturl.Encode() takes an ID and turns it into a short string
 * shorturl.Decode() takes a short string and turns it into an ID
 *
 * Features:
 * + large alphabet (51 chars) and thus very short resulting strings
 * + proof against offensive words (removed 'a', 'e', 'i', 'o' and 'u')
 * + unambiguous (removed 'I', 'l', '1', 'O' and '0')
 *
 * Example output:
 * 123456789 <=> pgK8p
 */

package shorturl

import (
	"strings"
)

const Alphabet string = "23456789bcdfghjkmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ-_"
const Base int = len(Alphabet)

func Encode(num int) string {
	bytes := []byte{}
	for num > 0 {
		bytes = append([]byte{Alphabet[num%Base]}, bytes...)
		num = num / Base
	}
	return string(bytes)
}

func Decode(str string) int {
	num := 0
	for i := 0; i < len(str); i++ {
		num = num*Base + strings.Index(Alphabet, string(str[i]))
	}
	return num
}
