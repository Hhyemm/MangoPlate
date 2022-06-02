
import UIKit
import Alamofire

class ReportViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    var reviewId: Int?
    var reviewUserId: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.tintColor = .mainOrangeColor
        contentTextField.tintColor = .mainOrangeColor
    }
    
    @IBAction func pressSendButton(_ sender: UIButton) {
        let input = ReportsInput(reviewUserId: reviewUserId!, reviewId: reviewId!, email: emailTextField.text!, reason: contentTextField.text!)
        postReport(input)
        self.dismiss(animated: false, completion: nil)
        
    }
    
    func postReport(_ parameters: ReportsInput) {
        let header: HTTPHeaders = [ "Content-Type":"application/json", "X-ACCESS-TOKEN":"\(Constant.token)"]
        AF.request("\(Constant.BASE_URL2)/reports", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let response):
                    if let nsDiectionary = response as? NSDictionary {
                        print(nsDiectionary["result"])
                        print("성공")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
