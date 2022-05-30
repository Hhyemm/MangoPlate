
import Foundation
import Alamofire

class EmailLoginData {
    func postEmailLogin(_ parameters: EmailLoginInput, delegate: LoginEmailViewController) {
        AF.request("\(Constant.BASE_URL2)/users/login", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: EmailLogin.self) { response in
                switch response.result {
                case .success(let response):
                    if ((response.isSuccess) != nil) {
                        print("로그인성공")
                        delegate.didSuccessEmailLogin(response)
                    }
                    else {
                        switch response.code {
                        case 2015: delegate.failedToRequest(message: "이메일을 입력해주세요.")
                        case 2016: delegate.failedToRequest(message: "이메일 형식을 확인해주세요.")
                        case 2014: delegate.failedToRequest(message: "비민번호를 입력해주세요.")
                        case 3014: delegate.failedToRequest(message: "없는 아이디거나 비밀번호가 틀렸습니다.")
                        case 4012: delegate.failedToRequest(message: "비밀번호 복호화에 실패하였습니다.")
                        default: break
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
