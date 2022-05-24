
import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    let identifiers: NSArray = ["RegionSelectItem1ViewController", "RegionSelectItem2ViewController", "RegionSelectItem3ViewController", "RegionSelectItem4ViewController"]
    
    lazy var VCArray: [UIViewController] = {
        return [self.VCInstance(name: "RegionSelectItem1ViewController"),
                self.VCInstance(name: "RegionSelectItem2ViewController"),
                self.VCInstance(name: "RegionSelectItem3ViewController"),
                self.VCInstance(name: "RegionSelectItem4ViewController")]
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    private func VCInstance(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
       
        if let firstVC = VCArray.first{
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = VCArray.firstIndex(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        if previousIndex < 0 {
            return VCArray.last
        } else {
            return VCArray[previousIndex]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = VCArray.firstIndex(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        if nextIndex >= VCArray.count {
            return VCArray.first
        } else {
            return VCArray[nextIndex]
        }
    }

}
