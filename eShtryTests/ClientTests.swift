//
//  ClientTests.swift
//  UnitTestingTests
//
//  Created by Mahmoud Ghoneim on 3/21/22.
//

import XCTest
@testable import eShtry
import MobileBuySDK

class ClientTests: XCTestCase {
    
    var sut: Client!
    
    override func setUpWithError() throws {
        sut = Client()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
  
    func testFetchAllCollections(){
        let expectation = XCTestExpectation(description: "Brands is downloaded") // wait untill fimising request and get response
      //  var brandsCollection:[Storefront.Collection]?
        var count: Int?
        sut.fetchAllCollections { (brands) in
            count = brands?.count
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(count)
        XCTAssertTrue(count! > 0, "brands is empty")
    }
    
    
    func testFetchAllSubCategoryProducts(){
        let expectation = XCTestExpectation(description: "fetch SubCategories products")
        var products:[Storefront.Product]?
        var Error:String?
        sut.fetchAllSubCategoryProducts(vendor: "VANS", type: "SHOES") { (results) in
            if results != nil {
                products = results
                expectation.fulfill()
            }else{
                Error = "error when fetching sub categories"
            }
        }
        wait(for: [expectation], timeout: 5)
        XCTAssertNil(Error)
        XCTAssertNotNil(products)
    }
    
 
    func testFetchBrandProducts(){
        let expectation = XCTestExpectation(description: "download brand products")
        var products:[Storefront.Product]?
        sut.fetchBrandProducts(vendor: "VANS") { (result) in
            if result != nil {
                products = result
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(products)
        XCTAssertFalse(products?.count == 0, "products count is greater than 0")
    }
    
    
    func testFetchAllProductsCount(){
        let expectation = XCTestExpectation(description: "download all products")
        var products:[Storefront.Product]?
        sut.fetchAllProducts { (results) in
            products = results
            expectation.fulfill()
        }
        
        wait(for: [expectation] , timeout: 5)
        XCTAssertNotNil(products, "products is nil")
        XCTAssertTrue(products?.count != 0, "products is empty")
    }
    
    

}
