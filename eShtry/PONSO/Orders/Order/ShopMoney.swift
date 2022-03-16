//
//  ShopMoney.swift
//  eShtry
//
//  Created by eslam mohamed on 16/03/2022.
//

import Foundation

struct ShopMoney:Codable{
    
    let amount : String?
    let currency_code : String?

    enum CodingKeys: String, CodingKey {

        case amount = "amount"
        case currency_code = "currency_code"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        amount = try values.decodeIfPresent(String.self, forKey: .amount)
        currency_code = try values.decodeIfPresent(String.self, forKey: .currency_code)
    }

}

