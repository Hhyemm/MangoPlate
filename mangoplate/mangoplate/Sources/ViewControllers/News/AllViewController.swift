
import UIKit
import Alamofire

class AllViewController: UIViewController {

    @IBOutlet weak var select5View: UIView!
    @IBOutlet weak var select3View: UIView!
    @IBOutlet weak var select1View: UIView!
    
    @IBOutlet weak var select5Label: UILabel!
    @IBOutlet weak var select3Label: UILabel!
    @IBOutlet weak var select1Label: UILabel!
    
    @IBOutlet weak var select5Image: UIImageView!
    @IBOutlet weak var select3Image: UIImageView!
    @IBOutlet weak var select1Image: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selects = [5:true, 3:true, 1:true]
    
    var todayReveiw: TodayReviewResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setViewDesign(select5View)
        setViewDesign(select3View)
        setViewDesign(select1View)
        pressSelectButton(select5View, select5Label)
        pressSelectButton(select3View, select3Label)
        pressSelectButton(select1View, select1Label)
        
        setCollectionVieW()
        
        fetchData()
    }
    
    func setViewDesign(_ selectView: UIView) {
        selectView.layer.borderWidth = 1
        selectView.layer.cornerRadius = selectView.frame.height / 2
    }
    
    func setSelect(_ tag: Int) {
        switch tag {
        case 5:
            if selects[tag]! {
                if selects.values.filter{$0}.count == 1 {
                    alartMessage()
                    break
                }
                unPressSelectButton(select5View, select5Label)
                select5Image.image = UIImage(named: "reviewImage11")
            } else {
                pressSelectButton(select5View, select5Label)
                select5Image.image = UIImage(named: "reviewImage1")
            }
        case 3:
            if selects[tag]! {
                if selects.values.filter{$0}.count == 1 {
                    alartMessage()
                    break
                }
                unPressSelectButton(select3View, select3Label)
                select3Image.image = UIImage(named: "reviewImage22")
                
            } else {
                pressSelectButton(select3View, select3Label)
                select3Image.image = UIImage(named: "reviewImage2")
            }
        case 1:
            if selects[tag]! {
                if selects.values.filter{$0}.count == 1 {
                    alartMessage()
                    break
                }
                unPressSelectButton(select1View, select1Label)
                select1Image.image = UIImage(named: "reviewImage33")
                
            } else {
                pressSelectButton(select1View, select1Label)
                select1Image.image = UIImage(named: "reviewImage3")
            }
        default :
            break
        }
        selects[tag]! = !selects[tag]!
    }
    
    func pressSelectButton(_ selectView: UIView, _ selectLabel: UILabel) {
        selectView.layer.borderColor = UIColor.mainOrangeColor.cgColor
        selectLabel.textColor = .mainOrangeColor
    }
    
    func unPressSelectButton(_ selectView: UIView, _ selectLabel: UILabel) {
  
        selectView.layer.borderColor = UIColor.mainLightGrayColor.cgColor
        selectLabel.textColor = .mainLightGrayColor
    }
    
    @IBAction func pressSelect5Button(_ sender: UIButton) {
        setSelect(sender.tag)
        
    }
    
    @IBAction func pressSelect3Button(_ sender: UIButton) {
        setSelect(sender.tag)
    }
    
    @IBAction func pressSelect1Button(_ sender: UIButton) {
        setSelect(sender.tag)
    }
    
    
    func setCollectionVieW() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "NewsCell", bundle: nil), forCellWithReuseIdentifier: "NewsCell")
        collectionView.register(UINib(nibName: "TodayReviewCell", bundle: nil), forCellWithReuseIdentifier: "TodayReviewCell")
    }
    
    func alartMessage() {
        guard let VC = storyboard?.instantiateViewController(withIdentifier: "ClearViewController") as? ClearViewController else { return }
        VC.modalPresentationStyle = .overCurrentContext
        self.present(VC, animated: false, completion: nil)
    }
}

extension AllViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayReviewCell", for: indexPath) as! TodayReviewCell
            cell.userName.text = todayReveiw?.userName
            (todayReveiw?.profileImgUrl) == nil ? cell.userImage.image = UIImage(named: "testImage2") : cell.userImage.load(url: URL(string: (todayReveiw?.profileImgUrl ?? ""))!)
            cell.content.text = todayReveiw?.content
            switch todayReveiw?.score ?? 0  {
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
            cell.resName.text = todayReveiw?.restaurantName
            (todayReveiw?.imgUrls?[0]) == nil ? cell.image.image = UIImage(named: "testImage2") : cell.image.load(url: URL(string: (todayReveiw?.imgUrls?[0] ?? ""))!)
            cell.reviewCount.text = "\(todayReveiw?.reviewCnt ?? 0)"
            cell.followCount.text = "\(todayReveiw?.followCnt ?? 0)"
            cell.isHolic.isHidden = todayReveiw?.isHolic ?? 0 == 0
            cell.updatedAt.text = todayReveiw?.updatedAt
            if todayReveiw?.wish ?? 0 == 1 {
                cell.wishImage.image = UIImage(named: "star3")
                cell.image.tintColor = .mainOrangeColor
            } else {
                cell.wishImage.image = UIImage(named: "star")
                cell.image.tintColor = .mainDarkGrayColor
            }
            if todayReveiw?.like ?? 0 == 1 {
                cell.likeImage.image = UIImage(named: "heart3")
                cell.image.tintColor = .red
            } else {
                cell.likeImage.image = UIImage(named: "heart")
                cell.image.tintColor = .mainDarkGrayColor
            }
            cell.likeCount.text = "\(todayReveiw?.reviewLikeCnt ?? 0)"
            cell.commentsCount.text = "\(todayReveiw?.reviewCommentCnt ?? 0)"
            
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as! NewsCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayReviewCell", for: indexPath) as? TodayReviewCell else {
                                return .zero }
                         
            cell.content.text = todayReveiw?.content
            cell.content.sizeToFit()
            let cellheight = cell.content.frame.height + cell.image.frame.height + 300
            return CGSize(width: collectionView.frame.width, height: cellheight)
        }
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/1.3)
    }
}

extension AllViewController {
    func fetchData() {
            let url = "\(Constant.BASE_URL2)/reviews/today"
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
                            do {
                                let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                                let getInstanceData = try JSONDecoder().decode(TodayReview.self, from: dataJSON)
                                if let results = getInstanceData.result {
                                    self.todayReveiw = results
                                    self.collectionView.reloadData()
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
