//
//  CountryVC.swift
//  FinalDemo
//
//  Created by Pola on 3/12/22.
//  Copyright © 2022 Pola. All rights reserved.
//

import UIKit

class CountryVC: UIViewController,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
    @IBOutlet weak var CountryTableView: UITableView!
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    
    let myCountries : [String] = ["Egypt","Qatar","Saudi Arabia","Kuwait","Lebanon","United Arab Emirates","Jordan","Bahrain"]
    var filterCountries : [String]!
    var myCountryProtocol : setCountryProtocol!
    

    override func viewDidLoad() {
        super.viewDidLoad()
     filterCountries = myCountries
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterCountries = []
        
        if searchText == "" {
            filterCountries = myCountries
        }else{
            for country in myCountries{
                if country.contains(searchText) {
                    filterCountries.append(country)
                }
            }
        }
        
        self.CountryTableView.reloadData()
    }

    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filterCountries.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
    let countryName = cell.viewWithTag(1) as! UILabel
    let countryFlag = cell.viewWithTag(2) as! UIImageView
    
    countryName.text = filterCountries[indexPath.row]
    countryFlag.image = UIImage(named: filterCountries[indexPath.row])
    return cell
}
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myCountryProtocol.sendCountry(name:filterCountries[indexPath.row])
        dismiss(animated: true, completion: nil)

    }
    
    @IBAction func backClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
