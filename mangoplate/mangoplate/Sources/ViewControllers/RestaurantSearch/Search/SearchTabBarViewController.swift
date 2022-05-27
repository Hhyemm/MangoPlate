
import UIKit
import Tabman
import Pageboy

class SearchTabBarViewController: TabmanViewController {

    private var viewControllers: Array<UIViewController> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingTabBar()
    }
    
    func settingTabBar() {
        let firstVC = storyboard?.instantiateViewController(withIdentifier: "RecommendSearchViewController")
        let secondVC = storyboard?.instantiateViewController(withIdentifier: "RecentSearchViewController")
        let thirdVC = storyboard?.instantiateViewController(withIdentifier: "FriendSearchViewController")
        
        viewControllers.append(firstVC!)
        viewControllers.append(secondVC!)
        viewControllers.append(thirdVC!)
        
        self.dataSource = self
        
        let bar = TMBar.ButtonBar()
                
        bar.backgroundView.style = .blur(style: .light)
        bar.layout.contentInset = UIEdgeInsets(top: 10.0, left: 0.0, bottom: 15.0, right: 0.0)
        
        bar.layout.transitionStyle = .snap
        bar.layout.interButtonSpacing = 22
        
        bar.buttons.customize { (button) in
            button.tintColor = .systemGray2
            button.selectedTintColor = .mainOrangeColor
            button.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            button.selectedFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
            
        }
        
        bar.indicator.weight = .custom(value: 1)
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .fit
        bar.indicator.tintColor = .mainOrangeColor
        addBar(bar, dataSource: self, at: .top)
    }
}

extension SearchTabBarViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0 :
            let item = TMBarItem(title: "추천 검색어")
            return item
        case 1 :
            return TMBarItem(title: "최근 검색어")
        default:
            return TMBarItem(title: "친구 찾기")
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
