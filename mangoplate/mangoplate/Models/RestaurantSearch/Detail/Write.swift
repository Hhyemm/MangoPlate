
import Foundation

struct Write: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: WriteId?
}

struct WriteId: Decodable {
    var id: Int
}
