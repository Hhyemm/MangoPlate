
import Foundation

struct WriteInput: Encodable {
    var content: String
    var score: Int
    //var file: [String]?
    
    var toDictionary: [String: Any] {
           let dict: [String: Any]  = ["content": content, "score": score]
           return dict
       }
}
