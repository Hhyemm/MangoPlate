
import UIKit
import Alamofire

class UpdateDeletePopupViewController: UIViewController {

    let dataService = RestaurantSearchDetailDataService()
    var id: Int?
    
    @IBOutlet weak var cancelView: UIView!
    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var updateView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        
        cancelView.layer.borderWidth = 2
        cancelView.layer.borderColor = UIColor.mainDarkGrayColor.cgColor
        cancelView.layer.cornerRadius = cancelView.frame.height / 2
        
        deleteView.layer.borderWidth = 2
        deleteView.layer.borderColor = UIColor.mainOrangeColor.cgColor
        deleteView.layer.cornerRadius = deleteView.frame.height / 2
        
        updateView.layer.borderWidth = 2
        updateView.layer.borderColor = UIColor.mainOrangeColor.cgColor
        updateView.layer.cornerRadius = deleteView.frame.height / 2
    }
    
    @IBAction func pressUpdateButton(_ sender: UIButton) {
    }
    

    @IBAction func pressRemoveButton(_ sender: UIButton) {
        dataService.fetchDeleteReviewData(delegate: self, id: id!)
    }
    
    @IBAction func pressCancelButton(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    } 
}
