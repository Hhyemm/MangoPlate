
import UIKit
import Pageboy

class FilterViewController: UIViewController {

    @IBOutlet weak var parkXView: UIView!
    @IBOutlet weak var parkOView: UIView!
    
    @IBOutlet weak var parkXLabel: UILabel!
    @IBOutlet weak var parkOLabel: UILabel!
    
    @IBOutlet weak var price0View: UIView!
    @IBOutlet weak var price1View1: UIView!
    @IBOutlet weak var price1View2: UIView!
    @IBOutlet weak var price2View1: UIView!
    @IBOutlet weak var price2View2: UIView!
    @IBOutlet weak var price2View3: UIView!
    @IBOutlet weak var price3View1: UIView!
    @IBOutlet weak var price3View2: UIView!
    @IBOutlet weak var price3View3: UIView!
    @IBOutlet weak var price3View4: UIView!
    
    @IBOutlet weak var price0Label: UILabel!
    @IBOutlet weak var price1Label: UILabel!
    @IBOutlet weak var price2Label: UILabel!
    @IBOutlet weak var price3Label: UILabel!
    
    
    @IBOutlet weak var price0CheckView: UIView!
    @IBOutlet weak var price1CheckView: UIView!
    @IBOutlet weak var price2CheckView: UIView!
    @IBOutlet weak var price3CheckView: UIView!
    
    @IBOutlet weak var price0CheckImageView: UIImageView!
    @IBOutlet weak var price1CheckImageView: UIImageView!
    @IBOutlet weak var price2CheckImageView: UIImageView!
    @IBOutlet weak var price3CheckImageView: UIImageView!
    
    @IBOutlet weak var foodCollectionView: UICollectionView!
    
    let foodImages = ["filterFood1", "filterFood2", "filterFood3", "filterFood4", "filterFood5", "filterFood6", "filterFood7", "filterFood8"]
    let foodTitles = ["한식", "일식", "중식", "양식", "세계음식", "뷔페", "카페", "주점"]
    var selectFoodCategory = [IndexPath]()
    var selectPrice = [10:false, 11:false, 12:false, 13:false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionView()
        setPriceView()
        setPriceCheck()
        pressParkButton(parkXView, parkXLabel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.2)
    }
    
    @IBAction func pressCancelButton(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func pressApplyButton(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func setCollectionView() {
        self.foodCollectionView.delegate = self
        self.foodCollectionView.dataSource = self
        
        foodCollectionView.register(UINib(nibName: "FilterFoodCell", bundle: nil), forCellWithReuseIdentifier: "FilterFoodCell")
    }
    
    func setPriceView() {
        let priceViews = [price0View, price1View1, price1View2, price2View1, price2View2, price2View3, price3View1, price3View2, price3View3, price3View4]
        for priceView in priceViews {
            setUnPressedPriceViewDesign(priceView!)
        }
    }
    
    func setPressedPriceViewDesign(_ priceView: UIView) {
        priceView.layer.borderColor = UIColor.mainOrangeColor.cgColor
    }
    
    func setUnPressedPriceViewDesign(_ priceView: UIView) {
        priceView.layer.borderWidth = 2
        priceView.layer.borderColor = UIColor.mainLightGrayColor.cgColor
        priceView.layer.cornerRadius = price0View.frame.width / 2
    }
    
    func setPriceCheck() {
        let priceCheckViews = [price0CheckView, price1CheckView, price2CheckView, price3CheckView]
        let priceCheckImages = [price0CheckImageView, price1CheckImageView, price2CheckImageView, price3CheckImageView]
        for i in 0..<priceCheckViews.count {
            priceCheckViews[i]?.isHidden = true
            priceCheckImages[i]?.isHidden = true
        }
    }
    
    func pressPriceButton(_ priceLabel: UILabel, _ checkView: UIView, _ checkImage: UIImageView) {
        priceLabel.textColor = .mainOrangeColor
        
        checkView.isHidden = false
        checkView.transform = .init(rotationAngle: 2.35)
        checkImage.isHidden = false
    }
    
    func unPressPriceButton(_ priceLabel: UILabel, _ checkView: UIView, _ checkImage: UIImageView) {
        priceLabel.textColor = .lightGray
        
        checkView.isHidden = true
        checkImage.isHidden = true
    }
    
    func selectPriceButton(_ priceViews: [UIView], _ priceLabel: UILabel, _ checkView: UIView, _ checkImage: UIImageView, _ tag: Int) {
        if selectPrice[tag]! {
            for i in 0..<priceViews.count {
                setUnPressedPriceViewDesign(priceViews[i])
            }
            unPressPriceButton(priceLabel, checkView, checkImage)
        } else {
            for i in 0..<priceViews.count {
                setPressedPriceViewDesign(priceViews[i])
            }
            pressPriceButton(priceLabel, checkView, checkImage)
        }
        selectPrice[tag]! = !selectPrice[tag]!
    }
    
    @IBAction func pressPrice0Button(_ sender: UIButton) {
        selectPriceButton([price0View], price0Label, price0CheckView, price0CheckImageView, sender.tag)
    }
    
    @IBAction func pressPrice1Button(_ sender: UIButton) {
        selectPriceButton([price1View1, price1View2], price1Label, price1CheckView, price1CheckImageView, sender.tag)
    }
    
    @IBAction func pressPrice2Button(_ sender: UIButton) {
        selectPriceButton([price2View1, price2View2, price2View3], price2Label, price2CheckView, price2CheckImageView, sender.tag)
    }
    
    @IBAction func pressPrice3Button(_ sender: UIButton) {
        selectPriceButton([price3View1, price3View2, price3View3, price3View4], price3Label, price3CheckView, price3CheckImageView, sender.tag)
    }
    
    func pressParkButton(_ sortView: UIView, _ sortLabel: UILabel) {
        sortView.layer.borderWidth = 2
        sortView.layer.borderColor = UIColor.mainOrangeColor.cgColor
        sortView.layer.cornerRadius = sortView.frame.height / 2
        sortLabel.textColor = .mainOrangeColor
    }
    
    func unPressParkButton(_ sortView: UIView, _ sortLabel: UILabel) {
        sortView.layer.borderWidth = 0
        sortLabel.textColor = .lightGray
    }
    
    @IBAction func pressParkXButton(_ sender: UIButton) {
        pressParkButton(parkXView, parkXLabel)
        unPressParkButton(parkOView, parkOLabel)
    }
    
    @IBAction func pressParkOButton(_ sender: UIButton) {
        pressParkButton(parkOView, parkOLabel)
        unPressParkButton(parkXView, parkXLabel)
    }
}

extension FilterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterFoodCell", for: indexPath) as! FilterFoodCell
        cell.foodImageView.image = UIImage(named: foodImages[indexPath.item])
        cell.foodLabel.text = foodTitles[indexPath.item]
        return cell
    }
    
    // 위 아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: foodCollectionView.frame.width / 4 - 15, height: foodCollectionView.frame.height / 2 - 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
       let cell = collectionView.cellForItem(at: indexPath) as! FilterFoodCell
        if selectFoodCategory.contains(indexPath) {
            collectionView.deselectItem(at: indexPath, animated: true)
            selectFoodCategory.remove(at: selectFoodCategory.firstIndex(of: indexPath)!)
            cell.foodLabel.textColor = .mainLightGrayColor
            cell.foodView.layer.borderColor = UIColor.mainLightGrayColor.cgColor
            cell.foodImageView.tintColor = .mainLightGrayColor
            cell.checkView.isHidden = true
            cell.checkImageView.isHidden = true
            return false
       } else {
           selectFoodCategory.append(indexPath)
           cell.foodLabel.textColor = .mainOrangeColor
           cell.foodView.layer.borderColor = UIColor.mainOrangeColor.cgColor
           cell.foodImageView.tintColor = .mainOrangeColor
           cell.checkView.isHidden = false
           cell.checkImageView.isHidden = false
           return true
       }
   }
}

