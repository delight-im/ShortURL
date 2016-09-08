# ShortURL

Bijective conversion between natural numbers (IDs) and short strings

Useful for URL shorteners and short IDs in your permalinks

## Usage

 * `ShortURL.encode()` takes an ID and turns it into a short string
 * `ShortURL.decode()` takes a short string and turns it into an ID

## Features

 * very short strings (much shorter than hex)
   * uses large alphabet of 51 characters
 * URL-safe (in contrast to Base64)
   * doesn't use any characters that need to be encoded for use in URLs
 * protection against offensive words (in contrast to Base64 and hex)
   * vowels are not used
 * unambiguous (in contrast to Base64 and hex)
   * look-alike characters are not used

## Example output

 * `3141592` <=> `vJST`
 * `123456789` <=> `pgK8p`

## Contributing

All contributions are welcome! If you wish to contribute, please create an issue first so that your feature, problem or question can be discussed.

## License

This project is licensed under the terms of the [MIT License](https://opensource.org/licenses/MIT).
