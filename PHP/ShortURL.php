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
		$num = filter_var ( $num, FILTER_VALIDATE_INT, array (
				'options' => array (
						'default' => false,
						'min_range' => 1,
						'max_range' => PHP_INT_MAX
				)
		) );
		if ($num === false) {
			throw new InvalidArgumentException ( 'input MUST be an int between 1 and ' . PHP_INT_MAX . ' (PHP_INT_MAX).' );
		}
		$str = '';

		while ( $num > 0 ) {
			$str = self::ALPHABET [($num % self::BASE)] . $str;
			if($num <= 0x7FFFFFFF){
				//the number is so small that using regular php division is safe (and fastest)
				$num = (int) ($num / self::BASE);
			} else if (is_callable ( 'bcdiv' )) {
				// use bcmath if available. should be faster than userland php division. could add GMP support.
				$num = ( int ) bcdiv ( $num, self::BASE, 0 );
			} else {
				//fallback to userland php division
				$num = self::saferudiv ( $num, self::BASE );
			}
		}

		return $str;
	}

	public static function decode($str) {
		$num = 0;
		$len = strlen ( $str );

		for($i = 0; $i < $len; $i ++) {
			$num = $num * self::BASE + strpos ( self::ALPHABET, $str [$i] );
		}

		return $num;
	}
	private static function saferudiv(/*int */$N,/* int */$D) {
		// based on an algorithm from http://justinparrtech.com/JustinParr-Tech/an-algorithm-for-arbitrary-precision-integer-division/
		$N = ( int ) abs ( ( int ) $N );
		$D = ( int ) abs ( ( int ) $D );
		$M = strlen ( ( string ) $D ) - 1;
		// assert($N===999999);
		// assert($D===7777);
		// assert($M===3);
		$A = ( int ) ($D - (( int ) ($D % (( int ) pow ( $M, 10 )))));
		// assert($A===7000);
		$Q = ( int ) self::_saferudiv ( $N, $A, 0 );
		// assert($Q===142);
		$R = ( int ) ($D + 1);
		// assert($R===7778);
		while ( (( int ) abs ( $R )) >= $D ) {
			$R = ( int ) ($N - (( int ) ($Q * $D)));
			$Qn = ( int ) ($Q + (( int ) (self::_saferudiv ( $R, $A ))));
			$Q = ( int ) (self::_saferudiv ( ( int ) ($Q + $Qn), 2 ));
		}
		$R = ( int ) ($N - (( int ) ($Q * $D)));
		// assert($R===-3234);
		if ($R < 0) {
			$Q = ( int ) ($Q - 1);
			// assert($Q===128);
			$R = ( int ) ($R + $D);
			// assert($R===4543);
		}
		// assert(999999===($Q*$D+$R));
		// var_dump ( $Q, $R );
		return $Q;
	}
	private static function _saferudiv($x, $y, $unused = NULL) {
		if (PHP_INT_SIZE === 4) {
			return ( int ) ($x / $y);
		} elseif (PHP_INT_SIZE === 8) {
			return ($x - ($x % $y)) / $y;
		} else {
			// running 128bit php or something?
			throw new Exception ( 'this code only supports 4 bytes (32bit) and 8 bytes (64bit) php integers, but this php runtime uses ' . PHP_INT_SIZE . ' bytes integers. the code needs to get updated.' );
		}
	}
}
