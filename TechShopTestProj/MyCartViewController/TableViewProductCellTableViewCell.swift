//
//  TableViewProductCellTableViewCell.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 15.12.2022.
//

import UIKit

class TableViewProductCell: UITableViewCell {
    
    var data: ProductModel? {
        didSet {
            guard let data = data else {return}
            productImageView.sd_setImage(with: URL(string: data.images), placeholderImage: UIImage(named: "placeholder"))
            print("CELL DATA \(data)")
//            titleLabel.text = data.title
//            subtitleLabel.text = data.subtitle
//            if !data.isNew {
//                newView.isHidden = true
            
            }
            
        }
    
    lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       // self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        self.setupHierarhy()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupInformation(id: Int, image: String, price: Double, title: String) {
        print("===================SETUP PRODUCT INFORMATION CALLED===================")
        productImageView.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "placeholder"))
    }

    private func setupHierarhy() {
        contentView.addSubview(productImageView)
        
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            productImageView.widthAnchor.constraint(equalToConstant: 100),
            productImageView.heightAnchor.constraint(equalToConstant: 100),
            productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            productImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 40)
        ])
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    


}
