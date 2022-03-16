//
//  LineItems.swift
//  eShtry
//
//  Created by eslam mohamed on 16/03/2022.
//

import Foundation

struct LineItems:Codable {
    
    let id : Int?
    let admin_graphql_api_id : String?
    let fulfillable_quantity : Int?
    let fulfillment_service : String?
    let fulfillment_status : String?
    let gift_card : Bool?
    let grams : Int?
    let name : String?
    let price : String?
    let price_set : PriceSet?
    let product_exists : Bool?
    let product_id : Int?
    let properties : [String]?
    let quantity : Int?
    let requires_shipping : Bool?
    let sku : String?
    let taxable : Bool?
    let title : String?
    let total_discount : String?
    let total_discount_set : TotalDiscountSet?
    let variant_id : Int?
    let variant_inventory_management : String?
    let variant_title : String?
    let vendor : String?
    let tax_lines : [String]?
    let duties : [String]?
    let discount_allocations : [String]?
//
    enum CodingKeys: String, CodingKey {

        case id = "id"
        case admin_graphql_api_id = "admin_graphql_api_id"
        case fulfillable_quantity = "fulfillable_quantity"
        case fulfillment_service = "fulfillment_service"
        case fulfillment_status = "fulfillment_status"
        case gift_card = "gift_card"
        case grams = "grams"
        case name = "name"
        case price = "price"
        case price_set = "price_set"
        case product_exists = "product_exists"
        case product_id = "product_id"
        case properties = "properties"
        case quantity = "quantity"
        case requires_shipping = "requires_shipping"
        case sku = "sku"
        case taxable = "taxable"
        case title = "title"
        case total_discount = "total_discount"
        case total_discount_set = "total_discount_set"
        case variant_id = "variant_id"
        case variant_inventory_management = "variant_inventory_management"
        case variant_title = "variant_title"
        case vendor = "vendor"
        case tax_lines = "tax_lines"
        case duties = "duties"
        case discount_allocations = "discount_allocations"
    }
//
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        admin_graphql_api_id = try values.decodeIfPresent(String.self, forKey: .admin_graphql_api_id)
        fulfillable_quantity = try values.decodeIfPresent(Int.self, forKey: .fulfillable_quantity)
        fulfillment_service = try values.decodeIfPresent(String.self, forKey: .fulfillment_service)
        fulfillment_status = try values.decodeIfPresent(String.self, forKey: .fulfillment_status)
        gift_card = try values.decodeIfPresent(Bool.self, forKey: .gift_card)
        grams = try values.decodeIfPresent(Int.self, forKey: .grams)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        price_set = try values.decodeIfPresent(PriceSet.self, forKey: .price_set)
        product_exists = try values.decodeIfPresent(Bool.self, forKey: .product_exists)
        product_id = try values.decodeIfPresent(Int.self, forKey: .product_id)
        properties = try values.decodeIfPresent([String].self, forKey: .properties)
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
        requires_shipping = try values.decodeIfPresent(Bool.self, forKey: .requires_shipping)
        sku = try values.decodeIfPresent(String.self, forKey: .sku)
        taxable = try values.decodeIfPresent(Bool.self, forKey: .taxable)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        total_discount = try values.decodeIfPresent(String.self, forKey: .total_discount)
        total_discount_set = try values.decodeIfPresent(TotalDiscountSet.self, forKey: .total_discount_set)
        variant_id = try values.decodeIfPresent(Int.self, forKey: .variant_id)
        variant_inventory_management = try values.decodeIfPresent(String.self, forKey: .variant_inventory_management)
        variant_title = try values.decodeIfPresent(String.self, forKey: .variant_title)
        vendor = try values.decodeIfPresent(String.self, forKey: .vendor)
        tax_lines = try values.decodeIfPresent([String].self, forKey: .tax_lines)
        duties = try values.decodeIfPresent([String].self, forKey: .duties)
        discount_allocations = try values.decodeIfPresent([String].self, forKey: .discount_allocations)
    }
}
//
