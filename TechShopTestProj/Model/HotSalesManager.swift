//
//  HotSalesManager.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 06.12.2022.
//

import Foundation

protocol HotSalesManagerDelegate {
    func didUpdateHotSales(_ hotSalessManager: HotSalesManager, hotSales: [HotSalesModel])
    func didFailWithError(error: Error)
}


struct HotSalesManager {
    let hotSalesURL = "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175"
    
    var delegate: HotSalesManagerDelegate?
    
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
                    if let hotSales = self.parseJSON(safeData) {
                        self.delegate?.didUpdateHotSales(self, hotSales: hotSales)
                    }
                }
            }
            task.resume()
        }
    }

    func parseJSON(_ hotSalesData: Data) -> [HotSalesModel]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MainControllerData.self, from: hotSalesData)
            print(decodedData)
            var hotSalesModelsArray: [HotSalesModel] = []
            for element in decodedData.home_store {
                print(element)
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
    

    
    
}
