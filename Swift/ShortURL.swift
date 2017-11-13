import UIKit

class ShortURL {
    static let alphabet = "23456789bcdfghjkmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ-_"
    static let base: Int = alphabet.count
    
    static func encode(num: Int) -> String {
        var str = ""
        var n = num
        
        while (n > 0) {
            let idx = n % base
            let index = alphabet.index(alphabet.startIndex, offsetBy: idx)
            
            str = String(alphabet[index]) + str
            n = n / base
        }
        return String(str)
    }
    
    static func decode(str: String) -> Int {
        return str.map { char in
            alphabet.distance(from: alphabet.startIndex, to: alphabet.index(of: char)!)
            }.reduce(0) { (result: Int, idx) -> Int in
                return (result * base) + idx
        }
    }
}

// ShortURL.encode(num: 123456789) is equal to "pgK8p"
// ShortURL.decode(str: "pgK8p") is equal to 123456789
