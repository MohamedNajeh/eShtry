//
//  ProductDetailsVC.swift
//  eShtry
//
//  Created by Najeh on 12/03/2022.
//

import UIKit

class ProductDetailsVC: UITableViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var reviewsCollectionView: UICollectionView!
    
    var isMorePressed = false
    var currentIndex = 0
    var timer:Timer?
    @IBOutlet weak var infoView: UIView!
    
    @IBOutlet weak var addToBagBtnOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Adidas Shoes"
        pageControl.numberOfPages = 9
        infoView.layer.cornerRadius = 20
        addToBagBtnOutlet.layer.cornerRadius = 20
        collectionView.register(UINib(nibName: "SliderCell", bundle: nil), forCellWithReuseIdentifier: "sliderCell")
        
        reviewsCollectionView.register(UINib(nibName: "ReviewCollectionCell", bundle: nil), forCellWithReuseIdentifier: "reviewCell")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        startTimer()
    }
    func startTimer(){
        
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timeAction), userInfo: nil, repeats: true)
        
    }
    
    @objc func timeAction(){
        if currentIndex < 9 {
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
}

extension ProductDetailsVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == reviewsCollectionView {
            let reviewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath) as! ReviewCollectionCell
            return reviewCell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell", for: indexPath) as! SliderCell
        cell.sliderImg.image = UIImage(named: "shoes")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == reviewsCollectionView {
            if !isMorePressed {
                return 2
            }
        }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == reviewsCollectionView{
            return CGSize(width: reviewsCollectionView.frame.width, height: reviewsCollectionView.frame.height / 3)
        }
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
}

