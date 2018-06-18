package shorturl

import (
	"fmt"
	"testing"
)

//go test -run Encode
func TestEncodeDecode(t *testing.T) {
	path := []string{
		"tvwxyzBF2",
		"2BCDFGHJP",
		"",
	}
	for _, v := range path {
		i, e := Decode(v)
		if e != nil {
			t.Fail()
		}
		s := Encode(i)

		if v != s {
			if v != string(Alphabets[0])+s { // v may start with Alphabet[0], which in base51 can mean 0.
				t.Fail()
				fmt.Println("expected :", v, "Got: ", s)
			}
		}
	}
}

// BenchmarkEncodeOriginal run command : go test -bench=Original
func BenchmarkEncodeOriginal(t *testing.B) {
	for i := 0; i < 10000000; i++ {
		Encode(i)
	}
}

// BenchmarkDecode run command; go test -bench=Decode
func BenchmarkDecode(t *testing.B) {
	for i := 0; i < 10000000; i++ {
		Decode("BCDFGHJP")
	}
}
