
import UIKit
import Tabman
import Pageboy

class MangoPickViewController: TabmanViewController {

    private var viewControllers: Array<UIViewController> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingTabBar()
    }
    
    func settingTabBar () {
        let firstVC = storyboard?.instantiateViewController(withIdentifier: "EatDealViewController")
        let secondVC = storyboard?.instantiateViewController(withIdentifier: "StroyViewController")
        let thirdVC = storyboard?.instantiateViewController(withIdentifier: "TopListViewController")
        
        viewControllers.append(firstVC!)
        viewControllers.append(secondVC!)
        viewControllers.append(thirdVC!)
        
        self.dataSource = self
        
        let bar = TMBar.ButtonBar()
        
        bar.backgroundView.style = .blur(style: .light)
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 10.0, right: 0.0)
        bar.layout.contentMode = .fit
        //bar.layout.interButtonSpacing = 135
        
        bar.buttons.customize { (button) in
            button.tintColor = .systemGray4
            button.selectedTintColor = .mainOrangeColor
            button.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
            button.selectedFont = UIFont.systemFont(ofSize: 18, weight: .bold)
        }
        
        bar.indicator.weight = .custom(value: 4)
        bar.layout.alignment = .centerDistributed
        bar.indicator.tintColor = .mainOrangeColor
        addBar(bar, dataSource: self, at: .top)
    }
}

extension MangoPickViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0 :
            return TMBarItem(title: "EAT딜")
        case 1 :
            return TMBarItem(title: "스토리")
        default :
            return TMBarItem(title: "TOP리스트")
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
