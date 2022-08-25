
import Foundation

struct Kakao: Decodable {
    var result: KakaoResult?
    var code: Int?
    var message: String?
    var isSuccess: Bool?
}

struct KakaoResult: Decodable {
    var userIdx: Int?
    var jwt: String?
}

