
import UIKit
import Alamofire

class ReportViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    
    let dataService = ReviewDetailDataService()
    var reviewId: Int?
    var reviewUserId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.tintColor = .mainOrangeColor
        contentTextField.tintColor = .mainOrangeColor
    }
    
    @IBAction func pressSendButton(_ sender: UIButton) {
        let input = ReportsInput(reviewUserId: reviewUserId!, reviewId: reviewId!, email: emailTextField.text!, reason: contentTextField.text!)
        dataService.fetchPostReportData(input)
        self.dismiss(animated: false, completion: nil)
    }
}
