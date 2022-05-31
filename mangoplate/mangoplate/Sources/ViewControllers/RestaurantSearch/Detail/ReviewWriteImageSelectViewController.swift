
import UIKit
import Photos

class ReviewWriteImageSelectViewController: UIViewController {

    @IBOutlet weak var collectionViewView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var selectCount = 0
    
    var images = ["cameraImage", "searchImage1", "searchImage2", "searchImage3", "searchImage4", "searchImage5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCollectionVieW()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkAlbumPermission()
    }
    
    func setCollectionVieW() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "ReviewImageSelectCell", bundle: nil), forCellWithReuseIdentifier: "ReviewImageSelectCell")

        collectionView.isScrollEnabled = false
        collectionViewView.isHidden = true
    }
    
    func checkAlbumPermission() {
        PHPhotoLibrary.requestAuthorization ({ status in
            switch status {
            case .notDetermined, .restricted:
                print("Album: 선택하지 않음")
            case .denied:
                print("Album: 권한 거부")
            case .authorized:
                print("Album: 권한 허용")
                DispatchQueue.main.async {
                    self.collectionViewView.isHidden = false
                }
            default:
                print("완료")
            }
        })
    }
    
    @IBAction func pressXButton(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func pressPassButton(_ sender: UIButton) {
        guard let VC = self.storyboard?.instantiateViewController(identifier: "ReviewWriteViewController") as? ReviewWriteViewController else { return }
        VC.modalPresentationStyle = .fullScreen
        self.present(VC, animated: false, completion: nil)
    }
}

extension ReviewWriteImageSelectViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewImageSelectCell", for: indexPath) as! ReviewImageSelectCell
        
        cell.image.image = UIImage(named: images[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width-5)/4, height: (collectionView.frame.width-5)/4)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewImageSelectCell", for: indexPath) as! ReviewImageSelectCell
    
    }
     
    
}
