//
//  BrandProductsVC.swift
//  eShtry
//
//  Created by Najeh on 12/03/2022.
//

import UIKit
import MobileBuySDK
class BrandProductsVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let searchBar = UISearchController()
    var vendor:String = ""
    var products:[Storefront.Product] = []
    var brnadProductViewModel = BrandProductViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Products"
        navigationItem.searchController = searchBar
        collectionView.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "productCell")

        fetchProducts(vendor: self.vendor)
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
    
    func fetchProducts(vendor:String){
        Client.shared.fetchBrandProducts(vendor:vendor) { response in
            if let products = response {
                self.products = products
                //print(products)
                self.collectionView.reloadData()
            }else{
                
            }
        }
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
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 10)/2, height: collectionView.frame.height/4)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "productDetailsVC") as! ProductDetailsVC
        vc.product = products[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

    
}
