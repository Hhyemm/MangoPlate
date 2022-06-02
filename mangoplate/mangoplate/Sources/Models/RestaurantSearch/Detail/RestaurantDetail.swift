
import Foundation

struct RestuarantDetail: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: RestuarantDetailInfo?
}


struct RestuarantDetailInfo: Codable{
    let id: Int
    let name: String
    let view: Int
    let wishCnt: Int
    let score: Double
    let address: String
    let latitude: Double
    let longitude: Double
    let updatedAt: String
    let dayOff: String
    let openHour: String
    let closeHour: String
    let breakTime: String?
    let minPrice: Int
    let maxPrice: Int
    let parkInfo: String
    let website: String?
    let foodCategoryId: Int
    let foodCategoryName: String
    let imgUrls: [String]
    var reviews: [Reviews]
    let menus: [Menus]
}

struct Reviews: Codable {
    let id: Int
    let userId: Int
    let userName: String
    let profileImgUrl: String?
    let content: String
    let score: Int
    let restaurantName: String
    let imgUrls: [String]
    let comment: String?
    let reviewCnt: Int?
    let followCnt: Int?
    let isHolic: Bool
    let updatedAt: String?
}

struct Menus: Codable {
    let name: String
    let price: Int
}
