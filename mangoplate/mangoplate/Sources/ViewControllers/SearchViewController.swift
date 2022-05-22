
import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.becomeFirstResponder()
    }
}
