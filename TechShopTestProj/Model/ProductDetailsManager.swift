//
//  ProductDetailsManager.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 14.12.2022.
//

import Foundation
import Foundation

protocol ProductDetailsManagerDelegate {
    func didUpdateProductDetails(_ productDetailsManager: ProductDetailsManager, productDetails: ProductDetailsModel)
    
    func didUpdateProductImages(_ productDetailsManager: ProductDetailsManager, imagesStrings: [String])
    
    func didFailWithError(error: Error)
}


struct ProductDetailsManager {
    
    //TODO передать ссылку через Coordinator
    let productDetailsURL = "https://run.mocky.io/v3/6c14c560-15c6-4248-b9d2-b4508df7d4f5"
    
    var delegate: ProductDetailsManagerDelegate?
    
    func fetchProductDetails() {
        performRequest(with: productDetailsURL)
    }
    
    func performRequest(with urlString: String){
        print("PERFORM REQUEST \(urlString)")
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let productDetails = self.parseJSON(productDetailsData: safeData) {
                        self.delegate?.didUpdateProductDetails(self, productDetails: productDetails)
                        
                    }
                    if let productDetails = self.parseJSON(imagesStrings: safeData) {
                        self.delegate?.didUpdateProductImages(self, imagesStrings: productDetails)
                        print("IMAGES URLS: \(productDetails)")
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(productDetailsData: Data) -> ProductDetailsModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ProductDetailsControllerData.self, from: productDetailsData)
            let CPU: String = decodedData.CPU
            let camera: String = decodedData.camera
            let capacity: [String] = decodedData.capacity
            let color: [String] = decodedData.color
            let id: String = decodedData.id
            let images: [String] = decodedData.images
            let isFavourites: Bool = decodedData.isFavorites ?? false
            let price: Double = decodedData.price
            let rating: Double = decodedData.rating
            let ssd: String = decodedData.ssd
            let sd: String = decodedData.sd
            let title: String = decodedData.title
            
            let productDetails = ProductDetailsModel(CPU: CPU, camera: camera, capacity: capacity, color: color, id: id, images: images, isFavorites: isFavourites, price: price, rating: rating, ssd: ssd, sd: sd, title: title)
           print(productDetails)
            return productDetails
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
            
        }
    }
    
    func parseJSON(imagesStrings: Data) -> [String]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ProductDetailsControllerData.self, from: imagesStrings)
            let images: [String] = decodedData.images
            print ("PARSING IMAGES")
            return images
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
            
        }
    }
    
    
}
