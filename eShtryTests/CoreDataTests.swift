//
//  CoreDataTests.swift
//  eShtryTests
//
//  Created by Mahmoud Ghoneim on 3/22/22.
//

import XCTest
@testable import eShtry
import CoreData

class CoreDataTests: XCTestCase {
    
    var sut:CoreDataManager! = CoreDataManager.shared
    
    var products:[Product]! = [Product(id: "Z2lkOi8vc2hvcGlmeS9Qcm9kdWN0LzY5MDU1MTYzNTk3Mjc=", imageUrl: "https://cdn.shopify.com/s/files/1/0564/3223/0447/products/d841f71ea6845bf6005453e15a18c632.jpg?v=1646812300", name: "VANS | AUTHENTIC | (MULTI EYELETS) | GRADIENT/CRIMSON"), eShtry.Product(id: "Z2lkOi8vc2hvcGlmeS9Qcm9kdWN0LzY5MDU1MTY1MjM1Njc=", imageUrl: "https://cdn.shopify.com/s/files/1/0564/3223/0447/products/7902bf65776d504e75f86c8e8781d802.jpg?v=1646812309", name: "VANS | \nERA 59 MOROCCAN | GEO/DRESS BLUES"), eShtry.Product(id: "Z2lkOi8vc2hvcGlmeS9Qcm9kdWN0LzY5MDU1MTYzMjY5NTk=", imageUrl: "https://cdn.shopify.com/s/files/1/0564/3223/0447/products/9f190cba7218c819c81566bca6298c6a.jpg?v=1646812296", name: "VANS |AUTHENTIC | LO PRO | BURGANDY/WHITE"), eShtry.Product(id: "Z2lkOi8vc2hvcGlmeS9Qcm9kdWN0LzY5MDU1MTY0NTgwMzE=", imageUrl: "https://cdn.shopify.com/s/files/1/0564/3223/0447/products/883c6488076367d30ddd8481164ec7e2.jpg?v=1646812305", name: "VANS | AUTHENTIC (BUTTERFLY) TRUE | WHITE / BLACK")]
    
    override func setUpWithError() throws {
        initStubs()
    }

    override func tearDownWithError() throws {
        flushData()
        sut = nil
        products = nil
       
    }
    
    func testDeleteProduct(){
        let expectation = XCTestExpectation(description: "delete products")
        sut.deleteProduct(product: products[0])
        products.remove(at: 0)
        let count = sut.getAllFavoriteProducts().count
        expectation.fulfill()
        
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(count, products.count)
    }
    
    func testGetAllFavoriteProducts(){
        let expectation = XCTestExpectation(description: "delete products")
        var  products:[Product]?
        products = sut.getAllFavoriteProducts()
        expectation.fulfill()
        wait(for: [expectation], timeout: 2)
        XCTAssertNotNil(products, "product is not found")
    }
    
    func testIsInFovorite(){
        let expectation = XCTestExpectation(description: "check if product is in favorite")
        var  isFound :Bool?
        isFound = sut.isInFovorite(productId: self.products[0].id)
        expectation.fulfill()
        wait(for: [expectation], timeout: 2)
        XCTAssertNotNil(isFound, "product is not found")
        XCTAssertTrue(isFound ==  true , "product is not found")
    }
    

}

extension CoreDataTests{
    
    func initStubs() {
        for product in products{
            sut.insert(product: product)
        }
    }
    
    func flushData(){
        for product in sut.getAllFavoriteProducts(){
            sut.deleteProduct(product: product)
        }
        
    }
}

