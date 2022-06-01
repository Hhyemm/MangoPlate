
import UIKit

class FollwingViewController: UIViewController {

    @IBOutlet weak var select5View: UIView!
    @IBOutlet weak var select3View: UIView!
    @IBOutlet weak var select1View: UIView!
    
    @IBOutlet weak var select5Label: UILabel!
    @IBOutlet weak var select3Label: UILabel!
    @IBOutlet weak var select1Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setViewDesign(select5View)
        setViewDesign(select3View)
        setViewDesign(select1View)
        pressSelectButton(select5View, select5Label)
        upPressSelectButton(select3View, select3Label)
        upPressSelectButton(select1View, select1Label)
    }
    
    func setViewDesign(_ selectView: UIView) {
        selectView.layer.borderWidth = 1
        selectView.layer.cornerRadius = selectView.frame.height / 2
    }
    
    func pressSelectButton(_ selectView: UIView, _ selectLabel: UILabel) {
        selectView.layer.borderColor = UIColor.mainOrangeColor.cgColor
        selectLabel.textColor = .mainOrangeColor
    }
    
    func upPressSelectButton(_ selectView: UIView, _ selectLabel: UILabel) {
        selectView.layer.borderColor = UIColor.mainLightGrayColor.cgColor
        selectLabel.textColor = .mainLightGrayColor
        
    }
    


}
