//
//  SalesModels.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 05.12.2022.
//

import Foundation

import Foundation

struct HotSalesModel {
    let id: Int
    let isNew: Bool
    let title: String
    let subtitle: String
    let picture: URL
    let isBuy: Bool
}

struct BestSellersModel {
    let id: Int
    let isFavorites: Bool
    let title: String
    let priceWithoutDiscount: Double
    let discountPrice: Double
    let picture: URL
}

