
import UIKit

class PlusViewController: UIViewController {

    @IBOutlet weak var newView: UIView!
    @IBOutlet weak var xView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        xView.layer.cornerRadius = xView.frame.width / 2
        newView.layer.cornerRadius = 5
        newView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    @IBAction func pressXButton(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
}
