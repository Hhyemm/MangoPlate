
import UIKit

protocol ClickLikeDelegate2: AnyObject {
    func clickLikeButton(for index: Int, id: Int?)
}

class NewsCell: UICollectionViewCell {
    
    
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
    
    var delegate: ClickLikeDelegate2?
    var index: Int?
    var id: Int?
    var touch: Bool?
    
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
}
