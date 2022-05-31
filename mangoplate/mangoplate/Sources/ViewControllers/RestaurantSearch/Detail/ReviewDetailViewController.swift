
import UIKit
import Alamofire

class ReviewDetailViewController: UIViewController, SendHashDelegate {

    @IBOutlet weak var reviewCollectionView: UICollectionView!
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var commentHeaderMessage: UIView!
    @IBOutlet weak var commentCollectionView: UICollectionView!
    
    var reviewDetailInfoList: ReviewDetailInfo!
    var id: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCollectionView()
        setDesign()
        fetchData()
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
        
        reviewCollectionView.register(UINib(nibName: "ReviewCell", bundle: nil), forCellWithReuseIdentifier: "ReviewCell")
        
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
            cell.userName.text = reviewDetailInfoList?.userName ?? ""
            (reviewDetailInfoList?.profileImgUrl) == nil ? cell.userImage.image = UIImage(named: "testImage2") : cell.userImage.load(url: URL(string: (reviewDetailInfoList?.profileImgUrl) as! String )!)
            
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
            cell.resName.text = reviewDetailInfoList?.restaurantName ?? ""
            //((reviewDetailInfoList?.imgUrls.count) == 0 ) ? nil : cell.image.load(url: URL(string: (reviewDetailInfoList?.imgUrls[0]) ?? "")!)
           // print((reviewDetailInfoList?.imgUrls.count) ?? [])
            cell.reviewCount.text = "\((reviewDetailInfoList?.reviewCnt) ?? 0)개"
            cell.followCount.text = "\((reviewDetailInfoList?.followCnt) ?? 0)개"
            cell.delegate = self
            return cell

        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentCell", for: indexPath) as! CommentCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == reviewCollectionView {
            return CGSize(width: reviewCollectionView.bounds.width, height: 300)
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
                            self.reviewCollectionView.reloadData()
                            self.commentCollectionView.reloadData()
                            //print(self.reviewDetailInfoList!)
    
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
}
