
import UIKit

protocol SendHashDelegate: AnyObject {
    func pressHashButton()
}

class ReviewCell: UICollectionViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var scoreImage: UIImageView!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var hashView: UIView!
    @IBOutlet weak var commentsCount: UILabel!
    @IBOutlet weak var reviewCount: UILabel!
    @IBOutlet weak var followCount: UILabel!
    @IBOutlet weak var updatedAt: UILabel!
    @IBOutlet weak var resName: UILabel!
    
    var delegate: SendHashDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImage.layer.cornerRadius = userImage.frame.width / 2
    }

    @IBAction func pressResButton(_ sender: UIButton) {
        delegate?.pressHashButton()
    }
}
