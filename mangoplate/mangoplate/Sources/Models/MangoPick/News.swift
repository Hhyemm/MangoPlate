
import Foundation

struct News: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [NewsResult]?
}

struct NewsResult: Codable{
    let reviewId: Int
    let userId: Int
    let userName: String?
    let profileImgUrl: String?
    let content: String?
    let score: Int?
    let restaurantId: Int?
    let restaurantName: String?
    let imgUrls: [String]?
    let comments: [String]?
    let reviewCnt: Int?
    let followCnt: Int?
    let isHolic: Int?
    let updatedAt: String?
    let wish: Int?
    let like: Int?
    let reviewLikeCnt: Int?
    let reviewCommentCnt: Int?
}
