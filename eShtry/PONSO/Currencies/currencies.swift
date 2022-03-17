//
//  currencies.swift
//  eShtry
//
//  Created by Pola on 3/16/22.
//

import Foundation
struct Currencies : Codable {
    var currency : String?
    let rate_updated_at : String?
    let enabled : Bool?

    enum CodingKeys: String, CodingKey {

        case currency = "currency"
        case rate_updated_at = "rate_updated_at"
        case enabled = "enabled"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        rate_updated_at = try values.decodeIfPresent(String.self, forKey: .rate_updated_at)
        enabled = try values.decodeIfPresent(Bool.self, forKey: .enabled)
    }

}
