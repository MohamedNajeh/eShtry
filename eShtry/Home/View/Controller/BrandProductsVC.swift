//
//  BrandProductsVC.swift
//  eShtry
//
//  Created by Najeh on 12/03/2022.
//

import UIKit
import MobileBuySDK
class BrandProductsVC: UIViewController {

    @IBOutlet weak var sliderOutlet: UISlider!
    @IBOutlet weak var collectionView: UICollectionView!
    let searchBar = UISearchController()
    var vendor1:[Storefront.Product] = []
    var vendor:String = ""
    //var products:[Storefront.Product] = []
    var brnadProductViewModel = BrandProductViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Products"
        navigationItem.searchController = searchBar
        collectionView.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "productCell")

        //fetchProducts(vendor: self.vendor)
         print(vendor)
       brnadProductViewModel = BrandProductViewModel(vendor: self.vendor)
        updateViewWithData()
    }
    
    func updateViewWithData(){
        self.brnadProductViewModel.relodCollectionViewClosure = {
            DispatchQueue.main.async {
                self.collectionView.reloadData()

            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.searchController?.searchBar.isHidden = true
        self.collectionView.reloadData()
    }
    
//    func fetchProducts(vendor:String){
//        Client.shared.fetchBrandProducts(vendor:vendor) { response in
//            if let products = response {
//                self.products = products
//                //print(products)
//                self.collectionView.reloadData()
//            }else{
//
//            }
//        }
//    }
    
    
    @IBAction func sliderValueChanges(_ sender: UISlider) {
        
        let currentVlue = Int(sender.value)
        print(currentVlue)
    }
    


}

extension BrandProductsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brnadProductViewModel.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCell

//        item.productImg.downloadImg(from: "\(products[indexPath.row].featuredImage!.url)")
//        item.productName.text = products[indexPath.row].title
//        item.productPrice.text = "\(products[indexPath.row].priceRange.minVariantPrice.amount)"
        item.configure(cellVM: brnadProductViewModel.getBrandProductCell(at: indexPath))

        
        if(CoreDataManager.shared.isInFovorite(productId: "\(brnadProductViewModel.getBrandProductCell(at: indexPath).id)")){
            item.favoriteButtonOutlet.setImage(UIImage(named: "filldHeart"), for: .normal)
        }else{
            item.favoriteButtonOutlet.setImage(UIImage(named: "emptyHeart"), for: .normal)
        }
        
        item.addToFavorites = { [weak self] in
            guard let self = self else { return }
            let product = Product(id: "\(self.brnadProductViewModel.getBrandProductCell(at: indexPath).id)", imageUrl: "\(self.brnadProductViewModel.getBrandProductCell(at: indexPath).imgUrl)", name: "\(self.brnadProductViewModel.getBrandProductCell(at: indexPath).name)")
            print("product = \(product)")
            if(CoreDataManager.shared.isInFovorite(productId: "\(self.brnadProductViewModel.getBrandProductCell(at: indexPath).id)")){
                CoreDataManager.shared.deleteProduct(product: product)
                item.favoriteButtonOutlet.setImage(UIImage(named: "emptyHeart"), for: .normal)
                BrandProductsVC.showToast(controller: self, message: "product removed from favorites 🤨", seconds: 1.0)
            }else{
                CoreDataManager.shared.insert(product: product)
                BrandProductsVC.showToast(controller: self, message: "product added to favorites 😉", seconds: 1.0)
                item.favoriteButtonOutlet.setImage(UIImage(named: "filldHeart"), for: .normal)
            }
            
        }

        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 10)/2, height: collectionView.frame.height/3.4)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "productDetailsVC") as! ProductDetailsVC
        //vc.product = products[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

    
}
