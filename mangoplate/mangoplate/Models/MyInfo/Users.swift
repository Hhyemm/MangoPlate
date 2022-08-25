
import Foundation

struct Users: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: UserInfo?
}

struct UserInfo: Codable {
    var userIdx: Int
    var userName: String
    var followings: [Followings]?
    var followers: [Followers]?
}

struct Followings: Codable {
    
}

struct Followers: Codable {
    
}
