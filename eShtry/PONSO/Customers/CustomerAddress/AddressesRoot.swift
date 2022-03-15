//
//  AddressesRoot.swift
//  eShtry
//
//  Created by eslam mohamed on 15/03/2022.
//

import Foundation


struct AddressesRoot:Codable{
    
    let addresses : [Addresses]?

    enum CodingKeys: String, CodingKey {

        case addresses = "addresses"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        addresses = try values.decodeIfPresent([Addresses].self, forKey: .addresses)
    }

}
