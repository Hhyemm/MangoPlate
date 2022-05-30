
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
               print("success")
           }
       }
    }
    
    @IBAction func pressEmailLoginButton(_ sender: UIButton) {
        guard let LEVC = self.storyboard?.instantiateViewController(identifier: "LoginEmailViewController") as? LoginEmailViewController else { return }
           LEVC.modalPresentationStyle = .fullScreen
           self.present(LEVC, animated: false)
    }
    
    func setUserInfo() {
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")
                _ = user
                print(user?.kakaoAccount?.profile?.nickname)
                
                if let url = user?.kakaoAccount?.profile?.profileImageUrl,
                    let data = try? Data(contentsOf: url) {
                    
                }
            }
        }
    }
}
