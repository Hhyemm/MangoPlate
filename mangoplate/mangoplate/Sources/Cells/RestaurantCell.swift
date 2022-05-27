
import UIKit

protocol ClickStarDelegate: AnyObject {
    func clickStarButton(for index: Int, like: Bool)
}

class RestaurantCell: UICollectionViewCell {

    var delegate: ClickStarDelegate?
    var index: Int?
    
    @IBOutlet weak var resImage: UIImageView!
    @IBOutlet weak var resIndex: UILabel!
    @IBOutlet weak var resTitle: UILabel!
    @IBOutlet weak var resLoc: UILabel!
    @IBOutlet weak var resRead: UILabel!
    @IBOutlet weak var resReview: UILabel!
    @IBOutlet weak var resRate: UILabel!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var starImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    @IBAction func presseStarButton(_ sender: UIButton) {
        guard let idx = index else { return }
        if sender.isSelected {
            isTouched = true
            delegate?.clickStarButton(for: idx, like: true)
        } else {
            isTouched = false
            delegate?.clickStarButton(for: idx, like: false)
        }
        sender.isSelected = !sender.isSelected
    }
    
    var isTouched: Bool? {
        didSet {
            if isTouched == true {
                starImage.tintColor = .clear
            } else {
                starImage.tintColor = .mainOrangeColor
            }
        }
    }
}
