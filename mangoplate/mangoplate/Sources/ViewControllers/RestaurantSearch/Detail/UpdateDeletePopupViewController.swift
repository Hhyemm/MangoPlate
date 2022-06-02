
import UIKit
import Alamofire

class UpdateDeletePopupViewController: UIViewController {

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
        deleteData(id!)
    }
    
    @IBAction func pressCancelButton(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func deleteData(_ id: Int) {
        let header: HTTPHeaders = [ "Content-Type":"application/json", "X-ACCESS-TOKEN":"\(Constant.token)"]
        AF.request("\(Constant.BASE_URL2)/reviews/\(id)", method: .delete, parameters: "", encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let obj) :
                    if let nsDiectionary = obj as? NSDictionary {
                        var x = nsDiectionary["result"]
                        print(x)
                    }
                case .failure(_):
                    print("실패")
            }
                    
        }
    }
    
    func updatePut(_ parameters: WriteInput, id: Int) {
        let header: HTTPHeaders = [ "Content-Type":"multipart/form-data",
                                    "X-ACCESS-TOKEN":"\(Constant.token)"]
        
            AF.request("\(Constant.BASE_URL2)/reviews/\(id)", method: .put, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
                .validate()
                .responseDecodable(of: Write.self) { response in
                    switch response.result {
                    case .success(let response):
                        if response.isSuccess{
                            print("성공")
                        } else {
                            print("실패")
                        }
                    case .failure(let error):
                        print(error.localizedDescription)

                }
            }
    }
}
