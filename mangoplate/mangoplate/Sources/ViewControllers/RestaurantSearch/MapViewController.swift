
import UIKit


class MapViewController: UIViewController {

    @IBOutlet weak var surroundView: UIView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewDesign()
        setCollectionView()
    }
    
    @IBAction func pressRegionButton(_ sender: UIButton) {
        guard let RSVC = self.storyboard?.instantiateViewController(identifier: "RegionSelectContainerViewController") as? RegionSelectContainerViewController else { return }
        RSVC.modalPresentationStyle = .overCurrentContext
        RSVC.nowView = "map"
        self.present(RSVC, animated: false, completion: nil)
    }
    
    @IBAction func pressSearchButton(_ sender: UIButton) {
        guard let SearchVC = self.storyboard?.instantiateViewController(identifier: "SearchViewController") as? SearchViewController else { return }
        SearchVC.modalPresentationStyle = .fullScreen
        self.present(SearchVC, animated: false, completion: nil)
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
        guard let SortVC = self.storyboard?.instantiateViewController(identifier: "SortViewController") as? SortViewController else { return }
        SortVC.modalPresentationStyle = .overCurrentContext
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
