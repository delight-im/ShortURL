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
 * Source: https://github.com/delight-im/ShortURL (Apache License 2.0)
 */

var bigInt = require("big-integer");

var ShortURL = new function() {

    var _alphabet = '23456789bcdfghjkmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ-_',
        _base = _alphabet.length;

    this.encode = function(num) {
        var str = '';
        while (num > 0) {
            str = _alphabet.charAt(num % _base) + str;
            num = Math.floor(num / _base);
        }
        return str;
    };

    /**
     * @param {num} input number represented by string
     * @return {str} encoded short url
     */
    this.encodeBigInteger = function (num) {
        var str = '';
        var bNum = bigInt(num);
        while (bNum.compare(0) == 1) {
            str = _alphabet.charAt(bNum.mod(_base)) + str;
            bNum = bNum.divide(_base);
        }
        return str;
    }

    this.decode = function(str) {
        var num = 0;
        for (var i = 0; i < str.length; i++) {
            num = num * _base + _alphabet.indexOf(str.charAt(i));
        }
        return num;
    };


    /**
     * @param {str} ShortURL represented by string
     * @return {str} decoded number represented by string
     */
    this.decodeBigInteger = function(str) {
        var bNum = bigInt(0);
        for (var i = 0; i < str.length; i++) {
            bNum = bNum.multiply(_base).add(_alphabet.indexOf(str.charAt(i)));
        }
        return bNum;
    }

};
