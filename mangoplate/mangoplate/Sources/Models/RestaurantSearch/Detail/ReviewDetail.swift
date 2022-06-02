
import Foundation

struct ReviewDetail: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: ReviewDetailInfo?
}


struct ReviewDetailInfo: Codable{
    let id: Int
    let userId: Int
    let userName: String
    let profileImgUrl: String?
    let content: String?
    let score: Int
    let restaurantId: Int
    let restaurantName: String
    let imgUrls: [String]
    let comments: [String]
    let reviewCnt: Int
    let followCnt: Int
    let isHolic: Bool
    let updatedAt: String
}
