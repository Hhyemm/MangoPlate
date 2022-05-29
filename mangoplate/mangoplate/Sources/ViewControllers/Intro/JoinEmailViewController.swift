
import UIKit

class JoinEmailViewController: UIViewController {

    
    @IBOutlet weak var certificationView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        certificationView.layer.cornerRadius = certificationView.frame.height / 2
    }
}
