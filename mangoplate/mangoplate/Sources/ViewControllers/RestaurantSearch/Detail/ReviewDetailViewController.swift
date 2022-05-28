
import UIKit

class ReviewDetailViewController: UIViewController {

    @IBOutlet weak var reviewCollectionView: UICollectionView!
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var commentHeaderMessage: UIView!
    @IBOutlet weak var commentCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCollectionView()
        setDesign()
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
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == reviewCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentCell", for: indexPath) as! CommentCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == reviewCollectionView {
            return CGSize(width: reviewCollectionView.bounds.width, height: reviewCollectionView.bounds.height)
        }
        return CGSize(width: reviewCollectionView.bounds.width-10, height: 100)
    }
    
}
