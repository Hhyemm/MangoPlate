
import UIKit

class TopListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        let nib = UINib(nibName: "TopListCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TopListCell")
    }
}

extension TopListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopListCell") as! TopListCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

