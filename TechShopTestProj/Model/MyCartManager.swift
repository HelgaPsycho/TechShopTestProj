//
//  MyCartManager.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 15.12.2022.
//

import Foundation

protocol MyCartManagerDelegate {
    func didUpdateMyCart(_ myCartManager: MyCartManager, myCart: MyCartModel)
    func didUpdateBasketProducts(_ myCartManager: MyCartManager, productsDetails: [ProductModel])
    func didFailWithError(error: Error)
}


struct MyCartManager {
    let myCartURL = "https://run.mocky.io/v3/53539a72-3c5f-4f30-bbb1-6ca10d42c149"
    
    var delegate: MyCartManagerDelegate?
    
    func fetchMyCartInfo() {
        performRequest(with: myCartURL)
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
                    if let myCart = self.parseJSON(myCartData: safeData) {
                        self.delegate?.didUpdateMyCart(self, myCart: myCart)
                    }
                    if let productDetails = self.parseJSON(productDetails: safeData){
                        self.delegate?.didUpdateBasketProducts(self, productsDetails: productDetails)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(myCartData: Data) -> MyCartModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MyCartData.self, from: myCartData)
            let delivery = decodedData.delivery
            let id = decodedData.id
            let total = decodedData.total
            
            let myCartModel = MyCartModel(delivery: delivery, id: id, total: total)
            
            return myCartModel
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func parseJSON(productDetails: Data) -> [ProductModel]?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MyCartData.self, from: productDetails)
            var productsArray: [ProductModel] = []
            var count = 0
            for element in decodedData.basket {
                let id = decodedData.basket[count].id
                let images = decodedData.basket[count].images
                let price = decodedData.basket[count].price
                let title = decodedData.basket[count].title
                
                let productModel = ProductModel(id: id, images: images, price: price, title: title)
                productsArray.append(productModel)
                count = count + 1
            }
            
            return productsArray
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
        
        
    }
}
