//
//  HotSalesManager.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 06.12.2022.
//

import Foundation

protocol HotSalesAndBestSellersManagerDelegate {
    func didUpdateHotSales(_ hotSalessManager: HotSalesAndBAstSellersManager, hotSales: [HotSalesModel])
    func didUpdateBestSellers(_ hotSalesAndBestSellersManager: HotSalesAndBAstSellersManager, bestSellers: [BestSellersModel])
    func didFailWithError(error: Error)
}


struct HotSalesAndBAstSellersManager {
    let hotSalesURL = "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175"
    
    var delegate: HotSalesAndBestSellersManagerDelegate?
    
    func fetchHotSales() {
        performRequest(with: hotSalesURL)
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
                let priceWithoutDiscount: Double = element.price_without_discount
                let discountPrice: Double = element.discount_Price ?? element.price_without_discount
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
