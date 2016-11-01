<?php

/*
 * ShortURL (https://github.com/delight-im/ShortURL)
 * Copyright (c) delight.im (https://www.delight.im/)
 * Licensed under the MIT License (https://opensource.org/licenses/MIT)
 */

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
 */
class ShortURL {

	const ALPHABET = '23456789bcdfghjkmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ-_';
	const BASE = 51; // strlen(self::ALPHABET)

	public static function encode($num) {
		static $mode=-1;
		if($mode===-1){
			if(is_callable('gmp_div_q')){
				$mode=1;
			}elseif(is_callable('bcdiv')){
				$mode=2;
			} else {
				$mode=0;
			}
		}
		if(!is_int($num) || $num<1 || ($mode===0 && $num>0x7FFFFFFF)){
			throw new InvalidArgumentException('argument 1 MUST be an int between 1 and '.($mode!==0?PHP_INT_MAX:0x7FFFFFFF.' (PS, if you install the GMP or BCMath extensions, the limit will be upgraded to '.PHP_INT_MAX.')'));
		}

		$str = '';
		while ($num > 0) {
			$str = self::ALPHABET[($num % self::BASE)] . $str;
			if($num<=0x7FFFFFFF)
			{
				$num = (int) ($num / self::BASE);
			} elseif($mode===1) {
				$num=gmp_intval(gmp_div_q($num,self::BASE));
			} elseif($mode===2){
				$num=(int)bcdiv($num,SELF::BASE);
			}else {
				throw new LogicException('unreachable code reached!');
			}
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
