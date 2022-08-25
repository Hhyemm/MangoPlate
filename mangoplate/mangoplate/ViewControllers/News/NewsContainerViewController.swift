
import UIKit
import Tabman
import Pageboy

class NewsContainerViewController: TabmanViewController {
    
    private var viewControllers: Array<UIViewController> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingTabBar()
      
    }
    
    func settingTabBar () {
        let firstVC = storyboard?.instantiateViewController(withIdentifier: "AllViewController")
        let secondVC = storyboard?.instantiateViewController(withIdentifier: "FollwingViewController")
        let thirdVC = storyboard?.instantiateViewController(withIdentifier: "HolicViewController")
    
        viewControllers.append(firstVC!)
        viewControllers.append(secondVC!)
        viewControllers.append(thirdVC!)
        
        self.dataSource = self
        
        let bar = TMBar.ButtonBar()
        
        bar.backgroundView.style = .blur(style: .light)
        bar.layout.contentInset = UIEdgeInsets(top: 5.0, left: 0.0, bottom: 5.0, right: 0.0)
        bar.layout.contentMode = .fit
        //bar.layout.interButtonSpacing = 135
        
        bar.buttons.customize { (button) in
            button.tintColor = .systemGray4
            button.selectedTintColor = .mainOrangeColor
            button.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            button.selectedFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
            
        }
        
        bar.indicator.weight = .custom(value: 3)
        bar.layout.alignment = .centerDistributed
        bar.indicator.tintColor = .mainOrangeColor
        addBar(bar, dataSource: self, at: .top)
    }
}

extension NewsContainerViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0 :
            return TMBarItem(title: "전체")
        case 1 :
            return TMBarItem(title: "팔로잉")
        default :
            return TMBarItem(title: "홀릭")
        }
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
        
    }
}
