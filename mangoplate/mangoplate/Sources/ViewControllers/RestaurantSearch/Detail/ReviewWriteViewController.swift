
import UIKit
import Alamofire

class ReviewWriteViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var select5Image: UIImageView!
    @IBOutlet weak var select3Image: UIImageView!
    @IBOutlet weak var select1Image: UIImageView!
    @IBOutlet weak var select5Label: UILabel!
    @IBOutlet weak var select3Label: UILabel!
    @IBOutlet weak var select1Label: UILabel!
    
    var nowSocre = 5
    var id: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.becomeFirstResponder()
        textField.tintColor = .mainOrangeColor
    }
    
    @IBAction func pressBackButton(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    
    @IBAction func select5Button(_ sender: UIButton) {
        select5Image.image = UIImage(named: "reviewImage1")
        select3Image.image = UIImage(named: "reviewImage22")
        select1Image.image = UIImage(named: "reviewImage33")
        
        select5Label.textColor = .mainOrangeColor
        select3Label.textColor = .mainLightGrayColor
        select1Label.textColor = .mainLightGrayColor
        
        nowSocre = sender.tag
        print(sender.tag)
        
    }
    
    @IBAction func select3Button(_ sender: UIButton) {
        select5Image.image = UIImage(named: "reviewImage11")
        select3Image.image = UIImage(named: "reviewImage2")
        select1Image.image = UIImage(named: "reviewImage33")
        
        select5Label.textColor = .mainLightGrayColor
        select3Label.textColor = .mainOrangeColor
        select1Label.textColor = .mainLightGrayColor
        
        nowSocre = sender.tag
        print(sender.tag)
    }
    
    @IBAction func select1Button(_ sender: UIButton) {
        select5Image.image = UIImage(named: "reviewImage11")
        select3Image.image = UIImage(named: "reviewImage22")
        select1Image.image = UIImage(named: "reviewImage3")
        
        select5Label.textColor = .mainLightGrayColor
        select3Label.textColor = .mainLightGrayColor
        select1Label.textColor = .mainOrangeColor
        
        nowSocre = sender.tag
        print(sender.tag)
    }
    
    @IBAction func pressCompleteButton(_ sender: UIButton) {
        let input = WriteInput(content: textField.text!, score: nowSocre)
        writePost(input, id: id!)
        print(id!, nowSocre, textField.text!)
    }
}

extension ReviewWriteViewController {
    func writePost(_ parameters: WriteInput, id: Int) {
        let header: HTTPHeaders = [ "Content-Type":"multipart/form-data",
                                    "X-ACCESS-TOKEN":"\(Constant.token)"]
        
            AF.request("\(Constant.BASE_URL2)/reviews/\(id)", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
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
