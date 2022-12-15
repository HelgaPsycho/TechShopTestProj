//
//  MyCartData.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 15.12.2022.
//

import Foundation

struct MyCartData: Codable {
    
    let basket: [ProductData]
    
    let delivery: String
    let id: String
    let total: Double
}

struct ProductData: Codable {
    let id: Int
    let images: String
    let price: Double
    let title: String
}


