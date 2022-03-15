//
//  SmartCollection.swift
//  eShtry
//
//  Created by eslam mohamed on 15/03/2022.
//

import Foundation

struct SmartCollectionRoot: Codable{
    
    let smart_collections : [SmartCollection]?

    enum CodingKeys: String, CodingKey {

        case smart_collections = "smart_collections"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        smart_collections = try values.decodeIfPresent([SmartCollection].self, forKey: .smart_collections)
    }

}

