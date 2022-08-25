
import UIKit
import Alamofire

class CommentPopupViewController: UIViewController {
    
    @IBOutlet weak var cancelView: UIView!
    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var updateView: UIView!

    let dataService = ReviewDetailDataService()
    var delegate: sendUpdateDelegate?
    var commentId = 0
    var text = ""
    
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
        self.delegate?.send(now: "update", text: text)
        self.presentingViewController?.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func pressCancelButton(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func pressDeleteButton(_ sender: UIButton) {
        self.delegate?.send(now: "delete", text: text)
        dataService.fetchDeleteCommentData(delegate: self, commentId)
        self.presentingViewController?.dismiss(animated: false, completion: nil)
    }
}
