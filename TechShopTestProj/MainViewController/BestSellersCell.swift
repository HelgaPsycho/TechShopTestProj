//
//  BestSellersCell.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 09.12.2022.
//

import UIKit
import SDWebImage

final class BestSellersCell: UICollectionViewCell {
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private lazy var favouriteView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.backgroundWhiteColor
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .center
        
        let image = UIImage(named: "heart.png")
        imageView.image = image
        
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        return imageView
        
    }()
    
    
    private lazy var priceWithDiscount: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = UIColor.symbolsBlackColor
        label.text = ""
        label.font = UIFont(name: "MarkPro-Bold", size: 16)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private lazy var priceWithoutDiscoutLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = UIColor.symbolsGrayColor
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "")
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
        label.attributedText = attributeString
        label.text = ""
        label.font = UIFont(name: "MarkPro", size: 10)
    
        return label
    }()
    
    private lazy var emptyLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = UIColor.symbolsBlackColor
        label.text = "      "
        label.font = UIFont(name: "MarkPro", size: 10)
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = UIColor.symbolsBlackColor
        label.text = "Samsung Galaxy s20 Ultra"
        label.font = UIFont(name: "MarkPro-Regular", size: 10)
        return label
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()
    

    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = UIColor.backgroundWhiteColor
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
