
import Foundation
import Alamofire

class KakaoViewModel {
    func postKakao( request: KakaoRequest, viewController: LoginViewController, kakao: String) {
        let header: HTTPHeaders = [ "Content-Type":"application/json", "X-ACCESS-TOKEN":"\(kakao)"]
        AF.request("\(Constant.BASE_URL2)/oauth/kakao/login", method: .post, parameters: request, encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseDecodable(of: Kakao.self) { response in
                switch response.result {
                case .success(let response):
                    if response.isSuccess!, let result = response.result {
                        viewController.didSuccessKakao(result)

                    } else {
                        viewController.failedToKakao(message: response.message!)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    viewController.failedToKakao(message: "서버와의 연결이 원활하지 않습니다")
            }
        }
    }
}
