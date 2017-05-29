
/**
 * based on https://github.com/delight-im/ShortURL/blob/master/Java/ShortURL.java
 * 
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
 */
object ShorURL {
  
  val alphabet:String = "23456789bcdfghjkmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ-_"
  val base:Int = alphabet.length()  

  // sample test
  def main(args: Array[String]) {
    println(encode(123456789))
    println(decode("pgK8p"))
  }
  
  def encode(num:Int): String = {
    var str = new StringBuilder()
    var n = num
    
    while(n > 0) {
      str.insert(0, alphabet.charAt(n % base))                 
      n = n / base
    }    
    return str.toString()
  }

  def decode(str:String): Int = {    
    return 0.to(str.length() - 1).foldLeft(0)((r,c) => r * base + alphabet.indexOf(str.charAt(c)))
  }
}
