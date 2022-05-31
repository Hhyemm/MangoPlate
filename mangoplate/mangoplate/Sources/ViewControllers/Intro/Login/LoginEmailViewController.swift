

import UIKit

class LoginEmailViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginView: UIView!
    
    var emailLogin = EmailLoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginView.layer.cornerRadius = loginView.frame.height / 2
        
    }
    
    @IBAction func pressBackButton(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func pressLoginButton(_ sender: UIButton) {
        let input = EmailLoginInput(email: emailTextField.text, password: passwordTextField.text)
        emailLogin.postEmailLogin(input, delegate: self)
    }
    
    @IBAction func pressJoinButton(_ sender: UIButton) {
        guard let JEVC = self.storyboard?.instantiateViewController(identifier: "JoinEmailViewController") as? JoinEmailViewController else { return }
           JEVC.modalPresentationStyle = .fullScreen
           self.present(JEVC, animated: false)
    }
    
    func didSuccessEmailLogin(_ result: EmailLogin) {
        print("로그인 성공")
        if let idd = result.result {
            Constant.userIdx = idd.userIdx!
            Constant.token = idd.jwt!
            print(Constant.userIdx, Constant.token)
        }
        guard let LAVC = self.storyboard?.instantiateViewController(identifier: "LocationAgreeViewController") as? LocationAgreeViewController else { return }
           LAVC.modalPresentationStyle = .fullScreen
           self.present(LAVC, animated: false)
    }
       
    func failedToRequest(message: String) {
       print("로그인 실패")
    }
}

