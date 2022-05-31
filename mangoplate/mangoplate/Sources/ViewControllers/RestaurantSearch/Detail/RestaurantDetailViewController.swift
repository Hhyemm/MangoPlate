
import UIKit
import Alamofire
import CoreLocation
import MapKit
import SwiftUI

class RestaurantDetailViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var navigationBar: UIView!
    @IBOutlet weak var navigationBarDismissButton: UIButton!
    @IBOutlet weak var navigationBarName: UILabel!
    @IBOutlet weak var navigationBarPictureButton: UIButton!
    @IBOutlet weak var navigationBarShareButton: UIButton!
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    @IBOutlet weak var wishImage: UIImageView!
    @IBOutlet weak var wishButton: UIButton!
    
    @IBOutlet weak var lotView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var roadSearchView: UIView!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var taxiView: UIView!
    @IBOutlet weak var adressView: UIView!
    
    @IBOutlet weak var callView: UIView!
    
    @IBOutlet weak var reviewView: UIView!
    @IBOutlet weak var reviewCollectionView: UICollectionView!
    
    @IBOutlet weak var blogSearchView: UIView!
    
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantView: UILabel!
    @IBOutlet weak var restaurantReviewsCount: UILabel!
    @IBOutlet weak var restaurantWishCount: UILabel!
    @IBOutlet weak var restaurantScore: UILabel!
    @IBOutlet weak var restaurantAddress: UILabel!
    @IBOutlet weak var restaurantUpdatedAt1: UILabel!
    @IBOutlet weak var restaurantUpdatedAt2: UILabel!
    @IBOutlet weak var restaurantOpenHour: UILabel!
    @IBOutlet weak var restaurantCloseHour: UILabel!
    @IBOutlet weak var restaurantLastOrder: UILabel!
    @IBOutlet weak var restaurantBreakTime1: UILabel!
    @IBOutlet weak var restaurantBreakTime2: UILabel!
    @IBOutlet weak var restaurantMinPrice: UILabel!
    @IBOutlet weak var restaurantMaxPrice: UILabel!
    
    @IBOutlet weak var menu1: UILabel!
    @IBOutlet weak var menu2: UILabel!
    @IBOutlet weak var menu3: UILabel!
    @IBOutlet weak var menuPrice1: UILabel!
    @IBOutlet weak var menuPrice2: UILabel!
    @IBOutlet weak var menuPrice3: UILabel!
    @IBOutlet weak var reviewsCount: UILabel!
    @IBOutlet weak var review1Count: UILabel!
    @IBOutlet weak var review2Count: UILabel!
    @IBOutlet weak var review3Count: UILabel!
    
    @IBOutlet weak var reviewCollectionViewHeight: NSLayoutConstraint!
    
    var restuarantDetailInfoList: RestuarantDetailInfo!
    let locationManager = CLLocationManager()
    var id: Int?
    var isWish: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionView()
        setViewDesign(roadSearchView)
        setViewDesign(navigationView)
        setViewDesign(taxiView)
        setViewDesign(adressView)
        lotView.layer.borderWidth = 1
        lotView.layer.borderColor = UIColor.mainLightGrayColor.cgColor
        callView.layer.borderWidth = 1
        callView.layer.borderColor = UIColor.mainDarkGrayColor.cgColor
        blogSearchView.layer.borderWidth = 2
        blogSearchView.layer.cornerRadius = blogSearchView.frame.height / 2
        blogSearchView.layer.borderColor = UIColor.mainOrangeColor.cgColor
        
        fetchData()
        wishGetData(id!)

    }
    
    @IBAction func pressBackButton(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func setCollectionView() {
        self.imageCollectionView.delegate = self
        self.imageCollectionView.dataSource = self
        self.reviewCollectionView.delegate = self
        self.reviewCollectionView.dataSource = self
        
        imageCollectionView.register(UINib(nibName: "DetailImageCell", bundle: nil), forCellWithReuseIdentifier: "DetailImageCell")
        reviewCollectionView.register(UINib(nibName: "ReviewCell", bundle: nil), forCellWithReuseIdentifier: "ReviewCell")
        
        reviewCollectionView.isScrollEnabled = false
    }
    
    func setViewDesign(_ setView: UIView) {
        setView.layer.borderWidth = 1
        setView.layer.cornerRadius = roadSearchView.frame.width / 2
        setView.layer.borderColor = UIColor.mainDarkGrayColor.cgColor
    }
    
    @IBAction func pressWishButton(_ sender: UIButton) {
        if isWish == true {
            wishImage.image = UIImage(named: "star-1")
            wishDeleteData(id!)
            isWish = false
        } else {
            wishImage.image = UIImage(named: "star3")
            wishPostData(id!)
            isWish = true
        }
    }
    
    func goLocation(latitudeValue: CLLocationDegrees, longtudeValue: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longtudeValue)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        mapView.setRegion(pRegion, animated: false)
        return pLocation
    }
    
    func setAnnotation(latitudeValue: CLLocationDegrees,
                          longitudeValue: CLLocationDegrees,
                          delta span :Double){
           let annotation = MKPointAnnotation()
           annotation.coordinate = goLocation(latitudeValue: latitudeValue, longtudeValue: longitudeValue, delta: span)
           mapView.addAnnotation(annotation)
    }
    
    
    @IBAction func pressWriteReviewButton(_ sender: UIButton) {
        guard let VC = self.storyboard?.instantiateViewController(identifier: "ReviewWriteImageSelectViewController") as? ReviewWriteImageSelectViewController else { return }
        VC.modalPresentationStyle = .fullScreen
        self.present(VC, animated: false, completion: nil)
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
            return restuarantDetailInfoList?.imgUrls.count ?? 0
        }
        return (restuarantDetailInfoList?.reviews.count) ?? 0 > 3 ? 3 : restuarantDetailInfoList?.reviews.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == imageCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailImageCell", for: indexPath) as! DetailImageCell
            let url = URL(string: (restuarantDetailInfoList.imgUrls[indexPath.item]))!
            cell.detailImage.load(url: url)
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
        cell.hashView.isHidden = true
        cell.hashView.bottomAnchor.constraint(equalTo: cell.content.topAnchor, constant: 20).isActive = true
        (restuarantDetailInfoList.reviews[indexPath.item].profileImgUrl) == nil ? cell.userImage.image = UIImage(named: "testImage2") : cell.userImage.load(url: URL(string: (restuarantDetailInfoList.reviews[indexPath.item].profileImgUrl!))!)
        cell.userName.text = restuarantDetailInfoList.reviews[indexPath.item].userName
        cell.content.text = restuarantDetailInfoList.reviews[indexPath.item].content
        switch restuarantDetailInfoList.reviews[indexPath.item].score  {
        case 5 :
            cell.score.text = "맛있다!"
            cell.scoreImage.image = UIImage(named: "reviewImage1")
        case 3 :
            cell.score.text = "괜찮다"
            cell.scoreImage.image = UIImage(named: "reviewImage2")
        case 1 :
            cell.score.text = "별로"
            cell.scoreImage.image = UIImage(named: "reviewImage3")
        default :
            break
        }
        //print(restuarantDetailInfoList.reviews[indexPath.item])
        //let url = URL(string: restuarantDetailInfoList.reviews[indexPath.item].imgUrls[0])!
        //print(url)
       // cell.image.load(url: url)
        cell.reviewCount.text = "\(restuarantDetailInfoList.reviews[indexPath.item].reviewCnt!)개"
        cell.followCount.text = "\(restuarantDetailInfoList.reviews[indexPath.item].followCnt!)개"
        cell.updatedAt.text = restuarantDetailInfoList.reviews[indexPath.item].updatedAt
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == imageCollectionView {
            return CGSize(width: (imageCollectionView.bounds.width)/2.5, height: imageCollectionView.bounds.height)
        }
        guard let cell = reviewCollectionView.dequeueReusableCell(withReuseIdentifier: "ReviewCell", for: indexPath) as? ReviewCell else {
                    return .zero
                }
             
        cell.content.text = restuarantDetailInfoList.reviews[indexPath.item].content
        cell.content.sizeToFit()
        let cellheight = cell.content.frame.height + 250
       
        return CGSize(width: reviewCollectionView.bounds.width, height: (cellheight))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == reviewCollectionView {
            guard let RDVC = self.storyboard?.instantiateViewController(identifier: "ReviewDetailViewController") as? ReviewDetailViewController else { return }
            RDVC.id = restuarantDetailInfoList.reviews[indexPath.item].id
            RDVC.modalPresentationStyle = .fullScreen
            self.present(RDVC, animated: false, completion: nil)
        }
    }
}

extension RestaurantDetailViewController {
    func fetchData() {
        let url = AF.request("\(Constant.BASE_URL2)/restaurants/\(id!)")
        url.responseJSON { (response) in
            switch response.result {
            case .success(let obj) :
                if let nsDiectionary = obj as? NSDictionary {
                    do {
                        let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                        let getInstanceData = try JSONDecoder().decode(RestuarantDetail.self, from: dataJSON)
                        if let results = getInstanceData.result {
                            self.restuarantDetailInfoList = results
                            self.imageCollectionView.reloadData()
                            self.reviewCollectionView.reloadData()
                            self.navigationBarName.text = self.restuarantDetailInfoList.name
                            self.restaurantName.text = self.restuarantDetailInfoList.name
                            self.restaurantView.text = "\(self.restuarantDetailInfoList.view)"
                            self.restaurantReviewsCount.text = "\(self.restuarantDetailInfoList.reviews.count)"
                            self.restaurantWishCount.text = "\(self.restuarantDetailInfoList.wishCnt)"
                            self.restaurantScore.text = "\(self.restuarantDetailInfoList.score)"
                            self.restaurantAddress.text = self.restuarantDetailInfoList.address
                            self.setAnnotation(latitudeValue: self.restuarantDetailInfoList.latitude, longitudeValue: self.restuarantDetailInfoList.longitude, delta: 0.0005)
                            self.restaurantUpdatedAt1.text = self.restuarantDetailInfoList.updatedAt
                            self.restaurantUpdatedAt2.text = self.restuarantDetailInfoList.updatedAt
                            self.restaurantOpenHour.text = self.restuarantDetailInfoList.openHour
                            self.restaurantCloseHour.text = self.restuarantDetailInfoList.closeHour
                            self.restaurantBreakTime1.text = self.restuarantDetailInfoList.dayOff
                            self.restaurantBreakTime2.text = self.restuarantDetailInfoList.breakTime
                            self.menu1.text = self.restuarantDetailInfoList.menus[0].name
                            self.menu2.text = self.restuarantDetailInfoList.menus[1].name
                            self.menu3.text = self.restuarantDetailInfoList.menus[2].name
                            self.menuPrice1.text = "\(self.restuarantDetailInfoList.menus[0].price)"
                            self.menuPrice2.text = "\(self.restuarantDetailInfoList.menus[1].price)"
                            self.menuPrice3.text = "\(self.restuarantDetailInfoList.menus[2].price)"
                            self.reviewsCount.text = "\(self.restuarantDetailInfoList.reviews.count)"
                            self.review1Count.text = "(\(self.restuarantDetailInfoList.reviews.filter{$0.score==5}.count))"
                            self.review2Count.text = "(\(self.restuarantDetailInfoList.reviews.filter{$0.score==3}.count))"
                            self.review3Count.text = "(\(self.restuarantDetailInfoList.reviews.filter{$0.score==1}.count))"
                            switch self.restuarantDetailInfoList.minPrice {
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
                            switch self.restuarantDetailInfoList.maxPrice {
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
                                    self.wishImage.image = x == 0 ? UIImage(named: "star-1") : UIImage(named: "star3")
                                    self.isWish = x == 0 ? false : true
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
