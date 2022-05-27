
import Foundation

struct RestaurantSearch: Decodable {
    var isSuccess: Bool
    var result: [RestaurantInfo]?
}

struct RestaurantInfo: Decodable {
    let name: String
}
