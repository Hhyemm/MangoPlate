
import UIKit
import Alamofire

protocol sendUpdateDelegate: AnyObject {
    func send(now: String, text: String)
}

extension ReviewDetailViewController: ClickLikeDelegate2, sendUpdateDelegate {
    func clickLikeButton(for index: Int, id: Int?) {
        if likeList[index] == 1 {
            print("like 취소")
            likeDeleteData(id!)
            likeList[index] = 0
            reviewCollectionView.reloadData()
        } else {
            print("like")
            likePostData(id!)
            likeList[index] = 1
            reviewCollectionView.reloadData()
        }
    }
    
    func send(now: String, text: String) {
        isNow = now
        if isNow == "update" {
            updateView.isHidden = false
           // self.textField.text = self.reviewDetailInfoList?.comments[indexPath.item].content
        }
    }
}

class ReviewDetailViewController: UIViewController {

    @IBOutlet weak var reviewCollectionView: UICollectionView!
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var commentHeaderMessage: UIView!
    @IBOutlet weak var commentCollectionView: UICollectionView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendButtonImage: UIImageView!
    @IBOutlet weak var updateView: UIView!
    
    var reviewDetailInfoList: ReviewDetailInfo!
    var id: Int?
    var likeList = [Int]()
    var isLike: Int?
    var commentId = 0
    var isNow = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateView.isHidden = true
        textField.tintColor = .mainOrangeColor
        textField.addLeftPadding()
        textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
        setCollectionView()
        setDesign()
        reviewFetchData()
        print(id)
        
    }
    
    func pressHashButton() {
        guard let RDVC = storyboard?.instantiateViewController(withIdentifier: "RestaurantDetailViewController") as? RestaurantDetailViewController else { return }
        RDVC.modalPresentationStyle = .fullScreen
        RDVC.id = reviewDetailInfoList?.restaurantId
        
        self.present(RDVC, animated: false, completion: nil)
    }
    
    @IBAction func pressBackButton(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func setCollectionView() {
        self.reviewCollectionView.delegate = self
        self.reviewCollectionView.dataSource = self
        
        reviewCollectionView.register(UINib(nibName: "NewsCell", bundle: nil), forCellWithReuseIdentifier: "NewsCell")
        
        self.commentCollectionView.delegate = self
        self.commentCollectionView.dataSource = self
        
        commentCollectionView.register(UINib(nibName: "CommentCell", bundle: nil), forCellWithReuseIdentifier: "CommentCell")
    }
    
    func setDesign() {
        userImage.layer.cornerRadius = userImage.frame.width / 2
        commentTextField.layer.borderWidth = 1
        commentTextField.layer.borderColor = UIColor.mainLightGrayColor.cgColor
        commentTextField.layer.cornerRadius = commentTextField.frame.height / 2
        commentHeaderMessage.layer.cornerRadius = commentTextField.frame.height / 2
    }
    
    @objc func textFieldDidChange(_ sender: Any?) {
        sendButtonImage.image = UIImage(named: "send3")
        sendButtonImage.tintColor = .mainOrangeColor
    }
    
    @IBAction func pressSendButton(_ sender: UIButton) {
        if isNow == "update" {
            let input = CommentPutInput(commentId: commentId, comment: textField.text!)
            textField.text = ""
            print(commentId)
            putComment(input)
            
        } else {
            let input = CommentPostInput(reviewId: id!, comment: textField.text!)
            textField.text = ""
            postComment(input)
        }
    }
    
    @IBAction func pressXButton(_ sender: UIButton) {
        updateView.isHidden = true
    }
}

extension ReviewDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == reviewCollectionView {
            return 1
        }
        return reviewDetailInfoList?.comments.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == reviewCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as! NewsCell
            cell.delegate = self
            cell.index = indexPath.item
            cell.id = reviewDetailInfoList?.id
            cell.userName.text = reviewDetailInfoList?.userName ?? ""
            (reviewDetailInfoList?.profileImgUrl) == nil ? cell.userImage.image = UIImage(named: "userBasicImage") : cell.userImage.load(url: URL(string: (reviewDetailInfoList?.profileImgUrl) as! String )!)
            
            cell.content.text = reviewDetailInfoList?.content ?? ""

            switch reviewDetailInfoList?.score {
            case 5 :
                cell.score.text = "맛있다!"
                cell.scoreImage.image = UIImage(named: "reviewImage1")
            case 3 :
                cell.score.text = "괜찮다"
                cell.scoreImage.image = UIImage(named: "reviewImage2")
            case 1 :
                cell.score.text = "별로"
                cell.scoreImage.image = UIImage(named: "reviewImage3")
            default :
                break
            }
            //((reviewDetailInfoList?.imgUrls.count) == 0 ) ? nil : cell.image.load(url: URL(string: (reviewDetailInfoList?.imgUrls[0]) ?? "")!)
           // print((reviewDetailInfoList?.imgUrls.count) ?? [])
            cell.reviewCount.text = "\((reviewDetailInfoList?.reviewCnt) ?? 0)"
            cell.followCount.text = "\((reviewDetailInfoList?.followCnt) ?? 0)"
            cell.isHolic.isHidden = reviewDetailInfoList?.isHolic == false
            cell.commentsCount.text = "\(reviewDetailInfoList?.comments.count ?? 0)"
            if likeList.count > indexPath.item {
                if likeList[indexPath.item] == 0 {
                    cell.likeImage.image = UIImage(named: "heart")
                    cell.likeImage.tintColor = .mainDarkGrayColor
                } else {
                    cell.likeImage.image = UIImage(named: "heart3")
                    cell.likeImage.tintColor = .mainOrangeColor
                }
            }
            return cell

        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentCell", for: indexPath) as! CommentCell
        cell.userName.text = reviewDetailInfoList?.comments[indexPath.item].userName
        cell.content.text = reviewDetailInfoList?.comments[indexPath.item].content
        cell.updatedAt.text = reviewDetailInfoList?.comments[indexPath.item].updated_at
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == reviewCollectionView {
            guard let cell = reviewCollectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as? NewsCell else { return .zero }
            cell.content.text = reviewDetailInfoList?.content
            cell.content.sizeToFit()
            let cellheight = cell.content.frame.height + cell.image.frame.height + 230
           
            return CGSize(width: reviewCollectionView.bounds.width, height: (cellheight))
        }
        return CGSize(width: reviewCollectionView.bounds.width-10, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == commentCollectionView {
            if reviewDetailInfoList?.comments[indexPath.item].userId == Constant.userIdx {
                commentId = (reviewDetailInfoList?.comments[indexPath.item].id)!
                guard let VC = self.storyboard?.instantiateViewController(identifier: "CommentPopupViewController") as? CommentPopupViewController else { return }
                VC.commentId = commentId
                VC.delegate = self
                VC.text = (self.reviewDetailInfoList?.comments[indexPath.item].content)!
                VC.modalPresentationStyle = .overCurrentContext
                self.present(VC, animated: false)
            }
        }
    }
    
}

extension ReviewDetailViewController {
    func reviewFetchData() {
        let url = AF.request("\(Constant.BASE_URL1)/reviews/\(id!)")
        url.responseJSON { (response) in
            switch response.result {
            case .success(let obj) :
                if let nsDiectionary = obj as? NSDictionary {
                    do {
                        let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                        let getInstanceData = try JSONDecoder().decode(ReviewDetail.self, from: dataJSON)
                        if let results = getInstanceData.result {
                            DispatchQueue.main.async {
                                self.reviewDetailInfoList = results
                                self.likeGetData(self.reviewDetailInfoList!.id)
                                self.reviewCollectionView.reloadData()
                                self.commentCollectionView.reloadData()
                            }
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                case .failure(_):
                    print("실패")
            }
        }
    }
    
    func likeGetData(_ id: Int) {
        let url = "\(Constant.BASE_URL2)/likes/\(id)"
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["X-ACCESS-TOKEN": "\(Constant.token)"])
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                switch response.result {
                case .success(let obj) :
                    if let nsDiectionary = obj as? NSDictionary {
                        self.isLike = nsDiectionary["result"] as! Int
                        self.likeList.append(self.isLike!)
                        print(self.likeList)
                        self.reviewCollectionView.reloadData()
                    }
                case .failure(_):
                    print("실패")
            }
        }
    }
    
    func likePostData(_ id: Int) {
        let header: HTTPHeaders = [ "Content-Type":"application/json", "X-ACCESS-TOKEN":"\(Constant.token)"]
        AF.request("\(Constant.BASE_URL2)/likes/\(id)", method: .post, parameters: "", encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseDecodable(of: Model.self) { response in
                switch response.result {
                case .success(let response):
                    if response.isSuccess, let result = response.result {
                        print("성공")
                    } else {
                        print("실패")
                    }
                case .failure(let error):
                    print(error.localizedDescription)

            }
        }
    }
    
    func likeDeleteData(_ id: Int) {
       let header: HTTPHeaders = [ "Content-Type":"application/json", "X-ACCESS-TOKEN":"\(Constant.token)"]
       AF.request("\(Constant.BASE_URL2)/likes/\(id)", method: .delete, parameters: "", encoder: JSONParameterEncoder(), headers: header)
           .validate()
           .responseDecodable(of: Model.self) { response in
               switch response.result {
               case .success(let response):
                   if response.isSuccess, let result = response.result {
                       print("성공")
                   } else {
                       print("실패")
                   }
               case .failure(let error):
                   print(error.localizedDescription)

               }
           }
    }
    
    func postComment(_ parameters: CommentPostInput) {
        let header: HTTPHeaders = [ "Content-Type":"application/json", "X-ACCESS-TOKEN":"\(Constant.token)"]
        AF.request("\(Constant.BASE_URL2)/comments", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .validate()
          //  .responseDecodable(of: Model.self) { response in
            .responseJSON { (response) in
                switch response.result {
                case .success(let response):
                    if let nsDiectionary = response as? NSDictionary {
                        var x = nsDiectionary["result"]
                        print(x!)
                        print("성공")
                        DispatchQueue.main.async {
                            self.reviewFetchData()
                            self.reviewCollectionView.reloadData()
                            self.commentCollectionView.reloadData()
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func putComment(_ parameters: CommentPutInput) {
        let header: HTTPHeaders = [ "Content-Type":"application/json", "X-ACCESS-TOKEN":"\(Constant.token)"]
        AF.request("\(Constant.BASE_URL2)/comments", method: .put, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .validate()
          //  .responseDecodable(of: Model.self) { response in
            .responseJSON { (response) in
                switch response.result {
                case .success(let response):
                    if let nsDiectionary = response as? NSDictionary {
                        
                        print("성공")
                        DispatchQueue.main.async {
                            self.reviewFetchData()
                            self.reviewCollectionView.reloadData()
                            self.commentCollectionView.reloadData()
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
}


extension UITextField {
    func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
    }
}
