
import UIKit

protocol sendPressIndex: AnyObject {
    func pressIndexCell(isPress: Bool)
}

class RegionSelectItem1ViewController: UIViewController {
    var list = ["홍대", "이태원/한남동", "신촌/이대", "강남역", "가로수길", "평택시", "방배/반포/잠원"]
    
    var delegate: sendPressIndex?
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "RegionSelectCell", bundle: nil), forCellWithReuseIdentifier: "RegionSelectCell")
        
    }
}

extension RegionSelectItem1ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RegionSelectCell", for: indexPath) as! RegionSelectCell
        cell.regionName.text = list[indexPath.item]
        return cell
    }
    
    // 위 아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width / 2 - 15, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RegionSelectCell", for: indexPath) as! RegionSelectCell
        delegate?.pressIndexCell(isPress: true)
    }
}
