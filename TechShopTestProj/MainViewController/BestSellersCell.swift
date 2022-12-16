//
//  BestSellersCell.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 09.12.2022.
//

import UIKit
import SDWebImage

final class BestSellersCell: UICollectionViewCell {
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    var favouriteView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.white
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .center
        
        let image = UIImage(named: "heart.png")
        imageView.image = image
        
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        return imageView
        
    }()
    
    private let priceWithDiscount: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black
        label.text = ""
        label.font = UIFont(name: "MarkPro-Bold", size: 16)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private let priceWithoutDiscoutLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = UIColor.lightGray
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "")
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
        label.attributedText = attributeString
        label.text = ""
        label.font = UIFont(name: "MarkPro", size: 10)
    
        return label
    }()
    
    private let emptyLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "      "
        label.font = UIFont(name: "MarkPro", size: 10)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Samsung Galaxy s20 Ultra"
        label.font = UIFont(name: "MarkPro-Regular", size: 10)
        return label
    }()
    
    private let labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    private let priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()
    

    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = UIColor(named: "white") ?? UIColor.white
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 10
        setupHierarhy()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarhy() {
        contentView.addSubview(productImageView)
        contentView.addSubview(favouriteView)
        contentView.addSubview(labelsStackView)
        labelsStackView.addArrangedSubview(priceStackView)
        labelsStackView.addArrangedSubview(titleLabel)
        priceStackView.addArrangedSubview(priceWithDiscount)
        priceStackView.addArrangedSubview(priceWithoutDiscoutLabel)
        priceStackView.addArrangedSubview(emptyLabel)
        
    }
    
    private func setupomponents() {
        labelsStackView.backgroundColor = .yellow
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            productImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            productImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            
            favouriteView.topAnchor.constraint(equalTo: productImageView.topAnchor, constant: 10),
            favouriteView.rightAnchor.constraint(equalTo: productImageView.rightAnchor, constant: -10),
            
            labelsStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            labelsStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            labelsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            labelsStackView.topAnchor.constraint(equalTo: productImageView.bottomAnchor)
            
        ])
    }
    
    
    //MARK: - Настройка содержимого ячейки

    func setup(with product: BestSellersModel){
        productImageView.sd_setImage(with: product.picture, placeholderImage: UIImage(named: "placeholder"))
        if product.isFavorites == false {
            favouriteView.image = UIImage(named: "heart.png")
        } else {
            favouriteView.image = UIImage(named: "fullHeart.png")
        }
        priceWithoutDiscoutLabel.text = "  $\(product.priceWithoutDiscount)"
        priceWithDiscount.text = "$\(product.discountPrice)"
        titleLabel.text = product.title
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
