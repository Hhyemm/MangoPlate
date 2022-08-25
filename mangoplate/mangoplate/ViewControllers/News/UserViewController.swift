
import UIKit
import Alamofire

class UserViewController: UIViewController, ClickUserFollowDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var dataService = MangoPickDataService()
    var userId: Int?
    var userName: String?
    var userInfo: UserInfo?
    var titles = ["가고싶다","마이리스트","북마크"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(userId!, userName!)
        
        setTableView()
        
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        let profileNib = UINib(nibName: "UserCell", bundle: nil)
        tableView.register(profileNib, forCellReuseIdentifier: "UserCell")
        let infoNib = UINib(nibName: "InfoCell", bundle: nil)
        tableView.register(infoNib, forCellReuseIdentifier: "InfoCell")
        let timeLineNib = UINib(nibName: "TimeLineCell", bundle: nil)
        tableView.register(timeLineNib, forCellReuseIdentifier: "TimeLineCell")
        
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: CGFloat.leastNonzeroMagnitude))
        
    }
    
    @IBAction func pressBackButton(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func clickFollowUser(userId: Int?) {
        dataService.fetchPostfollowData(self, userId!)
    }
    
    func didSuccessGetUserData(_ results: UserInfo) {
        self.userInfo = results
        self.tableView.reloadData()
    }
}

extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
            cell.userFollowDelegate = self
            cell.userName.text = userName!
            return cell
        }
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimeLineCell") as! TimeLineCell
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell") as! InfoCell
        cell.title.text = titles[indexPath.item-1]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
       
    }
}


