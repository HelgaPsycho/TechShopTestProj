//
//  ProductInformationView.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 12.12.2022.
//
import Foundation
import UIKit

class ProductInformationView: UIView {

    //Model
    var cpu: String = "ggg"
    var camera: String = ""
    var capacity: [String] = []
    var color: [String] = []
    var id = ""
    var images: [String] = []
    var isFavourites: Bool = false
    var price: Double = 0
    var rating: Double = 0
    var ssd: String = ""
    var sd: String = ""
    var title: String = ""

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  UIColor.black
        label.text = title
        label.textAlignment = .left
        label.contentMode = .bottomLeft
        let font = UIFont(name: "MarkPro-Medium", size: 24)
        label.font = font
        return label
    }()

    private lazy var favouriteButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "indigo") ?? UIColor.black
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.setImage(UIImage(named: "whiteHeart.png"), for: .normal)

        button.widthAnchor.constraint(equalToConstant:  40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true

        return button
    }()


    private lazy var ratingImageView = getRatingImageView()

    private func getRatingImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let image = getRatingImage()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }

    private lazy var informationDetailsView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view

    }()

    private lazy var simpleButtonsWithTextStack = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var shopButton = getSimpleButtonWith(label: "Shop")
    private lazy var detailsButton = getSimpleButtonWith(label: "Details")
    private lazy var featuresButton = getSimpleButtonWith(label: "Features")
    
    private var simpleButtonsWithLabelsArray: [UIButton] = []
    
    private func getSimpleButtonWith(label: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        simpleButtonsWithLabelsArray.append(button)
        button.setTitle(label, for: .normal)
        button.setTitleColor(UIColor(named: "darkSilver"), for: .normal)
        button.setTitleColor(UIColor.black, for: .selected)
        button.titleLabel?.font = UIFont(name: "MarkPro-Regular", size: 20)
        button.titleLabel?.textAlignment = .center
        
        button.addTarget(self, action: #selector(textButtonPressed), for: .touchUpInside)
        return button
    }

    private lazy var lineView: UIView = UIView()
    
    private lazy var lineImageView: UIImageView = {
        let image = UIImage(named: "horizontalLine.png")
        let imageView = UIImageView(image: image)
        return imageView
    }()

    private lazy var smallPicturesStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        return stackView
    }()

    private lazy var smallCPUview: UIView = getSmallViewWithPicture(name: "CPU.png")
    private lazy var smallCameraView: UIView = getSmallViewWithPicture(name: "camera.png")
    private lazy var smallSSDView: UIView = getSmallViewWithPicture(name: "SSD.png")
    private lazy var smallSDView: UIView = getSmallViewWithPicture(name: "SD.png")

    func getSmallViewWithPicture(name: String) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let imageView = UIImageView(image: UIImage(named: name))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        view.addSubview(imageView)
        
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return view
    }
    
    private lazy var detailsLabelsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var cpuLabel: UILabel = getDetailsLabel(string: cpu)
    private lazy var cameraLabel: UILabel = getDetailsLabel(string: camera)
    private lazy var ssdLabel: UILabel = getDetailsLabel(string: ssd)
    private lazy var sdLabel: UILabel = getDetailsLabel(string: sd)
    
    
    func getDetailsLabel(string: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  UIColor(named: "darkSilver") ?? UIColor.darkGray
        label.text = string
        label.textAlignment = .center
        let font = UIFont(name: "MarkPro-Regular", size: 11)
        label.font = font
        return label
    }

    private lazy var selectColorAndCapacityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  UIColor.black
        label.text = "Select color and capacity"
        label.textAlignment = .left
        let font = UIFont(name: "MarkPro-Medium", size: 16)
        label.font = font
        return label
    }()

    private lazy var colorsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private lazy var colorsButtonsArray = getColorButton(color)
 
    private func getColorButton(_ colors: [String]) -> [UIButton]{
        var array: [UIButton] = []
        for color in colors {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = UIColor(hex: color)
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 25
            button.setImage(UIImage(named: "checkMark.png"), for: .selected)
            button.setImage(UIImage(named: ""), for: .normal)
            button.addTarget(self, action: #selector(colorButtonPressed), for: .touchUpInside)

            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
            button.widthAnchor.constraint(equalToConstant: 50).isActive = true
           
            array.append(button)
        }
        return array
    }
    
    private lazy var capacityButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private lazy var capacityButtonsArray = getCapacityButtons(capacityes: capacity)
    private lazy var labelsForCapacityButtonsArray = getLabelsForCapacityButton(capacityes: capacity)
    
    private func getCapacityButtons(capacityes: [String]) -> [UIButton] {
        var array: [UIButton] = []
        for _ in capacityes {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 10
            
            button.addTarget(self, action: #selector(capacityButtonPressed), for: .touchUpInside)

            button.heightAnchor.constraint(equalToConstant: 30).isActive = true
            button.widthAnchor.constraint(equalToConstant: 60).isActive = true

            array.append(button)
        }

        return array
    }
    
    private func getLabelsForCapacityButton (capacityes: [String])-> [UILabel] {
        var array: [UILabel] = []
        for i in capacityes {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor =  UIColor(named: "darkSilver") ?? UIColor.darkGray
            label.textAlignment = .center
            let font = UIFont(name: "MarkPro-Bold", size: 13)
            label.font = font
            label.text = i
            array.append(label)
        }
        return array
    }

    
    private lazy var addToCartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "peach") ?? UIColor.orange
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.setTitle("Add to Cart        $1,500", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .highlighted)
        button.titleLabel?.font = UIFont(name: "MarkPro-Bold", size: 20)
        button.titleLabel?.textAlignment = .center

       button.addTarget(self, action: #selector(addToCartButtonPressed), for: .touchUpInside)

        return button
    }()



    override init(frame: CGRect) {
        super.init(frame: .zero)
    
        setupView()
        setupHierarhy()
        setupConstraints()
    }
    
    func setupModel(model: ProductDetailsModel){

        cpu = model.CPU
        camera = model.camera
        capacity = model.capacity
        color =  model.color
        id = model.id
        images = model.images
        isFavourites = model.isFavorites
        price = model.price
        rating = model.rating
        ssd = model.ssd
        sd = model.sd
        title  = model.title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupView(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.white
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 20

        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineImageView.isHidden = true
        
        colorsStackView.translatesAutoresizingMaskIntoConstraints = false
    }

    func setupHierarhy() {
        self.addSubview(titleLabel)
        self.addSubview(favouriteButton)
        self.addSubview(ratingImageView)
        self.addSubview(addToCartButton)

        self.addSubview(informationDetailsView)
        informationDetailsView.addSubview(simpleButtonsWithTextStack)
        informationDetailsView.addSubview(lineView)
        informationDetailsView.addSubview(smallPicturesStack)
        informationDetailsView.addSubview(detailsLabelsStack)
        informationDetailsView.addSubview(selectColorAndCapacityLabel)
        informationDetailsView.addSubview(colorsStackView)
        informationDetailsView.addSubview(capacityButtonsStackView)

        simpleButtonsWithTextStack.addArrangedSubview(shopButton)
        simpleButtonsWithTextStack.addArrangedSubview(detailsButton)
        simpleButtonsWithTextStack.addArrangedSubview(featuresButton)
        
        lineView.addSubview(lineImageView)

        smallPicturesStack.addArrangedSubview(smallCPUview)
        smallPicturesStack.addArrangedSubview(smallCameraView)
        smallPicturesStack.addArrangedSubview(smallSSDView)
        smallPicturesStack.addArrangedSubview(smallSDView)
        
        detailsLabelsStack.addArrangedSubview(cpuLabel)
        detailsLabelsStack.addArrangedSubview(cameraLabel)
        detailsLabelsStack.addArrangedSubview(ssdLabel)
        detailsLabelsStack.addArrangedSubview(sdLabel)

        for color in colorsButtonsArray {
           colorsStackView.addArrangedSubview(color)
        }
        
   //     привязка лейблов к кнопке и их расположение
        for item in capacityButtonsArray {
            capacityButtonsStackView.addArrangedSubview(item)
            item.addSubview(labelsForCapacityButtonsArray[capacityButtonsArray.firstIndex(of: item)!])
            labelsForCapacityButtonsArray[capacityButtonsArray.firstIndex(of: item)!].centerXAnchor.constraint(equalTo: item.centerXAnchor).isActive = true
            labelsForCapacityButtonsArray[capacityButtonsArray.firstIndex(of: item)!].centerYAnchor.constraint(equalTo: item.centerYAnchor).isActive = true

        }
        
        
//        shopButton.addSubview(shopLabel)
//        detailsButton.addSubview(detailsLabel)
//        featuresButton.addSubview(featuresLabel)


    }
    func setupConstraints() {
        NSLayoutConstraint.activate([

            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 40),

            favouriteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            favouriteButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),

            ratingImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 40),
            ratingImageView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
            ratingImageView.heightAnchor.constraint(equalToConstant: 20),
            ratingImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3),

            addToCartButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addToCartButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30),
            addToCartButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30),
            addToCartButton.heightAnchor.constraint(equalToConstant: 50),

            informationDetailsView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            informationDetailsView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            informationDetailsView.topAnchor.constraint(equalTo: ratingImageView.bottomAnchor, constant: 20),
            informationDetailsView.bottomAnchor.constraint(equalTo: addToCartButton.topAnchor),

            simpleButtonsWithTextStack.rightAnchor.constraint(equalTo: informationDetailsView.rightAnchor),
            simpleButtonsWithTextStack.leftAnchor.constraint(equalTo: informationDetailsView.leftAnchor),
            simpleButtonsWithTextStack.topAnchor.constraint(equalTo: informationDetailsView.topAnchor),
            simpleButtonsWithTextStack.heightAnchor.constraint(equalTo: informationDetailsView.heightAnchor, multiplier: 1/6),
            
//            shopLabel.centerXAnchor.constraint(equalTo: shopButton.centerXAnchor),
//            shopLabel.centerYAnchor.constraint(equalTo: shopButton.centerYAnchor),
//            detailsLabel.centerXAnchor.constraint(equalTo: detailsButton.centerXAnchor),
//            detailsLabel.centerYAnchor.constraint(equalTo: detailsButton.centerYAnchor),
//            featuresLabel.centerXAnchor.constraint(equalTo: featuresButton.centerXAnchor),
//            featuresLabel.centerYAnchor.constraint(equalTo: featuresButton.centerYAnchor),

            lineView.rightAnchor.constraint(equalTo: informationDetailsView.rightAnchor),
            lineView.leftAnchor.constraint(equalTo: informationDetailsView.leftAnchor),
            lineView.topAnchor.constraint(equalTo: simpleButtonsWithTextStack.bottomAnchor),
            lineView.heightAnchor.constraint(equalTo: informationDetailsView.heightAnchor, multiplier: 1/24),
            
    
            smallPicturesStack.rightAnchor.constraint(equalTo: informationDetailsView.rightAnchor),
            smallPicturesStack.leftAnchor.constraint(equalTo: informationDetailsView.leftAnchor),
            smallPicturesStack.topAnchor.constraint(equalTo: lineView.bottomAnchor),
            smallPicturesStack.heightAnchor.constraint(equalTo: informationDetailsView.heightAnchor, multiplier: 1/4),
            
            detailsLabelsStack.leftAnchor.constraint(equalTo: informationDetailsView.leftAnchor),
            detailsLabelsStack.rightAnchor.constraint(equalTo: informationDetailsView.rightAnchor),
            detailsLabelsStack.topAnchor.constraint(equalTo: smallPicturesStack.bottomAnchor),
            detailsLabelsStack.heightAnchor.constraint(equalTo: informationDetailsView.heightAnchor, multiplier: 1/12),
            
            selectColorAndCapacityLabel.leftAnchor.constraint(equalTo: informationDetailsView.leftAnchor, constant: 40),
            selectColorAndCapacityLabel.topAnchor.constraint(equalTo: detailsLabelsStack.bottomAnchor),
            selectColorAndCapacityLabel.heightAnchor.constraint(equalTo: informationDetailsView.heightAnchor, multiplier: 1/12),
            selectColorAndCapacityLabel.widthAnchor.constraint(equalTo: informationDetailsView.widthAnchor, multiplier: 2/3),
            
            colorsStackView.leftAnchor.constraint(equalTo: informationDetailsView.leftAnchor, constant: 30),
            colorsStackView.topAnchor.constraint(equalTo: selectColorAndCapacityLabel.bottomAnchor),
            colorsStackView.widthAnchor.constraint(equalTo: informationDetailsView.widthAnchor, multiplier: 1/3),
            colorsStackView.heightAnchor.constraint(equalTo: informationDetailsView.heightAnchor, multiplier: 3/8),
            
            capacityButtonsStackView.rightAnchor.constraint(equalTo: informationDetailsView.rightAnchor, constant: -30),
            capacityButtonsStackView.topAnchor.constraint(equalTo: selectColorAndCapacityLabel.bottomAnchor),
            capacityButtonsStackView.widthAnchor.constraint(equalTo: informationDetailsView.widthAnchor, multiplier: 2/5),
            capacityButtonsStackView.heightAnchor.constraint(equalTo: informationDetailsView.heightAnchor, multiplier: 3/8)
    

        ])
        
    }

    func getRatingImage()-> UIImage {
        switch rating {
        case 4.8...  :
           return UIImage(named: "5stars.png")!
        case 4.3... :
          return UIImage(named: "4.5stars.png")!
        case 3.8... :
            return UIImage(named: "4stars.png")!
        case 3.3...:
            return UIImage(named: "3.5stars.png")!
        case 2.8... :
            return UIImage(named: "3.0stars.png")!
        case 2.3... :
            return UIImage(named: "2.5stars.png")!
        case 1.8...:
            return UIImage(named: "2.0stars.png")!
        case 1.3...:
            return UIImage(named: "1.5stars.png")!
        case 0.8...:
            return UIImage(named: "1.0stars.png")!
        case 0.3...:
            return UIImage(named: "0.5stars.png")!
        case 0.0... :
            return UIImage(named: "0stars.png")!
        default:
            return UIImage(named: "5stars.png")!
        }
    }
}


extension ProductInformationView {
    
    
    @objc private func textButtonPressed(sender: UIButton){
        for button in simpleButtonsWithLabelsArray {
            if button == sender {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
        }
                
    }

    @objc private func colorButtonPressed(sender: UIButton){
        for i in colorsButtonsArray {
            if i == sender {
                i.isSelected = true
            } else {
                i.isSelected = false
            }
        }
        
    }
    
    @objc private func capacityButtonPressed(sender: UIButton){
        var count = 0
        for button in capacityButtonsArray {
            if button == sender {
                button.isSelected = true
                button.backgroundColor = UIColor(named: "peach") ?? UIColor.orange
                labelsForCapacityButtonsArray[count].textColor = UIColor.white
            } else {
                button.isSelected = false
                button.backgroundColor = UIColor.clear
                labelsForCapacityButtonsArray[count].textColor = UIColor(named: "darkSilveer") ?? UIColor.darkGray
            }
            count += 1
        }
    }
    
    @objc private func addToCartButtonPressed(sender: UIButton) {
        //API - отправить модель
        print("ADD TO CART BUTTON PRESSED")
    }
}


