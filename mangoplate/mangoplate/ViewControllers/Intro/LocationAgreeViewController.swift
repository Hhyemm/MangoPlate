
import UIKit

class LocationAgreeViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var agreeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.lineBreakMode = .byCharWrapping
        agreeButton.layer.cornerRadius = agreeButton.frame.height / 2
    }
    
    @IBAction func pressAgreeButton(_ sender: UIButton) {
        guard let VC = self.storyboard?.instantiateViewController(identifier: "LocationAgreeMessageViewController") as? LocationAgreeMessageViewController else { return }
        VC.modalPresentationStyle = .fullScreen
        self.present(VC, animated: false)
    }
    
    @IBAction func pressDifferButton(_ sender: UIButton) {
        guard let VC = self.storyboard?.instantiateViewController(identifier: "RegionSelectViewController") as? RegionSelectViewController else { return }
        VC.modalPresentationStyle = .fullScreen
        self.present(VC, animated: false, completion: nil)
    }
}
