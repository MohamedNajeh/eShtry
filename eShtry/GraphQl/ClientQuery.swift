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
    
    static func getAllProducts() -> Storefront.QueryRootQuery{
        return Storefront.buildQuery{ $0
                .products(first:30){ $0
                .edges{ $0
                .node{ $0
                .id()
                .title()
                .description()
                .variants(first:2){ $0
                .edges{ $0
                .node { $0
                .title()
                }
                }
                }
                .images(first:10){ $0
                .edges{ $0
                .node{ $0
                .url()
                }
                }
                }
                .featuredImage{ $0
                .url()
                }
                .priceRange { $0
                .minVariantPrice{ $0
                .amount()
                }
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
    
    static func queryToGetBrandProducts(vendor:String) -> Storefront.QueryRootQuery {
        return Storefront.buildQuery { $0
                .products(first:30 , query:"vendor:\(vendor)"){ $0
                .edges{ $0
                .node{ $0
                .id()
                .title()
                .description()
                .variants(first:5){ $0
                .edges{ $0
                .node { $0
                .title()
                .id()
                }
                }
                }
                .images(first:10){ $0
                .edges{ $0
                .node{ $0
                .url()
                }
                }
                }
                .featuredImage{ $0
                .url()
                }
                .priceRange { $0
                .minVariantPrice{ $0
                .amount()
                }
                }
                }
                }
                }
        }
    }
    
    static func getProductDetails(title:String) -> Storefront.QueryRootQuery {
        return Storefront.buildQuery{ $0
                .products(first:5,query:"title:\(title)"){ $0
                .edges{ $0
                .node{ $0
                .title()
                .description()
                .variants{ $0
                .edges{ $0
                .node{ $0
                .title()
                }
                }
                }
                .priceRange{ $0
                .maxVariantPrice{ $0
                .amount()
                }
                }
                .images{ $0
                .edges{ $0
                .node{ $0
                .url()
                }
                }
                    
                }
                }
                }
                }
        }
    }
}

