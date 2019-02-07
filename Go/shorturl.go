//ShortURL: Bijective conversion between natural numbers (IDs) and short strings
//Licensed under the MIT License (https://opensource.org/licenses/MIT)
//
//shorturl.Encode() takes an ID and turns it into a short string
//shorturl.Decode() takes a short string and turns it into an ID
//
// Example output:
// 123456789 <=> pgK8p

package shorturl

import "strings"

const (
	alphabet    = "23456789bcdfghjkmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ-_"
	alphabetLen = len(alphabet)
)

func Encode(n int) string {
	sb := strings.Builder{}
	for n > 0 {
		sb.WriteByte(alphabet[n%alphabetLen])
		n = n / alphabetLen
	}

	return reverse(sb.String())
}

func Decode(s string) (n int) {
	for _, r := range s {
		n = n*alphabetLen + strings.IndexRune(alphabet, r)
	}
	return
}

func reverse(s string) string {
	runes := []rune(s)
	lastIndex := len(s) - 1

	for i := 0; i < len(runes)/2; i++ {
		runes[i], runes[lastIndex-i] = runes[lastIndex-i], runes[i]
	}
	return string(runes)
}
