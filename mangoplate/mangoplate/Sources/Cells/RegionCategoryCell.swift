
import UIKit

class RegionCategoryCell: UICollectionViewCell {

    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var regionTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        indicatorView.isHidden = true
    }
    
    override var isSelected: Bool {
        didSet {
            regionTitleLabel.textColor = isSelected ?.mainOrangeColor : .mainLightGrayColor
            indicatorView.isHidden = isSelected ? false : true
        }
    }
}
