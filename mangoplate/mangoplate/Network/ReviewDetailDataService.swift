
import Foundation
import Alamofire

class ReviewDetailDataService {
    func fetchGetReviewData(delegate: ReviewDetailViewController, id:Int) {
        let url = AF.request("\(Constant.BASE_URL1)/reviews/\(id)")
        url.responseJSON { (response) in
            switch response.result {
            case .success(let obj) :
                if let nsDiectionary = obj as? NSDictionary {
                    do {
                        let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                        let getInstanceData = try JSONDecoder().decode(ReviewDetail.self, from: dataJSON)
                        if let results = getInstanceData.result {
                            delegate.didSuccessReviewGetData(results)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                case .failure(_):
                    print("실패")
            }
        }
    }
    
    func fetchGetLikeData(delegate: ReviewDetailViewController, id:Int) {
        let url = "\(Constant.BASE_URL2)/likes/\(id)"
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["X-ACCESS-TOKEN": "\(Constant.token)"])
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                switch response.result {
                case .success(let obj) :
                    if let nsDiectionary = obj as? NSDictionary {
                        let results = nsDiectionary["result"] as! Int
                        delegate.didSuccessLikeGetData(results)
                    }
                case .failure(_):
                    print("실패")
            }
        }
    }
    
    func fetchPostLikeData(delegate: ReviewDetailViewController, id:Int) {
        let header: HTTPHeaders = [ "Content-Type":"application/json", "X-ACCESS-TOKEN":"\(Constant.token)"]
        AF.request("\(Constant.BASE_URL2)/likes/\(id)", method: .post, parameters: "", encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseDecodable(of: Common.self) { response in
                switch response.result {
                case .success(let response):
                    if response.isSuccess, let result = response.result {
                        print("성공")
                    } else {
                        print("실패")
                    }
                case .failure(let error):
                    print(error.localizedDescription)

            }
        }
    }
    
    func fetchDeleteLikeData(delegate: ReviewDetailViewController, id:Int) {
       let header: HTTPHeaders = [ "Content-Type":"application/json", "X-ACCESS-TOKEN":"\(Constant.token)"]
       AF.request("\(Constant.BASE_URL2)/likes/\(id)", method: .delete, parameters: "", encoder: JSONParameterEncoder(), headers: header)
           .validate()
           .responseDecodable(of: Common.self) { response in
               switch response.result {
               case .success(let response):
                   if response.isSuccess, let result = response.result {
                       print("성공")
                   } else {
                       print("실패")
                   }
               case .failure(let error):
                   print(error.localizedDescription)

               }
           }
    }
    
    func fetchPostCommentData(delegate: ReviewDetailViewController, _ parameters: CommentPostInput, id:Int) {
        let header: HTTPHeaders = [ "Content-Type":"application/json", "X-ACCESS-TOKEN":"\(Constant.token)"]
        AF.request("\(Constant.BASE_URL2)/comments", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let response):
                    if let nsDiectionary = response as? NSDictionary {
                        delegate.didSuccessCommentPostData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func fetchPutCommentData(delegate: ReviewDetailViewController, _ parameters: CommentPutInput, id:Int) {
        let header: HTTPHeaders = [ "Content-Type":"application/json", "X-ACCESS-TOKEN":"\(Constant.token)"]
        AF.request("\(Constant.BASE_URL2)/comments", method: .put, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .validate()
          //  .responseDecodable(of: Model.self) { response in
            .responseJSON { (response) in
                switch response.result {
                case .success(let response):
                    if let nsDiectionary = response as? NSDictionary {
                        delegate.didSuccessCommentPutData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func fetchDeleteCommentData(delegate: CommentPopupViewController, _ comment_id: Int) {
       let header: HTTPHeaders = [ "Content-Type":"application/json", "X-ACCESS-TOKEN":"\(Constant.token)"]
       AF.request("\(Constant.BASE_URL2)/comments/\(comment_id)", method: .delete, parameters: "", encoder: JSONParameterEncoder(), headers: header)
           .validate()
           .responseJSON { (response) in
               switch response.result {
               case .success(let response):
                   if let nsDiectionary = response as? NSDictionary {
                   }
               case .failure(let error):
                   print(error.localizedDescription)

               }
           }
    }
    
    func fetchPostReportData(_ parameters: ReportsInput) {
        let header: HTTPHeaders = [ "Content-Type":"application/json", "X-ACCESS-TOKEN":"\(Constant.token)"]
        AF.request("\(Constant.BASE_URL2)/reports", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let response):
                    if let nsDiectionary = response as? NSDictionary {
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
