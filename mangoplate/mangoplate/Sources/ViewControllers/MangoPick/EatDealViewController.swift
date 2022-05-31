
import UIKit

class EatDealViewController: UIViewController {

    @IBOutlet weak var regionSelectView: UIView!
    @IBOutlet weak var surroundView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setViewDesign()
        setTableView()
        
    }
    
    func setViewDesign() {
        regionSelectView.layer.borderWidth = 1
        regionSelectView.layer.borderColor = UIColor.mainOrangeColor.cgColor
        regionSelectView.layer.cornerRadius = regionSelectView.frame.height / 2
        surroundView.layer.cornerRadius = surroundView.frame.height / 2
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        let nib = UINib(nibName: "EatDealCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "EatDealCell")
    }
}

extension EatDealViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EatDealCell") as! EatDealCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
