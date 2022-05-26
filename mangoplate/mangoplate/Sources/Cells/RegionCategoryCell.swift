
import UIKit

class RegionCategoryCell: UICollectionViewCell {

    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var regionTitleLabel: UILabel!
    @IBOutlet weak var countView: UIView!
    @IBOutlet weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        indicatorView.isHidden = true
        countView.layer.cornerRadius = countView.frame.height / 2
        countView.isHidden = true
    }
    
    override var isSelected: Bool {
        didSet {
            regionTitleLabel.textColor = isSelected ?.mainOrangeColor : .mainLightGrayColor
            indicatorView.isHidden = isSelected ? false : true
        }
    }
}
