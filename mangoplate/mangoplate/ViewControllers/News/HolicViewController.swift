
import UIKit
import Alamofire

class HolicViewController: UIViewController, ClickUserDelegate {

    @IBOutlet weak var select5View: UIView!
    @IBOutlet weak var select3View: UIView!
    @IBOutlet weak var select1View: UIView!
    
    @IBOutlet weak var select5Label: UILabel!
    @IBOutlet weak var select3Label: UILabel!
    @IBOutlet weak var select1Label: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataService = MangoPickDataService()
    var holicList: [HolicResult]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewDesign(select5View)
        setViewDesign(select3View)
        setViewDesign(select1View)
        pressSelectButton(select5View, select5Label)
        pressSelectButton(select3View, select3Label)
        pressSelectButton(select1View, select1Label)
        
        setCollectionVieW()
        
        dataService.fetchGetHolicData(self)
    }
    
    func clickUser(for index: Int, userId: Int?, userName: String?) {
        guard let VC = self.storyboard?.instantiateViewController(identifier: "UserViewController") as? UserViewController else { return }
        VC.userId = userId
        VC.userName = userName
        VC.modalPresentationStyle = .fullScreen
        self.present(VC, animated: false)
    }
    
    func setViewDesign(_ selectView: UIView) {
        selectView.layer.borderWidth = 1
        selectView.layer.cornerRadius = selectView.frame.height / 2
    }
    
    func pressSelectButton(_ selectView: UIView, _ selectLabel: UILabel) {
        selectView.layer.borderColor = UIColor.mainOrangeColor.cgColor
        selectLabel.textColor = .mainOrangeColor
    }
    
    func upPressSelectButton(_ selectView: UIView, _ selectLabel: UILabel) {
        selectView.layer.borderColor = UIColor.mainLightGrayColor.cgColor
        selectLabel.textColor = .mainLightGrayColor
        
    }
    
    func setCollectionVieW() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "HolicCell", bundle: nil), forCellWithReuseIdentifier: "HolicCell")
        collectionView.register(UINib(nibName: "NewsCell", bundle: nil), forCellWithReuseIdentifier: "NewsCell")
    }
}

extension HolicViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 + (holicList?.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HolicCell", for: indexPath) as! HolicCell
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as! NewsCell
        cell.userDelegate = self
        cell.index = indexPath.row
        cell.userId = holicList?[indexPath.item-1].userId
        cell.name = holicList?[indexPath.item-1].userName
        if holicList?[indexPath.item-1].profileImgUrl != nil {
            let url = URL(string: holicList?[indexPath.item-1].profileImgUrl ?? "")!
            cell.userImage.load(url: url)
        }
        cell.userName.text = holicList?[indexPath.item-1].userName
        cell.reviewCount.text = "\(holicList?[indexPath.item-1].reviewCnt ?? 0)"
        cell.followCount.text = "\(holicList?[indexPath.item-1].followCnt ?? 0)"
        switch holicList?[indexPath.item-1].score {
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
        cell.resName.text = holicList?[indexPath.item-1].restaurantName
        cell.content.text = holicList?[indexPath.item-1].content
        if holicList?[indexPath.item-1].imgUrls ?? [] != [] {
            let url = URL(string: (holicList?[indexPath.item-1].imgUrls![0])!)!
            cell.image.load(url: url)
        }
        cell.updatedAt.text = holicList?[indexPath.item-1].updatedAt
        cell.isHolic.isHidden = holicList?[indexPath.item-1].isHolic == 0
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: collectionView.frame.width, height: 55)
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as? NewsCell else {
                return .zero }
        return CGSize(width: collectionView.frame.width, height: cell.content.frame.height + 270)
    }
}

extension HolicViewController {
    func didSuccessGetHolicData(_ results:[HolicResult]) {
        DispatchQueue.main.async {
            self.holicList = results
            self.collectionView.reloadData()
        }
    }
}
