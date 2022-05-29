

import UIKit

class LoginEmailViewController: UIViewController {

    @IBOutlet weak var loginView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginView.layer.cornerRadius = loginView.frame.height / 2
        
    }

}
