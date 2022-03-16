//
//  SearchResultVC.swift
//  eShtry
//
//  Created by Mahmoud Ghoneim on 3/15/22.
//

import UIKit

class SearchResultVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        tableView.rowHeight = 130
    }

    private func configureSearchController(){
            let searchController = UISearchController()
           // searchController.searchResultsUpdater = self
            searchController.obscuresBackgroundDuringPresentation = false
            
            let searchBar = searchController.searchBar
            searchBar.tintColor    = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            searchBar.placeholder  = "Search for a product"
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

    }

extension SearchResultVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchingCell.reuseID, for: indexPath) as! SearchingCell
        return cell
    }
    
    
    
}


