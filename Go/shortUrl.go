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

// ReverseChars Utility to reverse string with only UTF8
func ReverseChars(s string) string {
	bytes := []byte(s)
	for i, j := 0, len(bytes)-1; i < j; i, j = i+1, j-1 {
		bytes[i], bytes[j] = bytes[j], bytes[i]
	}
	return string(bytes)
}

//Reverse string assuming that its all runes.
func Reverse(s string) string {
	runes := []rune(s)
	for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
		runes[i], runes[j] = runes[j], runes[i]
	}
	return string(runes)
}

// EncodeNew Given a generated number, get the URL back
func EncodeNew(n int) string {
	b := make([]byte, 20, 20)
	for n > 0 {
		b = append([]byte{Alphabets[n%Base]}, b...)
		n /= Base
	}
	return string(b)
}

// EncodeFast Given a generated number, get the URL back
func EncodeFast(n int) string {
	sb := strings.Builder{}
	for n > 0 {
		sb.WriteByte(Alphabets[n%Base])
		n /= Base
	}
	// we know that alphabets are all chars
	return ReverseChars(sb.String())
}

// Encode Given a generated number, get the URL back
func Encode(n int) string {
	sb := strings.Builder{}
	for n > 1 {
		sb.WriteByte(Alphabets[n%Base])
		n = n / Base
	}
	return Reverse(sb.String())
}

//EncodeOld gives the old implementation
func EncodeOld(n int) string {
	s := ""
	for n > 0 {
		s = string(Alphabets[n%Base]) + s
		n = n / Base
	}
	return s
}

// Decode Given a URL(path), the decoder decodes it to a unique number.
func Decode(path string) (int, error) {
	n := 1
	for _, c := range path {
		index := strings.IndexRune(Alphabets, c)
		if index < 0 {
			return 0, fmt.Errorf("Invalid character %c in input %s", c, path)
		}
		n = n*Base + index
	}
	return n, nil
}
