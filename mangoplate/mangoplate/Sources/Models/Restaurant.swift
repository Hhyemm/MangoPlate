
import Foundation

struct Restuarant: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [RestuarantInfo]?
}

struct RestuarantInfo: Codable {
    var id: Int
    var name: String
    var regionName: String
    var foodCategory: String
    var latitude: Double
    var longitude: Double
    var ratingsAvg: Double
    var numReviews: Int
    var distance: Double
    var isWishes: Int?
    var imgUrl: String
}
