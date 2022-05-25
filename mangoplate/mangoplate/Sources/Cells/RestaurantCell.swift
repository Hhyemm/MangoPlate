
import UIKit

class RestaurantCell: UICollectionViewCell {

    @IBOutlet weak var resImage: UIImageView!
    @IBOutlet weak var resIndex: UILabel!
    @IBOutlet weak var resTitle: UILabel!
    @IBOutlet weak var resLoc: UILabel!
    @IBOutlet weak var resRead: UILabel!
    @IBOutlet weak var resReview: UILabel!
    @IBOutlet weak var resRate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
