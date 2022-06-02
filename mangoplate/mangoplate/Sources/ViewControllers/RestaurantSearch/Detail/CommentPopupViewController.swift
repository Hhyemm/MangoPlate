
import UIKit
import Alamofire

class CommentPopupViewController: UIViewController {
    
    @IBOutlet weak var cancelView: UIView!
    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var updateView: UIView!

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
        deleteComment(commentId)
        self.presentingViewController?.dismiss(animated: false, completion: nil)
    }
    
    func deleteComment(_ comment_id: Int) {
       let header: HTTPHeaders = [ "Content-Type":"application/json", "X-ACCESS-TOKEN":"\(Constant.token)"]
       AF.request("\(Constant.BASE_URL2)/comments/\(comment_id)", method: .delete, parameters: "", encoder: JSONParameterEncoder(), headers: header)
           .validate()
           .responseJSON { (response) in
               switch response.result {
               case .success(let response):
                   if let nsDiectionary = response as? NSDictionary {
                       print("성공")
                       
                       
                       DispatchQueue.main.async {
                           
                       }
                   }
               case .failure(let error):
                   print(error.localizedDescription)

               }
           }
    }
}
