//
//  Addresses.swift
//  eShtry
//
//  Created by eslam mohamed on 15/03/2022.
//

import Foundation

struct Addresses : Codable {
    let id : Int?
    let customer_id : Int?
    let first_name : String?
    let last_name : String?
    let company : String?
    let address1 : String?
    let address2 : String?
    let city : String?
    let province : String?
    let country : String?
    let zip : String?
    let phone : String?
    let name : String?
    let province_code : String?
    let country_code : String?
    let country_name : String?
    let defaul : Bool?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case customer_id = "customer_id"
        case first_name = "first_name"
        case last_name = "last_name"
        case company = "company"
        case address1 = "address1"
        case address2 = "address2"
        case city = "city"
        case province = "province"
        case country = "country"
        case zip = "zip"
        case phone = "phone"
        case name = "name"
        case province_code = "province_code"
        case country_code = "country_code"
        case country_name = "country_name"
        case defaul = "default"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        customer_id = try values.decodeIfPresent(Int.self, forKey: .customer_id)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        company = try values.decodeIfPresent(String.self, forKey: .company)
        address1 = try values.decodeIfPresent(String.self, forKey: .address1)
        address2 = try values.decodeIfPresent(String.self, forKey: .address2)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        province = try values.decodeIfPresent(String.self, forKey: .province)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        zip = try values.decodeIfPresent(String.self, forKey: .zip)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        province_code = try values.decodeIfPresent(String.self, forKey: .province_code)
        country_code = try values.decodeIfPresent(String.self, forKey: .country_code)
        country_name = try values.decodeIfPresent(String.self, forKey: .country_name)
        defaul = try values.decodeIfPresent(Bool.self, forKey: .defaul)
    }

}
