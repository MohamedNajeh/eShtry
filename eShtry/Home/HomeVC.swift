//
//  HomeVC.swift
//  eShtry
//
//  Created by Najeh on 10/03/2022.
//

import UIKit
import MobileBuySDK
class HomeVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let searchController = UISearchController()
    var currentIndex = 0
    var timer:Timer?
    var products:[Storefront.Product] = []
    var mov = [1,2,3,2,1,4,5,2,21,21,32,6]
    
    var collectionsArr = [SmartCollection]()
    var productsArr    = [Products]()
    
    let networkShared = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "eShtry"
        
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(timeAction))
        
        collectionView.collectionViewLayout = creatCompositionalLayout()
        collectionView.register(UINib(nibName: "HeaderView", bundle: nil), forSupplementaryViewOfKind: "header", withReuseIdentifier: "HeaderView")
        collectionView.register(UINib(nibName: "SliderCell", bundle: nil), forCellWithReuseIdentifier: "sliderCell")
        collectionView.register(UINib(nibName: "OffersCell", bundle: nil), forCellWithReuseIdentifier: "offersCell")
        collectionView.register(UINib(nibName: "BrandCell", bundle: nil), forCellWithReuseIdentifier: "brandCell")
        collectionView.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "productCell")
        
        getColletionsData()
        fetchProductsUsingGrapgQL()
        //getProductsData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.searchController?.searchBar.isHidden = false
    }
    
    func fetchProductsUsingGrapgQL(){
        Client.shared.fetchAllProducts { products in
            if let products = products {
                self.products = products
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            else{
                print("Error Happened while loading products")
            }
        }
    }
    
    private func getColletionsData(){
        
        networkShared.getDataFromApi(urlString: "https://f36da23eb91a2fd4cba11b9a30ff124f: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@jets-ismailia.myshopify.com/admin/api/2022-01/smart_collections.json", baseModel: SmartCollectionRoot.self) { result  in
            switch result{
            case .success(let result):
                guard let smartCollection = result.smart_collections else {return}
                self.collectionsArr = smartCollection
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getProductsData(){
        
        networkShared.getDataFromApi(urlString: productsUrl, baseModel: ProductsRoot.self) { result in
            switch result {
            case .success(let products):
                guard let productsArr = products.products else {return}
                self.productsArr = productsArr
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
//    override func viewWillAppear(_ animated: Bool) {
//        if collectionView.contentOffset.y == 0 {
//           // startTimer()
//        }
//    }
    
    func startTimer(){
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.timeAction), userInfo: nil, repeats: true)
        }
    }
    
    func stopTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    @objc func timeAction(){
        if collectionView.contentOffset.y > 0 {
            stopTimer()
        }else{
            if currentIndex < 19 {
                currentIndex += 1
            }else{
                currentIndex = 0
            }
            collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
    
    func creatCompositionalLayout() -> UICollectionViewCompositionalLayout{
        let layout = UICollectionViewCompositionalLayout { [weak self] (index, enviroment) -> NSCollectionLayoutSection? in
            self?.creatSectionFor(index: index, enviroment: enviroment)
        }
        return layout
    }
    
    func creatSectionFor(index: Int , enviroment:NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection{
        
        switch index {
        case 0:
            return creatFirstSection()
        case 1:
            return creatSecondSection()
        case 2:
            return creatThirdSection()
        case 3:
            return creatForthSection()
        case 4:
            return creatFifthSection()
        default:
            return creatFirstSection()
        }
    }
    
    
    func creatFirstSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2.5, leading: 2.5, bottom: 2.5, trailing: 2.5)
        //Configure Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.25))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        //supplemantary
        //        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40))
        //        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)
        //        section.boundarySupplementaryItems = [header]
        return section
    }
    
    func creatSecondSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2.5, leading: 2.5, bottom: 2.5, trailing: 2.5)
        //Configure Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        //supplemantary
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    func creatThirdSection() -> NSCollectionLayoutSection {
        //smallItems
        let smallItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.33))
        let samllItem = NSCollectionLayoutItem(layoutSize: smallItemSize)
        samllItem.contentInsets = NSDirectionalEdgeInsets(top: 2.5, leading: 2.5, bottom: 2.5, trailing: 2.5)
        
        let largeItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let largeItem = NSCollectionLayoutItem(layoutSize: largeItemSize)
        largeItem.contentInsets = NSDirectionalEdgeInsets(top: 2.5, leading: 2.5, bottom: 2.5, trailing: 2.5)
        //Configure Groups
        let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1))
        let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitems: [samllItem])
        
        let horizantilGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.4))
        let horizantilGroup = NSCollectionLayoutGroup.horizontal(layoutSize: horizantilGroupSize, subitems: [verticalGroup ,verticalGroup,verticalGroup])
        //section
        let section = NSCollectionLayoutSection(group: horizantilGroup)
        section.orthogonalScrollingBehavior = .groupPaging
        
        //supplemantary
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    func creatForthSection() -> NSCollectionLayoutSection {
        //smallItems
        let smallItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
        let samllItem = NSCollectionLayoutItem(layoutSize: smallItemSize)
        samllItem.contentInsets = NSDirectionalEdgeInsets(top: 2.5, leading: 2.5, bottom: 2.5, trailing: 2.5)
        
        let largeItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let largeItem = NSCollectionLayoutItem(layoutSize: largeItemSize)
        largeItem.contentInsets = NSDirectionalEdgeInsets(top: 2.5, leading: 2.5, bottom: 2.5, trailing: 2.5)
        //Configure Groups
        let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitems: [samllItem])
        
        let horizantilGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.7))
        let horizantilGroup = NSCollectionLayoutGroup.horizontal(layoutSize: horizantilGroupSize, subitems: [verticalGroup ,verticalGroup,verticalGroup])
        //section
        let section = NSCollectionLayoutSection(group: horizantilGroup)
        section.orthogonalScrollingBehavior = .continuous
        
        //supplemantary
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    func creatFifthSection() -> NSCollectionLayoutSection {
        //smallItems
        let smallItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
        let samllItem = NSCollectionLayoutItem(layoutSize: smallItemSize)
        samllItem.contentInsets = NSDirectionalEdgeInsets(top: 2.5, leading: 2.5, bottom: 2.5, trailing: 2.5)
        
        let largeItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let largeItem = NSCollectionLayoutItem(layoutSize: largeItemSize)
        largeItem.contentInsets = NSDirectionalEdgeInsets(top: 2.5, leading: 2.5, bottom: 2.5, trailing: 2.5)
        //Configure Groups
        let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitems: [samllItem])
        
        //--- above group
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [largeItem])
        
        let horizantilGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
        let horizantilGroup = NSCollectionLayoutGroup.horizontal(layoutSize: horizantilGroupSize, subitems: [verticalGroup,verticalGroup])
        
        let allGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.25))
        let allGroup = NSCollectionLayoutGroup.vertical(layoutSize: allGroupSize, subitems: [group,horizantilGroup])
        //section
        let section = NSCollectionLayoutSection(group: allGroup)
        section.orthogonalScrollingBehavior = .groupPaging
        
        //supplemantary
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
    
}

extension HomeVC:UICollectionViewDataSource,UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        return section == 2 ? 15 : 20
        switch section {
        case 0:
            return 5
        case 1:
            return 5
        case 2:
            return collectionsArr.count
        case 3:
            return products.count
        default :
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        switch indexPath.section {
        case 0:
            let sliderCell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath) as! SliderCell
            sliderCell.sliderImg.image = UIImage(named: "add")
            return sliderCell
        case 1:
            let offersCell = collectionView.dequeueReusableCell(withReuseIdentifier: "offersCell", for: indexPath) as! OffersCell
            offersCell.offerImg.image = UIImage(named: "offer2")
            return offersCell
        case 2:
            let brandCell = collectionView.dequeueReusableCell(withReuseIdentifier: "brandCell", for: indexPath) as! BrandCell
            brandCell.brandImg.downloadImg(from: collectionsArr[indexPath.row].image?.src ?? "")
            brandCell.brandName.text = "Adidas"
            return brandCell
        case 3:
            let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCell
            productCell.downloadImg(from:"\((products[indexPath.row].featuredImage?.url)!)")
            productCell.productName.text = products[indexPath.row].title
            productCell.productPrice.text = "\(products[indexPath.row].priceRange.minVariantPrice.amount)"
            return productCell
        default:
            let offersCell = collectionView.dequeueReusableCell(withReuseIdentifier: "offersCell", for: indexPath) as! OffersCell
            offersCell.offerImg.image = UIImage(named: "offer1")
            return offersCell
         
            
            
        }
        //        cell.backgroundColor = UIColor(hue: CGFloat(drand48()), saturation: 1, brightness: 1, alpha: 1)
        //  return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderView else{
            return UICollectionReusableView()
        }
        switch indexPath.section{
        case 0:
            view.title = " "
        case 1:
            view.title = "Offers"
        case 2:
            view.title = "Brands"
        case 3:
            view.title = "Recommended"
        case 4:
            view.title = "what's new?"
        default:
            print("NO Thing")
        }
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "productsVC") as! BrandProductsVC
            vc.vendor = collectionsArr[indexPath.row].title!
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension HomeVC: UISearchBarDelegate{
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let storyboard = UIStoryboard(name: "SearchSB", bundle: nil)
        let searchVC = storyboard.instantiateViewController(identifier: "SearchResultVC") as! SearchResultVC
        self.navigationController?.pushViewController(searchVC, animated: true)
        searchBar.setShowsCancelButton(false, animated: true)
        return false
    }
}

