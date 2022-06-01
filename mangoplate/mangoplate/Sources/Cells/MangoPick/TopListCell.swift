
import UIKit

class TopListCell: UITableViewCell {

    @IBOutlet weak var contentVidw: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentVidw.layer.borderWidth = 1
        contentVidw.layer.borderColor = UIColor.mainLightGrayColor.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0))
    }
    
}
