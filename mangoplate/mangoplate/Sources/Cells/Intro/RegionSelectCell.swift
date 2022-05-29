
import UIKit

class RegionSelectCell: UICollectionViewCell {
    
    @IBOutlet weak var regionName: UILabel!
    @IBOutlet weak var regionView: UIView!
    @IBOutlet weak var checkView: UIView!
    @IBOutlet weak var checkImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        regionView.layer.borderWidth = 2
        regionView.layer.borderColor = UIColor.mainLightGrayColor.cgColor
        regionView.layer.cornerRadius = 25
        
        checkView.isHidden = true
        checkImage.isHidden = true
    }
}
