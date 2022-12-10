//
//  BestSellersCell.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 09.12.2022.
//

import UIKit

final class BestSellersCell: UICollectionViewCell {
    
    private let profileImageView: UIImageView = {
           let imageView = UIImageView(frame: .zero)
           imageView.contentMode = .scaleAspectFill
           return imageView
       }()

       let name: UILabel = {
           let label = UILabel(frame: .zero)
           label.textAlignment = .center
           return label
       }()

       let locationLabel: UILabel = {
           let label = UILabel(frame: .zero)
           label.textAlignment = .center
           return label
       }()

       let professionLabel: UILabel = {
           let label = UILabel(frame: .zero)
           label.textAlignment = .center
           return label
       }()
       

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupHierarhy()
        setupConstraints()
        contentView.backgroundColor = UIColor(named: "white") ?? UIColor.white
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 10
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarhy() {
        
    }
    private func setupConstraints() { }
    
       
       func setup(with profile: Profile) {
           print("SETUP COLLECTION CELL CALLED")
          // profileImageView.image = UIImage(named: profile.name)
           name.text = profile.name
           locationLabel.text = profile.location
           professionLabel.text = profile.profession
       }

    
}
protocol ReusableView: AnyObject {
    static var identifier: String { get }
}


extension BestSellersCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
