
import UIKit
import Alamofire


class ReviewDetailViewController: UIViewController {

    @IBOutlet weak var reviewCollectionView: UICollectionView!
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var commentHeaderMessage: UIView!
    @IBOutlet weak var commentCollectionView: UICollectionView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendButtonImage: UIImageView!
    @IBOutlet weak var updateView: UIView!
    
    let dataService = ReviewDetailDataService()
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
        dataService.fetchGetReviewData(delegate: self, id: id!)
    }
    
    func pressHashButton() {
        guard let VC = storyboard?.instantiateViewController(withIdentifier: "RestaurantDetailViewController") as? RestaurantDetailViewController else { return }
        VC.modalPresentationStyle = .fullScreen
        VC.id = reviewDetailInfoList?.restaurantId
        self.present(VC, animated: false, completion: nil)
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
            dataService.fetchPutCommentData(delegate: self, input, id: id!)
            
        } else {
            let input = CommentPostInput(reviewId: id!, comment: textField.text!)
            textField.text = ""
            dataService.fetchPostCommentData(delegate: self, input, id: id!)
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
    func didSuccessReviewGetData(_ results: ReviewDetailInfo) {
        DispatchQueue.main.async {
            self.reviewDetailInfoList = results
            self.dataService.fetchGetLikeData(delegate: self, id: self.reviewDetailInfoList!.id)
            self.reviewCollectionView.reloadData()
            self.commentCollectionView.reloadData()
        }
    }
    
    func didSuccessLikeGetData(_ results: Int) {
        self.likeList.append(self.isLike!)
        print(self.likeList)
        self.reviewCollectionView.reloadData()
    }
    
    func didSuccessCommentPostData() {
        DispatchQueue.main.async {
            self.dataService.fetchGetReviewData(delegate: self, id: self.id!)
            self.reviewCollectionView.reloadData()
            self.commentCollectionView.reloadData()
        }
    }
    
    func didSuccessCommentPutData() {
        DispatchQueue.main.async {
            self.dataService.fetchGetReviewData(delegate: self, id: self.id!)
            self.reviewCollectionView.reloadData()
            self.commentCollectionView.reloadData()
        }
    }
}

protocol sendUpdateDelegate: AnyObject {
    func send(now: String, text: String)
}

extension ReviewDetailViewController: ClickLikeDelegate2, sendUpdateDelegate {
    func clickLikeButton(for index: Int, id: Int?) {
        if likeList[index] == 1 {
            print("like 취소")
            dataService.fetchDeleteLikeData(delegate: self, id: id!)
            likeList[index] = 0
            reviewCollectionView.reloadData()
        } else {
            print("like")
            dataService.fetchPostLikeData(delegate: self, id: id!)
            likeList[index] = 1
            reviewCollectionView.reloadData()
        }
    }
    
    func send(now: String, text: String) {
        dataService.fetchGetReviewData(delegate: self, id: id!)
        isNow = now
        if isNow == "update" {
            updateView.isHidden = false
            self.textField.text = text
        }
    }
}
