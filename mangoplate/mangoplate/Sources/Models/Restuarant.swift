
import Foundation
import Alamofire

class Restuarant {
    weak var vc: RestaurantSearchViewController?
       var restuarantInfoList: [RestaurantInfo] = []

       var numOfRestuarantInfoList: Int {
           return restuarantInfoList.count
       }

       var trimmedRestuarantInfoList: [RestaurantInfo]{
           var count = 0
           let value = restuarantInfoList.map { (info) -> RestaurantInfo in
               count += 1
               return RestaurantInfo(name: "\(count). " + info.name)
           }
           return value
       }
       
       func restuarantInfo(at index: Int) -> RestaurantInfo {
           return trimmedRestuarantInfoList[index]
       }
       
       func getRestuarantListAPI(filter: Int, food: [Int], price: [Int],isAvailParking: Int, long : Double, lat: Double, distance: Int) {
           var foodValue = "&food=0"
           var priceValue = "&price=-1"
           if food != [] {
               foodValue = ""
               for i in food{
                   foodValue += "&food=\(i)"
               }
           }
           if price != [] {
               priceValue = ""
               for i in price{
                   priceValue += "&price=\(i)"
               }
           }
           let url = "http://3.39.170.0" + "/restaurants?areaName=건대/군자/광진&filter=\(filter)" + foodValue + "" + priceValue + "&parking=\(isAvailParking)&long=\(long)&lat=\(lat)&dist=\(distance)"
           print(url)
           let encodedURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
           
           AF.request(encodedURL, method: .get, parameters: nil,encoding: URLEncoding.default, headers: nil)
               .validate()
               .responseDecodable(of: RestaurantSearch.self) { (response) in
                   switch response.result {
                   case .success(let response):
                       if response.isSuccess, let result = response.result{
                           self.restuarantInfoList = result
                           DispatchQueue.main.async {
                               
                           }
                           print(result)
                       }else{
                           //print(response.message)
                       }
                   case .failure(let error):
                       break
                   }
               }
   }
}
