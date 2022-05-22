
import UIKit

class RestaurantSearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func pressSearchButton(_ sender: UIButton) {
        guard let SearchVC = self.storyboard?.instantiateViewController(identifier: "SearchViewController") as? SearchViewController else { return }
        SearchVC.modalPresentationStyle = .fullScreen
        self.present(SearchVC, animated: false, completion: nil)
    }
}
