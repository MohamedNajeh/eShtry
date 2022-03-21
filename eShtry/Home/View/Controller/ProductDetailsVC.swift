//
//  ProductDetailsVC.swift
//  eShtry
//
//  Created by Najeh on 12/03/2022.
//

import UIKit
import MobileBuySDK
class ProductDetailsVC: UITableViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var reviewsCollectionView: UICollectionView!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var varientsLbl: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    var isMorePressed = false
    var currentIndex = 0
    var timer:Timer?
    var titlePro:String = " "
    var product:Storefront.Product?
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var addToBagBtnOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Adidas Shoes"
        pageControl.numberOfPages = (product?.images.edges.count)!
        infoView.layer.cornerRadius = 20
        addToBagBtnOutlet.layer.cornerRadius = 20
        collectionView.register(UINib(nibName: "SliderCell", bundle: nil), forCellWithReuseIdentifier: "sliderCell")
        productName.text = product?.title
        productPrice.text = "\(String(describing: (product?.priceRange.minVariantPrice.amount)!))"
        descriptionTextView.text = product?.description
        varientsLbl.text = product?.variants.edges[0].node.title
        
        reviewsCollectionView.register(UINib(nibName: "ReviewCollectionCell", bundle: nil), forCellWithReuseIdentifier: "reviewCell")
        startTimer()
    }
//    func fetchProductDetails(title:String){
//        Client.shared.fetchProductDetails(title:title) { product in
//            if let product = product {
//                self.product = product
//                print(self.product)
//            }else {
//                print("SomethingErrorHappened")
//            }
//        }
//    }
    func startTimer(){
        
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timeAction), userInfo: nil, repeats: true)
        
    }
    
    @objc func timeAction(){
        if currentIndex < (product?.images.edges.count)! - 1 {
            currentIndex += 1
        }else{
            currentIndex = 0
        }
        collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
        pageControl.currentPage = currentIndex
       
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 && indexPath.row == 1{
            isMorePressed = true
            reviewsCollectionView.reloadData()
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    @IBAction func addToBagButtonPressed(_ sender: Any) {
        let title = product?.title
        let price = product?.priceRange.minVariantPrice.amount
        let image = product?.images.edges[0].node.url
        
        let item = CartItem(name: title!, price: "\(String(describing: price))", imgUrl: "\(String(describing: image))")
        CoreDataManager.shared.insertCartItem(cartItem: item)
        CoreDataManager.shared.updateOrderArr()
    }
}

extension ProductDetailsVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == reviewsCollectionView {
            let reviewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath) as! ReviewCollectionCell
            return reviewCell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath) as! SliderCell
        cell.sliderImg.downloadImg(from:"\((product?.images.edges[indexPath.row].node.url)!)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == reviewsCollectionView {
            if !isMorePressed {
                return 2
            }
        }
        return (product?.images.edges.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == reviewsCollectionView{
            return CGSize(width: reviewsCollectionView.frame.width, height: reviewsCollectionView.frame.height / 2.5)
        }
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
}

