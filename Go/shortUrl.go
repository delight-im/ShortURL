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

package shorturl

import (
	"fmt"
	"strings"
)

const (
	// Alphabets is "set of allowed alphabets"
	Alphabets = "23456789bcdfghjkmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ-_"
	// Base is const size of alphabets string
	Base = len(Alphabets)
)

//Reverse string assuming that its all runes.
func Reverse(s string) string {
	runes := []rune(s)
	for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
		runes[i], runes[j] = runes[j], runes[i]
	}
	return string(runes)
}

// Encode Given a generated number, get the URL back
func Encode(n int) string {
	sb := strings.Builder{}
	for n > 0 {
		sb.WriteByte(Alphabets[n%Base])
		n = n / Base
	}
	return Reverse(sb.String())
}

// Decode Given a URL(path), the decoder decodes it to a unique number.
func Decode(path string) (int, error) {
	n := 0
	for _, c := range path {
		index := strings.IndexRune(Alphabets, c)
		if index < 0 {
			return 0, fmt.Errorf("Invalid character %c in input %s", c, path)
		}
		n = n*Base + index
	}
	return n, nil
}
