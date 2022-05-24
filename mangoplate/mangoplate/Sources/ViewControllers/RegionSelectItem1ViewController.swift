
import UIKit

class RegionSelectItem1ViewController: UIViewController {
    
    var list = ["홍대", "이태원/한남동", "신촌/이대", "강남역", "가로수길", "평택시", "방배/반포/잠원"]
    var selectRegions = [IndexPath]()
   
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
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
       let cell = collectionView.cellForItem(at: indexPath) as! RegionSelectCell
        if selectRegions.contains(indexPath) {
            collectionView.deselectItem(at: indexPath, animated: true)
            selectRegions.remove(at: selectRegions.firstIndex(of: indexPath)!)
            cell.regionName.textColor = .mainLightGrayColor
            cell.regionView.layer.borderColor = UIColor.mainLightGrayColor.cgColor
            return false
       } else {
           selectRegions.append(indexPath)
           cell.regionName.textColor = .mainOrangeColor
           cell.regionView.layer.borderColor = UIColor.mainOrangeColor.cgColor
           
           return true
       }
   }
}
