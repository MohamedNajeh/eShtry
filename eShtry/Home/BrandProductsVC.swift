//
//  BrandProductsVC.swift
//  eShtry
//
//  Created by Najeh on 12/03/2022.
//

import UIKit

class BrandProductsVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let searchBar = UISearchController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Products"
        navigationItem.searchController = searchBar
        collectionView.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "productCell")

        
    }


}

extension BrandProductsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCell
        item.productImg.image = UIImage(named: "shoes")
        item.productName.text = "Adidas"
        item.productPrice.text = "15.0 $"
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
        
        navigationController?.pushViewController(vc, animated: true)
    }

    
}
