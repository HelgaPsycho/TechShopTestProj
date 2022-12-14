//
//  ProductDetailsControllerData.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 11.12.2022.
//

import Foundation

struct ProductDetailsControllerData: Codable {
    
    let CPU: String
    let camera: String
    let capacity: [String]
    let color: [String]
    let id: String
    let images: [String]
    let isFavorites: Bool
    let price: Double
    let rating: Double
    let ssd: String
    let sd: String
    let title: String
    
}


