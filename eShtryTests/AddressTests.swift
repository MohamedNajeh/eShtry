//
//  AddressTests.swift
//  eShtryTests
//
//  Created by Mahmoud Ghoneim on 3/22/22.
//

import XCTest
@testable import eShtry

class AddressTests: XCTestCase {
    
    var sut:NetworkManager!
    
    override func setUpWithError() throws {
        sut = NetworkManager.shared
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    
    func testAddAdress(){
        let expectation = XCTestExpectation(description: "add address")
        
        var errorMessage:String?
        var addAddressSuccedeed:Bool?
        

        let id = 5754289487919
        var address = Addresses(address1: "saed", address2: nil, city: "Cairo", province: "", phone: "12345674567", zip: "1234", name: "Ahmed base", country: "Egypt")
        
        sut.addAddress(id: id, address: address) { (data, response, error) in
            if error != nil {
                errorMessage = "error"
            }
            if let data = data{
                do{
                    let returnedCust = try JSONDecoder().decode(CustomarRoot.self, from: data)
                    
                    address.id = returnedCust.customer?.addresses?.last?.id ?? 0
                    if let address = address.id , address != 0 {
                        addAddressSuccedeed = true
                    } else{
                        addAddressSuccedeed = false
                    }
                }catch{
                    errorMessage = "\(error)"
                }
            
            expectation.fulfill()
           }
        }
        wait(for: [expectation], timeout: 5)
        XCTAssertNil(errorMessage, "error when add new address")
        XCTAssertNotNil(addAddressSuccedeed, "add address failed")
    }
    
    
    func testDeleteAddress(){
        let expectatin = XCTestExpectation(description: "delete address")
        var isDeletedSuccefully:Bool?
        sut.deleteAddress(userId: UserDefaults.standard.object(forKey: "userId") as? Int ?? 0, addressId: 6916348510255 ) { (data, response, error) in
            let json = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Dictionary<String,Any>
            isDeletedSuccefully = !json.isEmpty
            expectatin.fulfill()
        }
        wait(for: [expectatin], timeout: 5)
        XCTAssertNotNil(isDeletedSuccefully, "can't delete address ")
        XCTAssertTrue(isDeletedSuccefully == true, "can't delete address ")
    }
      
    }
    




