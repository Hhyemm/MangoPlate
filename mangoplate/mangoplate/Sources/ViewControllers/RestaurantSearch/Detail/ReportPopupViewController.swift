
import UIKit

class ReportPopupViewController: UIViewController {

    @IBOutlet weak var cancelView: UIView!
    @IBOutlet weak var reportView: UIView!
    
    var reviewId: Int?
    var reviewUserId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        
        cancelView.layer.borderWidth = 2
        cancelView.layer.borderColor = UIColor.mainDarkGrayColor.cgColor
        cancelView.layer.cornerRadius = cancelView.frame.height / 2
        
        reportView.layer.borderWidth = 2
        reportView.layer.borderColor = UIColor.mainOrangeColor.cgColor
        reportView.layer.cornerRadius = reportView.frame.height / 2
    }
    
    @IBAction func pressReportButton(_ sender: UIButton) {
        guard let VC = self.storyboard?.instantiateViewController(identifier: "ReportViewController") as? ReportViewController else { return }
        VC.reviewId = reviewId
        VC.reviewUserId = reviewUserId
        VC.modalPresentationStyle = .overCurrentContext
        self.present(VC, animated: false, completion: nil)
    }
    
    
    @IBAction func pressCancelButton(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
}
