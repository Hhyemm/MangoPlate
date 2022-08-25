
import UIKit

class JoinEmailViewController: UIViewController {
    
    @IBOutlet weak var joinView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordMessage: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    
    var join = JoinDataService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordMessage.isHidden = true
    }
    
    @IBAction func pressReturnButton(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }

    @IBAction func pressXButton(_ sender: UIButton) {
        guard let VC = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else { return }
           VC.modalPresentationStyle = .fullScreen
           self.present(VC, animated: false)
    }
    
    @IBAction func pressJoinButton(_ sender: UIButton) {
        if let password = passwordTextField.text {
            passwordMessage.isHidden = password.count < 6 ? false : true
        }
        let input = JoinInput(email: emailTextField.text, password: passwordTextField.text, userName: userNameTextField.text)
        join.postRegister(input, delegate: self)
        self.dismiss(animated: false, completion: nil)
    }
    
    func didSuccessRegister(_ result: Join) {
        print("성공")
    }
    
    func failedToRequest(message: String) {
        print("실패")
    }
}


