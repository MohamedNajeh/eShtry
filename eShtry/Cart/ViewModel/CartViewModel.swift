//
//  CartViewModel.swift
//  eShtry
//
//  Created by eslam mohamed on 11/03/2022.
//

import Foundation

class CartViewModel: NSObject{
    
    
    private var cartItems: [CartItem] = [CartItem]()
    
    
//    private var cellViewModdel:[CartItem]
    
    
    override init() {
        super.init()
        fetchCartItems()
    }
    
    
    private func fetchCartItems(){
        
    }
    
}
