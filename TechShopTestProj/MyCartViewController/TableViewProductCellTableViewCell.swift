//
//  TableViewProductCellTableViewCell.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 15.12.2022.
//

import UIKit

class TableViewProductCell: UITableViewCell {
    
    var counter = 1 {
        didSet {
            stepperLabel.text = "\(counter)"
        }
    }
    
    var data: ProductModel? {
        didSet {
            guard let data = data else {return}
            productImageView.sd_setImage(with: URL(string: data.images), placeholderImage: UIImage(named: "placeholder"))
            print("CELL DATA \(data)")
            titleLabel.text = data.title
            priceLabel.text = "$\(data.price)"
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
    
    
    lazy var trashButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "trash.png")
        button.setImage(image, for: .normal)
        button.contentMode = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return button
    }()
    
    
    private lazy var stepper: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "lightIndigo") ?? UIColor.darkGray
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15
        
        view.widthAnchor.constraint(equalToConstant: 30).isActive = true
        view.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        return view
    }()
    
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "plus.png")
        button.setImage(image, for: .normal)
        
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        button.addTarget(self, action: #selector(plusPressed), for: .touchUpInside)
        
        return button
        
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "minus.png")
        button.setImage(image, for: .normal)
        
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        button.addTarget(self, action: #selector(minusPressed), for: .touchUpInside)
        
        return button
        
    }()
    
    private lazy var stepperLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  UIColor.white
        label.text = "\(counter)"
        label.textAlignment = .center
        label.numberOfLines = 2
        let font = UIFont(name: "MarkPro-Medium", size: 20)
        label.font = font
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  UIColor.white
        label.text = ""
        label.textAlignment = .left
        label.numberOfLines = 2
        let font = UIFont(name: "MarkPro-Medium", size: 20)
        label.font = font
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  UIColor(named: "peach") ?? UIColor.orange
        label.text = ""
        label.textAlignment = .left
        label.numberOfLines = 1
        let font = UIFont(name: "MarkPro-Medium", size: 20)
        label.font = font
        return label
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
    
//    func setupInformation(id: Int, image: String, price: Double, title: String) {
//        print("===================SETUP PRODUCT INFORMATION CALLED===================")
//        productImageView.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "placeholder"))
//    }

    private func setupHierarhy() {
        contentView.addSubview(productImageView)
        contentView.addSubview(trashButton)
        contentView.addSubview(stepper)
        stepper.addSubview(plusButton)
        stepper.addSubview(minusButton)
        stepper.addSubview(stepperLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            productImageView.widthAnchor.constraint(equalToConstant: 100),
            productImageView.heightAnchor.constraint(equalToConstant: 100),
            productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            productImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 40),
            
            trashButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            trashButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            
            stepper.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stepper.rightAnchor.constraint(equalTo: trashButton.leftAnchor, constant: -10),
            
            plusButton.centerXAnchor.constraint(equalTo: stepper.centerXAnchor),
            plusButton.bottomAnchor.constraint(equalTo: stepper.bottomAnchor),
            
            minusButton.centerXAnchor.constraint(equalTo: stepper.centerXAnchor),
            minusButton.topAnchor.constraint(equalTo: stepper.topAnchor),
            
            stepperLabel.centerXAnchor.constraint(equalTo: stepper.centerXAnchor),
            stepperLabel.centerYAnchor.constraint(equalTo: stepper.centerYAnchor),
            
            titleLabel.leftAnchor.constraint(equalTo: productImageView.rightAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: stepper.leftAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: productImageView.topAnchor),
            
            priceLabel.leftAnchor.constraint(equalTo: productImageView.rightAnchor, constant: 10),
            priceLabel.rightAnchor.constraint(equalTo: stepper.leftAnchor, constant: -10),
            priceLabel.bottomAnchor.constraint(equalTo: productImageView.bottomAnchor)
            
        ])
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    


}

//MARK: - STEPPER FUNC

extension TableViewProductCell {

    @objc func plusPressed(sender: UIButton) {
        self.counter = counter + 1
    }
    
    @objc func minusPressed(sender: UIButton) {
        if counter > 0 {
            self.counter = counter - 1
        }
    }
}
