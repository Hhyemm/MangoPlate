
import UIKit

protocol SendDelegate: AnyObject {
    func send(title: String, tag: Int)
}

extension RestaurantSearchViewController: SendDelegate {
    func send(title: String, tag: Int) {
        self.sortTitleLabel.text = title
        sortTag = tag
    }
}


class RestaurantSearchViewController: UIViewController {

    var images = ["bannerImage1", "bannerImage2", "bannerImage3", "bannerImage4", "bannerImage5"]
    var sortTag = 1
    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var surroundView: UIView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var sortTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPageControl()
        filterView.layer.borderWidth = 1
        filterView.layer.borderColor = UIColor.mainDarkGrayColor.cgColor
        filterView.layer.cornerRadius = filterView.frame.height / 2
        
        surroundView.layer.cornerRadius = surroundView.frame.height / 2
    }
    
    @IBAction func pressSearchButton(_ sender: UIButton) {
        guard let SearchVC = self.storyboard?.instantiateViewController(identifier: "SearchViewController") as? SearchViewController else { return }
        SearchVC.modalPresentationStyle = .fullScreen
        self.present(SearchVC, animated: false, completion: nil)
    }
    
    func setPageControl() {
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .mainOrangeColor
        pageControl.pageIndicatorTintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        bannerImageView.image = UIImage(named: images[0])
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(responseToSwipeGesture(_ :)))
                swipeRight.direction = UISwipeGestureRecognizer.Direction.right
                self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(responseToSwipeGesture(_:)))
                swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
                self.view.addGestureRecognizer(swipeLeft)
    }
    
    @objc func responseToSwipeGesture(_ gesture: UISwipeGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
        switch swipeGesture.direction{
            case UISwipeGestureRecognizer.Direction.right:
            pageControl.currentPage -= 1
            bannerImageView.image = UIImage(named: images[pageControl.currentPage])
        case UISwipeGestureRecognizer.Direction.left:
            pageControl.currentPage += 1
            bannerImageView.image = UIImage(named: images[pageControl.currentPage])
            default:
                break
            }
        }
    }
    
    @IBAction func pageChanged(_ sender: UIPageControl) {
        bannerImageView.image = UIImage(named: images[pageControl.currentPage])
    }
    
    @IBAction func pressSortButton(_ sender: UIButton) {
        guard let SortVC = self.storyboard?.instantiateViewController(identifier: "SortViewController") as? SortViewController else { return }
        SortVC.modalPresentationStyle = .overCurrentContext
        SortVC.delegate = self
        SortVC.sortTag = sortTag
        self.present(SortVC, animated: false, completion: nil)
    }
    
    @IBAction func pressSurroundButton(_ sender: UIButton) {
        guard let SurroundVC = self.storyboard?.instantiateViewController(identifier: "SurroundViewController") as? SurroundViewController else { return }
        SurroundVC.modalPresentationStyle = .overCurrentContext
        self.present(SurroundVC, animated: false, completion: nil)
    }
    
    @IBAction func pressFilterButton(_ sender: UIButton) {
        guard let FilterVC = self.storyboard?.instantiateViewController(identifier: "FilterViewController") as? FilterViewController else { return }
        FilterVC.modalPresentationStyle = .overCurrentContext
        self.present(FilterVC, animated: false, completion: nil)
    }
    
}
