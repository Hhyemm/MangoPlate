
import UIKit
import Alamofire

class RestaurantDetailViewController: UIViewController {

    @IBOutlet weak var navigationBar: UIView!
    @IBOutlet weak var navigationBarDismissButton: UIButton!
    @IBOutlet weak var navigationBarName: UILabel!
    @IBOutlet weak var navigationBarPictureButton: UIButton!
    @IBOutlet weak var navigationBarShareButton: UIButton!
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    @IBOutlet weak var wishImage: UIImageView!
    @IBOutlet weak var wishButton: UIButton!
    
    @IBOutlet weak var roadSearchView: UIView!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var taxiView: UIView!
    @IBOutlet weak var adressView: UIView!
    
    @IBOutlet weak var callView: UIView!
    
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    @IBOutlet weak var reviewCollectionView: UICollectionView!
    
    @IBOutlet weak var blogSearchView: UIView!
    
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantView: UILabel!
    @IBOutlet weak var restaurantScore: UILabel!
    @IBOutlet weak var restaurantAddress: UILabel!
    @IBOutlet weak var restaurantOpenHour: UILabel!
    @IBOutlet weak var restaurantCloseHour: UILabel!
    @IBOutlet weak var restaurantBreakTime: UILabel!
    @IBOutlet weak var restaurantMinPrice: UILabel!
    @IBOutlet weak var restaurantMaxPrice: UILabel!
    
    var restuarantInfoList: RestuarantInfo!
    var wish: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionView()
        setViewDesign(roadSearchView)
        setViewDesign(navigationView)
        setViewDesign(taxiView)
        setViewDesign(adressView)
        callView.layer.borderWidth = 1
        callView.layer.borderColor = UIColor.mainDarkGrayColor.cgColor
        blogSearchView.layer.borderWidth = 2
        blogSearchView.layer.cornerRadius = blogSearchView.frame.height / 2
        blogSearchView.layer.borderColor = UIColor.mainOrangeColor.cgColor
        fetchData()
    }
    
    func fetchData() {
        let url = AF.request("http://3.39.170.0/restaurants/1")
            url.responseJSON { (response) in
                switch response.result {
                case .success(let obj) :
                    if let nsDiectionary = obj as? NSDictionary {
                        do {
                            let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                            let getInstanceData = try JSONDecoder().decode(Restuarant.self, from: dataJSON)
                            if let results = getInstanceData.result {
                                self.restuarantInfoList = getInstanceData.result
                                
                                self.navigationBarName.text = self.restuarantInfoList.name
                                self.restaurantName.text = self.restuarantInfoList.name
                                self.restaurantView.text = "\(self.restuarantInfoList.view)"
                                self.restaurantScore.text = "\(self.restuarantInfoList.score)"
                                self.restaurantAddress.text = self.restuarantInfoList.address
                                self.restaurantOpenHour.text = self.restuarantInfoList.openHour
                                self.restaurantCloseHour.text = self.restuarantInfoList.closeHour
                                self.restaurantBreakTime.text = self.restuarantInfoList.breakTime
                                switch self.restuarantInfoList.minPrice {
                                case 0..<10000 :
                                    self.restaurantMinPrice.text = "만원 미만"
                                case 10000..<20000 :
                                    self.restaurantMinPrice.text = "만원"
                                case 20000..<30000 :
                                    self.restaurantMinPrice.text = "2만원"
                                case 30000..<40000 :
                                    self.restaurantMinPrice.text = "3만원"
                                default :
                                    self.restaurantMinPrice.text = ""
                                }
                                switch self.restuarantInfoList.maxPrice {
                                case 0..<10000 :
                                    self.restaurantMaxPrice.text = ""
                                case 10000..<20000 :
                                    self.restaurantMaxPrice.text = "만원"
                                case 20000..<30000 :
                                    self.restaurantMaxPrice.text = "2만원"
                                case 30000..<40000 :
                                    self.restaurantMaxPrice.text = "3만원"
                                default :
                                    self.restaurantMaxPrice.text = "4만원 이상"
                                }
                                //print(self.restuarantInfoList)
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
    
    @IBAction func pressBackButton(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func setCollectionView() {
        self.imageCollectionView.delegate = self
        self.imageCollectionView.dataSource = self
        self.menuCollectionView.delegate = self
        self.menuCollectionView.dataSource = self
        self.reviewCollectionView.delegate = self
        self.reviewCollectionView.dataSource = self
        
        imageCollectionView.register(UINib(nibName: "DetailImageCell", bundle: nil), forCellWithReuseIdentifier: "DetailImageCell")
        menuCollectionView.register(UINib(nibName: "MenuImageCell", bundle: nil), forCellWithReuseIdentifier: "MenuImageCell")
        reviewCollectionView.register(UINib(nibName: "ReviewCell", bundle: nil), forCellWithReuseIdentifier: "ReviewCell")
    }
    
    func setViewDesign(_ setView: UIView) {
        setView.layer.borderWidth = 1
        setView.layer.cornerRadius = roadSearchView.frame.width / 2
        setView.layer.borderColor = UIColor.mainDarkGrayColor.cgColor
    }
    
    @IBAction func pressWishButton(_ sender: UIButton) {
        if wish == true {
            wishImage.image = UIImage(named: "star-1")
            wish = false
        } else {
            wishImage.image = UIImage(named: "star3")
            wish = true
        }
    }
    
    @IBAction func pressWriteReviewButton(_ sender: UIButton) {
        guard let RWVC = self.storyboard?.instantiateViewController(identifier: "ReviewWriteViewController") as? ReviewWriteViewController else { return }
        RWVC.modalPresentationStyle = .fullScreen
        self.present(RWVC, animated: false, completion: nil)
        
    }
}

extension RestaurantDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= imageCollectionView.frame.maxY+navigationBar.frame.height {
            backgroundView.backgroundColor = .mainOrangeColor
            navigationBar.backgroundColor = .mainOrangeColor
            navigationBarDismissButton.tintColor = .white
            navigationBarPictureButton.tintColor = .white
            navigationBarShareButton.tintColor = .white
            
        } else {
            backgroundView.backgroundColor = .white
            navigationBar.backgroundColor = .white
            navigationBarDismissButton.tintColor = .mainOrangeColor
            navigationBarPictureButton.tintColor = .mainOrangeColor
            navigationBarShareButton.tintColor = .mainOrangeColor
        }
    }
}


extension RestaurantDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == imageCollectionView {
           return 4
        } else if collectionView == menuCollectionView {
            return 5
        }
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == imageCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailImageCell", for: indexPath) as! DetailImageCell
            return cell
        } else if collectionView == menuCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuImageCell", for: indexPath) as! MenuImageCell
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == imageCollectionView {
            return CGSize(width: (imageCollectionView.bounds.width)/2.5, height: imageCollectionView.bounds.height)
        } else if collectionView == menuCollectionView {
            return CGSize(width: (menuCollectionView.bounds.width)/5, height: menuCollectionView.bounds.height)
        }
        return CGSize(width: reviewCollectionView.frame.width, height: (reviewCollectionView.frame.height-10) / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == reviewCollectionView {
            guard let RDVC = self.storyboard?.instantiateViewController(identifier: "ReviewDetailViewController") as? ReviewDetailViewController else { return }
            RDVC.modalPresentationStyle = .fullScreen
            self.present(RDVC, animated: false, completion: nil)
        }
    }
}

