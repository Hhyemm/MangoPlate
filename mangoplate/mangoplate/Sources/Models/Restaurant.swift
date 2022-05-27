
import Foundation

struct Restuarant: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: RestuarantInfo?
}


struct RestuarantInfo: Codable{
    let name: String
    let view: Int
    let score: Double
    let address: String
    let latitude: Double
    let longitude: Double
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
    //let reviews: [String]
}

struct Reviews: Codable {
    
}
