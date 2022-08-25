
import UIKit

protocol ClickLikeDelegate: AnyObject {
    func clickLikeButton(for index: Int, id: Int?)
}

protocol ClickUpdateDeleteDelegate: AnyObject {
    func clickUpdateDeleteButton(for index: Int, reviewId: Int?, userId: Int?)
}

class ReviewCell: UICollectionViewCell {
    
    var delegate: ClickLikeDelegate?
    var delegate2: ClickUpdateDeleteDelegate?
    var index: Int?
    var reviewId: Int?
    var userId: Int?
    var touch: Bool?

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var scoreImage: UIImageView!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var commentsCount: UILabel!
    @IBOutlet weak var reviewCount: UILabel!
    @IBOutlet weak var followCount: UILabel!
    @IBOutlet weak var updatedAt: UILabel!
    @IBOutlet weak var isHolic: UIView!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var updateDeleteImage: UIImageView!
    @IBOutlet weak var updateDeleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImage.layer.cornerRadius = userImage.frame.width / 2
        
    }
    
    @IBAction func pressLikeButton(_ sender: UIButton) {
        guard let idx = index else { return }
        if sender.isSelected {
            delegate?.clickLikeButton(for: idx, id:reviewId)
        } else {
            delegate?.clickLikeButton(for: idx, id:reviewId)
        }
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func PressUpdateAndDeleteButton(_ sender: UIButton) {
        guard let idx = index else { return }
        if sender.isSelected {
            delegate2?.clickUpdateDeleteButton(for: idx, reviewId: reviewId, userId: userId)
        } else {
            delegate2?.clickUpdateDeleteButton(for: idx, reviewId: reviewId, userId: userId)
        }
        sender.isSelected = !sender.isSelected
    }
}
