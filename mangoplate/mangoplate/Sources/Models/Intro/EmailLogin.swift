
import Foundation

struct EmailLogin: Decodable {
    var result: Result
    var isSuccess: Bool
    var code: Int
    var message: String
}

struct Result: Decodable {
    var userIdx: Int
    var jwt: String
}
