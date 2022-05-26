
import UIKit

class RegionSelectContainerViewController: UIViewController {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var regionCollectionView: UICollectionView!
    @IBOutlet weak var applyView: UIView!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!
    
    var selectCategoryIndex = 0
    var pressedRegionCount = 0
    
    var categoryList = ["인기지역", "서울-강남", "서울-강북", "경기도", "인천", "대구", "부산", "제주"]
    var regionList = [["홍대", "이태원/한남동", "신촌/이대", "강남역", "평택시", "방배/반포/잠원"],["전체", "강남역", "강동구", "개포/수서/일원", "관악구", "교대/서초", "구로구"], ["전체", "건대/군자/광진", "노원구", "대학로/혜화", "동대문구", "동부이촌동", "마포/공덕", "명동/남산", "삼청/인사"],["전체", "가평동", "고양시", "과천시", "광명시"],[],[],[]]
    var selectRegions = [Int:[Int]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionView()
        setContainRegionDic()
        applyView.layer.cornerRadius = applyView.frame.height / 2
    }
    
    func setCollectionView() {
        self.categoryCollectionView.delegate = self
        self.categoryCollectionView.dataSource = self
        self.regionCollectionView.delegate = self
        self.regionCollectionView.dataSource = self
        
        categoryCollectionView.register(UINib(nibName: "RegionCategoryCell", bundle: nil), forCellWithReuseIdentifier: "RegionCategoryCell")
        categoryCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: [])

        regionCollectionView.register(UINib(nibName: "RegionSelectCell", bundle: nil), forCellWithReuseIdentifier: "RegionSelectCell")
    }
    
    func setContainRegionDic() {
        for i in 0..<categoryList.count {
            selectRegions.updateValue([], forKey: i)
        }
    }
    
    @IBAction func pressApplyButton(_ sender: UIButton) {
        if pressedRegionCount > 0 {
            guard let RSVC = self.storyboard?.instantiateViewController(identifier: "RestaurantSearchViewController") as? RestaurantSearchViewController else { return }
            RSVC.modalPresentationStyle = .fullScreen
            self.present(RSVC, animated: false, completion: nil)
        }
    }
    
    @IBAction func pressRemoveButton(_ sender: UIButton) {
        setContainRegionDic()
        categoryCollectionView.reloadData()
        regionCollectionView.reloadData()
    }
}

extension RegionSelectContainerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView {
            return categoryList.count
        }
        return regionList[selectCategoryIndex].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RegionCategoryCell", for: indexPath) as! RegionCategoryCell
            cell.regionTitleLabel.text = categoryList[indexPath.item]
            if selectRegions[indexPath.item]!.count > 0 {
                cell.countView.isHidden = false
                cell.countLabel.text = String(selectRegions[indexPath.item]!.count)
            } else if selectRegions[indexPath.item]!.count == 0 {
                cell.countView.isHidden = true
            }
            if indexPath.item == selectCategoryIndex {
                cell.indicatorView.isHidden = false
                cell.regionTitleLabel.textColor = .mainOrangeColor
            } else if indexPath.item != selectCategoryIndex {
                cell.indicatorView.isHidden = true
                cell.regionTitleLabel.textColor = .mainLightGrayColor
            }
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RegionSelectCell", for: indexPath) as! RegionSelectCell
        cell.regionName.text = regionList[selectCategoryIndex][indexPath.item]
        if selectRegions[selectCategoryIndex]!.contains(indexPath.item) {
            cell.regionName.textColor = .mainOrangeColor
            cell.regionView.layer.borderColor = UIColor.mainOrangeColor.cgColor
            cell.checkView.isHidden = false
            cell.checkImage.isHidden = false
        } else {
            cell.regionName.textColor = .mainLightGrayColor
            cell.regionView.layer.borderColor = UIColor.mainLightGrayColor.cgColor
            cell.checkView.isHidden = true
            cell.checkImage.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == categoryCollectionView {
            return 0
        }
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryCollectionView {
            return CGSize(width: collectionView.frame.width / 3.5, height: collectionView.frame.height)
        }
        return CGSize(width: collectionView.frame.width / 2 - 15, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            selectCategoryIndex = indexPath.last!
            regionCollectionView.reloadData()
            categoryCollectionView.reloadData()
        } else if collectionView == regionCollectionView {
            let regionCell = collectionView.cellForItem(at: indexPath) as! RegionSelectCell
            if selectRegions[selectCategoryIndex]!.contains(indexPath.last!) {
                pressedRegionCount -= 1
                collectionView.deselectItem(at: indexPath, animated: true)
                var values = selectRegions[selectCategoryIndex]!.map{$0}
                values.remove(at: values.firstIndex(of: indexPath.last!)!)
                selectRegions[selectCategoryIndex]! = values
                regionCell.regionName.textColor = .mainLightGrayColor
                regionCell.regionView.layer.borderColor = UIColor.mainLightGrayColor.cgColor
                regionCell.checkView.isHidden = true
                regionCell.checkImage.isHidden = true
                if selectRegions[selectCategoryIndex]!.count == 0 {
                    applyView.backgroundColor = .mainLightGrayColor
                    removeButton.tintColor = .mainLightGrayColor
                }
           } else {
               pressedRegionCount += 1
               selectRegions[selectCategoryIndex]!.append(indexPath.last!)
               regionCell.regionName.textColor = .mainOrangeColor
               regionCell.regionView.layer.borderColor = UIColor.mainOrangeColor.cgColor
               regionCell.checkView.isHidden = false
               regionCell.checkImage.isHidden = false
               applyView.backgroundColor = .mainOrangeColor
               removeButton.tintColor = .mainOrangeColor
           }
            categoryCollectionView.reloadData()
        }
    }
}


