
import UIKit

class RecommendSearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var list = ["2022망고플레이트인기맛집", "세계음식", "유튜버추천", "신촌", "참치", "성수", "와인"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "SearchCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "SearchCell")

    }
}

extension RecommendSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        cell.title.text = list[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let SRVC = self.storyboard?.instantiateViewController(identifier: "SearchResultViewController") as? SearchResultViewController else { return }
        SRVC.search = list[indexPath.item]
        SRVC.modalPresentationStyle = .fullScreen
        self.present(SRVC, animated: false, completion: nil)
    }

}
