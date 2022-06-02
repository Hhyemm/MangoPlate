
import UIKit
import Alamofire

class SearchResultViewController: UIViewController {

    @IBOutlet weak var searchTitle: UILabel!
    @IBOutlet weak var filterView: UIView!
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var restaurantCollectionView: UICollectionView!
    
    var searchResult: [SearchInfo]?
    var search: String?
    let parma = [
        "search" : "세계음식",
        "lat" : "\(myLocation.0)",
        "long" : "\(myLocation.1)"
    ] as Dictionary
    
    var images = ["searchImage2", "searchImage1", "searchImage3", "searchImage4", "searchImage5"]
    var titles = ["2022 올해의 키워드: 그릭요거트", "2022 올해의 키워드: 생면파스타", "2022 다이닝 맛집 TOP 30", "2022 떡볶이 맛집 TOP 20", "2022 돼지고기 인기 맛집 TOP 50"]
    
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
        if collectionView == bannerCollectionView {
            return titles.count
        }
        return searchResult?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bannerCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchBannerCell", for: indexPath) as! SearchBannerCell
            cell.bannerTitle.text = titles[indexPath.item]
            cell.bannerImage.image = UIImage(named: images[indexPath.item])
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantCell", for: indexPath) as! RestaurantCell
        cell.resIndex.text = "\(indexPath.item + 1)."
        cell.resTitle.text = searchResult?[indexPath.item].name
        var address = searchResult?[indexPath.item].address
        var x = address?.prefix(9).suffix(3).map{String($0)}.joined()
        cell.resLoc.text = x
        let url = URL(string: (searchResult?[indexPath.item].imgUrl ?? ""))!
        cell.resImage.load(url: url)
        cell.resRate.text = "\(searchResult?[indexPath.item].ratingsAvg ?? 0)"
        cell.wishImage.tintColor = (searchResult?[indexPath.item].isWishes) == 0 ? .clear : .mainOrangeColor
        cell.resRead.text = "\(searchResult?[indexPath.item].view ?? 0)"
        cell.resReview.text = "\(searchResult?[indexPath.item].numReviews ?? 0)"
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
        let url = "\(Constant.BASE_URL2)/search"
        
        AF.request(url,
                   method: .get,
                   parameters: parma,
                   encoding: URLEncoding.default,
                   headers: ["X-ACCESS-TOKEN": "\(Constant.token)", "Content-Type" : "application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                switch response.result {
                case .success(let obj) :
                    if let nsDiectionary = obj as? NSDictionary {
                        do {
                            let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                            let getInstanceData = try JSONDecoder().decode(Search.self, from: dataJSON)
                            if let results = getInstanceData.result {
                                self.searchResult = results
                                self.restaurantCollectionView.reloadData()
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
