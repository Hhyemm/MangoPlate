
import UIKit

protocol ClickWishDelegate: AnyObject {
    func clickWishButton(for index: Int, id: Int?)
}

class RestaurantCell: UICollectionViewCell {

    var delegate: ClickWishDelegate?
    var index: Int?
    var id: Int?
    var touch: Bool?
    
    @IBOutlet weak var resImage: UIImageView!
    @IBOutlet weak var resIndex: UILabel!
    @IBOutlet weak var resTitle: UILabel!
    @IBOutlet weak var resLoc: UILabel!
    @IBOutlet weak var resRead: UILabel!
    @IBOutlet weak var resReview: UILabel!
    @IBOutlet weak var resRate: UILabel!
    @IBOutlet weak var wishButton: UIButton!
    @IBOutlet weak var wishImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    @IBAction func presseStarButton(_ sender: UIButton) {
        guard let idx = index else { return }
        if sender.isSelected {
            isTouched = true
            delegate?.clickWishButton(for: idx, id:id)
        } else {
            isTouched = false
            delegate?.clickWishButton(for: idx, id:id)
        }
        sender.isSelected = !sender.isSelected
    }
    
    var isTouched: Bool? {
        didSet {
            if isTouched == true {
               // wishImage.tintColor = .clear
            } else {
               // wishImage.tintColor = .mainOrangeColor
            }
        }
    }
}
