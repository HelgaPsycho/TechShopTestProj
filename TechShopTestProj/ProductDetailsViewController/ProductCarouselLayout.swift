//
//  ProductCarouselLayout.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 12.12.2022.
//

import Foundation
import UIKit
import SDWebImage

class ProductCarouselLayout: UICollectionViewFlowLayout {
    
    var delegate: ProductDelegateFlowLayout?

    override init () {
        super.init()
            self.minimumInteritemSpacing = 0
            self.minimumLineSpacing = 0
            self.scrollDirection = .horizontal
            self.sectionInset = .zero
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder){
        fatalError("init(coder:) has no implemented")
    }
    
    override func prepare() {
        super.prepare()
        if let collectionView = collectionView {
            itemSize = collectionView.frame.size
        }
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard itemSize != newBounds.size else {return false}
        itemSize = newBounds.size
        return true
    }
}

protocol ProductDelegateFlowLayout {
    func sizeForItemAt()
    
}
