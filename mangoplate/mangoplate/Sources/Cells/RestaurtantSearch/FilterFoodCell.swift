
import UIKit

class FilterFoodCell: UICollectionViewCell {

    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var foodView: UIView!
    @IBOutlet weak var checkView: UIView!
    @IBOutlet weak var checkImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        foodView.layer.borderWidth = 2
        foodView.layer.borderColor =  UIColor.mainLightGrayColor.cgColor
        foodView.layer.cornerRadius = foodView.frame.width / 2
        checkView.isHidden = true
        checkImageView.isHidden = true
    }
    /*
    override var isSelected: Bool {
        didSet {
            foodView.layer.borderColor = isSelected ? UIColor.mainOrangeColor.cgColor : UIColor.mainLightGrayColor.cgColor
            foodLabel.textColor = isSelected ? .mainOrangeColor : .mainLightGrayColor
            foodImageView.tintColor = isSelected ? .mainOrangeColor : .mainLightGrayColor
            checkView.isHidden = !isSelected
            checkImageView.isHidden = !isSelected
        }
    }*/
}
