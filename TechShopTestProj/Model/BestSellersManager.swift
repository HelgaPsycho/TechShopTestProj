//
//  BestSellersManager.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 07.12.2022.
//

import Foundation
import Foundation

protocol BestSellersManagerDelegate {
    func didUpdateBestSellers(_ bestSellersManager: BestSellersManager, bestSellers: [BestSellersModel])
    func didFailWithError(error: Error)
}


struct BestSellersManager {
    let hotSalesURL = "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175"
    
    var delegate: BestSellersManagerDelegate?
    
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
                    if let bestSellers = self.parseJSON(safeData) {
                        self.delegate?.didUpdateBestSellers(self, bestSellers: bestSellers)
                    }
                }
            }
            task.resume()
        }
    }

    func parseJSON(_ hotSalesData: Data) -> [BestSellersModel]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MainControllerData.self, from: hotSalesData)
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
