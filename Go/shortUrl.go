/**
 * ShortURL: Bijective conversion between natural numbers (IDs) and short strings
 * Licensed under the MIT License (https://opensource.org/licenses/MIT)
 *
 * ShortURL::encode() takes an ID and turns it into a short string
 * ShortURL::decode() takes a short string and turns it into an ID
 *
 * Features:
 * + large alphabet (51 chars) and thus very short resulting strings
 * + proof against offensive words (removed 'a', 'e', 'i', 'o' and 'u')
 * + unambiguous (removed 'I', 'l', '1', 'O' and '0')
 **/
package ShortURL

import (
	"fmt"
	"strings"
)

const (
	Alphabets = "23456789bcdfghjkmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ-_"
	Base      = len(Alphabets)
)

// reverseChar Utility to reverse string with only UTF8
func reverseChars(s string) string {
	bytes := []byte(s)
	for i, j := 0, len(bytes)-1; i < j; i, j = i+1, j-1 {
		bytes[i], bytes[j] = bytes[j], bytes[i]
	}
	return string(bytes)
}

// Encode: given a generated number, get the URL back
func Encode(n int) string {
	sb := strings.Builder{}
	for n > 0 {
		sb.WriteByte(Alphabets[n%Base])
		n /= Base
	}
	// We know that Alphabet set is UTF8, so we will use reverseChars.
	return reverseChars(sb.String())
}

// Decode: given a URL(path), the decoder decodes it to a unique number.
func Decode(path string) (int, error) {
	n := 0
	for _, c := range path {
		i := strings.Index(Alphabets, string(c))
		if i < 0 {
			return 0, fmt.Errorf("Invalid character %s in input %s", string(c), path)
		} else {
			n = n*Base + i
		}

	}
	return n, nil
}
