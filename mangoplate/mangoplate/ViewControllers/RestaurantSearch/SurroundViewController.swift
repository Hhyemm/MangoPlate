
import UIKit

class SurroundViewController: UIViewController {

    @IBOutlet weak var onLocationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onLocationButton.layer.cornerRadius = onLocationButton.frame.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.2)
    }
    
    @IBAction func pressDismissButton(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func pressOnLocationServiceButton(_ sender: UIButton) {
        if let url = URL(string: UIApplication.openSettingsURLString) {
          UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
}
