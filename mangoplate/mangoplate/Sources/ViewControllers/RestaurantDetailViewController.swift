
import UIKit

class RestaurantDetailViewController: UIViewController {

    @IBOutlet weak var navigationBar: UIView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var roadSearchView: UIView!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var taxiView: UIView!
    @IBOutlet weak var adressView: UIView!
    @IBOutlet weak var callView: UIView!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var reviewCollectionView: UICollectionView!
    @IBOutlet weak var blogSearchView: UIView!
    
    let MaxTopHeight: CGFloat = 250
    let MinTopHeight: CGFloat = 50
    
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
}

extension RestaurantDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
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
}

