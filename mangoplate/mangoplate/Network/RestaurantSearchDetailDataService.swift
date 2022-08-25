
import Foundation
import Alamofire

class RestaurantSearchDetailDataService {
    func fetchGetRestaurantDetailData(delegate: RestaurantDetailViewController, id:Int) {
        let url = AF.request("\(Constant.BASE_URL2)/restaurants/\(id)")
        url.responseJSON { (response) in
            switch response.result {
            case .success(let obj) :
                if let nsDiectionary = obj as? NSDictionary {
                    do {
                        let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                        let getInstanceData = try JSONDecoder().decode(RestuarantDetail.self, from: dataJSON)
                        if let results = getInstanceData.result {
                            delegate.didSuccessGetRestaurantDetailData(results)
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
    
    func fetchGetWishData(delegate: RestaurantDetailViewController, id: Int) {
        let url = "\(Constant.BASE_URL2)/wishes/\(id)"
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
                        do {
                            let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                            let getInstanceData = try JSONDecoder().decode(Wish.self, from: dataJSON)
                            if let results = getInstanceData.result {
                                delegate.didSuccessGetWishData(results)
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
    
    func fetchPostWishData(delegate: RestaurantDetailViewController, id: Int)  {
        let header: HTTPHeaders = [ "Content-Type":"application/json", "X-ACCESS-TOKEN":"\(Constant.token)"]
        AF.request("\(Constant.BASE_URL2)/wishes/\(id)", method: .post, parameters: "", encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseDecodable(of: Wish.self) { response in
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
    
    func fetchDeleteWishData(delegate: RestaurantDetailViewController, id: Int) {
        let header: HTTPHeaders = [ "Content-Type":"application/json", "X-ACCESS-TOKEN":"\(Constant.token)"]
        AF.request("\(Constant.BASE_URL2)/wishes/\(id)", method: .delete, parameters: "", encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseDecodable(of: Wish.self) { response in
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
    
    func fetchGetLikeData(delegate: RestaurantDetailViewController, id: Int) {
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
                        delegate.didSuccessGetLikeData(results)
                    }
                case .failure(_):
                    print("실패")
            }
        }
    }
    
    func fetchPostLikeData(delegate: RestaurantDetailViewController, id: Int) {
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
    
    func fetchDeleteLikeData(delegate: RestaurantDetailViewController, id: Int) {
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
    
    func fetchPutReviewData(delegate: UpdateDeletePopupViewController, _ parameters: WriteInput, id: Int) {
        let header: HTTPHeaders = [ "Content-Type":"multipart/form-data",
                                    "X-ACCESS-TOKEN":"\(Constant.token)"]
        AF.request("\(Constant.BASE_URL2)/reviews/\(id)", method: .put, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseDecodable(of: Write.self) { response in
                switch response.result {
                case .success(let response):
                    if response.isSuccess{
                        print("성공")
                    } else {
                        print("실패")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func fetchDeleteReviewData(delegate: UpdateDeletePopupViewController, id: Int) {
        let header: HTTPHeaders = [ "Content-Type":"application/json", "X-ACCESS-TOKEN":"\(Constant.token)"]
        AF.request("\(Constant.BASE_URL2)/reviews/\(id)", method: .delete, parameters: "", encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(_) :
                    print("성공")
                case .failure(_):
                    print("실패")
            }
                    
        }
    }
}

