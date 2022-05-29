
import Foundation
import Alamofire

class ViewModel {
    weak var vc: SearchResultViewController?
    var restuarantInfoList: [RestuarantInfo]?
    
    var restuarantInfoListCount: Int {
        return restuarantInfoList?.count ?? 0
    }
    
    func fetchData() {
        let url = AF.request("http://3.39.170.0/restaurants?lat=\(myLocation.0)&long=\(myLocation.1)")
        url.responseJSON { (response) in
            switch response.result {
            case .success(let obj) :
                if let nsDiectionary = obj as? NSDictionary {
                    do {
                        let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                        let getInstanceData = try JSONDecoder().decode(Restuarant.self, from: dataJSON)
                        if let results = getInstanceData.result {
                            self.restuarantInfoList = getInstanceData.result
                            DispatchQueue.main.async {
                                self.vc?.restaurantCollectionView.reloadData()
                            }
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

