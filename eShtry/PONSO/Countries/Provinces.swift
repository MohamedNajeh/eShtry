//
//  Provinces.swift
//  eShtry
//
//  Created by eslam mohamed on 16/03/2022.
//

import Foundation

struct Provinces : Codable {
    let id : Int?
    let country_id : Int?
    let name : String?
    let code : String?
    let tax_name : String?
    let tax_type : String?
    let shipping_zone_id : String?
    let tax : Double?
    let tax_percentage : Double?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case country_id = "country_id"
        case name = "name"
        case code = "code"
        case tax_name = "tax_name"
        case tax_type = "tax_type"
        case shipping_zone_id = "shipping_zone_id"
        case tax = "tax"
        case tax_percentage = "tax_percentage"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        country_id = try values.decodeIfPresent(Int.self, forKey: .country_id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        tax_name = try values.decodeIfPresent(String.self, forKey: .tax_name)
        tax_type = try values.decodeIfPresent(String.self, forKey: .tax_type)
        shipping_zone_id = try values.decodeIfPresent(String.self, forKey: .shipping_zone_id)
        tax = try values.decodeIfPresent(Double.self, forKey: .tax)
        tax_percentage = try values.decodeIfPresent(Double.self, forKey: .tax_percentage)
    }

}
