
import UIKit

class EatDealCell: UITableViewCell {

    @IBOutlet weak var discountView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        discountView.layer.cornerRadius = 5
        discountView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
