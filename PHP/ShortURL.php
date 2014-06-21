<?php

/**
 * ShortURL: Bijective conversion between natural numbers (IDs) and short strings
 *
 * ShortURL::encode() takes an ID and turns it into a short string
 * ShortURL::decode() takes a short string and turns it into an ID
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
class ShortURL {

    const ALPHABET = '23456789bcdfghjkmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ-_';
    const BASE = 51; // strlen(self::ALPHABET)

    public static function encode($num) {
        $str = '';
        while ($num > 0) {
            $str = substr(self::ALPHABET, ($num % self::BASE), 1) . $str;
            $num = floor($num / self::BASE);
        }
        return $str;
    }

    public static function decode($str) {
        $num = 0;
        $len = strlen($str);
        for ($i = 0; $i < $len; $i++) {
            $num = $num * self::BASE + strpos(self::ALPHABET, $str[$i]);
        }
        return $num;
    }

}
