//
//  Product.swift
//  Sample1
//
//  Created by Rajesh Yadav on 04/08/25.
//

/*
 "id": 1,
     "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
     "price": 109.95,
     "description": "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
     "category": "men's clothing",
     "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
     "rating": {
       "rate": 3.9,
       "count": 120
     }
 */

import Foundation

struct Product: Identifiable, Codable {
    let id: Int64
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating
}

struct Rating: Codable {
    let count: Int64
    let rate: Double
}
