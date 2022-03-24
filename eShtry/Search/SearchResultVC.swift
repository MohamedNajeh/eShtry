//
//  SearchResultVC.swift
//  eShtry
//
//  Created by Mahmoud Ghoneim on 3/19/22.
//

import UIKit
import MobileBuySDK
class SearchResultVC: UIViewController {
    
    var categories: [Storefront.Collection]! = []
    var products  : [Storefront.Product]! = []
    var filteredCategories: [Storefront.Collection] = []
    var filteredProducts:[Storefront.Product] = []
    
    var isSearching = false
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    let searchController = UISearchController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        configureSearchController()
        configureSegmentControl()
        configureTableView()
        
    }
    
    
    private func configureDataSource(){
        let navVC =  self.tabBarController?.viewControllers![0] as! UINavigationController
        let homeVC = navVC.viewControllers[0] as! HomeVC
        categories = homeVC.collectionsArr
        products   = homeVC.products
    }
    
    
    private func configureSegmentControl(){
        
        segmentControl.layer.borderWidth = 1
        segmentControl.layer.borderColor = #colorLiteral(red: 0.02600483396, green: 0.267517497, blue: 0.5049571701, alpha: 1)
        
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular) as Any,NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .bold) as Any,NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)], for: .selected)
    }
    
    
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 130
    }
    
    
    private func configureSearchController(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        let searchBar = searchController.searchBar
        searchBar.tintColor    = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        configureSearchBarPlaceHolder()
        searchBar.becomeFirstResponder()
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = UIColor.white
            textfield.layer.cornerRadius = 10;
            textfield.clipsToBounds = true;
        }
        
        let attributes:[NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 17)
        ]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
        
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.02600483396, green: 0.267517497, blue: 0.5049571701, alpha: 1)
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    
    private func configureSearchBarPlaceHolder(){
        searchController.searchBar.placeholder = segmentControl.selectedSegmentIndex == 0 ? "Search by Categories" : "Search by products"
    }
    
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        configureSearchBarPlaceHolder()
        tableView.reloadData()
    }
    
    
    private func navigationToCategories(categoryTitle:String){
        let storyboard = UIStoryboard(name: "HomeSB", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "productsVC") as! BrandProductsVC
       // vc.vendor = categoryTitle
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    private func naigateToProductDetails(product:Storefront.Product){
        let storyboard = UIStoryboard(name: "HomeSB", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "productDetailsVC") as! ProductDetailsVC
        vc.product =  product
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}




extension SearchResultVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching{
            return segmentControl.selectedSegmentIndex == 0 ? filteredCategories.count : filteredProducts.count
        }
        return segmentControl.selectedSegmentIndex == 0 ? categories.count : products.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchingCell.reuseID, for: indexPath) as! SearchingCell
        
        if segmentControl.selectedSegmentIndex == 0 {
            let activeCategory = isSearching ? filteredCategories[indexPath.row] : categories[indexPath.row]
            cell.configureCell(category: activeCategory)
        }else{
            let activeProduct = isSearching ? filteredProducts[indexPath.row] : products[indexPath.row]
            cell.configureCell(product: activeProduct)
        }
        
        return cell
    }
    
}



extension SearchResultVC : UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter  = searchController.searchBar.text , !filter.isEmpty else {
            isSearching = false
            filteredProducts.removeAll()
            filteredCategories.removeAll()
            tableView.reloadData()
            return
        }
        
        isSearching = true
        
        if segmentControl.selectedSegmentIndex == 0 {
            filteredCategories = self.categories.filter({($0.title.lowercased().contains(filter.lowercased()))})
            filteredProducts.removeAll()
        }else{
            filteredProducts = self.products.filter({ ($0.title.lowercased().contains(filter.lowercased()))})
            filteredCategories.removeAll()
        }
        print(" filtered categories count = \(filteredCategories.count)")
        tableView.reloadData()
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if isSearching{
            if segmentControl.selectedSegmentIndex == 0 {
                self.navigationToCategories(categoryTitle: self.filteredCategories[indexPath.row].title ?? "")
            }else{
                self.naigateToProductDetails(product: self.filteredProducts[indexPath.row])
            }
        }else{
            if segmentControl.selectedSegmentIndex == 0 {
                self.navigationToCategories(categoryTitle: self.categories[indexPath.row].title ?? "")
            }else{
                self.naigateToProductDetails(product: self.products[indexPath.row])
            }
        }
    }
    
    
}
