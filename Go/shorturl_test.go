package shorturl

import "testing"

func TestEncode(t *testing.T) {
	expected := "pgK8p"
	received := Encode(123456789)
	if received != expected {
		t.Fatalf("Expected: %s, received: %s", expected, received)
	}
}

func TestDecode(t *testing.T) {
	expected := 123456789
	received := Decode("pgK8p")
	if received != expected {
		t.Fatalf("Expected: %d, received: %d", expected, received)
	}
}

func BenchmarkEncode(b *testing.B) {
	for n := 0; n < b.N; n++ {
		Encode(n)
	}
}

func BenchmarkDecode(b *testing.B) {
	for n := 0; n < b.N; n++ {
		Decode("BCDFGHJP")
	}
}
