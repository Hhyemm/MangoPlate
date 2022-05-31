
import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var updateView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        updateView.layer.borderWidth = 1
        updateView.layer.borderColor = UIColor.mainLightGrayColor.cgColor
        updateView.layer.cornerRadius = updateView.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
