
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
        guard let LAMVC = self.storyboard?.instantiateViewController(identifier: "LocationAgreeMessageViewController") as? LocationAgreeMessageViewController else { return }
        LAMVC.modalPresentationStyle = .fullScreen
        self.present(LAMVC, animated: false)
    }
    
    @IBAction func pressDifferButton(_ sender: UIButton) {
        guard let RSVC = self.storyboard?.instantiateViewController(identifier: "RegionSelectViewController") as? RegionSelectViewController else { return }
        RSVC.modalPresentationStyle = .fullScreen
        self.present(RSVC, animated: false, completion: nil)
    }
}
