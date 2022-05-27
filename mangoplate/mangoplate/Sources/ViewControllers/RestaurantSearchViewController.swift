
import UIKit
import Alamofire
import CoreLocation

protocol SendDelegate: AnyObject {
    func send(title: String, tag: Int)
}

extension RestaurantSearchViewController: SendDelegate, ClickStarDelegate {
    func send(title: String, tag: Int) {
        self.sortTitleLabel.text = title
        sortTag = tag
    }
    
    func clickStarButton(for index: Int, like: Bool) {
        if like {
            print("가고싶다 취소")
        } else {
            print("가고싶다")
        }
    }
}

extension RestaurantSearchViewController {
    func fetchData() {
        let request = AF.request("http://3.39.170.0/restaurants/1")
        request.responseJSON { (data) in
          print(data)
        }
    }
}

class RestaurantSearchViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var images = ["bannerImage1", "bannerImage2", "bannerImage3", "bannerImage4", "bannerImage5"]
    var sortTag = 1
    var regionTitle = [String]()
    
    @IBOutlet weak var nowRegionTitle: UILabel!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var surroundView: UIView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var sortTitleLabel: UILabel!
    
    @IBOutlet weak var restaurantCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //fetchData()
        self.setupLocation()
        setPageControl()
        moveBannerImage()
        
        filterView.layer.borderWidth = 1
        filterView.layer.borderColor = UIColor.mainDarkGrayColor.cgColor
        filterView.layer.cornerRadius = filterView.frame.height / 2
        
        surroundView.layer.cornerRadius = surroundView.frame.height / 2
        
        setCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if regionTitle.count > 0 {
            nowRegionTitle.text = regionTitle.count == 1 ? "\(regionTitle.first!)" : "\(regionTitle.first!) 외 \(regionTitle.count-1)곳"
        }
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantCell", for: indexPath) as! RestaurantCell
        cell.delegate = self
        cell.index = indexPath.item
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (restaurantCollectionView.bounds.width - 10)/2, height: restaurantCollectionView.bounds.width/2 + 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let RDVC = storyboard?.instantiateViewController(withIdentifier: "RestaurantDetailViewController") as? RestaurantDetailViewController else { return }
        RDVC.modalPresentationStyle = .fullScreen
        self.present(RDVC, animated: false, completion: nil)
    }
}

extension RestaurantSearchViewController {
    func setupLocation(){
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil{
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            print(currentLocation)
        }
    }
}
