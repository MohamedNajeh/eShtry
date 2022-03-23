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
    var currentIndex = 0
    var timer:Timer?
    var shouldAnimate = true
    var products:[Storefront.Product] = []
    var mov = [1,2,3,2,1,4,5,2,21,21,32,6]
    let color:UIColor = UIColor(red: 43/255, green: 95/255, blue: 147/255, alpha: 1)
    
    var collectionsArr = [SmartCollection]()
    var productsArr    = [Products]()
    var offersImages = ["of1","s2","s1","s1","of5"]
    var addsImages = ["s1","s2","of1","s4","s5"]
    let networkShared = NetworkManager.shared
    
    let viewModel = HomeViewModel()
    let productViewModel = HomeProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureCollectionCells()
        getColletionsData()
        updateViewWithLoadingView()
        updateHomeWithProducts()
    }
    
    func configureNavBar(){
        configureNavigationBar(largeTitleColor: color, backgoundColor: color, tintColor: .white, title: "eshtry".localized, preferredLargeTitle: true)
        let searchButton = UIBarButtonItem(image: UIImage(named: "search"), style: .plain, target: self, action: #selector(searchButtonPressed))
        navigationItem.rightBarButtonItem = searchButton
        
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    @objc func searchButtonPressed(){
        let storyboard = UIStoryboard(name: "SearchSB", bundle: nil)
        let searchVC = storyboard.instantiateViewController(identifier: "SearchResultVC") as! SearchResultVC
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    func configureCollectionCells(){
        collectionView.collectionViewLayout = creatCompositionalLayout()
        collectionView.register(UINib(nibName: "HeaderView", bundle: nil), forSupplementaryViewOfKind: "header", withReuseIdentifier: "HeaderView")
        collectionView.register(UINib(nibName: "SliderCell", bundle: nil), forCellWithReuseIdentifier: "sliderCell")
        collectionView.register(UINib(nibName: "OffersCell", bundle: nil), forCellWithReuseIdentifier: "offersCell")
        collectionView.register(UINib(nibName: "BrandCell", bundle: nil), forCellWithReuseIdentifier: "brandCell")
        collectionView.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "productCell")
    }
    
    
    func updateHomeWithProducts(){
        productViewModel.relodCollectionViewClosure = {
            DispatchQueue.main.async {
                self.products = self.productViewModel.products
                self.collectionView.reloadData()
            }
        }
    }
    
    private func getColletionsData(){
        
        viewModel.relodCollectionViewClosure = {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.collectionsArr = self.viewModel.brandItems
                
            }
        }
    }
    
    private func updateViewWithLoadingView(){
        
        viewModel.bindToShowLoadingToView = {
            print("show Loading")
        }
        viewModel.bindToHideLoadingToView = {
            print("hide Loading")
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchData()
        collectionView.reloadData()
        startTimer()
    }
    
    func startTimer(){
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.timeAction), userInfo: nil, repeats: true)
    }
    
    func stopTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    @objc func timeAction(){
        if shouldAnimate {
        if currentIndex < addsImages.count - 1 {
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
        let smallItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
        let samllItem = NSCollectionLayoutItem(layoutSize: smallItemSize)
        samllItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let largeItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let largeItem = NSCollectionLayoutItem(layoutSize: largeItemSize)
        largeItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        //Configure Groups
        let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
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
        switch section {
        case 0:
            return 5
        case 1:
            return 5
        case 2:
            return viewModel.numberOfCells
        case 3:
            return productViewModel.numberOfCells
        default :
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            shouldAnimate = true
            let sliderCell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath) as! SliderCell
            sliderCell.sliderImg.image = UIImage(named: addsImages[indexPath.row])
            return sliderCell
        case 1:
            let offersCell = collectionView.dequeueReusableCell(withReuseIdentifier: "offersCell", for: indexPath) as! OffersCell
            offersCell.offerImg.image = UIImage(named: offersImages[indexPath.row])
            return offersCell
        case 2:
            let brandCell = collectionView.dequeueReusableCell(withReuseIdentifier: "brandCell", for: indexPath) as! BrandCell
            let cellVM = viewModel.getCellViewModel(at: indexPath)
            brandCell.configureCell(cell: cellVM)
            return brandCell
        case 3:
            let productCell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCell
            productCell.configureHomeProduct(cellVM: productViewModel.getCellViewModel(at: indexPath))
            if(CoreDataManager.shared.isInFovorite(productId: "\(productViewModel.getCellViewModel(at: indexPath).id)")){
                productCell.favoriteButtonOutlet.setImage(UIImage(named: "filldHeart"), for: .normal)
            }else{
                productCell.favoriteButtonOutlet.setImage(UIImage(named: "emptyHeart"), for: .normal)
            }
            
            productCell.addToFavorites = { [weak self] in
                guard let self = self else { return }
                let product = Product(id: "\(self.productViewModel.getCellViewModel(at: indexPath).id)", imageUrl: "\(self.productViewModel.getCellViewModel(at: indexPath).imgUrl)", name: "\(self.productViewModel.getCellViewModel(at: indexPath).name)")
                print("product = \(product)")
                guard let isLogedIn = UserDefaults.standard.object(forKey: "login") as? Bool , isLogedIn else{
                    BrandProductsVC.showToast(controller: self, message: "you must bo logged in to favorite products", seconds: 1)
                    return
                }
                if(CoreDataManager.shared.isInFovorite(productId: "\(self.productViewModel.getCellViewModel(at: indexPath).id)")){
                    CoreDataManager.shared.deleteProduct(product: product)
                    productCell.favoriteButtonOutlet.setImage(UIImage(named: "emptyHeart"), for: .normal)
                    BrandProductsVC.showToast(controller: self, message: "product removed from favorites 🤨", seconds: 1.0)
                }else{
                    CoreDataManager.shared.insert(product: product)
                    BrandProductsVC.showToast(controller: self, message: "product added to favorites 😉", seconds: 1.0)
                    productCell.favoriteButtonOutlet.setImage(UIImage(named: "filldHeart"), for: .normal)
                }
                
            }
            
            return productCell
            
        default:
            shouldAnimate = false
            let offersCell = collectionView.dequeueReusableCell(withReuseIdentifier: "offersCell", for: indexPath) as! OffersCell
            offersCell.offerImg.image = UIImage(named: offersImages[indexPath.row])
            return offersCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderView else{
            return UICollectionReusableView()
        }
        switch indexPath.section{
        case 0:
            view.title = " "
        case 1:
            view.title = "offers".localized
        case 2:
            view.title = "brands".localized
        case 3:
            view.title = "recommended".localized
        case 4:
            view.title = "what's new?".localized
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
        if indexPath.section == 3 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "productDetailsVC") as! ProductDetailsVC
            vc.product = products[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

