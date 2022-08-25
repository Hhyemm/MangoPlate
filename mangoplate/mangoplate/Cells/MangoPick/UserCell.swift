
import UIKit

protocol ClickUserFollowDelegate: AnyObject {
    func clickFollowUser(userId: Int?)
}

class UserCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var followings: UILabel!
    @IBOutlet weak var followButtonView: UIView!
    @IBOutlet weak var plusImage: UIImageView!
    @IBOutlet weak var personImage: UIImageView!
    
    var userFollowDelegate: ClickUserFollowDelegate?
    var userId: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        followButtonView.layer.borderWidth = 1
        followButtonView.layer.borderColor = UIColor.mainOrangeColor.cgColor
        followButtonView.layer.cornerRadius = followButtonView.frame.height / 2
    }
    
    @IBAction func pressFollowButton(_ sender: UIButton) {
        userFollowDelegate?.clickFollowUser(userId: userId)
        profileImage.layer.borderWidth = 2
        profileImage.layer.borderColor = UIColor.mainOrangeColor.cgColor
        followButtonView.backgroundColor = .mainOrangeColor
        plusImage.tintColor = .white
        personImage.tintColor = .white
        plusImage.image = UIImage(systemName: "checkmark")
    }
}
