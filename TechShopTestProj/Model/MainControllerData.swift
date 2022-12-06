//
//  MainControllerData.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 05.12.2022.
//

import Foundation

struct MainControllerData: Codable {
    
    let home_store: [HotSales]
    
    let best_seller: [BestSeller]
}

struct HotSales: Codable {
    let id: Int
    let is_new: Bool?
    let title: String
    let subtitle: String
    let picture: URL
    let is_buy: Bool?
    
}

struct BestSeller: Codable {
    let id: Int
    let is_favorites: Bool?
    let title: String
    let price_without_discount: Int
    let discount_Price: Int?
    let picture: URL
  
}
