
import UIKit

class TabBarViewController: UIViewController {

    @IBOutlet weak var restaurantSearchView: UIView!
    @IBOutlet weak var mangoPickView: UIView!
    @IBOutlet weak var newsView: UIView!
    @IBOutlet weak var myInfoView: UIView!
    
    @IBOutlet weak var restaurantSearchButton: UIButton!
    @IBOutlet weak var mangoPickButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var newsButton: UIButton!
    @IBOutlet weak var myInfoButton: UIButton!
    
    @IBOutlet weak var restaurantSearchImage: UIImageView!
    @IBOutlet weak var mangoPickImage: UIImageView!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var myInfoImage: UIImageView!
    
    @IBOutlet weak var restaurantSearchLabel: UILabel!
    @IBOutlet weak var mangoPickLabel: UILabel!
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var myInfoLabel: UILabel!
    
    @IBOutlet weak var animationView: UIView!
    
    @IBOutlet weak var containerView: UIView!
    
    var regionTitle = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pressTabBarItemButton(restaurantSearchImage, restaurantSearchLabel, restaurantSearchView)
        unPressTabBarItemButton(mangoPickImage, mangoPickLabel)
        unPressTabBarItemButton(newsImage, newsLabel)
        unPressTabBarItemButton(myInfoImage, myInfoLabel)
        
        animationView.backgroundColor = .mainOrangeColor
        presentViewController()
    }

    func pressTabBarItemButton(_ image: UIImageView, _ label: UILabel, _ aniView: UIView) {
        image.tintColor = .mainOrangeColor
        label.textColor = .mainOrangeColor
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping:0.5, initialSpringVelocity: 0.1) {
            self.animationView.frame = CGRect(x:aniView.frame.minX, y: aniView.frame.minY, width: aniView.frame.width, height: 3)
        }
    }
    
    func unPressTabBarItemButton(_ image: UIImageView, _ label: UILabel) {
        image.tintColor = .mainLightGrayColor
        label.textColor = .mainLightGrayColor
    }
    
    @IBAction func pressRestaurantSearchButton(_ sender: UIButton) {
        pressTabBarItemButton(restaurantSearchImage, restaurantSearchLabel, restaurantSearchView)
        unPressTabBarItemButton(mangoPickImage, mangoPickLabel)
        unPressTabBarItemButton(newsImage, newsLabel)
        unPressTabBarItemButton(myInfoImage, myInfoLabel)
        presentViewController()
        
    }
    
    @IBAction func pressMangoPickButton(_ sender: UIButton) {
        pressTabBarItemButton(mangoPickImage, mangoPickLabel, mangoPickView)
        unPressTabBarItemButton(restaurantSearchImage, restaurantSearchLabel)
        unPressTabBarItemButton(newsImage, newsLabel)
        unPressTabBarItemButton(myInfoImage, myInfoLabel)
    }
    
    @IBAction func pressPlusButton(_ sender: UIButton) {
        
    }
    
    @IBAction func pressNewsButton(_ sender: UIButton) {
        pressTabBarItemButton(newsImage, newsLabel, newsView)
        unPressTabBarItemButton(restaurantSearchImage, restaurantSearchLabel)
        unPressTabBarItemButton(mangoPickImage, mangoPickLabel)
        unPressTabBarItemButton(myInfoImage, myInfoLabel)
    }
    
    @IBAction func pressMyInfoButton(_ sender: UIButton) {
        pressTabBarItemButton(myInfoImage, myInfoLabel, myInfoView)
        unPressTabBarItemButton(restaurantSearchImage, restaurantSearchLabel)
        unPressTabBarItemButton(mangoPickImage, mangoPickLabel)
        unPressTabBarItemButton(newsImage, newsLabel)
    }
    
    func presentViewController() {
        guard let RSVC = self.storyboard?.instantiateViewController(identifier: "RestaurantSearchViewController") as? RestaurantSearchViewController else { return }
        self.addChild(RSVC)
        RSVC.view.frame = containerView.frame
        containerView.addSubview(RSVC.view)
        RSVC.regionTitle = regionTitle
        RSVC.didMove(toParent: self)
    }
}

extension UIColor {
    static let mainOrangeColor = UIColor(red: 238/255, green: 121/255, blue: 48/255, alpha: 1.0)
    static let mainDarkGrayColor = UIColor(red: 118/255, green: 118/255, blue: 118/255, alpha: 1.0)
    static let mainLightGrayColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1.0)
}

