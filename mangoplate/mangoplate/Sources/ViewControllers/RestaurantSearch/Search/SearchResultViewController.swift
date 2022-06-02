
import UIKit
import Alamofire

class SearchResultViewController: UIViewController {

    @IBOutlet weak var searchTitle: UILabel!
    @IBOutlet weak var filterView: UIView!
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var restaurantCollectionView: UICollectionView!
    
    let parma: Parameters = [
        "search" : "세계음식",
        "lat" : "37.5732",
        "long" : "126.9891"
    ]
    
    var images = ["searchImage2", "searchImage1", "searchImage3", "searchImage4", "searchImage5"]
    var titles = ["2022 올해의 키워드: 그릭요거트", "2022 올해의 키워드: 생면파스타", "2022 다이닝 맛집 TOP 30", "2022 떡볶이 맛집 TOP 20", "2022 돼지고기 인기 맛집 TOP 50"]
    var search: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTitle.text = search
        setFilterButtonDesign()
        setCollectionView()
        
        fetchData()
    }
    
    @IBAction func pressBackButton(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func pressMapButton(_ sender: UIButton) {
        guard let MapVC = self.storyboard?.instantiateViewController(identifier: "MapViewController") as? MapViewController else { return }
        MapVC.modalPresentationStyle = .fullScreen
        self.present(MapVC, animated: false, completion: nil)
    }
    
    
    @IBAction func pressRegionButton(_ sender: UIButton) {
        guard let RSVC = self.storyboard?.instantiateViewController(identifier: "RegionSelectContainerViewController") as? RegionSelectContainerViewController else { return }
        RSVC.modalPresentationStyle = .overCurrentContext
        RSVC.nowView = "search"
        self.present(RSVC, animated: false, completion: nil)
    }
    
    func setFilterButtonDesign() {
        filterView.layer.borderWidth = 1
        filterView.layer.borderColor = UIColor.mainDarkGrayColor.cgColor
        filterView.layer.cornerRadius = filterView.frame.height / 2
    }
    
    @IBAction func pressFilterButton(_ sender: UIButton) {
        guard let FilterVC = self.storyboard?.instantiateViewController(identifier: "FilterViewController") as? FilterViewController else { return }
        FilterVC.modalPresentationStyle = .overCurrentContext
        self.present(FilterVC, animated: false, completion: nil)
    }
    
    func setCollectionView() {
        self.bannerCollectionView.delegate = self
        self.bannerCollectionView.dataSource = self
        self.restaurantCollectionView.delegate = self
        self.restaurantCollectionView.dataSource = self
        
        
        bannerCollectionView.register(UINib(nibName: "SearchBannerCell", bundle: nil), forCellWithReuseIdentifier: "SearchBannerCell")
        restaurantCollectionView.register(UINib(nibName: "RestaurantCell", bundle: nil), forCellWithReuseIdentifier: "RestaurantCell")
        
        restaurantCollectionView.isScrollEnabled = false
    }
}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bannerCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchBannerCell", for: indexPath) as! SearchBannerCell
            cell.bannerTitle.text = titles[indexPath.item]
            cell.bannerImage.image = UIImage(named: images[indexPath.item])
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantCell", for: indexPath) as! RestaurantCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == bannerCollectionView {
            return CGSize(width: bannerCollectionView.frame.width, height: bannerCollectionView.frame.height)
        }
        return CGSize(width: (restaurantCollectionView.frame.width-10)/2, height: restaurantCollectionView.frame.height/2)
    }
}

extension SearchResultViewController {
    
    func fetchData() {
        let url = "\(Constant.BASE_URL2)/search?search=세계음식&lat=37.5732&long=126.9891"
        
        AF.request(url,
                   method: .get,
                   parameters: parma,
                   encoding: URLEncoding.httpBody,
                   headers: ["X-ACCESS-TOKEN": "\(Constant.token)"])
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                print(response)
                switch response.result {
                case .success(let obj) :
                    if let nsDiectionary = obj as? NSDictionary {
                        print(nsDiectionary)
                        do {
                            let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                           // let getInstanceData = try JSONDecoder().decode(Search.self, from: dataJSON)
                            /*if let results = getInstanceData.result {
                                DispatchQueue.main.async {
                                    self.restuarantInfoList = results
                                    for i in self.restuarantInfoList!.map({$0.id}) {
                                        self.wishGetData(i)
                                    }
                                    self.restaurantCollectionView.reloadData()
                                }
                            }*/
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
