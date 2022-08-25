
import Foundation

struct EatDeal: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [EatDealInfo]?
}

struct EatDealInfo: Codable {
    var eatDealId: Int
    var restaurantId: Int
    var restaurantName: String
    var menuName: String?
    var price: Int
    var discountRate: Int
    var imgUrls: [String]
    var address: String
}
