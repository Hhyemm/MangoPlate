
import Foundation

struct TodayReview: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: TodayReviewResult?
}

struct TodayReviewResult: Codable {
    var reviewId: Int
    var userId: Int
    var userName: String
    var profileImgUrl: String?
    var content: String?
    var score: Int
    var restaurantId: Int
    var restaurantName: String
    var imgUrls: [String]?
    var comments: [String]?
    var reviewCnt: Int
    var followCnt: Int
    var isHolic: Int
    var updatedAt: String
    var wish: Int
    var like: Int
    var reviewLikeCnt: Int
    var reviewCommentCnt: Int
}
