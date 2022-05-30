
import UIKit

class ReviewCell: UICollectionViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var scoreImage: UIImageView!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var hashView: UIView!
    @IBOutlet weak var commentsCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImage.layer.cornerRadius = userImage.frame.width / 2
    }

}
