//
//  Countries.swift
//  eShtry
//
//  Created by eslam mohamed on 16/03/2022.
//

import Foundation

struct Countries : Codable {
    let id : Int?
    let name : String?
    let code : String?
    let tax_name : String?
    let tax : Double?
    let provinces : [Provinces]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case code = "code"
        case tax_name = "tax_name"
        case tax = "tax"
        case provinces = "provinces"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        tax_name = try values.decodeIfPresent(String.self, forKey: .tax_name)
        tax = try values.decodeIfPresent(Double.self, forKey: .tax)
        provinces = try values.decodeIfPresent([Provinces].self, forKey: .provinces)
    }

}
