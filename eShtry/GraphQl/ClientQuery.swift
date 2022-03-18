//
//  ClientQuery.swift
//  eShtry
//
//  Created by Najeh on 17/03/2022.
//

import Foundation
import MobileBuySDK

class ClientQuery {
 

    static func queryToGetAllCollections() -> Storefront.QueryRootQuery {
        return Storefront.buildQuery { $0
                .collections(first: 25) { $0
                .edges { $0
                .node { $0
                    //                            .id()
                .title()
                .image{ $0
                .url()
                }
                }
                }
                }
        }
    }
    
    static func getSubCategoryProductsQuery(vendor:String , type:String) -> Storefront.QueryRootQuery {
        return Storefront.buildQuery{ $0
                .products(first: 50 , query: "vendor:\(vendor) AND product_type:\(type)"){ $0
                .edges{ $0
                .node { $0
                .title()
                .productType()
                .vendor()
                .featuredImage{ $0
                .url()
                }
                }
                }
                }
                }
    }
}
