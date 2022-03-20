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
    @IBOutlet weak var chooseOutletLabel: UILabel!
    
    var myCountries : [String] = ["Egypt","Qatar","Saudi Arabia","Kuwait","Lebanon","United Arab Emirates","Jordan","Bahrain"]
    var filterCountries : [String]!
    
    var myCities : [Provinces] = []
    var filterCities : [Provinces]!
    
    var myCurrencies : [Currencies] = []
    var filterCurrencies : [Currencies]!
    
    var myCountryProtocol : setCountryProtocol!
    let networkShared = NetworkManager.shared
    var checkWhichTable : Character = " "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if checkWhichTable == "0" || checkWhichTable == "1" {
            networkShared.getDataFromApi(urlString: countries, baseModel: CountriesRoot.self) { (result) in
                switch result {
                case .success(let data):
                    if self.checkWhichTable == "0" {
                        self.myCountries[0] = data.countries?[0].name ?? ""
                        self.filterCountries = self.myCountries
                    }else if self.checkWhichTable == "1"{
                        self.myCities = data.countries?[0].provinces ?? []
                        self.filterCities = self.myCities
                    }
                    DispatchQueue.main.async {
                        self.CountryTableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }else{
            networkShared.getDataFromApi(urlString: currencies, baseModel: CurrenciesRoot.self) { (result) in
                switch result {
                case .success(let data):
                    self.myCurrencies = data.currencies ?? []
                    self.myCurrencies[0].currency = "EGP"
                    self.filterCurrencies = self.myCurrencies
                    DispatchQueue.main.async {
                        self.CountryTableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        
        switch checkWhichTable {
        case "0":
            filterCountries = myCountries
            chooseOutletLabel.text = "Choose a Country"
        case "1":
            filterCities = myCities
            chooseOutletLabel.text = "Choose a City"
        case "2":
            filterCurrencies = myCurrencies
            chooseOutletLabel.text = "Choose a Currency"
        default:
            chooseOutletLabel.text = ""
        }
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch checkWhichTable {
        case "0":
            return filterCountries.count
        case "1":
            return filterCities.count
        case "2":
            return filterCurrencies.count
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        let labelName = cell.viewWithTag(1) as! UILabel
        let image = cell.viewWithTag(2) as! UIImageView
        switch checkWhichTable {
        case "0":
            labelName.text = filterCountries[indexPath.row]
            image.image = UIImage(named: filterCountries[indexPath.row])
            return cell
        case "1":
            labelName.text = filterCities[indexPath.row].name
            return cell
        case "2":
            labelName.text = filterCurrencies[indexPath.row].currency
            image.image = UIImage(named: "money")
            return cell
        default:
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch checkWhichTable {
        case "0":
            if filterCountries[indexPath.row] == "Egypt"{
                myCountryProtocol.sendCountry(name:filterCountries[indexPath.row],whichScreen:"0")
                dismiss(animated: true, completion: nil)
            }else{
                displayAlert(title: filterCountries[indexPath.row], message: "This country is not available on eShtryApp yet")
            }
        case "1":
            myCountryProtocol.sendCountry(name:filterCities[indexPath.row].name ?? "",whichScreen:"1")
            dismiss(animated: true, completion: nil)
        case "2":
            myCountryProtocol.sendCountry(name:filterCurrencies[indexPath.row].currency ?? "" ,whichScreen:"2")
            dismiss(animated: true, completion: nil)
        default:
            print("did select none")
        }
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        switch checkWhichTable {
        case "0":
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
        case "1":
            filterCities = []
            if searchText == "" {
                filterCities = myCities
            }else{
                for city in myCities{
                    if city.name?.contains(searchText) ?? false {
                        filterCities.append(city)
                    }
                }
            }
        case "2":
            filterCurrencies = []
            if searchText == "" {
                filterCurrencies = myCurrencies
            }else{
                for currency in myCurrencies{
                    if currency.currency?.lowercased().contains(searchText.lowercased()) ?? false {
                        filterCurrencies.append(currency)
                    }
                }
            }
        default:
            print("not Found")
        }
        
        self.CountryTableView.reloadData()
    }
    
    @IBAction func backClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func displayAlert(title: String,message: String) {
           let alert = UIAlertController(title: title,message:message,preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK",style: .default, handler: nil))
           self.present(alert, animated: true, completion: nil)
       }
    
}
