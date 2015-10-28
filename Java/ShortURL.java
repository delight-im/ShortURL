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

import java.math.BigInteger;

public class ShortURL {

    public static final String ALPHABET = "23456789bcdfghjkmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ-_";
    public static final int BASE = ALPHABET.length();

    public static String encode(int num) {
        StringBuilder str = new StringBuilder();
        while (num > 0) {
            str.insert(0, ALPHABET.charAt(num % BASE));
            num = num / BASE;
        }
        return str.toString();
    }

    public static int decode(String str) {
        int num = 0;
        for (int i = 0; i < str.length(); i++) {
            char c = str.charAt(i);
            if (ALPHABET.indexOf(c) < 0) {
                num = -1;
                break;
            }
            num = num * BASE + ALPHABET.indexOf(str.charAt(i));
        }
        return num;
    }

    public static String encode(String num) throws NumberFormatException {
        BigInteger bnum = new BigInteger(num);
        BigInteger bBase = new BigInteger(Integer.toString(BASE));
        StringBuilder str = new StringBuilder();
        while (bnum.compareTo(BigInteger.ZERO) > 0) {
            int n = bnum.mod(bBase).intValue();
            str.insert(0, ALPHABET.charAt(n));
            bnum = bnum.divide(bBase);
        }

        return str.toString();
    }

    public static BigInteger decodeWithBigNumber(String str) {
        BigInteger bNum = new BigInteger("0");
        BigInteger bBase = new BigInteger(Integer.toString(BASE));
        for (int i = 0; i < str.length(); i++) {
            char c = str.charAt(i);
            if (ALPHABET.indexOf(c) < 0) {
                bNum = new BigInteger("-1");
                break;
            }
            BigInteger br = new BigInteger(Integer.toString(ALPHABET.indexOf(c)));
            bNum = bNum.multiply(bBase).add(br);
        }

        return bNum;
    }
}
