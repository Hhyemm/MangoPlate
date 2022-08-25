
import UIKit

class NewsCell: UICollectionViewCell {
    
    @IBOutlet weak var resName: UILabel!
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
    var userDelegate: ClickUserDelegate?
    var index: Int?
    var id: Int?
    var touch: Bool?
    var userId: Int?
    var name: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImage.layer.cornerRadius = userImage.frame.width / 2
    }
    
    override func prepareForReuse() {
        image.image = nil
        content.text = nil
    }
    
    @IBAction func pressLikeButton(_ sender: UIButton) {
        guard let idx = index else { return }
        if sender.isSelected {
            delegate?.clickLikeButton(for: idx, id:id)
        } else {
            delegate?.clickLikeButton(for: idx, id:id)
        }
        sender.isSelected = !sender.isSelected
    }
    
    func sizeFittingWith(cellHeight: CGFloat, text: String) -> CGSize {
        content.text = text
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: cellHeight)

        return self.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required)
    }
    
    @IBAction func pressUserButton(_ sender: UIButton) {
        guard let idx = index else { return }
        userDelegate?.clickUser(for: idx, userId: userId, userName: name)
    }
}

protocol ClickUserDelegate: AnyObject {
    func clickUser(for index: Int, userId: Int?, userName: String?)
}

protocol ClickLikeDelegate2: AnyObject {
    func clickLikeButton(for index: Int, id: Int?)
}
