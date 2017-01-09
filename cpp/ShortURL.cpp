/**
 * ShortURL: Bijective conversion between natural numbers (IDs) and short strings
 *
 * ShortURL.encode() takes an ID and turns it into a short string
 * ShortURL.decode() takes a short string and turns it into an ID
 *
 * Features:
 * + large alphabet (51 chars) and thus very short resulting strings
 * + proof against offensive words (removed 'a', 'e', 'i', 'o' and 'u')
 * + unambiguous (removed 'I', 'l', '1', 'O' and '0')
 *
 * Example output:
 * 123456789 <=> pgK8p
 *
 * Works on C++11
 */

#include <string>

class ShortURL {
    const std::string alphabet = std::string("23456789bcdfghjkmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ-_");
    std::size_t base = alphabet.length();

public:
    std::string encode(int num) {
        std::string str;

        while(num > 0) {
            str = alphabet.at(num % base) + str;
            num /= base;
        }

        return str;
    }

    int decode(const std::string& str) {
        int num = 0;

        for(std::string::const_iterator ix = str.cbegin(); ix != str.cend(); ++ix) {
            std::size_t cIndex = alphabet.find(*ix);

            if(cIndex == std::string::npos)
                throw std::invalid_argument("Invalid character");

            num = num * base + cIndex;
        }

        return num;
    }
};
