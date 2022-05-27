
import UIKit

class SortViewController: UIViewController {

    @IBOutlet weak var rateSortView: UIView!
    @IBOutlet weak var rateSortLabel: UILabel!
    
    @IBOutlet weak var recommendSortView: UIView!
    @IBOutlet weak var recommendSortLabel: UILabel!
    
    @IBOutlet weak var reviewSortView: UIView!
    @IBOutlet weak var reviewSortLabel: UILabel!
    
    @IBOutlet weak var distanceSortView: UIView!
    @IBOutlet weak var distanceSortLabel: UILabel!
    
    weak var delegate: SendDelegate?
    var sortTag = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSortButton(sortTag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.2)
    }
    
    @IBAction func pressDismissButton(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func pressSortButton(_ sortView: UIView, _ sortLabel: UILabel) {
        sortView.layer.borderWidth = 2
        sortView.layer.borderColor = UIColor.mainOrangeColor.cgColor
        sortView.layer.cornerRadius = sortView.frame.height / 2
        sortLabel.textColor = .mainOrangeColor
    }
    
    func unPressSortButton(_ sortView: UIView, _ sortLabel: UILabel) {
        sortView.layer.borderWidth = 0
        sortLabel.textColor = .lightGray
    }
    
    func setSortButton(_ tag: Int) {
        unPressSortButton(rateSortView, rateSortLabel)
        unPressSortButton(recommendSortView, recommendSortLabel)
        unPressSortButton(reviewSortView, reviewSortLabel)
        unPressSortButton(distanceSortView, distanceSortLabel)
        switch tag {
        case 1 :
            pressSortButton(rateSortView, rateSortLabel)
            self.delegate?.send(title: rateSortLabel.text ?? "", tag: 1)
        case 2 :
            pressSortButton(recommendSortView, recommendSortLabel)
            self.delegate?.send(title: recommendSortLabel.text ?? "", tag: 2)
        case 3 :
            pressSortButton(reviewSortView, reviewSortLabel)
            self.delegate?.send(title: reviewSortLabel.text ?? "", tag: 3)
        case 4 :
            pressSortButton(distanceSortView, distanceSortLabel)
            self.delegate?.send(title: distanceSortLabel.text ?? "", tag: 4)
        default:
            break
        }
        view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressRateSortButton(_ sender: UIButton) {
        setSortButton(sender.tag)
    }
    
    @IBAction func pressRecommendSortButton(_ sender: UIButton) {
        setSortButton(sender.tag)
    }
    
    @IBAction func pressReviewSortButton(_ sender: UIButton) {
        setSortButton(sender.tag)
    }
    
    @IBAction func pressDistanceSortButton(_ sender: UIButton) {
        setSortButton(sender.tag)
    }
    
    
}
