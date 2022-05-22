
import UIKit
import Tabman
import Pageboy

class RegionSelectContainerViewController: TabmanViewController, sendPressIndex {
    
    @IBOutlet weak var applyButton: UIButton!
    private var viewControllers: Array<UIViewController> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        applyButton.layer.cornerRadius = applyButton.frame.height / 2
        settingTabBar()
    }
    
    func pressIndexCell(isPress: Bool) {
        applyButton.backgroundColor = .mainOrangeColor
    }
    
    func settingTabBar() {
        let firstVC = storyboard?.instantiateViewController(withIdentifier: "RegionSelectItem1ViewController")
        let secondVC = storyboard?.instantiateViewController(withIdentifier: "RegionSelectItem2ViewController")
        let thirdVC = storyboard?.instantiateViewController(withIdentifier: "RegionSelectItem3ViewController")
        let fourthVC = storyboard?.instantiateViewController(withIdentifier: "RegionSelectItem4ViewController")
        
        viewControllers.append(firstVC!)
        viewControllers.append(secondVC!)
        viewControllers.append(thirdVC!)
        viewControllers.append(fourthVC!)
        
        self.dataSource = self
        
        let bar = TMBar.TabBar()
        
        bar.backgroundView.style = .blur(style: .light)
        bar.layout.contentInset = UIEdgeInsets(top: -22, left: 0, bottom: 0, right: 0)
        bar.buttons.customize { (button) in
            button.tintColor = .systemGray4
            button.selectedTintColor = .mainOrangeColor
            button.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        }
    
        bar.layout.alignment = .centerDistributed
        bar.indicator.tintColor = .black
        addBar(bar, dataSource: self, at: .top)
    }
    
    @IBAction func pressApplyButton(_ sender: UIButton) {
    }
    
}


extension RegionSelectContainerViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0 :
            let item = TMBarItem(title: "인기지역")
            return item
        case 1 :
            return TMBarItem(title: "서울-강남")
        case 2 :
            return TMBarItem(title: "서울-강북")
        default:
            return TMBarItem(title: "경기도")
        }
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        let firstVC = storyboard?.instantiateViewController(withIdentifier: "RegionSelectItem1ViewController") as! RegionSelectItem1ViewController
        firstVC.delegate = self
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}
