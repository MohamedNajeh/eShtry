//
//  CategoryVC.swift
//  eShtry
//
//  Created by Mahmoud Ghoneim on 3/11/22.
//

import UIKit
import MobileBuySDK


class CategoryVC: UIViewController {
    
    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var productstableView: UITableView!
    
  
    var isHiddenViews:[Bool] = Array(repeating: true, count: 10)
    var collections:[Storefront.Collection] = []
    var productTypes:[String] = ["Rings".localized,"Earrings".localized,"Accessories".localized,"Necklace".localized]
    var selectedVendor:String = "VANS"
    var allProducts:[[Storefront.Product]] = []
    
    let viewModel = CategoryViewModel()
    let connection = NetworkReachibility.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.title = "Category"
        //configureSearchController()

        configureTableViews()
        fetchCollections()
        let color:UIColor = UIColor(red: 43/255, green: 95/255, blue: 147/255, alpha: 1)
        configureNavigationBar(largeTitleColor: color, backgoundColor: color, tintColor: .white, title: "categories".localized, preferredLargeTitle: true)
        let searchButton = UIBarButtonItem(image: UIImage(named: "search"), style: .plain, target: self, action: #selector(searchButtonPressed))
        
        navigationItem.rightBarButtonItem = searchButton
        fetchCollections()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        connection.checkNetwork(target: self)

    }
    
    @objc func searchButtonPressed(){
        let storyboard = UIStoryboard(name: "SearchSB", bundle: nil)
        let searchVC = storyboard.instantiateViewController(identifier: "SearchResultVC") as! SearchResultVC
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    func fetchCollections(){
        Client.shared.fetchAllCollections { collections ,products in
            if let collections = collections {
                self.collections = collections
                self.allProducts = products!
                self.categoryTableView.reloadData()
            }else{
               print("Wrong")
            }
        }
    }
    
    
      
    
    private func configureTableViews(){
        productstableView.tableFooterView = UIView()
        categoryTableView.tableFooterView = UIView()
        productstableView.rowHeight = UITableView.automaticDimension
    }
    
    private func configureSearchController(){
        let searchController = UISearchController()
       // searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        let searchBar = searchController.searchBar
        searchBar.tintColor    = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        searchBar.placeholder  = "Search for a product"
        
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = UIColor.white
            textfield.layer.cornerRadius = 10;
            textfield.clipsToBounds = true;
        }
        searchBar.delegate    = self
        let attributes:[NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 17)
        ]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
        
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.02600483396, green: 0.267517497, blue: 0.5049571701, alpha: 1)
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }

}


extension CategoryVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case categoryTableView :
            return collections.count
        case productstableView :
            return productTypes.count
        default:
            return 0
        }
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        switch tableView {
        case categoryTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.reuseID, for: indexPath)as! CategoryCell
            cell.categorylabel.text = self.collections[indexPath.row].title
            return cell
        case productstableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: SubCategoryCell.reuseID, for: indexPath) as! SubCategoryCell
            cell.subCategorynameLabel.text = productTypes[indexPath.row]
            cell.bottomView.isHidden = isHiddenViews[indexPath.row]
            if isHiddenViews[indexPath.row] {
                cell.expandedImageView.image = UIImage(named: "expand")
            }else{
                cell.expandedImageView.image = UIImage(named: "expand_more")
            }
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == productstableView{
            self.isHiddenViews[indexPath.row] = !self.isHiddenViews[indexPath.row]
            tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            let cell = tableView.cellForRow(at: indexPath) as! SubCategoryCell
            Client.shared.fetchAllSubCategoryProducts(vendor: self.selectedVendor, type: productTypes[indexPath.row]) { products in
                if let products = products {
                        cell.products = products
                }else{
                    print("Error")
                }
            }
            
        }
        if tableView == categoryTableView{
            selectedVendor = collections[indexPath.row].title
            isHiddenViews = Array(repeating: true, count: 10)
            productstableView.reloadData()
        }
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == productstableView && !isHiddenViews[indexPath.row]{
            return 220
        }

        return 70
    }
}


extension CategoryVC: UISearchBarDelegate{
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let searchVC = UIStoryboard(name: "SearchSB", bundle: nil).instantiateViewController(identifier: "SearchResultVC")
        self.navigationController?.pushViewController(searchVC, animated: true)
          searchBar.setShowsCancelButton(false, animated: true)
          return false
      }
}
