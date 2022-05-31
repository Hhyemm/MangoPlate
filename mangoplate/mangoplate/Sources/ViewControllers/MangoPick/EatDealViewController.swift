
import UIKit

class EatDealViewController: UIViewController {

    @IBOutlet weak var regionSelectView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setViewDesign()
        
    }
    
    func setViewDesign() {
        regionSelectView.layer.borderWidth = 1
        regionSelectView.layer.borderColor = UIColor.mainOrangeColor.cgColor
        regionSelectView.layer.cornerRadius = regionSelectView.frame.height / 2
    }
}
