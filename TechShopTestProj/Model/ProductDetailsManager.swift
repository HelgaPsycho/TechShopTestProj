//
//  ProductDetailsManager.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 14.12.2022.
//

import Foundation
import Foundation

protocol ProductDetailsManagerDelegate {
    func didUpdateProductDetails(_ productDetailsManager: ProductDetailsManager, productDetails: [ProductDetailsModel])
    func didFailWithError(error: Error)
}


struct ProductDetailsManager {
    let productDetailsURL = "https://run.mocky.io/v3/6c14c560-15c6-4248-b9d2-b4508df7d4f5"
    
    var delegate: ProductDetailsManagerDelegate?
    
    func fetchProductDetails() {
        performRequest(with: productDetailsURL)
    }
    
    func performRequest(with urlString: String){
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let hotSales = self.parseJSON(hotSalesData: safeData) {
                        self.delegate?.didUpdateHotSales(self, hotSales: hotSales)
                    }
                    if let bestSellers = self.parseJSON(bestSellersData: safeData){
                        self.delegate?.didUpdateBestSellers(self, bestSellers: bestSellers)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(hotSalesData: Data) -> [HotSalesModel]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MainControllerData.self, from: hotSalesData)
            var hotSalesModelsArray: [HotSalesModel] = []
            for element in decodedData.home_store {
                let id: Int = element.id
                let isNew: Bool = element.is_new ?? false
                let title: String = element.title
                let subtitle: String = element.subtitle
                let picture: URL = element.picture
                let isBuy: Bool = element.is_buy ?? false
                
                let hotSalesElement = HotSalesModel(id: id, isNew: isNew, title: title, subtitle: subtitle, picture: picture, isBuy: isBuy)
                hotSalesModelsArray.append(hotSalesElement)
                
            }
            
            return hotSalesModelsArray
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func parseJSON(bestSellersData: Data) -> [BestSellersModel]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MainControllerData.self, from: bestSellersData)
            var bestSellersModelsArray: [BestSellersModel] = []
            for element in decodedData.best_seller {
                let id: Int = element.id
                let isFavorites: Bool = element.is_favorites ?? false
                let title: String = element.title
                let priceWithoutDiscount: Int = element.price_without_discount
                let discountPrice: Int = element.discount_Price ?? element.price_without_discount
                let picture: URL = element.picture
                
                let bestSellersElement = BestSellersModel(id: id, isFavorites: isFavorites, title: title, priceWithoutDiscount: priceWithoutDiscount, discountPrice: discountPrice, picture: picture)
                bestSellersModelsArray.append(bestSellersElement)
                
            }
            
            return bestSellersModelsArray
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
        
        
    }
}
