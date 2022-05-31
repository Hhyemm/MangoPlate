
import UIKit

class ReviewImageSelectCell: UICollectionViewCell {
    
    @IBOutlet weak var countView: UIView!
    @IBOutlet weak var selectView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var count: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        countView.layer.cornerRadius = countView.frame.width / 2
        
        selectView.isHidden = true
        countView.isHidden = true
    }
    
}
