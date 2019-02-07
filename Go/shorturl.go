//ShortURL: Bijective conversion between natural numbers (IDs) and short strings
//Licensed under the MIT License (https://opensource.org/licenses/MIT)
//
//shorturl.Encode() takes an ID and turns it into a short string
//shorturl.Decode() takes a short string and turns it into an ID
//
// Example output:
// 123456789 <=> pgK8p

package shorturl

import (
	"bytes"
	"math"
)

var (
	alphabet    = [...]string{"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"}
	alphabetLen = len(alphabet)
	alphabetMap = makeAlphabetMap()
)

func Encode(n int) string {
	var digits []int
	for n > 0 {
		remainder := n % alphabetLen
		digits = append(digits, remainder)
		n = n / alphabetLen
	}
	reverse(digits)

	var result bytes.Buffer
	for _, e := range digits {
		result.WriteString(alphabet[e])
	}
	return result.String()
}

func Decode(s string) int {
	var digits []int
	for _, e := range s {
		digits = append(digits, alphabetMap[string(e)])
	}
	reverse(digits)

	var sum int
	for i, e := range digits {
		sum += e * int(math.Pow(float64(alphabetLen), float64(i)))
	}
	return sum
}

func reverse(slice []int) {
	lastIndex := len(slice) - 1

	for i := 0; i < len(slice)/2; i++ {
		slice[i], slice[lastIndex-i] = slice[lastIndex-i], slice[i]
	}
}

func makeAlphabetMap() map[string]int {
	alphabetMap := map[string]int{}
	for i, e := range alphabet {
		alphabetMap[e] = i
	}
	return alphabetMap
}
