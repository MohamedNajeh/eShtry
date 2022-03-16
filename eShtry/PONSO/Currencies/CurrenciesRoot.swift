//
//  CurrenciesRoot.swift
//  eShtry
//
//  Created by Pola on 3/16/22.
//

import Foundation
struct CurrenciesRoot : Codable {
    let currencies : [Currencies]?

    enum CodingKeys: String, CodingKey {

        case currencies = "currencies"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        currencies = try values.decodeIfPresent([Currencies].self, forKey: .currencies)
    }

}
