//
//  Carousel.swift
//  TechShopTestProj
//
//  Created by Ольга Егорова on 08.12.2022.
//

import UIKit
import Combine

class Carousel: UIView {
    
    private var api = StoreAPIForHotSales()
    private var cancellable = Set<AnyCancellable>()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: CarouselLayout())
    
    var hotSalesAndBestSellersManager = HotSalesAndBAstSellersManager()
    
    var urls: [URL] = []
    lazy var hotSalesModelsArray: [HotSalesModel] = []
    var selectedIndex: Int = 0
    private var timer: Timer?
    
    fileprivate func getHotSalesProducts() {
        api.hotSalesProducts()
            .receive(on: DispatchQueue.main)
            .sink {(hotSalesProducts) in
                self.hotSalesModelsArray = hotSalesProducts
                self.collectionView.reloadData()
            }
            .store(in: &self.cancellable)
    }

    public init(frame: CGRect, urls: [URL]){
        self.urls = urls
        super.init(frame: frame)
        setupView()
    }
    
    
    public init(frame: CGRect, urls: [URL], hotSales: [HotSalesModel]) {
        self.urls = urls
        super.init(frame: frame)
        self.hotSalesModelsArray = hotSales
        print("INIT WITH HOT SALES MADED")
        print(hotSales)
        setupView()
    }
    
    //init from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    //init from xib or storyboard
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView(){
     //   hotSalesAndBestSellersManager.delegate = self
    //    hotSalesAndBestSellersManager.fetchHotSales()
        
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isUserInteractionEnabled = true
        collectionView.isPagingEnabled = true
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        
        collectionView.register(HotSalesCell.self, forCellWithReuseIdentifier: "cell")
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor)
            
        ])
        //ТАЙМЕР, ПЕРЕЛИСТЫВАЮЩИЙ ЯЧЕЙКИ МОЖНО ВКЛЮЧИТЬ ПРИ НЕОБХОДИМОСТИ
      //  scheduleTimerIfNeeded()
    }
    
    private func scheduleTimerIfNeeded() {
        guard urls.count > 1 else { return}
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true, block: {[weak self] _ in self?.selectNext()
            
        })
    }
    
    private func selectNext() {
        selectItem(at: selectedIndex + 1)
    }
    
    private func selectItem(at index: Int){
        let index = urls.count > index ? index : 0
        guard selectedIndex != index else { return}
        selectedIndex = index
        collectionView.scrollToItem(at: IndexPath(item: selectedIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    
    //СОДЕРЖИМОЕ ЯЧЕЙКИ
    
//    var stackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.axis = .vertical
//        stackView.distribution = .fillEqually
//        stackView.alignment = .leading
//        return stackView
//        
//    }()
//    
//    var newView: UIView = {
//        let view = UIButton()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = UIColor(named: "peach") ?? UIColor.orange
//        view.layer.masksToBounds = true
//        view.layer.cornerRadius = 15
//        let title = UILabel()
//        title.translatesAutoresizingMaskIntoConstraints = false
//        title.textColor = UIColor(named: "white") ?? UIColor.white
//        let font = UIFont(name: "SFProDisplay-Bold", size: 10)
//        title.font = font
//        view.addSubview(title)
//        
//        title.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        title.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        
//        return view
//        
//        
//    }()
//    
//    var labelsStackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.axis = .vertical
//        stackView.distribution = .fillEqually
//        stackView.alignment = .leading
//        return stackView
//    }()
//    
//    var titleLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//      //  label.text = hotSalesModelsArray[indexPath.row].title
//        label.textColor = UIColor(named: "while") ?? UIColor.white
//        let font = UIFont(name: "SFProDisplay-Bold", size: 25)
//        label.font = font
//        label.textAlignment = .left
//        return label
//    }()
//    
//    var subtitleLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//     //   label.text = hotSalesModelsArray[indexPath.row].subtitle
//        label.textColor = UIColor(named: "while") ?? UIColor.white
//        let font = UIFont(name: "SFProDisplay-Bold", size: 11)
//        label.font = font
//        label.textAlignment = .left
//        return label
//    }()
//    
//    var buyNowButton: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.backgroundColor = UIColor(named: "white") ?? UIColor.white
//        button.layer.masksToBounds = true
//        button.layer.cornerRadius = 5
//        let title = UILabel()
//        title.translatesAutoresizingMaskIntoConstraints = false
//        title.textColor = UIColor.black
//        title.text = "Buy now!"
//        let font = UIFont(name: "SFProDisplay-Bold", size: 11)
//        title.font = font
//        button.addSubview(title)
//        
//        title.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
//        title.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
//        
//        return button
//        
//    }()

}

extension Carousel: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
        //hotSalesModelsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HotSalesCell
        return cell
        
        //  cell.layer.cornerRadius = 10
        // let imageView: UIImageView = UIImageView(frame: .zero)
        //        imageView.translatesAutoresizingMaskIntoConstraints = false
        //        imageView.contentMode = .scaleAspectFill
        //        imageView.layer.masksToBounds = true
        //        imageView.layer.cornerRadius = 10
        //        imageView.sd_setImage(with: urls[indexPath.row], placeholderImage: UIImage(named: "placeholder"))
        
        //        cell.contentView.addSubview(imageView)
        //        NSLayoutConstraint.activate([
        //            imageView.topAnchor.constraint(equalTo: cell.topAnchor),
        //            imageView.bottomAnchor.constraint(equalTo: cell.bottomAnchor),
        //            imageView.leftAnchor.constraint(equalTo: cell.leftAnchor),
        //            imageView.rightAnchor.constraint(equalTo: cell.rightAnchor)
        //        ])
        //
        //
        //         guard hotSalesModelsArray.isEmpty == false else {return cell}
        //        print("FULL CELL WILL MAKE")
        //        return getCellWithSetLabelsAndButton(cell: cell, indexPath: indexPath)
        //
        //    }
    
    }
}

extension Carousel: UICollectionViewDelegate {
    
}



//extension Carousel {
//
//
//
//    func getCellWithSetLabelsAndButton(cell: UICollectionViewCell, indexPath: IndexPath)-> UICollectionViewCell {
//
//        print("FULL CELL START TO MAKE")
//
//        titleLabel.text = hotSalesModelsArray[indexPath.row].title
//        subtitleLabel.text = hotSalesModelsArray[indexPath.row].subtitle
//
//        cell.addSubview(stackView)
//        stackView.addArrangedSubview(newView)
//        stackView.addArrangedSubview(labelsStackView)
//        stackView.addArrangedSubview(buyNowButton)
//        labelsStackView.addArrangedSubview(titleLabel)
//        labelsStackView.addArrangedSubview(subtitleLabel)
//
//        stackView.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 20).isActive = true
//        stackView.topAnchor.constraint(equalTo: cell.topAnchor, constant:  20).isActive = true
//        stackView.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -30).isActive = true
//        stackView.widthAnchor.constraint(equalToConstant: 300).isActive = true
//
//        print ("FULL CELL MADE")
//        return cell
//
//    }
//
//
//}


//extension Carousel: HotSalesAndBestSellersManagerDelegate {
//
//    func didUpdateHotSales(_ hotSalessManager: HotSalesAndBAstSellersManager, hotSales: [HotSalesModel]) {
//        DispatchQueue.main.async { [self] in
//            print(hotSales)
//            hotSalesModelsArray = hotSales
//            for element in hotSalesModelsArray {
//                urls.append(element.picture)
//            }
//            collectionView.reloadData()
//
//        }
//    }
//
//    func didUpdateBestSellers(_ hotSalesAndBestSellersManager: HotSalesAndBAstSellersManager, bestSellers: [BestSellersModel]) {
//
//    }
//
//    func didFailWithError(error: Error) {
//        print(error)
//    }
//
//
//}

extension Carousel: DelegateFlowLayout {
    func sizeForItemAt() {
        
    }
}
