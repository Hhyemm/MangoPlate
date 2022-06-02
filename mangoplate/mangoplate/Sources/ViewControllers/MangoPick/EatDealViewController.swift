
import UIKit
import Alamofire

class EatDealViewController: UIViewController {

    @IBOutlet weak var regionSelectView: UIView!
    @IBOutlet weak var surroundView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var eatDealInfoList: [EatDealInfo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setViewDesign()
        setTableView()
        fetchData()
        
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
    
    func DecimalWon(value: Int) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: NSNumber(value: value))! + "원"
        return result
    }
}

extension EatDealViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eatDealInfoList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EatDealCell") as! EatDealCell
        cell.name.text = eatDealInfoList![indexPath.item].restaurantName
        let url = URL(string: (eatDealInfoList![indexPath.item].imgUrls[0]))!
        cell.resImage.load(url: url)
        cell.loc.text = "[\(eatDealInfoList![indexPath.item].address)]"
        cell.menu.text = eatDealInfoList![indexPath.item].menuName
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        cell.price.text = numberFormatter.string(from: NSNumber(value: eatDealInfoList![indexPath.item].price))
        let a =  (Double(1+eatDealInfoList![indexPath.item].discountRate)/100) * Double(eatDealInfoList![indexPath.item].price)
        cell.discountPrice.text = String(a)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension EatDealViewController {
    func fetchData() {
        let url = AF.request("\(Constant.BASE_URL1)/eatdeals?lat=\(myLocation.0)&long=\(myLocation.1)")
        url.responseJSON { (response) in
            switch response.result {
            case .success(let obj) :
                if let nsDiectionary = obj as? NSDictionary {
                    do {
                        let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                        let getInstanceData = try JSONDecoder().decode(EatDeal.self, from: dataJSON)
                        if let results = getInstanceData.result {
                            self.eatDealInfoList = results
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

