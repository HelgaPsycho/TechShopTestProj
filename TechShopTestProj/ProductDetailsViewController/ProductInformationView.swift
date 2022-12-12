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
    var price: String = ""
    var rating: Double = 0
    var ssd: String = ""
    var sd: String = ""
    var title: String = ""

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  UIColor.black
        label.text = "Galaxy Note 20 Ultra"
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
        view.backgroundColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view

    }()

    private lazy var simpleButtonsWithTextStack = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .red
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        return stackView
    }()

    private lazy var shopButton = getSimpleButton()
    private lazy var shopLabel = getLabelForButton(named: "Shop")

    private lazy var detailsButton = getSimpleButton()
    private lazy var detailsLabel = getLabelForButton(named: "Details")

    private lazy var featuresButton = getSimpleButton()
    private lazy var featuresLabel = getLabelForButton(named: "Features")

    private func getSimpleButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.red
        return button
    }

    private func getLabelForButton (named: String)-> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  UIColor(named: "darkSilver") ?? UIColor.darkGray
        label.text = named
        label.textAlignment = .center
        let font = UIFont(name: "MarkPro-Regular", size: 20)
        label.font = font
        return label
    }

    private func getLabelForSelectButton (named: String)-> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  UIColor.black
        label.text = named
        label.textAlignment = .center
        let font = UIFont(name: "MarkPro-Bold", size: 20)
        label.font = font
        return label
    }

    private lazy var lineView: UIView = UIView()

    private lazy var smallPicturesStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .blue
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


    private lazy var addToCartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "peach") ?? UIColor.orange
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  UIColor.white
        label.text = "Add to Cart        $1,500"
        label.textAlignment = .left
        let font = UIFont(name: "MarkPro-Bold", size: 20)
        label.font = font
        button.addSubview(label)

        label.leftAnchor.constraint(equalTo: button.leftAnchor, constant: 60).isActive = true
        label.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true

      //  button.addTarget(self, action: #selector(addToCartButtonPressed), for: .touchUpInside)

        return button
    }()



    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupModel()
        setupView()
        setupHierarhy()
        setupConstraints()
    }

    func setupModel(){

        cpu = "Exynos 990"
        camera = "108 + 12 mp"
        capacity = ["126", "252"]
        color =  ["#772D03", "#010035"]
        id = "3"
        images = ["https://avatars.mds.yandex.net/get-mpic/5235334/img_id5575010630545284324.png/orig",
            "https://www.manualspdf.ru/thumbs/products/l/1260237-samsung-galaxy-note-20-ultra.jpg"]
        isFavourites = true
        price = String(1500)
        rating = 4.5
        ssd = "256 GB"
        sd = "8 GB"
        title  = "Galaxy Note 20 Ultra"
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
        lineView.backgroundColor = .orange
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

        simpleButtonsWithTextStack.addArrangedSubview(shopButton)
        simpleButtonsWithTextStack.addArrangedSubview(detailsButton)
        simpleButtonsWithTextStack.addArrangedSubview(featuresButton)

        smallPicturesStack.addArrangedSubview(smallCPUview)
        smallPicturesStack.addArrangedSubview(smallCameraView)
        smallPicturesStack.addArrangedSubview(smallSSDView)
        smallPicturesStack.addArrangedSubview(smallSDView)

        shopButton.addSubview(shopLabel)
        detailsButton.addSubview(detailsLabel)
        featuresButton.addSubview(featuresLabel)


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

            addToCartButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -40),
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
            
            shopLabel.centerXAnchor.constraint(equalTo: shopButton.centerXAnchor),
            shopLabel.centerYAnchor.constraint(equalTo: shopButton.centerYAnchor),
            detailsLabel.centerXAnchor.constraint(equalTo: detailsButton.centerXAnchor),
            detailsLabel.centerYAnchor.constraint(equalTo: detailsButton.centerYAnchor),
            featuresLabel.centerXAnchor.constraint(equalTo: featuresButton.centerXAnchor),
            featuresLabel.centerYAnchor.constraint(equalTo: featuresButton.centerYAnchor),

            lineView.rightAnchor.constraint(equalTo: informationDetailsView.rightAnchor),
            lineView.leftAnchor.constraint(equalTo: informationDetailsView.leftAnchor),
            lineView.topAnchor.constraint(equalTo: simpleButtonsWithTextStack.bottomAnchor),
            lineView.heightAnchor.constraint(equalTo: informationDetailsView.heightAnchor, multiplier: 1/24),
            
    
            smallPicturesStack.rightAnchor.constraint(equalTo: informationDetailsView.rightAnchor),
            smallPicturesStack.leftAnchor.constraint(equalTo: informationDetailsView.leftAnchor),
            smallPicturesStack.topAnchor.constraint(equalTo: lineView.bottomAnchor),
            smallPicturesStack.heightAnchor.constraint(equalTo: informationDetailsView.heightAnchor, multiplier: 1/4)


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
