//
//  CustomarRoot.swift
//  eShtry
//
//  Created by eslam mohamed on 15/03/2022.
//

import Foundation

struct CustomarRoot:Codable{
    let customer : Customer?

    enum CodingKeys: String, CodingKey {

        case customer = "customer"
    }
    

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        customer = try values.decodeIfPresent(Customer.self, forKey: .customer)
//    }
}

struct LoginResponse: Codable {
    let customers: [Customer]
}



extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
