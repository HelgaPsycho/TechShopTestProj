//
//  ProductDetailsModel.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 12.12.2022.
//

import Foundation

struct ProductDetailsModel: Codable {
    
    let CPU: String
    let camera: String
    let capaciry: [Int]
    let color: [String]
    let id: Int
    let images: [URL]
    let isFavourites: Bool
    let price: Double
    let rating: Double
    let ssd: String
    let title: String
    
}
