# ShortURL

Bijective conversion between natural numbers (IDs) and short strings

Useful for URL shorteners and short IDs in your permalinks

## Usage

 * `ShortURL.encode()` takes an ID and turns it into a short string
 * `ShortURL.decode()` takes a short string and turns it into an ID

## Features
 * large alphabet (51 chars) and thus very short resulting strings
 * proof against offensive words (removed `a`, `e`, `i`, `o` and `u`)
 * unambiguous (removed `I`, `l`, `1`, `O` and `0`)

## Example output
 * `123456789` <=> `pgK8p`

## License

This project is licensed under the terms of the [MIT License](https://opensource.org/licenses/MIT).
