//
//  ProductDetailsVC.swift
//  eShtry
//
//  Created by Najeh on 12/03/2022.
//

import UIKit
import MobileBuySDK
class ProductDetailsVC: UITableViewController {

    @IBOutlet weak var varientCollectionView: UICollectionView!
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
        descriptionTextView.layer.borderColor = UIColor(red: 43/255, green: 95/255, blue: 147/255, alpha: 0.75).cgColor
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.cornerRadius = 15
        
        pageControl.numberOfPages = (product?.images.edges.count)!
        infoView.layer.cornerRadius = 20
        addToBagBtnOutlet.layer.cornerRadius = 20
        collectionView.register(UINib(nibName: "SliderCell", bundle: nil), forCellWithReuseIdentifier: "sliderCell")
        productName.text = product?.title
        productPrice.text = "\(String(describing: (product?.priceRange.minVariantPrice.amount)!))"
        descriptionTextView.text = product?.description
//        varientsLbl.text = product?.variants.edges[0].node.title
        
        reviewsCollectionView.register(UINib(nibName: "ReviewCollectionCell", bundle: nil), forCellWithReuseIdentifier: "reviewCell")
        varientCollectionView.register(UINib(nibName: "VarientCell", bundle: nil), forCellWithReuseIdentifier: "VarientCell")
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
        guard let title = product?.title else{return}
        guard let price = product?.priceRange.minVariantPrice.amount else{return}
        guard let image = product?.images.edges[0].node.url else {return}
        guard let id    = product?.id else{return}
        let qty         = 1
        
        let item = CartItem(name: title, price: "\(price)", imgUrl: "\(image)",id:"\(id)",qty: "\(qty)")
        CoreDataManager.shared.insertCartItem(cartItem: item,qtyTypeProcess: .addition)
        CoreDataManager.shared.updateOrderArr()
    }
}

extension ProductDetailsVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == reviewsCollectionView {
            let reviewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath) as! ReviewCollectionCell
            return reviewCell
        }
        if collectionView == varientCollectionView {
            let varCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VarientCell", for: indexPath) as! VarientCell
            varCell.varientTitle.text = product?.variants.edges[indexPath.row].node.title
            return varCell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath) as! SliderCell
        cell.sliderImg.contentMode = .scaleAspectFit
        cell.sliderImg.downloadImg(from:"\((product?.images.edges[indexPath.row].node.url)!)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == reviewsCollectionView {
            if !isMorePressed {
                return 2
            }
        }
        if collectionView == varientCollectionView {
            return product?.variants.edges.count ?? 0
        }
        return (product?.images.edges.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == reviewsCollectionView{
            return CGSize(width: reviewsCollectionView.frame.width, height: reviewsCollectionView.frame.height / 2.5)
        }
        if collectionView == varientCollectionView {
            return CGSize(width: varientCollectionView.frame.width / 2.5, height: varientCollectionView.frame.height)
        }
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
}

