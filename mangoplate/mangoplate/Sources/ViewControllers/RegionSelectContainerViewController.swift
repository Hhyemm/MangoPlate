
import UIKit

class RegionSelectContainerViewController: UIViewController {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var regionCollectionView: UICollectionView!
    @IBOutlet weak var applyView: UIView!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!
    
    var selectCategoryIndex = 0
    var pressedRegionCount = 0
    var pressedRegion = [String]()
    var nowView = ""
    
    var categoryList = ["서울-강남", "서울-강북", "경기도", "인천", "대구", "부산", "제주"]
    var regionList = [["전체", "강동구", "개포동", "관악구", "구로구", "금천구", "논현동", "대치동", "도곡동", "방이동", "삼성동", "양재동", "청담동"],["전체", "노원구", "동대문구", "동부이촌동", "서대문구", "성북구", "연남동", "은평구", "한남동", "중구", "중랑구"], ["전체", "가평군", "고양시", "과천시", "광명시", "광주시", "구리시", "군포시", "김포시", "남양주시", "동두천시", "부천시", "성남시", "수원시", "시흥시", "안산시"],["전체", "인천 강화군", "인천 계양구", "인천 남동구", "인천 동구", "인천 미주홀구", "인천 부평구", "인천 서구", "인천 연수구", "인천 옹진군", "인천 중구"],["전체", "대구 남구", "대구 달서구", "대구 달성군", "대구 동구", "대구 북구", "대구 서구", "대구 수성구"],["전체", "부산 강서구", "부산 금정구", "부산 기장군", "부산 남구"],["전체"]]
    var selectRegions = [Int:[Int]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.2)
        
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
        if nowView == "search" {
            dismiss(animated: false, completion: nil)
        } else {
            if pressedRegionCount > 0 {
                guard let TBVC = self.storyboard?.instantiateViewController(identifier: "TabBarViewController") as? TabBarViewController else { return }
                TBVC.modalPresentationStyle = .fullScreen
                for key in selectRegions.keys {
                   for value in selectRegions[key]!.sorted(by: <) {
                       if value == 0 {
                           pressedRegion.append(categoryList[key])
                           break
                       } else {
                           pressedRegion.append(regionList[key][value])
                       }
                   }
               }
                TBVC.regionTitle = pressedRegion.sorted(by: <)
                self.present(TBVC, animated: false, completion: nil)
            }
        }
    }
    
    @IBAction func pressRemoveButton(_ sender: UIButton) {
        setContainRegionDic()
        pressedRegion = []
        applyView.backgroundColor = .mainLightGrayColor
        removeButton.tintColor = .mainLightGrayColor
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
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryCollectionView {
            return CGSize(width: collectionView.frame.width / 4, height: collectionView.frame.height)
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
                collectionView.deselectItem(at: indexPath, animated: true)
                pressedRegionCount -= 1
                if indexPath.last! == 0 {
                    selectRegions[selectCategoryIndex]! = []
                } else {
                    var values = selectRegions[selectCategoryIndex]!.map{$0}
                    values.remove(at: values.firstIndex(of: indexPath.last!)!)
                    selectRegions[selectCategoryIndex]! = values
                }
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
               if indexPath.last! == 0 {
                   selectRegions[selectCategoryIndex]! = []
                   selectRegions[selectCategoryIndex] = [Int](0..<regionList[selectCategoryIndex].count)
               } else {
                   selectRegions[selectCategoryIndex]!.append(indexPath.last!)
               }
               regionCell.regionName.textColor = .mainOrangeColor
               regionCell.regionView.layer.borderColor = UIColor.mainOrangeColor.cgColor
               regionCell.checkView.isHidden = false
               regionCell.checkImage.isHidden = false
               applyView.backgroundColor = .mainOrangeColor
               removeButton.tintColor = .mainOrangeColor
           }
            regionCollectionView.reloadData()
            categoryCollectionView.reloadData()
        }
    }
}


