
-- # ShortURL (https://github.com/delight-im/ShortURL)
-- # Copyright (c) delight.im (https://www.delight.im/), Marcello Verona <marcelloverona@gmail.com>
-- # Licensed under the MIT License (https://opensource.org/licenses/MIT)

-- ShortURL: Bijective conversion between natural numbers (IDs) and short strings
--
-- shorturl_encode() takes an ID and turns it into a short string
-- shorturl_decode() takes a short string and turns it into an ID
--
-- Features:
-- + large alphabet (51 chars) and thus very short resulting strings
-- + proof against offensive words (removed 'a', 'e', 'i', 'o' and 'u')
-- + unambiguous (removed 'I', 'l', '1', 'O' and '0')
--
-- Example output:
-- 123456789 <=> pgK8p
--
-- Example:
-- SELECT shorturl_encode(123456789) AS x;
-- => pgK8p
--
-- SELECT shorturl_decode('pgK8p') AS x;
-- => 123456789
--
-- The functions can be used in a trigger or in a stored procedure

DELIMITER //

DROP FUNCTION IF EXISTS shorturl_encode //

CREATE FUNCTION shorturl_encode(id INT) RETURNS VARCHAR(20) CHARSET utf8
BEGIN

	SET @ALPHABET = '23456789bcdfghjkmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ-_';
	SET @BASE = LENGTH(@ALPHABET);
	SET @str = '';
	SET @num = id;

	WHILE @num > 0 DO
		SET @str:= CONCAT( SUBSTRING(@ALPHABET, (@num % @BASE)+1, 1), @str);
		SET @num:= FLOOR(@num / @BASE);
	END WHILE;
	RETURN @str;

END;
//


DROP FUNCTION IF EXISTS shorturl_decode //

CREATE FUNCTION shorturl_decode(str VARCHAR(20) ) RETURNS INT
BEGIN

	SET @ALPHABET = '23456789bcdfghjkmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ-_';
	SET @BASE = LENGTH(@ALPHABET);
	SET @len = LENGTH(str);
	SET @i = 1;
	SET @num = 0;

	WHILE @i <= @len DO
		SET @num:= @num * @BASE + LOCATE( BINARY SUBSTRING(str, @i, 1) , @ALPHABET)-1;
		SET @i:=@i+1;
	END WHILE;
	RETURN @num;

END;
//

DELIMITER ;

