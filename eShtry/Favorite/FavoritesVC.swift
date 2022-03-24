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
    
    @IBOutlet weak var noFavoriteItemsLabel: UILabel!
    var favorites:[Product] = []
    let color:UIColor = UIColor(red: 43/255, green: 95/255, blue: 147/255, alpha: 1)
    override func viewDidLoad() {
        super.viewDidLoad()
       configureTableView()
        configureNavigationBar(largeTitleColor: color, backgoundColor: color, tintColor: .white, title: "favorite".localized, preferredLargeTitle: true)
        noFavoriteItemsLabel.text = "noFavoriteItemsLabel".localized
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.favorites = CoreDataManager.shared.getAllFavoriteProducts()
        guard let isLogedIn = UserDefaults.standard.object(forKey: "login") as? Bool , isLogedIn else {
            for product in favorites{
                CoreDataManager.shared.deleteProduct(product: product)
            }
            self.favorites = []
            tableView.reloadData()
            return
        }
        tableView.reloadData()
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
        cell.productNameLabel.text = favorites[indexPath.row].name
        print("image url = \((favorites[indexPath.row].imageUrl))")
//        cell.productImageView.downloadImg(from: favorites[indexPath.row].imageUrl)
        cell.productImageView.setImage(with: favorites[indexPath.row].imageUrl)
        cell.productCreationDateLabel.text = "20/12/2021"
        cell.removeFromFavorites = { [weak self] in
            
            
            let alert = UIAlertController(title: "Delete Product ⛔️".localized, message: "Are sure you want to delet product from favorites".localized, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self] _ in
                CoreDataManager.shared.deleteProduct(product: (self?.favorites[indexPath.row])!)
                self?.favorites.remove(at: indexPath.row)
                tableView.reloadData()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self?.present(alert, animated: true, completion: nil)
            }
            
        return cell
    }
    
    
}
