
import Foundation

struct WriteInput: Encodable {
    var content: String
    var score: Int
    var file: [String]?
}
