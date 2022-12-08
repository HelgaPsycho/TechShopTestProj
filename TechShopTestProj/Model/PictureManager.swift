//
//  PictureManager.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 08.12.2022.
//

import Foundation
import UIKit

import Foundation
import UIKit
protocol PictureManagerDelegate {
    func didUpdatePicture(_ pictureManager: PictureManager, picture: UIImage)

    func didFailWithError(error: Error)
}


struct PictureManager {
    let hotSalesURL = "https://img.ibxk.com.br/2020/09/23/23104013057475.jpg?w=1120&h=420&mode=crop&scale=both"
    
    var delegate: PictureManagerDelegate?
    
    func fetchHotSales(pictureURL: String) {
        performRequest(with: pictureURL)
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
                    let picture = UIImage(data: safeData)
                    self.delegate?.didUpdatePicture(self, picture: (picture ?? UIImage(systemName: "photo"))!)
                    //                    if let picture = self.parseJSON(hotSalesData: safeData) {
                    //                        self.delegate?.didUpdatePicture(self, picture: picture)
                    // }
                }
            }
            task.resume()
        }
    }
    
    
}
