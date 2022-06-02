
import UIKit
import Alamofire

class MyInfoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var titles = [["이벤트"],["구매한 EAT딜", "EAT딜 입고알림"],["가고싶다","마이리스트","북마크","내가 등록한 식당"],["설정"]]
    var userInfo: UserInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        fetchData()
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
    
    func fetchData() {
        let url = "\(Constant.BASE_URL2)/users"
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["X-ACCESS-TOKEN": "\(Constant.token)"])
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                switch response.result {
                case .success(let obj) :
                    if let nsDiectionary = obj as? NSDictionary {
                        do {
                            let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                            let getInstanceData = try JSONDecoder().decode(Users.self, from: dataJSON)
                            if let results = getInstanceData.result {
                                self.userInfo = results
                                self.tableView.reloadData()
                            }
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                case .failure(_):
                    print("실패")
            }
        }
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
            cell.userName.text = userInfo?.userName
            cell.followers.text = "\(userInfo?.followers?.count ?? 0)"
            cell.followings.text = "\(userInfo?.followings?.count ?? 0)"
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
        if indexPath == [4, 0] {
            guard let VC = self.storyboard?.instantiateViewController(identifier: "SettingViewController") as? SettingViewController else { return }
            VC.modalPresentationStyle = .fullScreen
            self.present(VC, animated: false)
        }
    }
}
