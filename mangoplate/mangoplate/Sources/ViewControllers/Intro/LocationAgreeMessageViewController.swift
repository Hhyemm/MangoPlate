
import UIKit
import CoreLocation

var locationAgree = false
var myLocation = (37.5732, 126.9891)

class LocationAgreeMessageViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
    }
}

extension LocationAgreeMessageViewController {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("GPS 권한 설정됨")
            self.locationManager.startUpdatingLocation()
            locationAgree = true
            guard let TBVC = self.storyboard?.instantiateViewController(identifier: "TabBarViewController") as? TabBarViewController else { return }
            TBVC.modalPresentationStyle = .fullScreen
            self.present(TBVC, animated: false)
        case .restricted, .notDetermined:
            print("GPS 권한 설정되지 않음")
        case .denied:
            print("GPS 권한 요청 거부됨")
            locationAgree = false
            guard let RSCVC = self.storyboard?.instantiateViewController(identifier: "RegionSelectViewController") as? RegionSelectViewController else { return }
            RSCVC.modalPresentationStyle = .fullScreen
            self.present(RSCVC, animated: false)
        default:
            print("GPS: Default")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil{
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            print(currentLocation)
        }
    }
}
