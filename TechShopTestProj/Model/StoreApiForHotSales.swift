//
//  StoreApiForHotSales.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 09.12.2022.
//

import Foundation
import Combine

class StoreAPIForHotSales {
    
    private var cancellable = Set<AnyCancellable>()
    
    func hotSalesProducts() -> Future<[HotSales], Never>{
        return Future { promise in
            let taskPublisher =
            URLSession.shared.dataTaskPublisher(for: URL(string: "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175")!)
            taskPublisher.map {
                $0.data
            }
            .decode(type: [HotSales].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(_):
                    promise(.success([HotSales]()))
                }
            } receiveValue:  { (hotSalesProducts) in
                promise(.success(hotSalesProducts))
            } .store(in: &self.cancellable)
            
        }
    }
}
                        
                        
