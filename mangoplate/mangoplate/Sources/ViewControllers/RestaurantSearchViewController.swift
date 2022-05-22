
import UIKit

class RestaurantSearchViewController: UIViewController {

    var images = ["bannerImage1", "bannerImage2", "bannerImage3", "bannerImage4", "bannerImage5"]
    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPageControl()
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
}
