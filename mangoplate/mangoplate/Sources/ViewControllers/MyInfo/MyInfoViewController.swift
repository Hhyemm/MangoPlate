
import UIKit

class MyInfoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var titles = [["이벤트"],["구매한 EAT딜", "EAT딜 입고알림"],["가고싶다","마이리스트","북마크","내가 등록한 식당"],["설정"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let profileNib = UINib(nibName: "ProfileCell", bundle: nil)
        tableView.register(profileNib, forCellReuseIdentifier: "ProfileCell")
        let infoNib = UINib(nibName: "InfoCell", bundle: nil)
        tableView.register(infoNib, forCellReuseIdentifier: "InfoCell")
        let timeLineNib = UINib(nibName: "TimeLineCell", bundle: nil)
        tableView.register(timeLineNib, forCellReuseIdentifier: "TimeLineCell")
        
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: CGFloat.leastNonzeroMagnitude))
    }
    
}

extension MyInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return 2
        } else if section == 3 {
            return 5
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as! ProfileCell
            return cell
        } else if indexPath.section == 3 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TimeLineCell") as! TimeLineCell
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell") as! InfoCell
            cell.title.text = titles[indexPath.section-1][indexPath.row-1]
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell") as! InfoCell
        cell.title.text = titles[indexPath.section-1][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
