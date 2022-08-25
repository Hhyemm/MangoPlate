
import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func pressFacebookLoginButton(_ sender: UIButton) {
    }
    
    @IBAction func pressKakaoLoginButton(_ sender: UIButton) {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("success.")

                _ = oauthToken
                        
                let accessToken = oauthToken?.accessToken
                    
                Constant.kakaoToken = accessToken!
                print("토큰:\(Constant.kakaoToken)")
                //var kakao = KakaoViewModel()
                //kakao.postKakao( viewController: self, kakao: Constant.kakaoToken)
                self.setUserInfo()
            }
        }
    }
    
    @IBAction func pressEmailLoginButton(_ sender: UIButton) {
        guard let VC = self.storyboard?.instantiateViewController(identifier: "LoginEmailViewController") as? LoginEmailViewController else { return }
           VC.modalPresentationStyle = .fullScreen
           self.present(VC, animated: false)
    }
    
    func setUserInfo() {
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("success.")
                _ = user
                print(user?.kakaoAccount?.profile?.nickname)

                if let url = user?.kakaoAccount?.profile?.profileImageUrl,
                    let data = try? Data(contentsOf: url) {
                }
            }
        }
    }
    
    @IBAction func pressPassButton(_ sender: UIButton) {
        guard let VC = self.storyboard?.instantiateViewController(identifier: "LocationAgreeViewController") as? LocationAgreeViewController else { return }
           VC.modalPresentationStyle = .fullScreen
           self.present(VC, animated: false)
    }
}
