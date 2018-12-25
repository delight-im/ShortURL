/*
 * ShortURL (https://github.com/delight-im/ShortURL)
 * Copyright (c) delight.im (https://www.delight.im/)
 * Licensed under the MIT License (https://opensource.org/licenses/MIT)
 */

/**
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
const size_t base = sizeof(alphabet) / sizeof(alphabet[0]) - 1;     // correct for '\0'


/*
    buff is preallocated buffer provided by caller
    buffsize is it's size
*/

size_t url_encode(char *buff, size_t buffsize, int num) {
    
    size_t idx = 0; 
    size_t i;
    
    
    // encode the number
    while (num > 0 && idx < buffsize) {
        buff[idx++] = alphabet[num % base];
        num /= base;
    }
    
    if (idx == buffsize) {
        return -1;              // FAIL, BUFFER NOT BIG ENOUGH
    }
    
    buff[idx] = '\0';           // add a null terminator
    
    // the result is reversed, so we reverse it
    for (i = 0; i < idx / 2; ++i) {
        char t = buff[i];
        buff[i] = buff[idx - i - 1];
        buff[idx - i - 1] = t;
    }
    return idx;     // length of encoded string
}


int url_decode(const char *url) {
    int num = 0;
    size_t idx, i, j, len;
    
    len = strlen(url);
    
    for (i = 0; i < len; ++i) {
        
        // locate the char in alphabet
        // keep looking untill a match is found or alphabet finishes
        for (j = 0; j <= base && alphabet[j] != url[i]; ++j);
        
        if (j > base) return INT_MAX;   // error, invalid url
        
        num = num * base + j;
    }
    
    return num;
}


/*
// test

int main() {
    char url[100] = {0};
    int id = 123456789;
    size_t len;
    
    len = url_encode(url, 100, id);
    printf("id: %d, encoded: %s, len: %ld\n", id, url, len);
    
    id = url_decode(url);
    printf("decoded: %d\n", id);
    
    return 0;
}

*/
