
import UIKit

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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImage.layer.cornerRadius = userImage.frame.width / 2
    }
}
