
import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    
    @IBOutlet weak var nowRegionTitle: UILabel!
    @IBOutlet weak var surroundView: UIView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nowMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewDesign()
        setCollectionView()
        setNowLocation()
    }

    @IBAction func pressRegionButton(_ sender: UIButton) {
        guard let VC = self.storyboard?.instantiateViewController(identifier: "RegionSelectContainerViewController") as? RegionSelectContainerViewController else { return }
        VC.modalPresentationStyle = .overCurrentContext
        VC.nowView = "map"
        self.present(VC, animated: false, completion: nil)
    }
    
    @IBAction func pressSearchButton(_ sender: UIButton) {
        guard let VC = self.storyboard?.instantiateViewController(identifier: "SearchViewController") as? SearchViewController else { return }
        VC.modalPresentationStyle = .fullScreen
        self.present(VC, animated: false, completion: nil)
    }
    
    @IBAction func pressBackButton(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func setViewDesign() {
        filterView.layer.borderWidth = 1
        filterView.layer.borderColor = UIColor.mainDarkGrayColor.cgColor
        filterView.layer.cornerRadius = filterView.frame.height / 2
        
        surroundView.layer.cornerRadius = surroundView.frame.height / 2
    }
    
    @IBAction func pressSortButton(_ sender: UIButton) {
        guard let VC = self.storyboard?.instantiateViewController(identifier: "SortViewController") as? SortViewController else { return }
        VC.modalPresentationStyle = .overCurrentContext
        self.present(VC, animated: false, completion: nil)
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
    
    func setNowLocation() {
        if locationAgree == true {
            findLocation()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            goLocation(latitudeValue: myLocation.0, longtudeValue: myLocation.1, delta: 0.01)
            nowMap.showsUserLocation = true
        }
    }
    
    func setAnnotation(latitudeValue: CLLocationDegrees,
                           longitudeValue: CLLocationDegrees,
                           delta span :Double){
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitudeValue: latitudeValue, longtudeValue: longitudeValue, delta: span)
        nowMap.addAnnotation(annotation)
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
    
    func goLocation(latitudeValue: CLLocationDegrees,
                        longtudeValue: CLLocationDegrees,
                        delta span: Double) -> CLLocationCoordinate2D {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longtudeValue)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        nowMap.setRegion(pRegion, animated: true)
        return pLocation
    }
    
    func setCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "MapRestaurantCell", bundle: nil), forCellWithReuseIdentifier: "MapRestaurantCell")
        
        collectionView.layer.borderWidth = 1
        collectionView.layer.borderColor = UIColor.mainLightGrayColor.cgColor
    }
}

extension MapViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MapRestaurantCell", for: indexPath) as! MapRestaurantCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width-10, height: collectionView.frame.height)
    }
}
