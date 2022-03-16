//
//  PriceSet.swift
//  eShtry
//
//  Created by eslam mohamed on 16/03/2022.
//

import Foundation

struct PriceSet:Codable{
    
    
    let shop_money : ShopMoney?
    let presentment_money : PresentmentMoney?

    enum CodingKeys: String, CodingKey {

        case shop_money = "shop_money"
        case presentment_money = "presentment_money"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        shop_money = try values.decodeIfPresent(ShopMoney.self, forKey: .shop_money)
        presentment_money = try values.decodeIfPresent(PresentmentMoney.self, forKey: .presentment_money)
    }

}

