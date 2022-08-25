
import Foundation

struct Wish: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: WishResult?
}

struct WishResult: Codable {
    var result: Int
    var isWishes: Int?
    var wishId: Int?
}
