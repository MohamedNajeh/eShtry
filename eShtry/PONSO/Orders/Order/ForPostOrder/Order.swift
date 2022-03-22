//
//  File.swift
//  eShtry
//
//  Created by eslam mohamed on 22/03/2022.
//

import Foundation

struct Order: Codable {
    var line_items: [CartItemCellViewModel]
    let customer: OrderCustomer
    var financial_status: String = "paid"
    var created_at :String?
    var id : Int?
    var currency:String?
    var current_total_price:String?
}


struct APIOrder: Codable {
    var order: Order
}
