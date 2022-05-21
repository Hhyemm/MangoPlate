
import UIKit

class LocationAgreeViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var agreeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.lineBreakMode = .byCharWrapping
        agreeButton.layer.cornerRadius = agreeButton.frame.height / 2
    }
    
    @IBAction func pressDifferButton(_ sender: UIButton) {
        guard let RSVC = self.storyboard?.instantiateViewController(identifier: "RegionSelectViewController") as? RegionSelectViewController else { return }
        RSVC.modalPresentationStyle = .fullScreen // 화면 전환 스타일 지정
        self.present(RSVC, animated: false, completion: nil)
    }
}
