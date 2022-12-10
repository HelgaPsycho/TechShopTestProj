//
//  HotSalesCell.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 09.12.2022.
//

import UIKit
import SDWebImage


class HotSalesCell: UICollectionViewCell {

    
    var data: HotSalesModel? {
        didSet {
            guard let data = data else {return}
            imageView.sd_setImage(with: data.picture, placeholderImage: UIImage(named: "placeholder"))
            titleLabel.text = data.title
            subtitleLabel.text = data.subtitle
            if !data.isNew {
                newView.isHidden = true
            
            }
            
        }
    }
    
    
    var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupHierarhy()
        setupConatraints()
        
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 10
        
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHierarhy (){
        contentView.addSubview(imageView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(newView)
        stackView.addArrangedSubview(labelsStackView)
        stackView.addArrangedSubview(buyNowButton)
        labelsStackView.addArrangedSubview(titleLabel)
        labelsStackView.addArrangedSubview(subtitleLabel)
        
    }
    
    func setupConatraints(){
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 10
        
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        stackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/2).isActive = true
        
      
    buyNowButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    buyNowButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/4).isActive = true
        
    }
    

    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        return stackView
        
    }()
    
    var newView: UIView = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "peach") ?? UIColor.orange
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = UIColor(named: "white") ?? UIColor.white
        let font = UIFont(name: "SFProDisplay-Bold", size: 10)
        title.font = font
        title.text = "New"
        view.addSubview(title)
        title.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        title.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.widthAnchor.constraint(equalToConstant: 30).isActive = true
        view.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        return view
        
    }()
    
    
    var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        return stackView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.borderColor = UIColor.black.cgColor
        label.textColor = UIColor(named: "white") ?? UIColor.white
        label.textAlignment = .left
        label.font = UIFont(name: "SFProDisplay-Bold", size: 25)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        
        return label
    }()
    
    var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Description"
        label.textColor = UIColor(named: "white") ?? UIColor.white
        let font = UIFont(name: "SFProDisplay-Bold", size: 11)
        label.font = font
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    var buyNowButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "white") ?? UIColor.white
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = UIColor.black
        title.text = "Buy now!"
        let font = UIFont(name: "SFProDisplay-Bold", size: 11)
        title.font = font
        button.addSubview(title)
        
        title.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        title.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        
        return button
        
    }()

}

