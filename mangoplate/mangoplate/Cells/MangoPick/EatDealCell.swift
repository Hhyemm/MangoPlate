
import UIKit

class EatDealCell: UITableViewCell {

    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var discountPrice: UILabel!
    @IBOutlet weak var discountView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var menu: UILabel!
    @IBOutlet weak var loc: UILabel!
    @IBOutlet weak var resImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        discountView.layer.cornerRadius = 5
        discountView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
