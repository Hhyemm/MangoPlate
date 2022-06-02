
import UIKit
import Alamofire

extension ReviewDetailViewController: ClickLikeDelegate2 {
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
}

class ReviewDetailViewController: UIViewController {

    @IBOutlet weak var reviewCollectionView: UICollectionView!
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var commentHeaderMessage: UIView!
    @IBOutlet weak var commentCollectionView: UICollectionView!
    
    var reviewDetailInfoList: ReviewDetailInfo!
    var id: Int?
    var likeList = [Int]()
    var isLike: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCollectionView()
        setDesign()
        fetchData()
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
            print(likeList)
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
    
}

extension ReviewDetailViewController {
    func fetchData() {
        let url = AF.request("\(Constant.BASE_URL1)/reviews/\(id!)")
        url.responseJSON { (response) in
            switch response.result {
            case .success(let obj) :
                if let nsDiectionary = obj as? NSDictionary {
                    do {
                        let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                        let getInstanceData = try JSONDecoder().decode(ReviewDetail.self, from: dataJSON)
                        if let results = getInstanceData.result {
                            self.reviewDetailInfoList = results
                            
                            self.likeGetData(self.reviewDetailInfoList!.id)
                            
                            self.reviewCollectionView.reloadData()
                            self.commentCollectionView.reloadData()
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
}
