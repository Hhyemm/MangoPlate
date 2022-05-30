
import Foundation

struct Join: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: UserIdx
}

struct UserIdx: Decodable {
    var userIdx: Int
}
