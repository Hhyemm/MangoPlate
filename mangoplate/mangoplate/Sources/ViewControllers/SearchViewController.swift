
import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTextField()
    }
    
    func setTextField() {
        textField.becomeFirstResponder()
        textField.tintColor = .mainOrangeColor
    }
    
    @IBAction func pressBackButton(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
}
