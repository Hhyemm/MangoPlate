
import Foundation

struct ReportsInput: Encodable  {
    var reviewUserId: Int
    var reviewId: Int
    var email: String
    var reason: String
}
