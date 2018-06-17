package shorturl

import (
	"fmt"
	"testing"
)

//go test -run Encode
func TestEncodeDecode(t *testing.T) {
	path := []string{
		"tvwxyzBF",
		"2BCDFGHJP",
	}
	for _, v := range path {
		i, e := Decode(v)
		if e != nil {
			t.Fail()
		}
		s := Encode(i)

		if v != s {
			t.Fail()
			fmt.Println("expected :", v, "Got: ", s)
		}
	}
}

//BenchmarkEncodeNew run command:  go test -bench=Fast
func BenchmarkEncodeNew(t *testing.B) {
	for i := 0; i < 10000000; i++ {
		EncodeNew(i)
	}
}

//BenchmarkEncodeFast run command : go test -bench=Fast
func BenchmarkEncodeFast(t *testing.B) {
	for i := 0; i < 10000000; i++ {
		EncodeFast(i)
	}
}

// BenchmarkEncodeOriginal run command : go test -bench=Original
func BenchmarkEncodeOriginal(t *testing.B) {
	for i := 0; i < 10000000; i++ {
		Encode(i)
	}
}

// BenchmarkEncodeOld run command : go test -bench=Old
func BenchmarkEncodeOld(t *testing.B) {
	for i := 0; i < 10000000; i++ {
		EncodeOld(i)
	}
}

// BenchmarkDecode run command; go test -bench=Decode
func BenchmarkDecode(t *testing.B) {
	for i := 0; i < 10000000; i++ {
		Decode("BCDFGHJP")
	}
}
