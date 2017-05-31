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
package ShortUrl

import (
	"fmt"
	"strings"
)

const (
	Alphabets = "23456789bcdfghjkmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ-_"
	Base      = len(Alphabets)
)

type Codec struct{}

func (c *Codec) Encode(n int) string {
	var s string
	for n > 0 {
		c := string(Alphabets[n%Base])
		fmt.Println(c)
		s = c + s
		n /= Base
	}
	return s
}

func (c *Codec) Decode(path string) (int, error) {
	n := 0
	for _, c := range path {
		i := strings.Index(Alphabets, string(c))
		if i < 0 {
			return 0, fmt.Errorf("Invalid input %s", path)
		} else {
			n = n*Base + i
		}

	}
	return n, nil
}
func InitShortingCodec() *Codec {
	codec := Codec{}
	return &codec
}
