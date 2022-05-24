
import UIKit

class RegionSelectContainerViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var applyView: UIView!
    @IBOutlet weak var applyButton: UIButton!
    
    var list = ["인기지역", "서울-강남", "서울-강북", "경기도", "인천", "대구", "부산", "제주"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionView()
        applyView.layer.cornerRadius = applyView.frame.height / 2
    }
    
    func setCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "RegionCategoryCell", bundle: nil), forCellWithReuseIdentifier: "RegionCategoryCell")
        collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: [])
    }
}

extension RegionSelectContainerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RegionCategoryCell", for: indexPath) as! RegionCategoryCell
        cell.regionTitleLabel.text = list[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 4, height: collectionView.frame.height)
    }
}
