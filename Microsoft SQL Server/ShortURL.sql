
-- # ShortURL (https://github.com/delight-im/ShortURL)
-- # Copyright (c) delight.im (https://www.delight.im/)
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
-- Microsoft SQL Server 2016+

drop function if exists shorturl_encode
go

create function shorturl_encode(@id int)
returns varchar(20)
as
begin
	declare
		@alphabet varchar(51) = '23456789bcdfghjkmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ-_',
		@base int,
		@str varchar(20) = '',
		@num int;

	set @base = len(@alphabet)

	set @num = @id;

	while @num > 0
	begin
		set @str= concat( substring(@alphabet, (@num % @base)+1, 1), @str)
		set @num= floor(@num / @base)
	end

	return @str
end
go

drop function if exists shorturl_decode
go

create function dbo.shorturl_decode(@str varchar(20) )
returns int
as
begin
	declare
		@alphabet varchar(51) = '23456789bcdfghjkmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ-_',
		@i int = 1,
		@num int = 0,
		@base int,
		@len int;

	set @base = len(@alphabet)
	set @len = len(@str)

	while @i <= @len
	begin
		set @num = @num * @base + charindex( substring(@str collate SQL_Latin1_General_CP1_CS_AS, @i, 1) , @alphabet)-1
		set @i=@i+1
	end

	return @num
end
go

