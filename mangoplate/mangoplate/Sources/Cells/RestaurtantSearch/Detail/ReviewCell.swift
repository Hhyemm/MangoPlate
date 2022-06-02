
import UIKit

protocol ClickLikeDelegate: AnyObject {
    func clickLikeButton(for index: Int, id: Int?)
}

protocol ClickUpdateDeleteDelegate: AnyObject {
    func clickUpdateDeleteButton(for index: Int, id: Int?)
}

class ReviewCell: UICollectionViewCell {
    
    var delegate: ClickLikeDelegate?
    var delegate2: ClickUpdateDeleteDelegate?
    var index: Int?
    var id: Int?
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
           // isTouched = true
            delegate?.clickLikeButton(for: idx, id:id)
        } else {
           // isTouched = false
            delegate?.clickLikeButton(for: idx, id:id)
        }
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func PressUpdateAndDeleteButton(_ sender: UIButton) {
        guard let idx = index else { return }
        if sender.isSelected {
           // isTouched = true
            delegate2?.clickUpdateDeleteButton(for: idx, id:id)
        } else {
           // isTouched = false
            delegate2?.clickUpdateDeleteButton(for: idx, id:id)
        }
        sender.isSelected = !sender.isSelected
    }
}
