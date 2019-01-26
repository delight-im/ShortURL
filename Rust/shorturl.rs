/// # Shorturl
/// Bijective conversion between usize and string
///
/// short_url::encode(usize) takes an usize and turns it into a string
/// short_url::decode(String) takes a string and turns it into an usize
///
/// ## Features:
/// * Large alphabet (51 chars) and thus very short resulting strings
/// * Proof against offensive words (Removed 'a', 'e', 'i', 'o' and 'u')
/// * Unambiguous (Removed 'I', 'l', '1', 'O' and '0')
///
/// ## Example
/// * 123456789 <=> pgK8p
/// * 420 <=> bg
///
/// ShortURL (https://github.com/delight-im/ShortURL)
/// Copyright (c) andra.xyz (http://andra.xyz/)
/// Licensed under the MIT License (https://opensource.org/licenses/MIT)
mod short_url {
    static ALPHABET: &str = "23456789bcdfghjkmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ";
    static BASE: usize = 51;
    /// # Argument
    /// * `id` - A usize number that will be transformed
    pub fn encode(mut id: usize) -> String {
        let mut string: String = format!("");
        while id > 0 {
            string.push_str(&ALPHABET[(id % BASE)..(id % BASE + 1)]);
            id = id / BASE;
        }
        string.chars().rev().collect()
    }
    pub fn decode(string: String) -> usize {
        let mut number: usize = 0;
        for c in string.chars() {
            number = number * BASE + ALPHABET.find(c).unwrap();
        }
        number
    }
}
