/*
 * ShortURL (https://github.com/delight-im/ShortURL)
 * Copyright (c) delight.im (https://www.delight.im/)
 * Licensed under the MIT License (https://opensource.org/licenses/MIT)
 */

/*
 * ShortURL: Bijective conversion between natural numbers (IDs) and short strings
 *
 * url_encode() takes an ID and turns it into a short string and writes it into a buffer
 * url_decode() takes a short string and turns it into an ID
 *
 * Features:
 * + large alphabet (51 chars) and thus very short resulting strings
 * + proof against offensive words (removed 'a', 'e', 'i', 'o' and 'u')
 * + unambiguous (removed 'I', 'l', '1', 'O' and '0')
 *
 * Example output:
 * 123456789 <=> pgK8p
 */

#include <string.h>
#include <limits.h>
#include <stdio.h>

const char alphabet[] = "23456789bcdfghjkmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ-_";
const size_t base = sizeof(alphabet) / sizeof(alphabet[0]) - 1;

// buff is a pre-allocated buffer provided by the caller, e.g. char[100]
// buffsize is the pre-allocated buffer's size, e.g. 100
size_t url_encode(char *buff, size_t buffsize, int num) {
	size_t idx = 0;
	size_t i;

	while (num > 0 && idx < buffsize) {
		buff[idx++] = alphabet[num % base];
		num /= base;
	}

	// if the buffer is not large enough
	if (idx == buffsize) {
		// fail
		return -1;
	}

	// add a null terminator
	buff[idx] = '\0';

	// reverse the encoded string
	for (i = 0; i < idx / 2; ++i) {
		char t = buff[i];
		buff[i] = buff[idx - i - 1];
		buff[idx - i - 1] = t;
	}

	// return the length of the encoded string
	return idx;
}

int url_decode(const char *url) {
	int num = 0;
	size_t idx, i, j, len;

	len = strlen(url);

	for (i = 0; i < len; ++i) {
		// locate the char in the alphabet
		for (j = 0; j <= base && alphabet[j] != url[i]; ++j);

		if (j > base) return INT_MAX;

		num = num * base + j;
	}

	return num;
}
