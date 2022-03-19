//
//  FavoritesVC.swift
//  eShtry
//
//  Created by Mahmoud Ghoneim on 3/16/22.
//

import UIKit

class FavoritesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emtyStateView: UIView!
    
    var favorites = ["IPhone 5" , "Iphone 6" , "Macbook Pro" , "Lenovo Ideapad" , "Dell" ]
    override func viewDidLoad() {
        super.viewDidLoad()
       configureTableView()
        
    }
    
  
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 120
        tableView.tableFooterView = UIView()
        tableView.backgroundView = emtyStateView
    }
   

}



extension FavoritesVC:UITableViewDelegate , UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.emtyStateView.isHidden = favorites.count > 0
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID, for: indexPath)as! FavoriteCell
        cell.productNameLabel.text = favorites[indexPath.row]
        cell.productCreationDateLabel.text = "20/12/2021"
        cell.removeFromFavorites = { [weak self] in
            self?.favorites.remove(at: indexPath.row)
            self?.tableView.reloadData()
        }
        return cell
    }
    
    
}
