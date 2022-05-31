
import Foundation
import Alamofire

class JoinViewModel{
    func postRegister(_ parameters: JoinInput, delegate: JoinEmailViewController) {
        AF.request("\(Constant.BASE_URL2)/users", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: Join.self) { response in
                switch response.result {
                case .success(let response):
                    if ((response.isSuccess) != nil) {
                        delegate.didSuccessRegister(response)
                    } else {
                        switch response.code {
                        case 2015: delegate.failedToRequest(message: "이메일을 입력해주세요.")
                        case 2016: delegate.failedToRequest(message: "이메일 형식을 확인해주세요.")
                        case 2018: delegate.failedToRequest(message: "유저 이름을 입력해주세요")
                        case 3000: delegate.failedToRequest(message: "비밀번호 암호화에 실패하였습니다.")
                        case 4000: delegate.failedToRequest(message: "데이터베이스 연결에 실패하였습니다.")
                        default: break
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
