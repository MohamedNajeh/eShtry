//
//  Customer.swift
//  eShtry
//
//  Created by eslam mohamed on 15/03/2022.
//

import Foundation

//struct Customer:Codable{
//    let id : Int?
//    let email : String?
//    let accepts_marketing : Bool?
//    let created_at : String?
//    let updated_at : String?
//    let first_name : String?
//    let last_name : String?
//    let orders_count : Int?
//    let state : String?
//    let total_spent : String?
//    let last_order_id : String?
//    let note : String?
//    let verified_email : Bool?
//    let multipass_identifier : String?
//    let tax_exempt : Bool?
//    let phone : String?
//    let tags : String?
//    let last_order_name : String?
//    let currency : String?
//    let addresses : [Addresses]?
//    let accepts_marketing_updated_at : String?
//    let marketing_opt_in_level : String?
//    let tax_exemptions : [String]?
//    let admin_graphql_api_id : String?
//    let default_address : Addresses?

struct Customer: Codable {
    let first_name, last_name, email, phone, tags: String?
    let id: Int?
    let verified_email: Bool?
    let addresses:  [Addresses]?
}
    

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case email = "email"
        case accepts_marketing = "accepts_marketing"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case first_name = "first_name"
        case last_name = "last_name"
        case orders_count = "orders_count"
        case state = "state"
        case total_spent = "total_spent"
        case last_order_id = "last_order_id"
        case note = "note"
        case verified_email = "verified_email"
        case multipass_identifier = "multipass_identifier"
        case tax_exempt = "tax_exempt"
        case phone = "phone"
        case tags = "tags"
        case last_order_name = "last_order_name"
        case currency = "currency"
        case addresses = "addresses"
        case accepts_marketing_updated_at = "accepts_marketing_updated_at"
        case marketing_opt_in_level = "marketing_opt_in_level"
        case tax_exemptions = "tax_exemptions"
        case admin_graphql_api_id = "admin_graphql_api_id"
        case default_address = "default_address"
    }

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        email = try values.decodeIfPresent(String.self, forKey: .email)
//        accepts_marketing = try values.decodeIfPresent(Bool.self, forKey: .accepts_marketing)
//        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
//        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
//        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
//        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
//        orders_count = try values.decodeIfPresent(Int.self, forKey: .orders_count)
//        state = try values.decodeIfPresent(String.self, forKey: .state)
//        total_spent = try values.decodeIfPresent(String.self, forKey: .total_spent)
//        last_order_id = try values.decodeIfPresent(String.self, forKey: .last_order_id)
//        note = try values.decodeIfPresent(String.self, forKey: .note)
//        verified_email = try values.decodeIfPresent(Bool.self, forKey: .verified_email)
//        multipass_identifier = try values.decodeIfPresent(String.self, forKey: .multipass_identifier)
//        tax_exempt = try values.decodeIfPresent(Bool.self, forKey: .tax_exempt)
//        phone = try values.decodeIfPresent(String.self, forKey: .phone)
//        tags = try values.decodeIfPresent(String.self, forKey: .tags)
//        last_order_name = try values.decodeIfPresent(String.self, forKey: .last_order_name)
//        currency = try values.decodeIfPresent(String.self, forKey: .currency)
//        addresses = try values.decodeIfPresent([Addresses].self, forKey: .addresses)
//        accepts_marketing_updated_at = try values.decodeIfPresent(String.self, forKey: .accepts_marketing_updated_at)
//        marketing_opt_in_level = try values.decodeIfPresent(String.self, forKey: .marketing_opt_in_level)
//        tax_exemptions = try values.decodeIfPresent([String].self, forKey: .tax_exemptions)
//        admin_graphql_api_id = try values.decodeIfPresent(String.self, forKey: .admin_graphql_api_id)
//        default_address = try values.decodeIfPresent(Addresses.self, forKey: .default_address)
//    }

//}

