
import UIKit

class AllViewController: UIViewController {

    @IBOutlet weak var select5View: UIView!
    @IBOutlet weak var select3View: UIView!
    @IBOutlet weak var select1View: UIView!
    
    @IBOutlet weak var select5Label: UILabel!
    @IBOutlet weak var select3Label: UILabel!
    @IBOutlet weak var select1Label: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setViewDesign(select5View)
        setViewDesign(select3View)
        setViewDesign(select1View)
        pressSelectButton(select5View, select5Label)
        upPressSelectButton(select3View, select3Label)
        upPressSelectButton(select1View, select1Label)
        
        setCollectionVieW()
    }
    
    func setViewDesign(_ selectView: UIView) {
        selectView.layer.borderWidth = 1
        selectView.layer.cornerRadius = selectView.frame.height / 2
    }
    
    func pressSelectButton(_ selectView: UIView, _ selectLabel: UILabel) {
        selectView.layer.borderColor = UIColor.mainOrangeColor.cgColor
        selectLabel.textColor = .mainOrangeColor
    }
    
    func upPressSelectButton(_ selectView: UIView, _ selectLabel: UILabel) {
        selectView.layer.borderColor = UIColor.mainLightGrayColor.cgColor
        selectLabel.textColor = .mainLightGrayColor
        
    }
    
    func setCollectionVieW() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "NewsCell", bundle: nil), forCellWithReuseIdentifier: "NewsCell")
    }
}

extension AllViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as! NewsCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/1.3)
    }
}
