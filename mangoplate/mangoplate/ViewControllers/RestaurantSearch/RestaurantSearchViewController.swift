
import UIKit
import Tabman
import CoreLocation

class RestaurantSearchViewController: UIViewController {
    
    var images = ["bannerImage1", "bannerImage2", "bannerImage3", "bannerImage4", "bannerImage5"]
    var sortTag = 1
    var regionTitle = [String]()
    
    let dataService = RestaurantSearchDataService()
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
        if locationAgree {
            dataService.fetchGetRestaurantData(delegate: self)
        } else {
            dataService.fetchGetRegionRestaurantData(delegate: self, lat: 37.5552, long: 126.9142)
        }
    }
    
    func findLocation(){
        let findLoc = CLLocation(latitude: myLocation.0, longitude: myLocation.1)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")
        geocoder.reverseGeocodeLocation(findLoc, preferredLocale: locale) { (placemarks, error) in
            if let address: [CLPlacemark] = placemarks {
                if let name = address.last?.name {
                    if locationAgree == true {
                        let loc = name.filter{$0.isLetter}
                        self.nowRegionTitle.text = loc
                    }
                }
            }
        }
    }
    
    @IBAction func pressRegionButton(_ sender: UIButton) {
        guard let VC = self.storyboard?.instantiateViewController(identifier: "RegionSelectContainerViewController") as? RegionSelectContainerViewController else { return }
        VC.modalPresentationStyle = .overCurrentContext
        self.present(VC, animated: false, completion: nil)
    }
    
    
    @IBAction func pressSearchButton(_ sender: UIButton) {
        guard let VC = self.storyboard?.instantiateViewController(identifier: "SearchViewController") as? SearchViewController else { return }
        VC.modalPresentationStyle = .fullScreen
        self.present(VC, animated: false, completion: nil)
    }
    
    @IBAction func pressMapButton(_ sender: UIButton) {
        guard let VC = self.storyboard?.instantiateViewController(identifier: "MapViewController") as? MapViewController else { return }
        VC.modalPresentationStyle = .fullScreen
        self.present(VC, animated: false, completion: nil)
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
        guard let VC = self.storyboard?.instantiateViewController(identifier: "SortViewController") as? SortViewController else { return }
        VC.modalPresentationStyle = .overCurrentContext
        VC.delegate = self
        VC.sortTag = sortTag
        self.present(VC, animated: false, completion: nil)
    }
    
    func setViewDesign() {
        filterView.layer.borderWidth = 1
        filterView.layer.borderColor = UIColor.mainDarkGrayColor.cgColor
        filterView.layer.cornerRadius = filterView.frame.height / 2
        
        surroundView.layer.cornerRadius = surroundView.frame.height / 2
    }
    
    @IBAction func pressSurroundButton(_ sender: UIButton) {
        guard let VC = self.storyboard?.instantiateViewController(identifier: "SurroundViewController") as? SurroundViewController else { return }
        VC.modalPresentationStyle = .overCurrentContext
        self.present(VC, animated: false, completion: nil)
    }
    
    @IBAction func pressFilterButton(_ sender: UIButton) {
        guard let VC = self.storyboard?.instantiateViewController(identifier: "FilterViewController") as? FilterViewController else { return }
        VC.modalPresentationStyle = .overCurrentContext
        self.present(VC, animated: false, completion: nil)
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
        guard let VC = storyboard?.instantiateViewController(withIdentifier: "RestaurantDetailViewController") as? RestaurantDetailViewController else { return }
        VC.modalPresentationStyle = .fullScreen
        VC.id = restuarantInfoList?[indexPath.item].id
        self.present(VC, animated: false, completion: nil)
    }
}

extension RestaurantSearchViewController {
    func didSuccessGetRestaurantData(_ results: [RestuarantInfo]) {
        DispatchQueue.main.async {
            self.restuarantInfoList = results
            for i in self.restuarantInfoList!.map({$0.id}) {
                self.dataService.fetchGetWishData(delegate: self, id: i)
            }
            self.restaurantCollectionView.reloadData()
        }
    }
    
    func didSuccessGetWishData(_ results: WishResult) {
        DispatchQueue.main.async {
            let x = results.isWishes
            self.wishList.append(x!)
            self.restaurantCollectionView.reloadData()
        }
    }
}

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
            self.dataService.fetchDeleteWishData(delegate: self, id: id!)
            wishList[index] = 0
            restaurantCollectionView.reloadData()
        } else {
            self.dataService.fetchPostWishData(delegate: self, id: id!)
            wishList[index] = 1
            restaurantCollectionView.reloadData()
        }
    }
}

