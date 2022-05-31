
import UIKit
import Alamofire
import Tabman
import CoreLocation

protocol SendDelegate: AnyObject {
    func send(title: String, tag: Int)
}

extension RestaurantSearchViewController: SendDelegate, ClickWishDelegate {
    func send(title: String, tag: Int) {
        self.sortTitleLabel.text = title
        sortTag = tag
    }
    
    func clickWishButton(for index: Int, id : Int?) {
        if wishList[index] == 1 {
            print("가고싶다 취소")
            wishDeleteData(id!)
            wishList[index] = 0
            restaurantCollectionView.reloadData()
        } else {
            print("가고싶다")
            wishPostData(id!)
            wishList[index] = 1
            restaurantCollectionView.reloadData()
        }
    }
}

class RestaurantSearchViewController: UIViewController {
    
    var images = ["bannerImage1", "bannerImage2", "bannerImage3", "bannerImage4", "bannerImage5"]
    var sortTag = 1
    var regionTitle = [String]()
    
    var restuarantInfoList: [RestuarantInfo]?
    var wishList = [Int]()
    var isWish: Bool?
    
    @IBOutlet weak var nowRegionTitle: UILabel!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var surroundView: UIView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var sortTitleLabel: UILabel!
    
    @IBOutlet weak var restaurantCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPageControl()
        moveBannerImage()
        setViewDesign()
        setCollectionView()
        
        findLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if regionTitle.count > 0 {
            nowRegionTitle.text = regionTitle.count == 1 ? "\(regionTitle.first!)" : "\(regionTitle.first!) 외 \(regionTitle.count-1)곳"
        }
        self.fetchData()
    }
    
    @IBAction func pressRegionButton(_ sender: UIButton) {
        guard let RSVC = self.storyboard?.instantiateViewController(identifier: "RegionSelectContainerViewController") as? RegionSelectContainerViewController else { return }
        RSVC.modalPresentationStyle = .overCurrentContext
        self.present(RSVC, animated: false, completion: nil)
    }
    
    
    @IBAction func pressSearchButton(_ sender: UIButton) {
        guard let SearchVC = self.storyboard?.instantiateViewController(identifier: "SearchViewController") as? SearchViewController else { return }
        SearchVC.modalPresentationStyle = .fullScreen
        self.present(SearchVC, animated: false, completion: nil)
    }
    
    @IBAction func pressMapButton(_ sender: UIButton) {
        guard let MapVC = self.storyboard?.instantiateViewController(identifier: "MapViewController") as? MapViewController else { return }
        MapVC.modalPresentationStyle = .fullScreen
        self.present(MapVC, animated: false, completion: nil)
    }
    
    
    func moveBannerImage() {
        DispatchQueue.main.async {
            let _: Timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (Timer) in
                if self.pageControl.currentPage >= self.images.count-1 {
                    self.bannerImageView.image = UIImage(named: self.images[0])
                    self.pageControl.currentPage = 0
                } else {
                    self.pageControl.currentPage += 1
                    self.bannerImageView.image = UIImage(named: self.images[self.pageControl.currentPage])
                }
            }
        }
    }
    
    func setPageControl() {
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .mainOrangeColor
        pageControl.pageIndicatorTintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        bannerImageView.image = UIImage(named: images[0])
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(responseToSwipeGesture(_ :)))
                swipeRight.direction = UISwipeGestureRecognizer.Direction.right
                self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(responseToSwipeGesture(_:)))
                swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
                self.view.addGestureRecognizer(swipeLeft)
    }
    
    @objc func responseToSwipeGesture(_ gesture: UISwipeGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
        switch swipeGesture.direction{
            case UISwipeGestureRecognizer.Direction.right:
            pageControl.currentPage -= 1
            bannerImageView.image = UIImage(named: images[pageControl.currentPage])
        case UISwipeGestureRecognizer.Direction.left:
            pageControl.currentPage += 1
            bannerImageView.image = UIImage(named: images[pageControl.currentPage])
            default:
                break
            }
        }
    }
    
    @IBAction func pageChanged(_ sender: UIPageControl) {
        bannerImageView.image = UIImage(named: images[pageControl.currentPage])
    }
    
    @IBAction func pressSortButton(_ sender: UIButton) {
        guard let SortVC = self.storyboard?.instantiateViewController(identifier: "SortViewController") as? SortViewController else { return }
        SortVC.modalPresentationStyle = .overCurrentContext
        SortVC.delegate = self
        SortVC.sortTag = sortTag
        self.present(SortVC, animated: false, completion: nil)
    }
    
    func setViewDesign() {
        filterView.layer.borderWidth = 1
        filterView.layer.borderColor = UIColor.mainDarkGrayColor.cgColor
        filterView.layer.cornerRadius = filterView.frame.height / 2
        
        surroundView.layer.cornerRadius = surroundView.frame.height / 2
    }
    
    @IBAction func pressSurroundButton(_ sender: UIButton) {
        guard let SurroundVC = self.storyboard?.instantiateViewController(identifier: "SurroundViewController") as? SurroundViewController else { return }
        SurroundVC.modalPresentationStyle = .overCurrentContext
        self.present(SurroundVC, animated: false, completion: nil)
    }
    
    @IBAction func pressFilterButton(_ sender: UIButton) {
        guard let FilterVC = self.storyboard?.instantiateViewController(identifier: "FilterViewController") as? FilterViewController else { return }
        FilterVC.modalPresentationStyle = .overCurrentContext
        self.present(FilterVC, animated: false, completion: nil)
    }
    
    func setCollectionView() {
        self.restaurantCollectionView.delegate = self
        self.restaurantCollectionView.dataSource = self
        
        restaurantCollectionView.register(UINib(nibName: "RestaurantCell", bundle: nil), forCellWithReuseIdentifier: "RestaurantCell")
        
        restaurantCollectionView.isScrollEnabled = false
    }
}

extension RestaurantSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.restuarantInfoList?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantCell", for: indexPath) as! RestaurantCell
        cell.delegate = self
        cell.index = indexPath.item
        cell.id = restuarantInfoList?[indexPath.item].id
        cell.resIndex?.text = String(indexPath.item+1)+"."
        cell.resTitle?.text = restuarantInfoList?[indexPath.item].name
        cell.resLoc?.text = restuarantInfoList?[indexPath.item].regionName
        cell.resReview?.text = String(restuarantInfoList?[indexPath.item].numReviews ?? 0)
        cell.resRate?.text = String(restuarantInfoList?[indexPath.item].ratingsAvg ?? 0)
        if wishList.count > indexPath.item {
            cell.wishImage.tintColor = (wishList[indexPath.item]) == 0 ? .clear : .mainOrangeColor
        }
        cell.resRead.text = String(restuarantInfoList?[indexPath.item].view ?? 0)
        let url = URL(string: restuarantInfoList![indexPath.item].imgUrl)!
        cell.resImage.load(url: url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (restaurantCollectionView.bounds.width - 10)/2, height: restaurantCollectionView.bounds.width/2 + 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let RDVC = storyboard?.instantiateViewController(withIdentifier: "RestaurantDetailViewController") as? RestaurantDetailViewController else { return }
        RDVC.modalPresentationStyle = .fullScreen
        RDVC.id = restuarantInfoList?[indexPath.item].id
        self.present(RDVC, animated: false, completion: nil)
    }
}


extension RestaurantSearchViewController {
    func findLocation(){
        let findLoc = CLLocation(latitude: myLocation.0, longitude: myLocation.1)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")
        geocoder.reverseGeocodeLocation(findLoc, preferredLocale: locale) { (placemarks, error) in
            if let address: [CLPlacemark] = placemarks {
                if let name = address.last?.name {
                    if locationAgree == true {
                        var loc = name.filter{$0.isLetter}
                        self.nowRegionTitle.text = loc
                    }
                }
            }
        }
    }
    func fetchData() {
        let url = "\(Constant.BASE_URL2)/restaurants?lat=\(myLocation.0)&long=\(myLocation.1)"
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
                            let getInstanceData = try JSONDecoder().decode(Restuarant.self, from: dataJSON)
                            if let results = getInstanceData.result {
                                DispatchQueue.main.async {
                                    self.restuarantInfoList = results
                                    for i in self.restuarantInfoList!.map({$0.id}) {
                                        self.wishGetData(i)
                                    }
                                    self.restaurantCollectionView.reloadData()
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
    
    func wishGetData(_ id: Int) {
        let url = "\(Constant.BASE_URL2)/wishes/\(id)"
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
                            let getInstanceData = try JSONDecoder().decode(Wish.self, from: dataJSON)
                            if let results = getInstanceData.result {
                                DispatchQueue.main.async {
                                    var x = results.isWishes
                                    self.wishList.append(x!)
                                    self.restaurantCollectionView.reloadData()
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
    
    func wishDeleteData(_ id: Int) {
        let header: HTTPHeaders = [ "Content-Type":"application/json", "X-ACCESS-TOKEN":"\(Constant.token)"]
        AF.request("\(Constant.BASE_URL2)/wishes/\(id)", method: .delete, parameters: "", encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseDecodable(of: Wish.self) { response in
                switch response.result {
                case .success(let response):
                    if response.isSuccess, let result = response.result {
                        print("성공")
                    } else {
                        print("실패")
                    }
                case .failure(let error):
                    print(error.localizedDescription)

            }
        }
    }
    
    func wishPostData(_ id: Int) {
        let header: HTTPHeaders = [ "Content-Type":"application/json", "X-ACCESS-TOKEN":"\(Constant.token)"]
        AF.request("\(Constant.BASE_URL2)/wishes/\(id)", method: .post, parameters: "", encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseDecodable(of: Wish.self) { response in
                switch response.result {
                case .success(let response):
                    if response.isSuccess, let result = response.result {
                        print("성공")
                    } else {
                        print("실패")
                    }
                case .failure(let error):
                    print(error.localizedDescription)

            }
        }
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

