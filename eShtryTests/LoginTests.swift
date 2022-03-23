//
//  LoginTests.swift
//  eShtryTests
//
//  Created by Mahmoud Ghoneim on 3/21/22.
//

import XCTest
@testable import eShtry

class LoginTests: XCTestCase {
    
    var sut:NetworkManager!
        
    override func setUpWithError() throws {
        sut = NetworkManager.shared
    }

    override func tearDownWithError() throws {
        sut = nil
    }
   
    
    func testLogin(){
        let expectation = XCTestExpectation(description: "login user")
        
        var error:String?
        var userIsFound:Bool?
        
        let userEmail = "user@gamil.com"
        let userPassword = "123456789As"
        
        sut.login(email: userEmail , password: userPassword ) { (response) in
            switch response.result{
            case .success(_):
                if let users = response.value {
                    for user in users.customers{
                        if  user.email == userEmail && user.tags == userPassword{
                           userIsFound = true
                            break
                        }
                    }
                   if userIsFound == nil {
                      userIsFound = false
                    }
                     
                    
                }else{
                    error = "response not valid"
                }
                
            case .failure(_):
                error = "error when loging in"
            
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        XCTAssertNil(error, "error while calling api")
        XCTAssertNotNil(userIsFound)
        print(userIsFound)
        XCTAssertTrue(userIsFound == true, "user is not found")
    }
    
    
    func testRegister(){
        let expectation = XCTestExpectation(description: "register new user")
        
        var errorMessage:String?
        var registerationSuccedeed:Bool?
        
        let customer = Customer(first_name: "mahmoud", last_name: "yousef_Ghoneim", email: "mahmoud1911@gmail.com", phone: "01078954123", tags: "123456789Ax", id: nil, verified_email: true, addresses: nil)
        let newCustomer = CustomarRoot(customer: customer)
        
        sut.registerCustomer(newCustomer: newCustomer) { (data, response, error) in
            if error != nil {
                errorMessage = "error"
            }
             if  let data = data {
                let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String,Any>
                print(json)
                let returnedCustomer = json["customer"] as? Dictionary<String,Any>
                let id = returnedCustomer?["id"] as? Int
                if let id = id , id > 0 {
                     registerationSuccedeed = true
                }else{
                    registerationSuccedeed = false
                }
             }else{
                errorMessage = "error"
             }
            expectation.fulfill()
         }
        wait(for: [expectation], timeout: 5)
        XCTAssertNil(errorMessage, "error when registering anew user")
        XCTAssertNotNil(registerationSuccedeed, "registeration failed")
        XCTAssertTrue(registerationSuccedeed == false, "registeration failed")
    }

}
